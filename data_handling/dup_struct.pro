;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   dup_struct
;   
; PURPOSE:
;   Duplicate a structure. The duplicate structure is blank.
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
;   Procedure only works for structures with vector tags.
;   
; EXAMPLES:
;   
; PROCEDURES CALLED:
;   
; REVISION HISTORY:
;   2018-Nov-27  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION dup_struct, struct, $
                     len


;; rip structure tags
vars = tag_names(struct)
nvars = n_elements(vars)
;; create blank vectors of same data type
for i = 0,nvars-1 do begin
    re = execute('type = typename(struct.'+vars[i]+')')
    if (type eq 'LONG64') then type = 'L64'
    re = execute(vars[i]+' = make_array(len,/'+type+')')
endfor
;; create duplicate structure with blank vectors
re = execute('dup_struct = {'+strjoin(vars+":"+vars,",")+'}')
;; reform to array of structures
dup_struct = soa2aos(dup_struct)

return, dup_struct


END
