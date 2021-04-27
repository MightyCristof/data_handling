FUNCTION width, arr, $
                MED = MED


w = abs(arr[0:-2]-arr[1:-1])
if keyword_set(med) then w = median(w)

return, w


END




