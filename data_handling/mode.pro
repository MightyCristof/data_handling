FUNCTION mode, arr, $
               BIN = bin, $
               VERBOSE = verbose



if keyword_set(bin) then begin
    ;; mode of smoothed distribution using kernel density estimation
    typ = size(bin,/type)
    if (typ lt 4 or typ gt 5) then message, 'SPECIFY FLOAT/DOUBLE BIN SIZE FOR SMOOTHING.'
    mm = minmax(arr)
    t = [mm[0]:mm[1]:bin]
    d = akde(arr,t)
    mode = t[where(d eq max(d))]
endif else begin
    ;; absolute mode
    len = n_elements(arr)               ;; elements in the array
    x = arr[sort(arr)]                  ;; sort input array
    dx = width([x,abs(max(x)*2.)])      ;; difference in sorted array, account for last value
    ind = where(dx gt 0.,num)           ;; indices where values change
    if (num eq len) then begin
        if keyword_set(verbose) then print, 'ARRAY IS UNIQUE. BINNING.'
        binsz = freedman(arr)
        yh = histogram(arr,bin=binsz,location=xh)
        imax = where(yh eq max(yh),nmax)
        if (nmax gt 1) then $
            if keyword_set(verbose) then print, 'MULTIPLE EXTREMA FOUND.'
        mode = xh[imax]
    endif else if (num gt 0) then begin
        imax = where(width([0,ind]) eq max(width([0,ind])),nmax)    ;; longest persistence length of repeated values
        if (nmax gt 1) then $
            if keyword_set(verbose) then print, 'MULTIPLE EXTREMA FOUND.'
        mode = x[ind[imax]]
    endif else begin
        if keyword_set(verbose) then print, 'ARRAY IS STATIC. RETURN IS NULL.'
        mode = !NULL
    endelse
endelse

return, mode


END