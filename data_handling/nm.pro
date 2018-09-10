;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	nm
;	
; PURPOSE:
;	Return data normalized to 1.
;    
; CALLING SEQUENCE:
;   result = nm( data )
;	
; INPUTS:
;	arr 			- Array of data to normalize.
;	
; OPTIONAL INPUTS:
;   
; OUTPUTS:
;   result			- An array the size of arr, normalized to 1.
;	 
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   Result is changed to float() if arr lower precision.
;	
; EXAMPLES:
;	arr1 = findgen(5)
;	IDL> print, nm(arr1)
;	      0.00000     0.250000     0.500000     0.750000      1.00000	
;
; REVISION HISTORY:
;   2018-Jun-19  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION nm, arr


return, arr/max(arr * 1.)


END