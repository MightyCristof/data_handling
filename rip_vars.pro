;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	rip_vars
;	
; PURPOSE:
;	Extract all variable names within an IDL .SAV file without the need to restore.
;	
; CALLING SEQUENCE:
;   rip_vars, file
;	
; INPUTS:
;   file			- String containing IDL .SAV file.
;	   
; OPTIONAL INPUTS:
;   
; OUTPUTS:
;   vars            - String array containing the variable names.
;	
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;
; EXAMPLES:
;   IDL> vars = rip_vars('fits.sav')
;   IDL> help, vars
;       VARS            STRING    = Array[15]
;   IDL> print, strjoin(vars,',')
;       BAND,BIN,DEC,E_FLUX,E_MAG,E_Z,E_ZARR,FLUX,MAG,OBJID,OBSWV,PARAM,RA,Z,ZARR
;
; PROCEDURES CALLED:
;   
; REVISION HISTORY:
;   2018-May-16  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION rip_vars, file


;; load first .SAV file as an IDL_Savefile object
object = OBJ_NEW('IDL_Savefile',file)
;; extract variable names
vars = object->names()

return, vars


END




