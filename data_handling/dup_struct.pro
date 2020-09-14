;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   dup_struct
;   
; PURPOSE:
;   Duplicate a structure. The duplicate structure is blank.
;   
; CALLING SEQUENCE:
;   result = dup_struct( struct, [, BLANK=, NEW_TAGS= ] )
;
; INPUTS:
;   
; OPTIONAL INPUTS:
;   blank           - New structure is blank.
;   new_tags		- Replace tag names in new structure.
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
                     BLANK = blank, $
                     NEW_TAGS = new_tags


len = n_elements(struct)
tags = tag_names(struct)
;; rip structure tags
if keyword_set(new_tags) then begin
    vars = new_tags
    ;; catch illegal characters for structure tags. replace with underscore
    chars = '-!;$".&:*@?''
    ichar = where(strmatch(vars,'*['+chars+']*'),charct)
    if (charct gt 0) then for i = 0,charct-1 do vars[ichar[i]] = strjoin(strsplit(vars[ichar[i]],chars,/extract),'_')
endif else vars = tags
nvars = n_elements(vars)
;; create blank vectors of same data type
for i = 0,nvars-1 do begin
    re = execute('type = typename(struct.'+tags[i]+')')
    if (type eq 'LONG64') then type = 'L64'
    re = execute(vars[i]+' = make_array(len,/'+type+')')
endfor
;; create duplicate structure with blank vectors
re = execute('dup_struct = {'+strjoin(vars+":"+vars,",")+'}')
;; reform to array of structures
dup_struct = soa2aos(dup_struct)

if keyword_set(blank) then return, dup_struct

for i = 0,nvars-1 do dup_struct.(i) = struct.(i)
return, dup_struct


END








