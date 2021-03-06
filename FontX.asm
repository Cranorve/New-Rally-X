;***	 FONT OBJETOS - Antic 4 - $A000 - 1024 Bytes
	ORG SETAREA						

;PISTA
	.BYTE 170,170,170,170,170,170,170,170		;0
	
;HUMO
	.BYTE 170,160,143,63,63,15,252,195		;1
	.BYTE 171,47,3,60,252,15,240,252
	.BYTE 234,242,204,252,252,60,242,252
	.BYTE 243,252,195,51,60,60,60,143
	.BYTE 252,240,207,207,63,255,252,51		;5
	.BYTE 252,242,202,202,242,242,202,242
	.BYTE 143,143,63,63,51,136,170,170
	.BYTE 63,207,243,207,207,35,168,170
	.BYTE 242,252,252,252,204,194,42,170
	
CPPUNT
	.BYTE 170,170,170,170,170,170,170,170		;10	Ganancia C
	.BYTE 138,34,34,34,34,34,34,138			;11	 Cero  (Ganancia B)
	.BYTE 170,34,34,138,138,34,34,170		;12	X
	.BYTE 170,10,162,162,138,42,2,170 	        ;13	2

;Esquinas
	.BYTE 175,175,191,191,245,245,245,245		;Up/Left -14
	.BYTE 250,250,254,254,95,95,95,95		;Up/Right
	.BYTE 95,95,95,95,254,254,250,250		;Down/Right                                                                                                                                                                                                                                                                                                                                                                                  
	.BYTE 245,245,245,245,191,191,175,175		;Down/Left
;Mitades
	.BYTE 255,255,255,255,85,85,85,85		;Up -18
	.BYTE 95,95,95,95,95,95,95,95			;Right
	.BYTE 85,85,85,85,255,255,255,255		;Down
	.BYTE 245,245,245,245,245,245,245,245		;Left
;Puntas	
	.BYTE 245,245,245,245,85,85,85,85		;Up/Left -22			
	.BYTE 95,95,95,95,85,85,85,85			;Up/Right			
	.BYTE 85,85,85,85,95,95,95,95			;Down/Right
	.BYTE 85,85,85,85,245,245,245,245		;Down/Left
;Centro
	.BYTE 85,85,85,85,85,85,85,85			; -26

;CPOINT
									;0							
	.BYTE 170,170,170,170,170,170,174,175	;27
									;0
	
									;0	
	.BYTE 175,175,175,175,175,175,174,174		;28 *
	.BYTE 234,250,254,250,234,170,170,170		;29
									
									;0	
	.BYTE 174,174,174,191,191,191,170,170		;30
									;0

;SCPOINT
	.BYTE 170,170,170,170,170,170,165,149		;31
	.BYTE 170,170,170,170,170,170,174,111		;32
									;0
									
	.BYTE 154,154,149,165,170,154,149,165		;33
	.BYTE 111,175,175,111,111,111,110,174		;34 *
									;29
									
									;0	
									;30
									;0
									
;LCPOINT
	.BYTE 170,170,170,170,170,170,154,154		;35
									;27
	
	.BYTE 154,154,154,154,154,154,149,149		;36
	.BYTE 175,175,175,175,175,111,110,110		;37 *
	
;ROCK
	.BYTE 162,42,42,168,35,163,141,141		;38
	.BYTE 170,130,60,244,52,53,53,53
	.BYTE 8,170,134,134,162,42,42,42
	.BYTE 141,17,20,20,133,132,20,21
	.BYTE 52,69,71,83,84,84,4,20			;42 *
	.BYTE 40,202,210,210,210,212,196,68
	.BYTE 133,133,133,133,161,168,26,10
	.BYTE 17,17,81,85,68,34,170,170
	.BYTE 82,10,42,34,164,162,170,162
