FUNCTION width, arr, $
                ALL = bin


bin = abs(arr[0:-2]-arr[1:-1])
w = median(bin)
return, w


END




