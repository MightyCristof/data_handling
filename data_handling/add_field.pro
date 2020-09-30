;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	add_field
;	
; PURPOSE:
;	Add a new tag to an existing structure
;	
; CALLING SEQUENCE:
;   struct = add_field( struct, new_tag, new_data, [ ind ] )
;	
; INPUTS:
;   in_struct		- Input IDL structure to add field to.
;   new_tag         - String containing the name of the new tag.
;   new_data        - Array containing the data to be added to the structure.
;	
; OPTIONAL INPUTS:
;   ind             - Index of where to add the new field within the list 
;                     of existing tags.
;   
; OUTPUTS:
;   out_struct		- IDL structure with new tag and data.
;	
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   ADD_FIELD.PRO is much faster than the existing STRUCT_ADD_FIELD.PRO available
;   online.
;
;   This function is not currently built for adding multiple new fields at the same
;   time, but in practice it would be easy enough.
;
; EXAMPLES:
;
; PROCEDURES CALLED:
;	SAO2AOS.PRO

; REVISION HISTORY:
;   2018-May-16  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION add_field, in_struct, $
                    new_tag, $
                    new_data, $
                    ind
                  

;; if index not specified, append to end                  
if (n_params() eq 3) then ind = -1

;; pull tags and data from input structure
tags = tag_names(in_struct)
ntags = n_elements(tags)
for i = 0,ntags-1 do re = execute(tags[i]+' = in_struct.'+tags[i])

;; link new_tag and new_data
re = execute(new_tag+' = new_data')
if (ind eq -1) then tags = [tags,new_tag] else $
                    tags = [tags[0:ind-1],new_tag,tags[ind:-1]]

;; create output structure string and fill it
re = execute('out_struct = {'+strjoin(tags+":"+tags,",")+'}')

return, soa2aos(out_struct)


END




