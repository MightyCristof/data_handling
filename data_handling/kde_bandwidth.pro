FUNCTION kde_bandwidth, arr


;; rule-of-thumb for normal distributions
h = 1.06*min([stddev(arr),iqr(arr)/1.34])*n_elements(arr)^(-0.2)

return, h


END




