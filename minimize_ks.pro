FUNCTION minimize_ks, arr1, $
                      arr2



n1 = n_elements(arr1)
n2 = n_elements(arr2)

df1 = cdf(arr1,xloc=dx1)
df2 = cdf(arr2,xloc=dx2)

dxi = [dx1,dx2]
dxi = dxi[uniq(dxi,sort(dxi))]

dfi1 = interpol(df1,dx1,dxi)
dfi2 = interpol(df2,dx2,dxi)

dfi1[where(dfi1 lt 0.,/null)] = 0.
dfi2[where(dfi2 lt 0.,/null)] = 0.
dfi1[where(dfi1 gt 1.,/null)] = 1.
dfi2[where(dfi2 gt 1.,/null)] = 1.

d = max(abs(dfi1-dfi2))
neff = long64(n1)*n2/float(n1+n2)


e = {yra:[-0.05,1.05],thick:4}
p1 = plot(dxi,dfi1,_extra=e,name='ARR 1')
p2 = plot(dxi,dfi2,'--r',_extra=e,/ov,name='ARR 2')
l = legend(target=[p1,p2],position=[0.25,0.92],/relative,/auto_text_color)
stop
return, d


END