;ARBOL
DATARBOL
	.BYTE 255,255,253,221,247,245,245,249		;47
	.BYTE 255,151,151,93,85,233,85,85
	.BYTE 255,255,127,103,95,187,119,87
	.BYTE 213,245,221,217,213,214,249,213
	.BYTE 214,217,149,85,89,101,86,245		;51
	.BYTE 102,93,221,217,86,85,93,118
	.BYTE 229,245,249,213,251,221,255,255
	.BYTE 85,149,149,217,87,91,85,85
	.BYTE 87,155,95,87,95,175,127,255
;BANG
	.BYTE 106,86,150,149,165,165,169,170		;56
	.BYTE 154,154,89,89,85,85,85,85 
	.BYTE 106,105,101,86,86,86,86,90 
	.BYTE 170,169,85,149,165,169,170,170 
	.BYTE 85,85,85,85,85,85,85,85 
	.BYTE 90,90,90,106,106,90,86,86 
	.BYTE 165,165,149,149,89,105,170,170 
	.BYTE 85,85,85,89,89,105,106,106 
	.BYTE 85,85,85,85,106,106,106,106 

ENE1
	.BYTE 170,170,168,168,168,168,170,170		;65
	.BYTE 150,150,20,20,20,20,125,125
	.BYTE 170,170,42,42,42,42,170,170
	.BYTE 169,169,160,160,160,160,160,160
	.BYTE 125,125,125,125,85,85,65,65		;69
	.BYTE 106,106,10,10,10,10,10,10
	.BYTE 85,85,85,85,85,85,85,85
	.BYTE 85,85,85,85,85,85,85,85
	.BYTE 85,85,85,85,85,85,85,85
	
;ENEMIGO2
	.BYTE 170,170,170,170,170,170,168,168		;65
	.BYTE 170,170,170,170,150,150,20,20
	.BYTE 170,170,170,170,170,170,42,42
	.BYTE 168,168,170,170,169,169,160,160
	.BYTE 20,20,125,125,125,125,125,125		;69
	.BYTE 42,42,170,170,106,106,10,10
	.BYTE 160,160,160,160,170,170,170,170
	.BYTE 85,85,65,65,170,170,170,170
	.BYTE 10,10,10,10,170,170,170,170
;ENEMIGO3
	.BYTE 170,170,168,168,168,168,170,170		;83
	.BYTE 150,150,20,20,20,20,125,125
	.BYTE 170,170,42,42,42,42,170,170
	.BYTE 169,169,160,160,160,160,160,160
	.BYTE 125,125,125,125,85,85,65,65
	.BYTE 106,106,10,10,10,10,10,10
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
;ENEMIGO4
	.BYTE 170,170,168,168,168,168,170,170		;92
	.BYTE 150,150,20,20,20,20,125,125
	.BYTE 170,170,42,42,42,42,170,170
	.BYTE 169,169,160,160,160,160,160,160
	.BYTE 125,125,125,125,85,85,65,65
	.BYTE 106,106,10,10,10,10,10,10
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
;ENEMIGO5
	.BYTE 170,170,168,168,168,168,170,170		;101
	.BYTE 150,150,20,20,20,20,125,125
	.BYTE 170,170,42,42,42,42,170,170
	.BYTE 169,169,160,160,160,160,160,160
	.BYTE 125,125,125,125,85,85,65,65
	.BYTE 106,106,10,10,10,10,10,10
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
;ENEMIGO6
	.BYTE 170,170,168,168,168,168,170,170		;110
	.BYTE 150,150,20,20,20,20,125,125
	.BYTE 170,170,42,42,42,42,170,170
	.BYTE 169,169,160,160,160,160,160,160
	.BYTE 125,125,125,125,85,85,65,65
	.BYTE 106,106,10,10,10,10,10,10
	.BYTE 170,170,170,170,170,170,170,170


	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170		;119
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 170,170,170,170,170,170,170,170
	.BYTE 138,34,34,34,34,34,34,138			;126 Cero
	
CERED
	.BYTE 69,17,17,17,17,17,17,69			


