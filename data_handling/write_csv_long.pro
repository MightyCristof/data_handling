; $Id: //depot/Release/ENVI52_IDL84/idl/idldir/lib/write_csv.pro#1 $
;
; Copyright (c) 2008-2014, Exelis Visual Information Solutions, Inc. All
;       rights reserved. Unauthorized reproduction is prohibited.

;----------------------------------------------------------------------------
function write_csv_convert, data

  compile_opt idl2, hidden
  
  switch (SIZE(data, /TYPE)) of
  
  7: begin   ; string type
      ; Always surround all strings with quotes, to avoid problems with
      ; commas and whitespace.
      data1 = '"'+data+'"'
      ; Now look for double-quote chars, which need to be escaped.
      hasQuote = WHERE(STRPOS(data, '"') ge 0, nQuote)
      if (nQuote gt 0) then begin
        d = data[hasQuote]
        for i=0,nQuote-1 do d[i] = STRJOIN(STRTOK(d[i],'"',/EXTRACT,/PRESERVE_NULL),'""')
        data1[hasQuote] = '"' + d + '"'
      endif
      return, data1
     end
  
  ; Be sure to convert bytes to numbers
  1: return, STRTRIM(FIX(data), 1)
  
  ; Use a format code for double-precision numbers.
  5: return, STRTRIM(STRING(data, FORMAT='(g)'), 1)
     
  6: ; complex and dcomplex (fall thru)
  9: return, '"' + STRCOMPRESS(data, /REMOVE_ALL) + '"'
  
  else: begin
      ; regular numeric types
      return, STRTRIM(data, 2)
     end
     
  endswitch
  
end

