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
;	value			- Scalar or vector of value(s) to be rounded.
;	digit			- Scalar or vector of decimal place(s) to round input values.
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
FUNCTION rnd, value, $
              digit

sz = size(value, /type)
if sz eq 5 then ten = 10d else ten = 10.

if (n_elements(digit) eq 0) then digit = 0
return, round(value*ten^digit)*ten^(-digit)


END



