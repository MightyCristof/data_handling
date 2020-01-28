FUNCTION commas, in_str


neg = 0

str = strtrim(in_str,2)
if (strmatch(strmid(str,0,1),'-') eq 1) then begin
    neg = 1
    str = strmid(str,1)    
endif

len = strlen(str)
nsets = len/3
nrem = len mod 3

if (nrem ne 0) then nsets++
if (nrem eq 0) then nrem = 3

new_str = ''
for i = 1,nsets-1 do re = execute('new_str = ","+strmid(str,len-3*i,3)+new_str')
new_str = strmid(str,0,nrem)+new_str

if (neg eq 1) then new_str = '-'+new_str

return, new_str


END