;***	FONT VENTANA - Antic 6/2 - $AA00 - 768 Bytes
	ORG SETVENT					
	
	.BYTE     5,16,80,80,80,20,5,0		; Cero
	.BYTE     64,80,20,20,20,16,64,0
	
	.BYTE     5,21,5,5,5,5,85,0
	.BYTE     0,0,0,0,0,0,80,0
	
	.BYTE     21,80,0,5,21,84,85,0
	.BYTE     80,20,84,80,64,0,84,0
	
	.BYTE     85,0,1,5,0,80,21,0
	.BYTE     84,80,64,80,20,20,80,0
	
	.BYTE     1,5,20,80,85,0,0,0
	.BYTE     80,80,80,80,84,80,80,0
	
	.BYTE     85,80,85,0,0,80,21,0
	.BYTE     80,0,80,20,20,20,80,0
	
	.BYTE     5,20,80,85,80,80,21,0
	.BYTE     80,0,0,80,20,20,80,0
	
	.BYTE     85,80,0,1,5,5,5,0
	.BYTE     84,20,80,64,0,0,0,0
	
	.BYTE     21,80,84,21,65,64,21,0
	.BYTE     64,16,16,64,84,20,80,0

	.BYTE     21,80,80,21,0,0,21,0		; Nueve		
	.BYTE     80,20,20,84,20,80,64,0		;Ascii 19 $13

LETRAA	
	.BYTE     5,20,80,80,85,80,80,0	
	.BYTE     64,80,20,20,84,20,20,0

	.BYTE     85,80,80,85,80,80,85,0
	.BYTE     80,20,20,80,20,20,80,0
LETRAC
	.BYTE     5,20,80,80,80,20,5,0
	.BYTE     80,20,0,0,0,20,80,0
LETRAD
	.BYTE     85,80,80,80,80,80,85,0
	.BYTE     64,80,20,20,20,80,64,0
LETRAE	
	.BYTE     85,80,80,85,80,80,85,0
	.BYTE     84,0,0,64,0,0,84,0

	.BYTE      2,2,0,0,0,0,0,0			; F * 30
	.BYTE      64,80,20,20,20,16,0,68	
	.BYTE      85,69,1,5,69,85,69,1		; G *
	.BYTE      84,68,0,64,68,84,68,0
LETRAH	
	.BYTE     80,80,80,85,80,80,80,0
	.BYTE     20,20,20,84,20,20,20,0
LETRAI	
	.BYTE     85,5,5,5,5,5,85,0
	.BYTE     80,0,0,0,0,0,80,0
VIDAS
	.BYTE      0,0,0,0,0,0,2,138			; J
	.BYTE      0,0,0,0,0,0,0,136
	.BYTE      170,138,2,10,138,170,138,2	; K   40
	.BYTE      168,136,0,128,136,168,136,0
	
	.BYTE     80,80,80,80,80,80,85,0		;L *
	.BYTE     0,0,0,0,0,0,84,0
	
	.BYTE     80,84,85,85,81,80,80,0		;M *
	.BYTE     20,84,84,84,20,20,20,0
LETRAN
	.BYTE     80,84,85,85,81,80,80,0
	.BYTE     20,20,20,84,84,84,20,0
LETRAO	
	.BYTE     21,80,80,80,80,80,21,0
	.BYTE     80,20,20,20,20,20,80,0
LETRAP	
	.BYTE     85,80,80,80,85,80,80,0		;50
	.BYTE     80,20,20,20,80,0,0,0
	
	.BYTE     21,80,80,80,81,80,21,0		;Q *
	.BYTE     80,20,20,20,84,80,68,0
LETRAR	
	.BYTE     85,80,80,80,85,81,80,0
	.BYTE     80,20,20,84,64,80,84,0
LETRAS	
	.BYTE     21,80,80,21,0,80,21,0
	.BYTE     64,80,0,80,20,20,80,0
	
	.BYTE     85,5,5,5,5,5,5,0			;T *
	.BYTE     80,0,0,0,0,0,0,0
LETRAU	
	.BYTE     80,80,80,80,80,80,21,0		;60
	.BYTE     20,20,20,20,20,20,80,0
