;-----------------------------------------------------------------------------------------
; NAME:                                                                      IDL Procedure
;   dec_init
;   
; PURPOSE:
;   Declare and initialize a set of variables drawn from an IDL structure, where the
;   new variables match the original data type.
;   
; CALLING SEQUENCE:
;   
; INPUTS:
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
;   
; PROCEDURES CALLED:
;   
; REVISION HISTORY:
;   2018-Nov-27  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
PRO dec_init, struct, $
              vars, $
              len


nvars = n_elements(vars)
for i = 0,nvars-1 do begin
    re = execute('type = typename(struct.'+vars[i]+')')
    if (type eq 'LONG64') then type = 'L64'
    re = execute(vars[i]+' = make_array(len,/'+type+')')
endfor


END
