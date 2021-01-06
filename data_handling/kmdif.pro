       SUBROUTINE KMDIF(S,ZU,BS,BL,DIFF,F,NTOT,START,BINSIZ,LSTEP,
     +                   OUT,IBIN,IU)

C
C      *       INPUT    ZU(I)  :  UNCENSORED DATA POINTS                    *
C      *                NTOT   :  TOTAL NUMBER OF DATA POINTS,=IU+IC.       *
C      *                 IU    :  NUMBER OF UNCENSORED DATA POINTS          *
C      *                 S(L)  :  PL ESTIMATOR                              *
C      *                 OUT   :  OUTPUT FILE NAME. IF IT IS BLANK          *
C      *                          THE RESULTS WILL BE SHOWN ON THE          *
C      *                          TERMINAL.                                 *
C      *                START  :  STARTING VALUE OF THE FIRST BIN           *
C      *                BINSIZ :  WIDTH OF THE BIN                          *
C      *                LSTEP  :  NUMBER OF BINS                            *
C      *                IBIN   :  DIMENSION                                 *
C      *              ICHANGE  :  INDICATES IF THE LAST POINT (OR THE       *
C      *                            FIRST POINT FOR UPPER LIMITS DATA)      *
C      *                            HAS BEEN CHANGED TO A DETECTION.        *
C      *                                                                    *
C      *      OTHERS                                                        *
C      *               BS(J)   :  STARTING VALUE FOR THE BIN J              *
C      *               BL(J)   :  ENDING VALUE FOR THE BIN J                *
C      *               DIFF(J) :  DIFFERENTIAL KM ESTIMATOR AT BIN J        *
C      *               F(I)    :  MASS OF THE I TH DATA POINT               *


FUNCTION KMDIF, s, $        ;; survival analysis
                zu, $       ;; uncensored data point
                bs, $       ;; start value for bin j
                bl, $       ;; end value for bin j
                diff, $     ;; differential km estimator at bin j
                f, $        ;; mass of i-th data point
                ntot, $     ;; total number of data points IU + IC
                start, $    ;; starting value of first bin
                binsiz, $   ;; width of the bin
                lstep, $    ;; number of bins
                out, $      ;; output file name
                ibin, $     ;; dimension
                iu          ;; number of uncensored data points





;; i == number of sources
;; j == number of diffkm bins


diff = dblarr(n_elements(xdw))
f = dblarr(n_elements(xdw))
ntot = n_elements(xdw)
start = -1.5
binsiz = 0.5
lstep = 10.
iu = total(xdw eq 1)


indu = where(xdw eq 1)


;C       *    FIRST, COMPUTE THE MASS OF EACH POINT                          *
f = dblarr(n_elements(s))
f[0] = 1.-s[0]
for i = 1,iu-1 do f[i] = abs(s[i]-s[i-1])

;C       *  SET THE BIN BOUNDARIES.                                          *
bins = start+dindgen(lstep)*binsiz

;C      *       CHECK WHETHER THE I-TH POINT IS IN THE BIN                  *
ii = where()

;C      *       COMPUTE THE DIFFERENTIAL KM                                 *
;C      *         START PRINTING THE RESULTS                                  *
;C      * MULTIPLY DIFF(I) BY THE TOTAL NUMBER OF POINTS TO GET THE NUMBER    *
;C      * OF POINTS IN EACH BIN.                                              *













;       IMPLICIT REAL*8 (A-H,O-Z), INTEGER (I-N)
;       CHARACTER*9 OUT,CHECK
;
;       DIMENSION ZU(NTOT),S(NTOT),F(NTOT)
;       DIMENSION BS(IBIN),BL(IBIN),DIFF(IBIN)
;       CHECK='         '
;C
;C       *    FIRST, COMPUTE THE MASS OF EACH POINT                          *
;C
;        F(1) = 1.0 -S(1)
;       
;        DO 610 I = 2, IU
;           F(I) = DABS(S(I) - S(I-1))
;  610   CONTINUE
f = dblarr(n_elements(s))
f[0] = 1.-s[0]
for i = 1,n_elements(s)-1 do f[i] = abs(s[i]-s[i-1])



