FUNCTION cdf, arr, $
              XLOC = dx, $
              BIN = bin, $
              LOC = loc
              

;; take XY from the input NH structure
if (n_elements(bin) gt 0) then yh = histogram(arr,location=xh,bin=bin) else $
                               yh = histogram(arr,location=xh)
;; create finer grid for x-axis (simulate continuous function)
dx = [xh[0]:xh[-1]:diff(minmax(xh))/9999.]
;; interpolate and normalize to create probability distribution function
pdf = interpol(yh,xh,dx);spline(xh,yh,dx)
pdf >= 0.               ;; sanity check
pdf /= total(pdf)       ;; normalize
;; sum to create cumulative distribution function
cdf = total(pdf,/cumulative)
;; return CDF at requested input values
if keyword_set(loc) then cdf = interpol(cdf,dx,loc)

return, cdf


END
