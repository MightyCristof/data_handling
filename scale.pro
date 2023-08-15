FUNCTION scale, x, $
                b, $
                a


x_norm = (b-a)*((x-min(x))/(max(x)-min(x))) + a

return, x_norm


END



