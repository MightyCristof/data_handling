;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   freedman
;   
; PURPOSE:
;   Calculate histogram bin width using Freedman-Diaconis' normal choice.
;
;   "The FreedmanÐDiaconis rule is based on the interquartile range, denoted by IQR. 
;    It replaces 3.5-sigma of Scott's rule with 2 IQR, which is less sensitive than the 
;    standard deviation to outliers in data." - https://en.wikipedia.org/wiki/Histogram
;
; CALLING SEQUENCE:
;   h = freedman( arr )
;   
; INPUTS:
;   arr             - Array of data to compute histogram bin size.
;   
; OPTIONAL INPUTS:
;   
; OUTPUTS:
;   h               - Histogram bin width using Freedman-Diaconis' normal choice.
;   
; OPTIONAL OUTPUTS:
;   
; COMMENTS:
;   
; EXAMPLES:
;   Determine bin width of a randomly generated array.
;       IDL> arr = randomu(seed,100)
;       IDL> h = freedman(arr)
;       % Compiled module: FREEDMAN.
;       % Compiled module: IQR.
;       IDL> print, h
;            0.210554;
;
; PROCEDURES CALLED:
;   IQR.PRO
;   
; REVISION HISTORY:
;   2018-May-17  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION freedman, arr


;; minimum, lower quartile, median, upper quartile, and maximum values
h = 2.*iqr(arr)/n_elements(arr)^(1./3.)
return, h

END