GUION
	.BYTE     0,0,0,21,0,0,0,0
	.BYTE     0,0,0,84,0,0,0,0
ESPACIO	
	.BYTE     0,0,0,0,0,0,0,0			;32
	.BYTE     0,0,0,0,0,0,0,0
FUEL
	.BYTE	0,0,252,192,240,192,192,0
	.BYTE 	0,0,204,204,204,204,48,0
	.BYTE 	0,0,252,192,240,192,252,0
	.BYTE 	0,0,192,192,192,192,252,0

INDICADOR
	.BYTE 	0,3,3,0,0,0,0,0			; 35 - 70
	.BYTE 	0,0,2,0,0,0,0,0			; 71
	
RADAR
ZONA_00
	.DS 8							;Ascii 72 $48
ZONA_01
	.DS 8
ZONA_02
	.DS 8
ZONA_03
	.DS 8
ZONA_04
	.DS 8
ZONA_05
	.DS 8
ZONA_06
	.DS 8	
ZONA_07
	.DS 8
ZONA_08
	.DS 8	
ZONA_09
	.DS 8
ZONA_10
	.DS 8
ZONA_11
	.DS 8							;Atascii 83	


;***	FONT ATARIWARE - namco - $B000 - 176 Bytes
	ORG SETATARI
		
;	.BYTE 63,63,0,63,127,112,127,63		;ATASCII 32
;	.BYTE 254,255,15,255,255,15,255,255
;	.BYTE 1,63,63,1,1,1,1,0
;	.BYTE 224,255,255,224,224,224,255,255
;	.BYTE 31,31,0,31,63,56,63,31
;	.BYTE 255,255,7,255,255,7,255,255
;	.BYTE 28,157,159,158,158,158,158,158
;	.BYTE 254,254,0,0,0,0,0,0
;	.BYTE 120,120,120,120,120,120,120,120
;	.BYTE 240,240,240,240,240,240,255,127
;	.BYTE 248,248,248,248,248,248,255,255
;	.BYTE 120,120,120,120,121,121,249,240
;	.BYTE 255,255,0,255,255,192,255,255
;	.BYTE 248,252,60,252,252,60,252,252
;	.BYTE 231,239,252,240,240,240,240,240
;	.BYTE 243,243,3,3,3,3,3,1
;	.BYTE 255,255,192,255,255,192,255,255
;	.BYTE 240,248,56,248,240,0,241,241
;	.BYTE 7,15,15,15,15,15,207,199
;	.BYTE 255,255,0,0,0,0,255,255
;	.BYTE 60,60,60,60,60,60,63,31
;	.BYTE 0,0,0,0,0,0,254,254
    .BYTE 63,63,1,63,127,113,127,63
    .BYTE 129,207,207,193,193,193,193,192
    .BYTE 192,248,248,192,193,193,249,248
    .BYTE 254,255,7,255,255,199,255,255
    .BYTE 57,59,62,60,56,56,56,56
    .BYTE 231,231,7,7,7,7,7,7
    .BYTE 50,50,50,50,50,63,63,31
    .BYTE 99,99,96,99,103,231,231,195
    .BYTE 248,252,28,252,252,28,252,252
    .BYTE 231,239,248,240,224,224,224,224
    .BYTE 143,159,28,31,31,28,31,15
    .BYTE 224,240,112,240,224,3,227,227
    .BYTE 15,31,28,28,28,156,159,143
    .BYTE 243,243,3,3,3,3,243,241
    .BYTE 128,128,128,128,128,128,254,254
	
