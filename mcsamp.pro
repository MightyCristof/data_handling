;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   mcsamp.pro
;                                                                    
; PURPOSE:
;   
; CALLING SEQUENCE:
;   
; INPUTS:
;  
; OPTIONAL INPUTS:
; 
; KEYWORDS:
;   
; 
; OUTPUTS:
;   
; PROCEDURE:
;
; RESTRICTIONS: 
; 
;
; cmc
;-----------------------------------------------------------------------------------------
FUNCTION mcsamp, arr, $
                 ndraw, $
                 PLT = plt


;; histogram
yh = histogram(arr,bin=freedman(arr),locations=xh,min=min(arr)-freedman(arr),max=max(arr)+freedman(arr))
;; create finer grid for x-axis
dx = [xh[0]:xh[-1]:width(minmax(xh))/1000.]

;; interpolate and normalize to create probability distribution function
;; remember newY=spline(X,Y,newX)
pdf = spline(xh,yh,dx)
pdf >= 0.
pdf /= total(pdf)
;; sum to create cumulative distribution function
cdf = total(pdf,/cumulative)
;; unique elements of CDF
iu = uniq(cdf)
xdx = dx[iu]
cdf = cdf[iu]
;; draw random values from 0-1
randcdf = randomu(seed,ndraw)
;; project to sample X input variable
;; remember newY=interpol(Y,X,newX)
samp = interpol(xdx,cdf,randcdf)

return, samp


END
