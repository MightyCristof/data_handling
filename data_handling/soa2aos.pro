FUNCTION SoA2AoS, table

  if (table eq !NULL) then return, !NULL

  tnames = tag_names(table)
  new_table = create_struct(tnames[0], (table.(0)[0]))
  for t = 1L, n_tags(table) - 1L do begin
    new_table = create_struct(new_table, tnames[t], (table.(t))[0])
  endfor

  new_table = replicate(new_table, n_elements(table.(0)))

  for t = 0L, n_tags(table) - 1L do begin
    new_table.(t) = table.(t)
  endfor

  return, new_table

end

;function SoA2AoS, table
;
;  if (table eq !NULL) then return, !NULL
;
;  tnames = tag_names(table)
;  new_table = create_struct(tnames[0], (table.(0)[0]))
;  for t = 1L, n_tags(table) - 1L do begin
;  	sz = size(table.(t))
;  	if (sz[0] eq 1) then new_table = create_struct(new_table, tnames[t], (table.(t))[0]) else $
;  						 new_table = create_struct(new_table, tnames[t], reform((table.(t))[0,*]))
;  endfor
;
;  new_table = replicate(new_table, n_elements(table.(0)))
;
;  for t = 0L, n_tags(table) - 1L do begin
;  	sz = size(table.(t))
;  	if (sz[0] eq 1) then new_table.(t) = table.(t) else $
;  						 new_table.(t) = transpose(table.(t))
;  endfor
;
;  return, new_table
;
;end




;; my original attempt, very similar except for the fancy structure indexing
	;names = tag_names(r)
	;for j = 0,n_elements(names)-1 do re = execute(names[j]+' = r.'+names[j])
	;re = execute('entry = create_struct(names[0],'+names[0]+'[0])')
	;for j = 1,n_elements(names)-1 do re = execute('struct_add_field,entry,names[j],'+names[j]+'[0]')
	;r2 = replicate(entry,n_elements(imsw))
	;for j = 0,n_elements(names)-1 do re = execute('r2.'+names[j]+' = r.'+names[j])	