;***	FONT NEW RALLY X - Set de Caracteres Antic 6 - $A400 - 512 Bytes
	ORG SETNRX					
	
	.BYTE 0,0,0,0,0,0,0,0				; Espacio
	.BYTE 14,14,12,12,8,0,24,24			;!
	.BYTE 0,0,0,0,0,0,0,0				;"
	
	.BYTE 0,0,0,0,0,0,0,0				;#
	.BYTE 0,0,0,0,0,0,0,0				;$
	
	.BYTE 0,0,0,0,0,0,0,0				;%
	.BYTE 0,0,0,0,0,0,0,0				;&
	.BYTE 0,48,48,16,32,0,0,0			;'
	
	.BYTE 12,24,48,48,48,24,12,0		;(
	.BYTE 48,24,12,12,12,24,48,0		;) 	10 Caract.
	
	.BYTE 0,0,0,0,0,0,0,0				;*
	.BYTE 0,0,0,0,0,0,0,0				;+
	
	.BYTE 0,0,0,0,0,0,0,0				;,
	.BYTE 0,0,0,124,0,0,0,0			;-
	
	.BYTE 0,0,0,0,0,48,48,0			; .
	.BYTE 24,24,24,24,24,24,0,0			; /	16 Caract. 
	
Numeros
	.BYTE 56,76,198,198,198,100,56,0	
	.BYTE 48,112,48,48,48,48,252,0
	.BYTE 124,198,14,60,120,224,254,0
	.BYTE 254,12,24,60,6,198,124,0
	.BYTE 28,60,108,204,254,12,12,0	
	.BYTE 252,192,252,6,6,198,124,0
	.BYTE 60,96,192,252,198,198,124,0
	.BYTE 254,198,12,24,48,48,48,0
	.BYTE 120,196,228,120,158,134,124,0
	.BYTE 124,198,198,126,6,12,120,0		;26 Caract. 

	.BYTE 0,0,0,0,0,0,0,0				; :	
	.BYTE 0,0,0,0,0,0,0,0				; ;
	.BYTE 0,0,0,0,0,0,0,0				; <
	.BYTE 0,126,126,0,126,126,0,0		; =
	.BYTE 24,24,24,24,24,24,0,0			; > 30 parche1
	.BYTE 0,12,24,40,40,72,72,72		; ? 31 parche2
	.BYTE 1,3,3,1,1,1,0,0				; @ 32 parche3
;Letras	
	.BYTE 56,108,198,198,254,198,198,0	; A
	.BYTE 252,198,198,252,198,198,252,0
	.BYTE 60,102,192,192,192,102,60,0	; C
	.BYTE 248,204,198,198,198,204,248,0	; D
	.BYTE 254,192,192,248,192,192,254,0	; E
	.BYTE 254,192,192,248,192,192,192,0	; F
	.BYTE 62,96,192,206,198,102,62,0
	.BYTE 198,198,198,254,198,198,198,0	; H
	.BYTE 252,48,48,48,48,48,252,0		; I
	.BYTE 0,0,0,0,0,0,0,0				; J - 6,6,6,6,6,198,124,0			;
	.BYTE 198,204,216,240,248,220,206,0
	.BYTE 192,192,192,192,192,192,254,0
	.BYTE 198,238,254,254,214,198,198,0
	.BYTE 198,230,246,254,222,206,198,0	; N
	.BYTE 124,198,198,198,198,198,124,0	; O
	.BYTE 252,198,198,198,252,192,192,0	; P
	.BYTE 0,0,0,0,0,0,0,0				; Q - 124,198,198,198,222,204,122,0
	.BYTE 252,198,198,206,248,220,206,0	; R
	.BYTE 120,204,192,124,6,198,124,0	; S
	.BYTE 252,48,48,48,48,48,48,0		; T
	.BYTE 198,198,198,198,198,198,124,0	; U
	.BYTE 198,198,198,238,124,56,16,0	; 55 Caract
	.BYTE 198,198,214,254,254,238,198,0	; W
	.BYTE 198,238,124,56,124,238,198,0	; X
	.BYTE 204,204,252,120,48,48,48,0		; Y
	.BYTE 0,0,0,0,0,0,0,0				; Z - 0,78,164,164,228,164,164,164

	.BYTE 0,76,170,170,234,172,170,170	; 
	.BYTE 0,81,17,81,85,95,91,81
	.BYTE 0,38,85,85,117,86,85,85
	.BYTE 0,99,66,66,98,66,66,107
	.BYTE 0,64,64,64,64,64,64,96
