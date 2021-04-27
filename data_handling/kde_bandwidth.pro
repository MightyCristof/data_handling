FUNCTION kde_bandwidth, arr


;; normal distribution approximation
h = 0.9*min([stddev(arr),iqr(arr)/1.34])*n_elements(arr)^(-0.2)

return, h


END




