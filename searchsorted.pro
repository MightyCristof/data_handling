FUNCTION searchsorted, a, v, SIDE = side, SORTER = sorter


if (n_elements(side) eq 0) then side = 'LEFT'
arr = intarr(n_elements(v))

case strupcase(side) of
    'LEFT': begin
        mma = minmax(a)
        iless = where(v lt mma[0],nless)
        if (nless gt 0) then arr[iless] = 0
        
        iin = where(v ge mma[0] and v le mma[1],nin)
        ;if (nin gt 0) then arr[iin] = value_locate(a,v[iin])
        if (nin gt 0) then begin
            for i = 0,nin-1 do begin
                arr[iin[i]] = (where(v[iin[i]] le a))[0]
            endfor
        endif
        
        imore = where(v gt mma[1],nmore)
        if (nmore gt 0) then arr[imore] = n_elements(a)
        end
    'RIGHT': begin
        mma = minmax(a)
        iless = where(v lt mma[0],nless)
        if (nless gt 0) then arr[iless] = 0
        
        iin = where(v ge mma[0] and v le mma[1],nin)
        ;if (nin gt 0) then arr[iin] = value_locate(a,v[iin])+1
        if (nin gt 0) then begin
            for i = 0,nin-1 do begin
                arr[iin[i]] = (where(v[iin[i]] ge a))[-1]+1
            endfor
        endif

        imore = where(v gt mma[1],nmore)
        if (nmore gt 0) then arr[imore] = n_elements(a)
        end
endcase

return, arr


END
