;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   scott.pro
;                                                                    
; PURPOSE:
;   Calculate histogram bin width using Scott's normal reference rule.
;
;   "Scott's normal reference rule is optimal for random samples of normally 
;    distributed data, in the sense that it minimizes the integrated mean squared 
;    error of the density estimate." - https://en.wikipedia.org/wiki/Histogram
;  
; CALLING SEQUENCE:
;   
; INPUTS:
;   arr             - Input array to determine bin width, h.
;  
; OPTIONAL INPUTS:
; 
; KEYWORDS:
;   
; 
; OUTPUTS:
;   h               - Histogram bin width.
;
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   
; EXAMPLES:
;
; REVISION HISTORY:
;   2018-May-17  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION scott, arr


h = 3.5 * stddev(arr,/nan,/double)/n_elements(arr)^(1./3.)
return, h


END