;----------------------------------------------------------------------------
;+
; :Description:
;    The WRITE_CSV procedure writes data to a "comma-separated value"
;    (comma-delimited) text file.
;
;    This routine writes CSV files consisting of an optional line of column
;    headers, followed by columnar data, with commas separating each field.
;    Each row is a new record.
;
;    This routine is written in the IDL language. Its source code can be
;    found in the file write_csv.pro in the lib subdirectory of the IDL
;    distribution. 
;
; :Syntax:
;    WRITE_CSV, Filename, Data1 [, Data2,..., Data8]
;      [, HEADER=value]
;    
; :Params:
;    Filename
;      A string containing the name of the CSV file to write.
;
;    Data1...Data8
;      The data values to be written out to the CSV file. The data arguments
;      can have the following forms:
;      * Data1 can be an IDL structure, where each field contains a
;        one-dimensional array (a vector) of data that corresponds
;        to a separate column. The vectors must all have the same
;        number of elements, but can have different data types. If Data1
;        is an IDL structure, then all other data arguments are ignored.
;      * Data1 can be a two-dimensional array, where each column in the array
;        corresponds to a separate column in the output file. If Data1 is
;        a two-dimensional array, then all other data arguments are ignored.
;      * Data1...Data8 are one-dimensional arrays (vectors), where each vector
;        corresponds to a separate column in the output file. Each vector
;        can have a different data type.
;
; :Keywords:
;    HEADER
;      Set this keyword equal to a string array containing the column header
;      names. The number of elements in HEADER must match the number of
;      columns provided in Data1...Data8. If HEADER is not present,
;      then no header row is written.
;      
;      TABLE_HEADER
;      Set this keyword to a scalar string or string array containing extra table lines 
;      to be written at the beginning of the file. 
;      
; :History:
;   Written, CT, VIS, Nov 2008
;   MP, VIS, Oct 2009:  Added keyword SKIP_HEADER
;   Dec 2010:  Better handling for byte and double precision data.
;   
;-
pro write_csv_long, Filename, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, $
                              Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, $
                              Data21, Data22, Data23, Data24, Data25, Data26, Data27, Data28, Data29, Data30, $
                              Data31, Data32, Data33, Data34, Data35, Data36, Data37, Data38, Data39, Data40, $
                              Data41, Data42, Data43, Data44, Data45, Data46, Data47, Data48, Data49, Data50, $
                              Data51, Data52, Data53, Data54, Data55, Data56, Data57, Data58, Data59, Data60, $
                              Data61, Data62, Data63, Data64, Data65, Data66, Data67, Data68, Data69, Data70, $
                              Data71, Data72, Data73, Data74, Data75, Data76, Data77, Data78, Data79, Data80, $
                              Data81, Data82, Data83, Data84, Data85, Data86, Data87, Data88, Data89, Data90, $
                              Data91, Data92, Data93, Data94, Data95, Data96, Data97, Data98, Data99, Data100, $
  HEADER=header, TABLE_HEADER=tableHeader

  compile_opt idl2

  ON_ERROR, 2         ;Return on error

  ON_IOERROR, ioerr

  if (N_PARAMS() lt 2) then $
    MESSAGE, 'Incorrect number of arguments.'

  isStruct = SIZE(Data1, /TYPE) eq 8
  isArray = SIZE(Data1, /N_DIM) eq 2

  if (SIZE(Filename,/TYPE) ne 7) then $
    MESSAGE, 'Filename must be a string.'
    
  if (N_ELEMENTS(Data1) eq 0) then $
    MESSAGE, 'Data1 must contain data.'
   
  ; Verify that all columns have the same number of elements.

  msg = 'Data fields must all have the same number of elements.'
  
  if (isStruct) then begin
  
    nfields = N_TAGS(Data1)
    nrows = N_ELEMENTS(Data1.(0))
    for i=1,nfields-1 do begin
      if (N_ELEMENTS(Data1.(i)) ne nrows) then $
        MESSAGE, msg
    endfor
    
  endif else if (isArray) then begin
  
    d = SIZE(Data1, /DIM)
    nfields = d[0]
    nrows = d[1]
    
  endif else begin  ; Individual data arguments
  
    nfields = N_PARAMS() - 1
    nrows = N_ELEMENTS(Data1)
    
    switch (nfields) of
    100: if (N_ELEMENTS(Data100) ne nrows) then MESSAGE, msg
    99: if (N_ELEMENTS(Data99) ne nrows) then MESSAGE, msg
    98: if (N_ELEMENTS(Data98) ne nrows) then MESSAGE, msg
    97: if (N_ELEMENTS(Data97) ne nrows) then MESSAGE, msg
    96: if (N_ELEMENTS(Data96) ne nrows) then MESSAGE, msg
    95: if (N_ELEMENTS(Data95) ne nrows) then MESSAGE, msg
    94: if (N_ELEMENTS(Data94) ne nrows) then MESSAGE, msg
    93: if (N_ELEMENTS(Data93) ne nrows) then MESSAGE, msg
    92: if (N_ELEMENTS(Data92) ne nrows) then MESSAGE, msg
    91: if (N_ELEMENTS(Data91) ne nrows) then MESSAGE, msg
    90: if (N_ELEMENTS(Data90) ne nrows) then MESSAGE, msg
    89: if (N_ELEMENTS(Data89) ne nrows) then MESSAGE, msg
    88: if (N_ELEMENTS(Data88) ne nrows) then MESSAGE, msg
    87: if (N_ELEMENTS(Data87) ne nrows) then MESSAGE, msg
    86: if (N_ELEMENTS(Data86) ne nrows) then MESSAGE, msg
    85: if (N_ELEMENTS(Data85) ne nrows) then MESSAGE, msg
    84: if (N_ELEMENTS(Data84) ne nrows) then MESSAGE, msg
    83: if (N_ELEMENTS(Data83) ne nrows) then MESSAGE, msg
    82: if (N_ELEMENTS(Data82) ne nrows) then MESSAGE, msg
    81: if (N_ELEMENTS(Data81) ne nrows) then MESSAGE, msg
    80: if (N_ELEMENTS(Data80) ne nrows) then MESSAGE, msg
    79: if (N_ELEMENTS(Data79) ne nrows) then MESSAGE, msg
    78: if (N_ELEMENTS(Data78) ne nrows) then MESSAGE, msg
    77: if (N_ELEMENTS(Data77) ne nrows) then MESSAGE, msg
    76: if (N_ELEMENTS(Data76) ne nrows) then MESSAGE, msg
    75: if (N_ELEMENTS(Data75) ne nrows) then MESSAGE, msg
    74: if (N_ELEMENTS(Data74) ne nrows) then MESSAGE, msg
    73: if (N_ELEMENTS(Data73) ne nrows) then MESSAGE, msg
    72: if (N_ELEMENTS(Data72) ne nrows) then MESSAGE, msg
    71: if (N_ELEMENTS(Data71) ne nrows) then MESSAGE, msg
    70: if (N_ELEMENTS(Data70) ne nrows) then MESSAGE, msg
    69: if (N_ELEMENTS(Data69) ne nrows) then MESSAGE, msg
    68: if (N_ELEMENTS(Data68) ne nrows) then MESSAGE, msg
    67: if (N_ELEMENTS(Data67) ne nrows) then MESSAGE, msg
    66: if (N_ELEMENTS(Data66) ne nrows) then MESSAGE, msg
    65: if (N_ELEMENTS(Data65) ne nrows) then MESSAGE, msg
    64: if (N_ELEMENTS(Data64) ne nrows) then MESSAGE, msg
    63: if (N_ELEMENTS(Data63) ne nrows) then MESSAGE, msg
    62: if (N_ELEMENTS(Data62) ne nrows) then MESSAGE, msg
    61: if (N_ELEMENTS(Data61) ne nrows) then MESSAGE, msg
    60: if (N_ELEMENTS(Data60) ne nrows) then MESSAGE, msg
    59: if (N_ELEMENTS(Data59) ne nrows) then MESSAGE, msg
    58: if (N_ELEMENTS(Data58) ne nrows) then MESSAGE, msg
    57: if (N_ELEMENTS(Data57) ne nrows) then MESSAGE, msg
    56: if (N_ELEMENTS(Data56) ne nrows) then MESSAGE, msg
    55: if (N_ELEMENTS(Data55) ne nrows) then MESSAGE, msg
    54: if (N_ELEMENTS(Data54) ne nrows) then MESSAGE, msg
    53: if (N_ELEMENTS(Data53) ne nrows) then MESSAGE, msg
    52: if (N_ELEMENTS(Data52) ne nrows) then MESSAGE, msg
    51: if (N_ELEMENTS(Data51) ne nrows) then MESSAGE, msg
    50: if (N_ELEMENTS(Data50) ne nrows) then MESSAGE, msg
    49: if (N_ELEMENTS(Data49) ne nrows) then MESSAGE, msg
    48: if (N_ELEMENTS(Data48) ne nrows) then MESSAGE, msg
    47: if (N_ELEMENTS(Data47) ne nrows) then MESSAGE, msg
    46: if (N_ELEMENTS(Data46) ne nrows) then MESSAGE, msg
    45: if (N_ELEMENTS(Data45) ne nrows) then MESSAGE, msg
    44: if (N_ELEMENTS(Data44) ne nrows) then MESSAGE, msg
    43: if (N_ELEMENTS(Data43) ne nrows) then MESSAGE, msg
    42: if (N_ELEMENTS(Data42) ne nrows) then MESSAGE, msg
    41: if (N_ELEMENTS(Data41) ne nrows) then MESSAGE, msg
    40: if (N_ELEMENTS(Data40) ne nrows) then MESSAGE, msg
    39: if (N_ELEMENTS(Data39) ne nrows) then MESSAGE, msg
    38: if (N_ELEMENTS(Data38) ne nrows) then MESSAGE, msg
    37: if (N_ELEMENTS(Data37) ne nrows) then MESSAGE, msg
    36: if (N_ELEMENTS(Data36) ne nrows) then MESSAGE, msg
    35: if (N_ELEMENTS(Data35) ne nrows) then MESSAGE, msg
    34: if (N_ELEMENTS(Data34) ne nrows) then MESSAGE, msg
    33: if (N_ELEMENTS(Data33) ne nrows) then MESSAGE, msg
    32: if (N_ELEMENTS(Data32) ne nrows) then MESSAGE, msg
    31: if (N_ELEMENTS(Data31) ne nrows) then MESSAGE, msg
    30: if (N_ELEMENTS(Data30) ne nrows) then MESSAGE, msg
    29: if (N_ELEMENTS(Data29) ne nrows) then MESSAGE, msg
    28: if (N_ELEMENTS(Data28) ne nrows) then MESSAGE, msg
    27: if (N_ELEMENTS(Data27) ne nrows) then MESSAGE, msg
    26: if (N_ELEMENTS(Data26) ne nrows) then MESSAGE, msg
    25: if (N_ELEMENTS(Data25) ne nrows) then MESSAGE, msg
    24: if (N_ELEMENTS(Data24) ne nrows) then MESSAGE, msg
    23: if (N_ELEMENTS(Data23) ne nrows) then MESSAGE, msg
    22: if (N_ELEMENTS(Data22) ne nrows) then MESSAGE, msg
    21: if (N_ELEMENTS(Data21) ne nrows) then MESSAGE, msg
    20: if (N_ELEMENTS(Data20) ne nrows) then MESSAGE, msg
    19: if (N_ELEMENTS(Data19) ne nrows) then MESSAGE, msg
    18: if (N_ELEMENTS(Data18) ne nrows) then MESSAGE, msg
    17: if (N_ELEMENTS(Data17) ne nrows) then MESSAGE, msg
    16: if (N_ELEMENTS(Data16) ne nrows) then MESSAGE, msg
    15: if (N_ELEMENTS(Data15) ne nrows) then MESSAGE, msg
    14: if (N_ELEMENTS(Data14) ne nrows) then MESSAGE, msg
    13: if (N_ELEMENTS(Data13) ne nrows) then MESSAGE, msg
    12: if (N_ELEMENTS(Data12) ne nrows) then MESSAGE, msg
    11: if (N_ELEMENTS(Data11) ne nrows) then MESSAGE, msg
    10: if (N_ELEMENTS(Data10) ne nrows) then MESSAGE, msg
    9: if (N_ELEMENTS(Data9) ne nrows) then MESSAGE, msg
    8: if (N_ELEMENTS(Data8) ne nrows) then MESSAGE, msg
    7: if (N_ELEMENTS(Data7) ne nrows) then MESSAGE, msg
    6: if (N_ELEMENTS(Data6) ne nrows) then MESSAGE, msg
    5: if (N_ELEMENTS(Data5) ne nrows) then MESSAGE, msg
    4: if (N_ELEMENTS(Data4) ne nrows) then MESSAGE, msg
    3: if (N_ELEMENTS(Data3) ne nrows) then MESSAGE, msg
    2: if (N_ELEMENTS(Data2) ne nrows) then MESSAGE, msg
    else:
    endswitch
    
  endelse


  ; Verify that the header (if provided) has the correct number of elements.
  
  nheader = N_Elements(header)
  if (nheader gt 0) then begin
    ; Quietly ignore null strings.
    if (ARRAY_EQUAL(header,'')) then begin
      nheader = 0
    endif else begin
      if (nheader ne nfields || SIZE(header,/type) ne 7) then begin
        MESSAGE, 'HEADER must be a string array of length equal to the number of columns.'
      endif
    endelse
  endif


  ; Start writing the file.
  
  OPENW, lun, filename, /GET_LUN
