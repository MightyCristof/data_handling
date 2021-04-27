FUNCTION width, arr, $
                MIN = min, $
                AVG = avg, $
                MED = MED


w = abs(arr[0:-2]-arr[1:-1])
if keyword_set(min) then w = min(w) else $
if keyword_set(med) then w = median(w) else $
if keyword_set(avg) then w = mean(w)

return, w


END




