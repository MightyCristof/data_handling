FUNCTION soa2aos, table, $
                  nrows


;; check for input table
if (table eq !null) then return, !null
;; first tag array data shape for initialization
sz = size(table.(0))

;; validate the length of the data structures
if (n_elements(nrows) eq 0) then begin
    if (sz[0] ne 1) then begin
        print, 'FIRST TAG OF INPUT DATA STRUCTURE HAS MULTIPLE DIMENSIONS.'
        print, 'PLEASE INPUT NUMBER OF ROWS.'
        return, !NULL
    endif else nrows = sz[1] 
endif

;; rip tag names
tnames = tag_names(table)
             
;; initialize structure     
case sz[0] of
    1:  new_table = create_struct(tnames[0], (table.(0)[0]))
    2:  begin
        if (sz[2] eq nrows) then begin
            new_table = create_struct(tnames[0], (table.(0))[*,0])
        endif else if (sz[1] eq nrows) then begin
            new_table = create_struct(tnames[0], reform((table.(0))[0,*]))
        endif else begin
            print, 'TAG DOES NOT MATCH DATA STRUCTURE ('+tnames[t]+')'
            stop
        endelse
        end
    else:   begin
        print, 'NOT YET SUITED TO HANDLE 3+ DIMENSIONAL ARRAYS'
        stop
        endelse
endcase    

;; initialize each subsequent tag
for t = 1L, n_tags(table) - 1L do begin
    sz = size(table.(t))
    case sz[0] of
        1:  new_table = create_struct(new_table, tnames[t], (table.(t))[0])
        2:  begin
            if (sz[2] eq nrows) then begin
                new_table = create_struct(new_table, tnames[t], (table.(t))[*,0])
            endif else if (sz[1] eq nrows) then begin
                new_table = create_struct(new_table, tnames[t], reform((table.(t))[0,*]))
            endif else begin
                print, 'TAG DOES NOT MATCH DATA STRUCTURE ('+tnames[t]+')'
                stop
            endelse
            end
        else:   begin
            print, 'NOT YET SUITED TO HANDLE 3+ DIMENSIONAL ARRAYS'
            stop
            endelse
    endcase
endfor

;; replicate full structure length
new_table = replicate(new_table, nrows)

;; procede through tags and fill data
for t = 0L, n_tags(table)-1L do begin
    sz = size(table.(t))
    case sz[0] of
        1:  new_table.(t) = table.(t)
        2:  begin
            if (sz[2] eq nrows) then begin
                new_table.(t) = table.(t)
            endif else if (sz[1] eq nrows) then begin
                new_table.(t) = transpose(table.(t))
            endif else begin
                print, 'NOT YET SUITED TO HANDLE 3+ DIMENSIONAL ARRAYS'
                stop
            endelse
            end
        else:   begin
            print, 'NOT YET SUITED TO HANDLE 3+ DIMENSIONAL ARRAYS'
            stop
            endelse
    endcase
endfor

return, new_table


END





