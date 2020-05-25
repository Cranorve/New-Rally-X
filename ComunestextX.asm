;Pantalla modo de textos GR.3-Antic 6
INI_PANTALLA
	jsr CLR_PMG		;Limpia zona para P/M

;Inicia P/M para pantallas de textos
	clc
	lda >PLAYMISS
	adc #4

	tax	
	stx TEMP0+1
	inx
	stx TEMP1+1
	inx
	stx TEMP2+1
	inx
	stx TEMP3+1

	lda #0
	sta SIZEM
	sta SIZEP0
	sta SIZEP1
	sta SIZEP2
	sta SIZEP3
	sta PRIOR

	lda #2		
	sta GRACTL		;Activa Player

;Inicia pantalla modo de textos
INI_MODOTEXT
	jsr MUTE

	ldx #4
COLOR_TEXT
	lda COLORTEXT,X	;Toma colores definidos para pantallas activas
	sta COLOR0,X	;guarda en registos PF0 a PF4
	dex
	bpl COLOR_TEXT
		
	lda >MEMOGR1
	sta PUNTDES+1
	lda <MEMOGR1
	sta PUNTDES
		
C1_CLEARGR1	
	tay
C2_CLEARGR1
	sta (PUNTDES),Y
	iny
	bne C2_CLEARGR1
					
	lda >SETNRX
	sta CHBAS
	
	lda #$3E		;Playfield normal
	sta SDMCTL		;P/M Resolucion una linea
					;Habilita DLI - Habilita VBI
	rts


;*************************************
PUT_TEXTO			;Escribe por caracter
	ldy #0
	sty ATRACT
C1_PUTTEXTO
	lda (PUNTFUE),Y
	cmp #155
	beq J1_PUTTEXTO
	sta (PUNTDES),Y
	
	iny
	lda #3			;Tiempo entre letras
	jsr PAUSA
	
	lda CTRMODO+1
	bne C1_PUTTEXTO
	
	lda STRIG0
	bne  C1_PUTTEXTO
	rts

J1_PUTTEXTO	
	lda #12			;Tiempo entre Lineas
	jsr PAUSA
	lda #1
	rts
	

;************************************
PRINT				;Escribe por frases
	ldy #0
C_PRINT
	lda (PUNTFUE),Y
	cmp #155
	bne J_PRINT
	rts

J_PRINT	
	sta (PUNTDES),Y
	iny
	jmp C_PRINT	


;**************************************************************
COLORTEXT
	.BYTE $34,$1E,$0E,$C4,$28		;Rojo - Amarillo - Blanco - Verde - Naranjo
	
BTEXT
	.BYTE 2,3,3,3,3,3,3,3			;P0(AMARILLO)
	.BYTE 2,2,2,2,2,7,7,7 				
	.BYTE 0,0,128,192,224,192,128,0	;P1(AMARILLO) 
	.BYTE 0,0,0,0,0,0,0,0	

STEXT
	.BYTE 48,120,72,64,112,56,8,72	;P2(ROJO) 
	.BYTE 120,48,0,0,0,0,0,0	

LTEXT
	.BYTE 64,64,64,64,64,64,64,72	;P2(ROJO) 
	.BYTE 120,120,0,0,0,0,0,0	
		
RTEXT
	.BYTE 32,134,137,17,169,40,72,72	;P0(NEGRO)
	.BYTE 73,164,148,146,65,81,157,137
	.BYTE 74,74,66,64,37,26,128,192	
	
	.BYTE 208,0,64,64,32,128,128,128	;P1(NEGRO) 
	.BYTE 144,64,32,32,32,16,80,80
	.BYTE 32,192,128,160,16,32,0,32		
	
	.BYTE 0,0,0,2,2,3,19,19		;P2(ROJO) 
	.BYTE 18,91,106,108,62,46,98,118
	.BYTE 53,53,61,63,26,0,64,0				
	
	.BYTE 0,0,32,32,0,0,0,0		;P3(ROJO) 
	.BYTE 0,0,64,64,64,96,32,160
	.BYTE 192,0,0,0,32,0,0,0					

HTEXT
	.BYTE 0,56,78,137,129,204,19,33,33,19,100,164,136,144,145,74,72,68,130,132,164,90,1				;P0(NEGRO) 
	.BYTE 0,32,80,16,16,144,32,16,16,32,64,64,32,32,64,32,32,16,16,16,80,96,128					;P1(NEGRO) 
	.BYTE 1,3,49,118,126,51,236,158,222,236,155,91,103,111,110,53,55,59,125,123,91,1,0				;P2(AMARILLO)
	.BYTE 128,192,160,224,224,96,192,224,224,192,128,128,192,192,128,192,192,224,224,224,160,128,0	;P3(AMARILLO) 
	
HISCORE	
	.BYTE 64,64,4,5,0,1,0,1,0,1,0,1
	
INIHSCORE
	.BYTE 0,2,0,0,0,0
	
SCORE	
	.BYTE 64,64,64,64,64,64,64,64,0,1,0,1
	