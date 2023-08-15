FUNCTION kde_bandwidth, arr


;; normal distribution approximation
;h = 1.06*min([stddev(arr),iqr(arr)/1.34])*n_elements(arr)^(-0.2)
h = 0.90*min([stddev(arr),iqr(arr)/1.34])*n_elements(arr)^(-0.2)

return, h


END




