;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	combine_savs
;	
; PURPOSE:
;	Concatenate identically named variables across multiple IDL .SAV files.
;	
; CALLING SEQUENCE:
;   combine_savs, files
;	
; INPUTS:
;   files			- String containing IDL .SAV files.
;	   
; OPTIONAL INPUTS:
;   
; OUTPUTS:
;   common_vars		- String containing the name of the common block and variables
;					  to load, formatted for EXECUTE.PRO.
;	
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   This function was written with 2-D arrays in mind, specifically, where the length 
;	of the first dimension changes between two different variables. This was intentional, 
;	as to keep an array 1-D when indexing a single object (helpful for IDL structures).
;
;	E.g., where there are 1000 objects and 6 photometric filters:
;
;	IDL> help, z
;		Z (_COMBINE)     DOUBLE    = Array[268511]
;	IDL> help, flux
;		FLUX (_COMBINE)  DOUBLE    = Array[13, 268511]
;	IDL> help, z[0]
;		<Expression>    DOUBLE    =       0.25300300
;	IDL> help, flux[*,0]
;		<Expression>    DOUBLE    = Array[13]	
;
; EXAMPLES:
;	sav_files = file_search()
;	loadstr = combine_savs(sav_files)
;	IDL> print, loadstr
;		_COMBINE,BAND,BIN,DEC,E_FLUX,E_MAG,FLUX,MAG,OBJID,OBSWV,PARAM,RA,Z,ZARR,ZERR
;	re = execute('common'+loadstr)
;	IDL> print, scope_varname(common='_COMBINE')
;		BAND BIN DEC E_FLUX E_MAG FLUX MAG OBJID OBSWV PARAM RA Z ZARR ZERR
;	IDL> help, flux
;		FLUX (_COMBINE)  DOUBLE    = Array[13, 268511]
;	IDL> help, objid
;		OBJID (_COMBINE) LONG64    = Array[268511]
;
; PROCEDURES CALLED:
;	RIP_VARS.PRO

; REVISION HISTORY:
;   2018-May-16  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION combine_savs, files


;; rip variable names from first file
vars = rip_vars(files[0])

;; create an IDL COMMON block for variables to load them outside current function
var_str = strjoin(vars,',')
re = execute('common _COMBINE,'+var_str)

;; create temporary variables so we don't overwrite on subsequent restore
temp_vars = 'TEMP_'+vars
for i = 0,n_elements(temp_vars)-1 do re = execute(temp_vars[i]+' = []')

;; loops over all .SAV files and append variables
;; note: appending is computationally inefficient, but easier to handle within EXECUTE
for i = 0,n_elements(files)-1 do begin
	restore, files[i]
	for j = 0,n_elements(vars)-1 do begin
		;; check for 1- or 2-D array
		re = execute('sz = size('+vars[j]+')')
		if (sz[0] eq 2) then re = execute(temp_vars[j]+' = [['+temp_vars[j]+'],['+vars[j]+']]') else $
		                     re = execute(temp_vars[j]+' = ['+temp_vars[j]+','+vars[j]+']')
	endfor
endfor

;; transfer concatenated variables to common block variables
for i = 0,n_elements(vars)-1 do re = execute(vars[i]+' = '+temp_vars[i])
;; join the name of common block with name of variables for call with EXECUTE
common_vars = ' _COMBINE,'+var_str
return, common_vars


END


