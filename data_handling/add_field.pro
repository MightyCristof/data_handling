;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	add_field
;	
; PURPOSE:
;	Add new tags and data to an existing structure
;	
; CALLING SEQUENCE:
;   struct = add_field( struct, new_tag, new_data, [ IND= ] )
;	
; INPUTS:
;   in_struct		- Input IDL structure to add field to.
;   new_tags        - String or string array containing the name(s) of the new tag.
;   new_data        - Array containing the data to be added to the structure.
;                     (Note: number of NEW_DATA arrays must match the length of NEW_TAGS)
;	
; OPTIONAL INPUTS:
;   ind             - Index of where to add the new field(s) within the list 
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
;   If additional fields are needed beyond the 100 present here, add additional
;   arguments at the call line. The function handles the rest.
;
; EXAMPLES:
;
; PROCEDURES CALLED:
;	SAO2AOS.PRO
;
; REVISION HISTORY:
;   2018-May-16  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION add_field, in_struct, $
                    new_tags, $
                    new_data00, new_data01, new_data02, new_data03, new_data04, $
                    new_data05, new_data06, new_data07, new_data08, new_data09, $
                    new_data10, new_data11, new_data12, new_data13, new_data14, $
                    new_data15, new_data16, new_data17, new_data18, new_data19, $
                    new_data20, new_data21, new_data22, new_data23, new_data24, $
                    new_data25, new_data26, new_data27, new_data28, new_data29, $
                    new_data30, new_data31, new_data32, new_data33, new_data34, $
                    new_data35, new_data36, new_data37, new_data38, new_data39, $
                    new_data40, new_data41, new_data42, new_data43, new_data44, $
                    new_data45, new_data46, new_data47, new_data48, new_data49, $
                    new_data50, new_data51, new_data52, new_data53, new_data54, $
                    new_data55, new_data56, new_data57, new_data58, new_data59, $
                    new_data60, new_data61, new_data62, new_data63, new_data64, $
                    new_data65, new_data66, new_data67, new_data68, new_data69, $
                    new_data70, new_data71, new_data72, new_data73, new_data74, $
                    new_data75, new_data76, new_data77, new_data78, new_data79, $
                    new_data80, new_data81, new_data82, new_data83, new_data84, $
                    new_data85, new_data86, new_data87, new_data88, new_data89, $
                    new_data90, new_data91, new_data92, new_data93, new_data94, $
                    new_data95, new_data96, new_data97, new_data98, new_data99, $
                    IND = ind
                  
                  
;; if index not specified, append to end                  
if (n_elements(ind) eq 0) then ind = -1
;; number of new fields
nnew = n_elements(new_tags)
;; number of sources
;nrows = n_elements(in_struct)

;; pull tags and data from input structure
tags = tag_names(in_struct)
ntags = n_elements(tags)

;; match data location to tag names
vars = 'in_struct.'+tags
new_vars = 'new_data'+string(indgen(nnew),format='(i02)')
;; place tags and data in desired order
if (ind eq -1) then begin
    tags = [tags,new_tags]
    vars = [vars,new_vars]
endif else if (ind eq 0) then begin
    tags = [new_tags,tags]
    vars = [new_vars,vars]
endif else begin
    tags = [tags[0:ind-1],new_tags,tags[ind:-1]]
    vars = [vars[0:ind-1],new_vars,vars[ind:-1]]
endelse
;; create output structure string and fill it
re = execute('out_struct = {'+strjoin(tags+":"+vars,",")+'}')

return, soa2aos(out_struct)


END




