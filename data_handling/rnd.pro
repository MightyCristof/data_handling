;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   rnd
;   
; PURPOSE:
;   Round a scalar or vector to a specified decimal place.
;   
; CALLING SEQUENCE:
;   arr_round = rnd( vals, deci )
;   
; INPUTS:
;	vals			- Scalar or vector of value(s) to be rounded.
;	deci			- Scalar or vector of decimal place(s) to round input values.
;
; OPTIONAL INPUTS:
;   
; OUTPUTS:
;   
; OPTIONAL OUTPUTS:
;   
; COMMENTS:
;   
; EXAMPLES:
;   IDL> vals = replicate(randomu(101,1),6)
;   IDL> deci = indgen(6); PROCEDURES CALLED:
;   IDL> print, vals
;        0.516399     0.516399     0.516399     0.516399     0.516399     0.516399
;   IDL> print, deci
;          0       1       2       3       4       5;   
;   IDL> rounded = rnd(vals,deci)
;   IDL> print, rounded
;         1.00000     0.500000     0.520000     0.516000     0.516400     0.516400
;
; REVISION HISTORY:
;   2020-Jan-06  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION rnd, vals, $
              deci


deci = 10.^deci
return, round(vals*deci)/deci


END