; What about handling COMMAS or QUOTES?!

  format = (nfields ge 2) ? '(' + STRTRIM(nfields-1,2)+'(A,","),A)' : '(A)'
  
  ; Printing out extra headers to csv file
  if n_elements(tableHeader) gt 0 then begin
    for i=0, n_elements(tableHeader)-1 do begin
      ;check if there is comma in the string
      posComma = stregex(tableHeader[i], ',')
      posQuote = stregex(tableHeader[i], '"')
      if (posComma eq -1) && (posQuote eq -1) then printf, lun, tableHeader[i], FORMAT=format else printf, lun, '"' + tableHeader[i] + '"', FORMAT=format
    endfor
  endif
  
  if (nheader gt 0) then begin
    PRINTF, lun, header, FORMAT=format
  endif
  
  
  if (isStruct) then begin  ; Structure fields
  
    strCopy = STRARR(nfields, nrows)

    for i=0,nfields-1 do begin
      strCopy[i,*] = WRITE_CSV_CONVERT(Data1.(i))
    endfor
    
    PRINTF, lun, strCopy, FORMAT=format
    
  endif else if (isArray) then begin  ; Two-dimensional array
  
    PRINTF, lun, WRITE_CSV_CONVERT(Data1), FORMAT=format
    
  endif else begin  ; Individual data arguments
  
    strCopy = STRARR(nfields, nrows)
    
    switch (nfields) of

    100: strCopy[99,*] = WRITE_CSV_CONVERT(Data100)
    99: strCopy[98,*] = WRITE_CSV_CONVERT(Data99)
    98: strCopy[97,*] = WRITE_CSV_CONVERT(Data98)
    97: strCopy[96,*] = WRITE_CSV_CONVERT(Data97)
    96: strCopy[95,*] = WRITE_CSV_CONVERT(Data96)
    95: strCopy[94,*] = WRITE_CSV_CONVERT(Data95)
    94: strCopy[93,*] = WRITE_CSV_CONVERT(Data94)
    93: strCopy[92,*] = WRITE_CSV_CONVERT(Data93)
    92: strCopy[91,*] = WRITE_CSV_CONVERT(Data92)
    91: strCopy[90,*] = WRITE_CSV_CONVERT(Data91)
    90: strCopy[89,*] = WRITE_CSV_CONVERT(Data90)
    89: strCopy[88,*] = WRITE_CSV_CONVERT(Data89)
    88: strCopy[87,*] = WRITE_CSV_CONVERT(Data88)
    87: strCopy[86,*] = WRITE_CSV_CONVERT(Data87)
    86: strCopy[85,*] = WRITE_CSV_CONVERT(Data86)
    85: strCopy[84,*] = WRITE_CSV_CONVERT(Data85)
    84: strCopy[83,*] = WRITE_CSV_CONVERT(Data84)
    83: strCopy[82,*] = WRITE_CSV_CONVERT(Data83)
    82: strCopy[81,*] = WRITE_CSV_CONVERT(Data82)
    81: strCopy[80,*] = WRITE_CSV_CONVERT(Data81)
    80: strCopy[79,*] = WRITE_CSV_CONVERT(Data80)
    79: strCopy[78,*] = WRITE_CSV_CONVERT(Data79)
    78: strCopy[77,*] = WRITE_CSV_CONVERT(Data78)
    77: strCopy[76,*] = WRITE_CSV_CONVERT(Data77)
    76: strCopy[75,*] = WRITE_CSV_CONVERT(Data76)
    75: strCopy[74,*] = WRITE_CSV_CONVERT(Data75)
    74: strCopy[73,*] = WRITE_CSV_CONVERT(Data74)
    73: strCopy[72,*] = WRITE_CSV_CONVERT(Data73)
    72: strCopy[71,*] = WRITE_CSV_CONVERT(Data72)
    71: strCopy[70,*] = WRITE_CSV_CONVERT(Data71)
    70: strCopy[69,*] = WRITE_CSV_CONVERT(Data70)
    69: strCopy[68,*] = WRITE_CSV_CONVERT(Data69)
    68: strCopy[67,*] = WRITE_CSV_CONVERT(Data68)
    67: strCopy[66,*] = WRITE_CSV_CONVERT(Data67)
    66: strCopy[65,*] = WRITE_CSV_CONVERT(Data66)
    65: strCopy[64,*] = WRITE_CSV_CONVERT(Data65)
    64: strCopy[63,*] = WRITE_CSV_CONVERT(Data64)
    63: strCopy[62,*] = WRITE_CSV_CONVERT(Data63)
    62: strCopy[61,*] = WRITE_CSV_CONVERT(Data62)
    61: strCopy[60,*] = WRITE_CSV_CONVERT(Data61)
    60: strCopy[59,*] = WRITE_CSV_CONVERT(Data60)
    59: strCopy[58,*] = WRITE_CSV_CONVERT(Data59)
    58: strCopy[57,*] = WRITE_CSV_CONVERT(Data58)
    57: strCopy[56,*] = WRITE_CSV_CONVERT(Data57)
    56: strCopy[55,*] = WRITE_CSV_CONVERT(Data56)
    55: strCopy[54,*] = WRITE_CSV_CONVERT(Data55)
    54: strCopy[53,*] = WRITE_CSV_CONVERT(Data54)
    53: strCopy[52,*] = WRITE_CSV_CONVERT(Data53)
    52: strCopy[51,*] = WRITE_CSV_CONVERT(Data52)
    51: strCopy[50,*] = WRITE_CSV_CONVERT(Data51)
    50: strCopy[49,*] = WRITE_CSV_CONVERT(Data50)
    49: strCopy[48,*] = WRITE_CSV_CONVERT(Data49)
    48: strCopy[47,*] = WRITE_CSV_CONVERT(Data48)
    47: strCopy[46,*] = WRITE_CSV_CONVERT(Data47)
    46: strCopy[45,*] = WRITE_CSV_CONVERT(Data46)
    45: strCopy[44,*] = WRITE_CSV_CONVERT(Data45)
    44: strCopy[43,*] = WRITE_CSV_CONVERT(Data44)
    43: strCopy[42,*] = WRITE_CSV_CONVERT(Data43)
    42: strCopy[41,*] = WRITE_CSV_CONVERT(Data42)
    41: strCopy[40,*] = WRITE_CSV_CONVERT(Data41)
    40: strCopy[39,*] = WRITE_CSV_CONVERT(Data40)
    39: strCopy[38,*] = WRITE_CSV_CONVERT(Data39)
    38: strCopy[37,*] = WRITE_CSV_CONVERT(Data38)
    37: strCopy[36,*] = WRITE_CSV_CONVERT(Data37)
    36: strCopy[35,*] = WRITE_CSV_CONVERT(Data36)
    35: strCopy[34,*] = WRITE_CSV_CONVERT(Data35)
    34: strCopy[33,*] = WRITE_CSV_CONVERT(Data34)
    33: strCopy[32,*] = WRITE_CSV_CONVERT(Data33)
    32: strCopy[31,*] = WRITE_CSV_CONVERT(Data32)
    31: strCopy[30,*] = WRITE_CSV_CONVERT(Data31)
    30: strCopy[29,*] = WRITE_CSV_CONVERT(Data30)
    29: strCopy[28,*] = WRITE_CSV_CONVERT(Data29)
    28: strCopy[27,*] = WRITE_CSV_CONVERT(Data28)
    27: strCopy[26,*] = WRITE_CSV_CONVERT(Data27)
    26: strCopy[25,*] = WRITE_CSV_CONVERT(Data26)
    25: strCopy[24,*] = WRITE_CSV_CONVERT(Data25)
    24: strCopy[23,*] = WRITE_CSV_CONVERT(Data24)
    23: strCopy[22,*] = WRITE_CSV_CONVERT(Data23)
    22: strCopy[21,*] = WRITE_CSV_CONVERT(Data22)
    21: strCopy[20,*] = WRITE_CSV_CONVERT(Data21)
    20: strCopy[19,*] = WRITE_CSV_CONVERT(Data20)
    19: strCopy[18,*] = WRITE_CSV_CONVERT(Data19)
    18: strCopy[17,*] = WRITE_CSV_CONVERT(Data18)
    17: strCopy[16,*] = WRITE_CSV_CONVERT(Data17)
    16: strCopy[15,*] = WRITE_CSV_CONVERT(Data16)
    15: strCopy[14,*] = WRITE_CSV_CONVERT(Data15)
    14: strCopy[13,*] = WRITE_CSV_CONVERT(Data14)
    13: strCopy[12,*] = WRITE_CSV_CONVERT(Data13)
    12: strCopy[11,*] = WRITE_CSV_CONVERT(Data12)
    11: strCopy[10,*] = WRITE_CSV_CONVERT(Data11)
    10: strCopy[9,*] = WRITE_CSV_CONVERT(Data10)
    9: strCopy[8,*] = WRITE_CSV_CONVERT(Data9)
    8: strCopy[7,*] = WRITE_CSV_CONVERT(Data8)
    7: strCopy[6,*] = WRITE_CSV_CONVERT(Data7)
    6: strCopy[5,*] = WRITE_CSV_CONVERT(Data6)
    5: strCopy[4,*] = WRITE_CSV_CONVERT(Data5)
    4: strCopy[3,*] = WRITE_CSV_CONVERT(Data4)
    3: strCopy[2,*] = WRITE_CSV_CONVERT(Data3)
    2: strCopy[1,*] = WRITE_CSV_CONVERT(Data2)
    1: strCopy[0,*] = WRITE_CSV_CONVERT(Data1)      
    endswitch
    
    PRINTF, lun, strCopy, FORMAT=format

  endelse
  
  FREE_LUN, lun

  return
  
ioerr:
  ON_IOERROR, null
  if (N_ELEMENTS(lun) gt 0) then $
    FREE_LUN, lun
  MESSAGE, !ERROR_STATE.msg

end

