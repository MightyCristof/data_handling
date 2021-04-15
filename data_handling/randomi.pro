;-----------------------------------------------------------------------------------------
; NAME:                                                                       IDL Function
;	randomi
;	
; PURPOSE:
;	Draw N random indices, with or without duplicates, from a range of values.
;	
; CALLING SEQUENCE:
;   irand = randomi( nind, rang )
;	
; INPUTS:
;   nind    		- Number of random indices desired.
;   rang            - Range of indices to draw from, starting from zero.
;	
; OPTIONAL INPUTS:
;   NODUP           - Draw random indices without duplicates.
;   
; OUTPUTS:
;   irand           - Randomly drawn indices.
;	
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   This "no duplicate" solution was created by Ken Bowman on IDLCoyote.
;       http://www.idlcoyote.com/code_tips/randomindex.html
;
; EXAMPLES:
;
; PROCEDURES CALLED:
;
; REVISION HISTORY:
;   2018-May-16  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
FUNCTION randomi, nind, $
                  rang, $
                  NODUP = nodup


if keyword_set(nodup) then begin
    random_numbers = randomu(seed,rang)            
    sorted_random_numbers = sort(random_numbers)     
    irand = sorted_random_numbers[0:nind-1] 
endif else $
    irand = round(randomu(seed,nind)*rang)

return, irand


END