;; set bin boundaries
for j = 0,lstep-1 do begin
    bs[j] = start + binsiz*(j-1)
    bl[j] = start + binsz*j
endfor


C
C       *  SET THE BIN BOUNDARIES.                                          *
C
        DO 620 J = 1, LSTEP
           BS(J) = START + BINSIZ*(J-1)
           BL(J) = START + BINSIZ*J
  620   CONTINUE

        I = 1
        J = 0

  630   J = J + 1
        DIFF(J) = 0.0

C
C      *       CHECK WHETHER THE I-TH POINT IS IN THE BIN                  *
C
  640  IF(J .LE. LSTEP) THEN
         IF(ZU(I) .LT. BS(J)) THEN
            IF(I .GE. IU) THEN
               GOTO 630
            ENDIF
            I = I + 1
            GOTO 640
         ENDIF

C      *       COMPUTE THE DIFFERENTIAL KM                                 *
C
         IF(ZU(I) .GE. BL(J)) GOTO 630
         DIFF(J) = DIFF(J) + F(I)
   
         IF(I .LT. IU) THEN
            I = I + 1
            GOTO 640
         ENDIF
         GOTO 630
       ENDIF
C
C      *         START PRINTING THE RESULTS                                  *
C
          IF(OUT.EQ.CHECK) THEN
             PRINT *
             PRINT *,'           DIFFERENTIAL KM ESTIMATOR'
             PRINT 660
             PRINT *
          ELSE
             WRITE(60, 658)
             WRITE(60,659)
             WRITE(60, 660)
             WRITE(60,658)
          ENDIF
  658     FORMAT('  ')
  659     FORMAT(5X,'   DIFFERENTIAL KM ESTIMATOR')
  660     FORMAT(5X,'   BIN CENTER          D')

C
C      * MULTIPLY DIFF(I) BY THE TOTAL NUMBER OF POINTS TO GET THE NUMBER    *
C      * OF POINTS IN EACH BIN.                                              *
C
          SUM = 0.0
          DO 690 I = 1, LSTEP
             DIFF(I) =DIFF(I)*NTOT
             CENTER = 0.5*(BS(I) + BL(I))
             IF(OUT .EQ. CHECK) THEN
                PRINT 680, CENTER, DIFF(I)
             ELSE
                WRITE(60,680) CENTER, DIFF(I)
             ENDIF
  680        FORMAT(2F15.3)
             SUM = SUM + DIFF(I)
  690     CONTINUE

          IF(OUT .EQ. CHECK) THEN
             PRINT 700, SUM
             PRINT 658
          ELSE
             WRITE(60,700) SUM
             WRITE(60,658)
             WRITE(60,701)
 701         FORMAT(' (D GIVES THE ESTIMATED DATA POINTS IN EACH BIN)')
          ENDIF

 700      FORMAT(23X,'-------',/10X,'SUM =',F15.3)

       RETURN
       END










;; set bin boundaries
for j = 0,nbins-1 do begin
    bin_start[j] = val_start + binsz*(j-1)
    bin_end[j] = val_start + binsz*j
endfor

;; ckeck if i-th point is in the bin
if (j le nbins) then begin
    if (bin_start[i] lt bin_start[j]) then begin
        if (i ge n_events) then
            j = j+1
            diffkm[j] = 0.
        endif
        i = i+1
        ;; go back to if (j le nbins) ...
    endif
    
    if (event[i] ge bin_end[j]) then begin
        j = j+1
        diffkm[j] = 0
    endif
    
    if (i lt n_events) then begin
        i = i+1
    endif
    j = j+1
    diffkm[j] = 0.
endif

sum = 0
for i = 0,nbins-1 do begin
    diffkm[i] = diffkm[i]*tot_srcs
    center = 0.5*(bin_start[i] + bin_end[i])
    sum = sum+diffkm[i]
endfor




    
    
    