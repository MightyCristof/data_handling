;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;   sav2fits
;
; PURPOSE:
;   Convert an IDL save file to IDL structure.
;
; CALLING SEQUENCE:
;   struct = ( file, [, /AOS ] )
;
; INPUTS:
;   file            - String containing the IDL save file.
;
; OPTIONAL INPUTS:
;   /AOS            - Set this keyword to return an array of structures. This only 
;                     works when each index contains a single value.
;   /SAV            - Save IDL structure to FITS file.
;
; OUTPUTS:
;   struct          - IDL structure containing the save file data.
;
; OPTIONAL OUTPUTS:
;   
; COMMENTS:
;   
; EXAMPLES:
;   
; PROCEDURES CALLED:
;   SOA2AOS.PRO
;
; REVISION HISTORY:
;   2017-Jul-25  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION sav2fits, file, $
                   AOS = aos, $
                   SAV = sav


object = OBJ_NEW('IDL_Savefile', file[0])                   ;; save file to object
vars = object->names()                                      ;; pull variables in object
re = execute('common _load, '+strjoin(vars,','))            ;; create common block
restore,file                                                ;; restore variables into common block
re = execute('struct = {'+strjoin(vars+":"+vars,",")+'}')   ;; fill variables into structure
if keyword_set(aos) then struct = soa2aos(struct)           ;; Structure of Arrays to Array of Structures
if keyword_set(sav) then mwrfits,struct,strsplit(file,'.sav',/extract,/regex)+'.fits',/CREATE

return, struct


END



