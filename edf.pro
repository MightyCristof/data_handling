FUNCTION edf, arr, $
              XLOC = sarr


;; finite values only
ifin = where(finite(arr),sz)
fin = arr[ifin]
;; sort and create EDF
is = sort(fin)
sarr = fin[is]
edf = (findgen(sz))/sz

return, edf


END
