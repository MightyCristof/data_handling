;-----------------------------------------------------------------------------------------
; NAME:                                                                      IDL Procedure
;   buddy_sys
;   
; PURPOSE:
;   Sort department grads and postdocs into random groups for post-apocalypse COVID-19 check-ins.
;   
; CALLING SEQUENCE:
;   buddy_sys
;	
; INPUTS:
;   
; OPTIONAL INPUTS:
;	
; OUTPUTS:
;   
; OPTIONAL OUTPUTS:
;  
; COMMENTS:
;   Yeah, it's all hard-coded; best-practices, best-schmactices.
;   "Why the hell is this in IDL?"
;   Maybe I'll take this "exiled for the good of the realm" alone time
;     to finally refresh my Python skills...
;
; EXAMPLES:
;	
; PROCEDURES CALLED:
;	
; REVISION HISTORY:
;   2020-Mar-22  Written by Christopher M. Carroll (Dartmouth)
;-----------------------------------------------------------------------------------------
PRO buddy_sys


;; err'body
pd = ['TONIMA ANANNA','JAMES H BROWN','TAK CHU LI','ZHAO LI','LEIGH NORRIS','ASHLEY PERK','ALEXANDER SMITH']
gr = ['DANIEL ALLMAN','THOMAS BOUDREAUX','WILLIAM BRAASCH','BENJAMIN BROCK','MCKINLEY BRUMBACK','YANPING CAI', $
      'KELLY CANTWELL','CHRISTOPHER CARROLL','RILEY CHIEN','ANTHONY CRESSMAN','VINCENT FLYNN','AYLIN GARCIA SOTO', $
      'CHRISTINA GILLIGAN','BRENT HARRISON','EMILY HUDSON','LINTA JOSEPH','SISIRA KANHIRATHINGAL','MUHAMMAD Q KHAN', $
      'MAX KRACKOW','SHAN-CHANG LIN','CHRYSTAL MOSER','MAGDALINA MOSES','SARA PEERY','GRAYSON PETTER','STEPHANIE PODJED', $
      'MURONG QIN','FRANCISCO RIBERI','KEIGHLEY ROCKCLIFFE','PARTH SABHARWAL','VIVIAN SABLA','ATHIRA SANAL','KANAV SETIA', $
      'BHARGAVA THYAGARAJAN','AVERY TISHUE','JULES VAN IRSEL','SARA VANNAH','HUI WANG','WEISHI WANG','KATHRYN WEIL', $
      'KELLY E WHALEN','JACOB WILLARD','ETHAN WILLIAMS','QIDONG XU','WEI YAN','JUN YANG','JACKSON YANT']

;; random without replacement
randn = randomu(seed,46)
rands = sort(randn)
ind = rands[0:45]

;; initialize groups
ngr = n_elements(gr)
sz = 4
ngroups = ngr/sz
group = 'GROUP'+strtrim(string(indgen(ngroups,start=1),format='(i02)'),2)

;; first pass bulk grad groups
for i = 0,ngroups-1 do re = execute(group[i]+' = strjoin(gr[ind[i*4:3+(i*4)]],",")')
;; add stragglers and postdocs
strag = [gr[ind[i*4:-1]],pd]
nstrag = n_elements(strag)
for i = 0,nstrag-1 do re = execute(group[i]+' = '+group[i]+'+","+strag[i]')
;; print groups to screen
for i = 0,ngroups-1 do re = execute('print, strlowcase(group[i]+": "+'+group[i]+')')


END


