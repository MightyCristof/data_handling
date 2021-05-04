FUNCTION mode, arr, $
               KDE = kde, $
               BIN = bin, $
               VERBOSE = verbose



if keyword_set(kde) then begin
    ;; mode of smoothed distribution using kernel density estimation
    type = size(kde,/type)
    if (type lt 2 or type gt 5) then message, 'SPECIFY KDE BANDWIDTH FOR SMOOTHING.'
    mm = minmax(arr)
    t = [mm[0]:mm[1]:kde]
    d = akde(arr,t)
    mode = t[where(d eq max(d))]
endif else if keyword_set(bin) then begin
    type = size(bin,/type)
    if (type lt 2 or type gt 5) then message, 'SPECIFY BINSIZE FOR HISTOGRAM.'
    yh = histogram(arr,bin=bin,location=xh)
    imax = where(yh eq max(yh),nmax)
    if (nmax gt 1) then $
        if keyword_set(verbose) then print, 'MULTIPLE EXTREMA FOUND.'
    mode = xh[imax]    
endif else begin
    len = n_elements(arr)               ;; elements in the array
    x = arr[sort(arr)]                  ;; sort input array
    ind = where(x ne shift(x,-1), nind)
    len = n_elements(arr)               ;; elements in the array
    x = arr[sort(arr)]                  ;; sort input array
    ind = where(x ne shift(x,-1), nind)
    if (nind eq len) then message,'ARRAY IS UNIQUE. TRY BINNING.'
    if nind eq 0 then mode = x[0] else begin
        void = max(ind-[-1,ind], imax)
        ;ct = ind-[-1,ind]
        ;imax = where(ct eq max(ct),nmax)
        ;if (nmax gt 1) then message,'MULTIPLE EXTREMA FOUND. TRY DIFFERENT BIN SIZE.'
        mode = x[ind[imax]]
    endelse
endelse

return, mode


END



