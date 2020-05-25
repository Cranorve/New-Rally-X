	STATE = 0	;Invisible = 0, Visible =1
	DIRE = 1	;Direccion - Norte=0, Este=1, Sur=2, Oeste=3
	POSC = 2	;Posicion por caracter horizontal - 32*3
	COL = 3		;Columna - 0 a 3
	POSR = 4	;Posicion por caracter vertical - 56*3
	ROW = 5		;Linea - 0 a 3
	PFEL = 6	;Punteros fuente
	PFEH = 7
	PBEL = 8	;Punteros buffer
	PBEH = 9
	CONTH = 10	;Contador horizontal
	CONTV = 11
	

ANIMA_ENEMIGOS
	lda CONTENE
	asl			;*2
	asl			;*4
	asl			;*8
	asl			;*16
	tax
	sta TEMP0	;Buffer para X, numero enemigo
	
	lda TABLENE+STATE,X
	bne ES_VISIBLE
	rts
	
ES_VISIBLE
	lda TABLENE+PFEL,X	;ENEX
	sta PUNTOBJ
	
	lda TABLENE+PFEH,X	
	sta PUNTOBJ+1
	
	lda TABLENE+PBEL,X	;ENEBUFFERX
	sta TEMP1
	
	lda TABLENE+PBEH,X	
	sta TEMP1+1

	lda TABLENE+COL,X	;0 a 3
	and #3
	sta COLENE
	
	lda TABLENE+ROW,X	;0 a 3
	and #3
	sta ROWENE

	lda TABLENE+POSC,X	;32*3
	sta POSCENE			;Columna Memoria
		
	lda TABLENE+POSR,X	;56*3
	sta POSRENE			;Linea Memoria

	lda TABLENE+DIRE,X	;Norte=0, Este=1, Sur=2, Oeste=3
	and #3
	ror
	bcc ENE_VERTICAL
	jmp ENE_HORIZONTAL
	
ENE_VERTICAL	
	ror
	bcc ENE_NORTE
	jmp ENE_SUR
	
ENE_NORTE
	lda TABLENE+ROW,X	;Control Byte 0, scroll grueso
	dec TABLENE+ROW,X
	and #3
	sta TABLENE+ROW,X
	bne SIGUE_ENENORTE	;Continua scroll fino
		
	lda PUNTFUE
	sta PUNTDES
	lda PUNTFUE+1
	sta PUNTDES+1
	
	ldy POSRENE
	iny
	tya
	jsr CALC_XY
	
	ldy TABLENE+CONTV,X
	ldx #3
C_SCROLL_GNORTE			;scroll grueso
	lda (PUNTDES),Y
	pha
	lda (PUNTFUE),Y
	sta (PUNTDES),Y
	lda (TEMP1),Y
	sta (PUNTFUE),Y
	pla
	sta (TEMP1),Y
	dey
	dex
	bne C_SCROLL_GNORTE
		
	jsr SCROLL_FNORTE
	rts
	
SIGUE_ENENORTE
	ldy TABLENE+POSR,X	;POSRENE
	dey
	dey
	tya
	jsr CALC_XY
			
	ldy #1
	lda (PUNTFUE),Y
	beq J4_ENE_NORTE	;Es pista!
	
	cmp #20+128			;Cuadra?
	bne J1_ENE_NORTE
	jsr GIRA_ENE
	
J1_ENE_NORTE
	cmp #54+128			;Abol?
	bne J2_ENE_NORTE
	jsr GIRA_ENE

J2_ENE_NORTE		
	cmp #45+128			;Roca?
	bne J3_ENE_NORTE
	jsr GIRA_ENE
	
J3_ENE_NORTE
	cmp #8				;Humo?
	bne J4_ENE_NORTE
	jsr ES_HUMO	

J4_ENE_NORTE
	rts
	
	
SCROLL_FNORTE
	
	
ENE_SUR
ENE_HORIZONTAL

GIRA_ENE	
ES_HUMO	
	rts
	
	
;*** Calcula XY
CALC_XY
	pha
	asl
	tay
	pla
	cmp #128
	bcc J_CALC_XY
		
	inc CME1+2
	inc CME2+2
	
J_CALC_XY
	clc
CME1	lda TABLADL,Y
	adc POSCENE
	sta PUNTFUE		;AREA XY Lo		
	iny
CME2	lda TABLADL,Y
	adc #0
	sta PUNTFUE+1	;AREA XY Hi
		
	lda #>TABLADL
	sta CME1+2
	sta CME2+2
	rts
	
	
TABLENE
	.BYTE 1		;STATE
	.BYTE 0		;Direccion
	.BYTE 66	;Pos X
	.BYTE 0		;Columna
	.BYTE 169	;Pos Y
	.BYTE 0		;Linea
	.WORD ENE1	;Font
	.WORD E1BU	;Buffer
	.BYTE 7		;CONTH
	.BYTE 7		;CONTV
	

	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0	
	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE 1,66,0,168,0,0,0,0,0,0,0,0,0,0,0,0	

MASCNORTE
	.BYTE 255,252,252,255
	.BYTE 195,0,0,0
	.BYTE 255,63,63,255
	.BYTE 252,240,240,240
	.BYTE 0,0,0,0
	.BYTE 63,15,15,15
	


POSINIENE
	.BYTE 66,168
	.BYTE 66,168
	.BYTE 66,168
	.BYTE 66,168
	.BYTE 66,168
	.BYTE 66,168
	.BYTE 66,168
	
AI_ENEMIGO
	rts	
	