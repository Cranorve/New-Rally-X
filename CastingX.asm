CASTING
	lda #$0
	sta SDMCTL			;deshabilitab ANTIC
	sta NMIEN			;deshabilita NMIs
	sta NMIRES			;reset NMI

	lda <DLCAST			;Lista de Despliege modo texto
	sta SDLSTL
    lda >DLCAST
	sta SDLSTL+1
	
	lda <DLICASTAUTO		;DLI uno
	sta VDSLST
	lda >DLICASTAUTO
	sta VDSLST+1

	jsr INI_PANTALLA

	lda #$C0
	sta NMIEN				;Activa ANTIC
		
	lda <TEX0CAST
	sta PUNTFUE
	lda >TEX0CAST
	sta PUNTFUE+1
	
	lda <MEMOGR1+4			;NEW RALLY-X
	sta PUNTDES
	lda >MEMOGR1
	sta PUNTDES+1
	
	jsr PUT_TEXTO

	bne  J1_CASTING
	jmp SALE_CASTING

J1_CASTING
	Lda <TEX1CAST
	sta PUNTFUE
	lda >TEX1CAST
	sta PUNTFUE+1
	lda <MEMOGR1+20+7		;CAST
	sta PUNTDES
	lda >MEMOGR1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne J2_CASTING
	jmp SALE_CASTING

J2_CASTING
	lda #66
	sta TEMP0
	sta TEMP1
	
	ldy #7
C_CASTING_MYCAR
	lda CHANORTE,Y
	sta (TEMP0),Y
	dec TEMP0
	sta (TEMP0),Y
		
	lda RUENORTE,Y
	sta (TEMP1),Y
	dec TEMP1
	sta (TEMP1),Y
			
	dey
	bpl C_CASTING_MYCAR
			
	lda <TEX2CAST
	sta PUNTFUE
	lda >TEX2CAST
	sta PUNTFUE+1
	lda <MEMOGR1+2*20+1	
	sta PUNTDES
	lda >MEMOGR1+2*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J3_CASTING
	jmp SALE_CASTING

J3_CASTING
	lda #84
	sta TEMP0
	sta TEMP1
	
	ldy #7
C_CASTING_REDCAR
	lda CHANORTE,Y
	sta (TEMP0),Y
	dec TEMP0
	sta (TEMP0),Y
		
	lda RUENORTE,Y
	sta (TEMP1),Y
	dec TEMP1
	sta (TEMP1),Y
			
	dey
	bpl C_CASTING_REDCAR
	
	lda <TEX3CAST
	sta PUNTFUE
	lda >TEX3CAST
	sta PUNTFUE+1
	lda <MEMOGR1+3*20+1	;RED CAR
	sta PUNTDES
	lda >MEMOGR1+3*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J4_CASTING
	jmp SALE_CASTING
	
J4_CASTING
	lda #98
	sta TEMP0
	sta TEMP1
		
	ldy #15
C_CASTING_CHECKPOINT
	lda BTEXT,Y
	sta (TEMP0),Y
	lda BTEXT+16,Y
	sta (TEMP1),Y
	dey
	bpl C_CASTING_CHECKPOINT
		
	lda <TEX4CAST
	sta PUNTFUE
	lda >TEX4CAST
	sta PUNTFUE+1
	lda <MEMOGR1+4*20+1	;CHECK POINT	
	sta PUNTDES
	lda >MEMOGR1+4*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J5_CASTING
	jmp SALE_CASTING
	
J5_CASTING
	clc
	lda TEMP0
	adc #18
	sta TEMP0
	sta TEMP1
	sta TEMP2
	
	ldy #15
C_CASTING_SCHECKPOINT
	lda BTEXT,Y
	sta (TEMP0),Y
	lda BTEXT+16,Y
	sta (TEMP1),Y
	lda STEXT,Y
	sta (TEMP2),Y
	dey
	bpl C_CASTING_SCHECKPOINT

	lda <TEX5CAST
	sta PUNTFUE
	lda >TEX5CAST
	sta PUNTFUE+1
	lda <MEMOGR1+5*20+1	;SPECIAL CHECK POINT	
	sta PUNTDES
	lda >MEMOGR1+5*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J6_CASTING
	jmp SALE_CASTING
	
J6_CASTING
	clc
	lda TEMP0
	adc #18
	sta TEMP0
	sta TEMP1
	sta TEMP2
	
	ldy #15
C_CASTING_LCHECKPOINT
	lda BTEXT,Y
	sta (TEMP0),Y
	lda BTEXT+16,Y
	sta (TEMP1),Y
	lda LTEXT,Y
	sta (TEMP2),Y
	dey
	bpl C_CASTING_LCHECKPOINT
	
	lda <TEX6CAST
	sta PUNTFUE
	lda >TEX6CAST
	sta PUNTFUE+1
	lda <MEMOGR1+6*20+1	;LUCKY CHECK POINT
	sta PUNTDES
	lda >MEMOGR1+6*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J7_CASTING
	jmp SALE_CASTING
	
J7_CASTING
	clc
	lda TEMP0
	adc #19
	sta TEMP0
	sta TEMP1
	sta TEMP2
	sta TEMP3
			
	ldy #23
C_CASTING_ROCK
	lda RTEXT,Y
	sta (TEMP0),Y
	lda RTEXT+24,Y
	sta (TEMP1),Y
	lda RTEXT+48,Y
	sta (TEMP2),Y
	lda RTEXT+72,Y
	sta (TEMP3),Y
	dey
	bpl C_CASTING_ROCK
	
	lda #31+192	;26+192
	sta MEMOGR1+7*20+1

	lda <TEX7CAST
	sta PUNTFUE
	lda >TEX7CAST
	sta PUNTFUE+1
	lda <MEMOGR1+8*20+1		;ROCK ( DANGER ! )
	sta PUNTDES
	lda >MEMOGR1+8*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J8_CASTING
	jmp SALE_CASTING
	
J8_CASTING
	clc
	lda TEMP0
	adc #25
	sta TEMP0
	sta TEMP1
	sta TEMP2
	sta TEMP3

	ldy #22
C_CASTING_SMOK
	lda HTEXT,Y
	sta (TEMP0),Y
	lda HTEXT+23,Y
	sta (TEMP1),Y
	lda HTEXT+46,Y
	sta (TEMP2),Y
	lda HTEXT+69,Y
	sta (TEMP3),Y
	dey
	bpl C_CASTING_SMOK
	
	lda <TEX8CAST
	sta PUNTFUE
	lda >TEX8CAST
	sta PUNTFUE+1
	lda <MEMOGR1+9*20+1		;SMOKE SCREEN
	sta PUNTDES
	lda >MEMOGR1+9*20+1
	sta PUNTDES+1

	jsr PUT_TEXTO
	bne  J9_CASTING
	jmp SALE_CASTING
	
J9_CASTING
	lda <TEX9CAST
	sta PUNTFUE
	lda >TEX9CAST
	sta PUNTFUE+1
	lda <MEMOGR1+10*20+3	;ATARIWARE
	sta PUNTDES
	lda >MEMOGR1+10*20+3
	sta PUNTDES+1

	jsr PUT_TEXTO

	bne  SALE_CASTING
	
	lda #255
SALE_CASTING

	rts
	
;******************************		
DLICASTAUTO
	sta REGA
			
	lda #$74
	sta COLPM0
	lda #$02
	sta COLPM1
	
	lda #56
	sta HPOSP0
	sta HPOSP1
	
	lda >SETNRX
	sta CHBASE
	
	lda <DLICASTENEMIGO	
	sta VDSLST			
	lda >DLICASTENEMIGO		
	sta VDSLST+1	
		
	lda REGA
	rti
	
DLICASTENEMIGO
	sta REGA
	
	lda #$36
	sta COLPM0
		
	lda <DLICASTBANDERA
	sta VDSLST			
	lda >DLICASTBANDERA		
	sta VDSLST+1
	
	lda REGA
	rti
	
DLICASTBANDERA
	sta REGA
		
	lda #$1E
	sta COLPM0
	sta COLPM1
	lda #$36
	sta COLPM2
	sta COLPM3
	
	lda #55
	sta HPOSP0
	sta HPOSP2
	lda #63
	sta HPOSP1
	sta HPOSP3
	
	lda <DLICASTROCK
	sta VDSLST			
	lda >DLICASTROCK	
	sta VDSLST+1	
		
	lda REGA
	rti
	
DLICASTROCK
	sta REGA
		
	lda #$02
	sta COLPM0
	sta COLPM1
		
	lda <DLICASTSMOK
	sta VDSLST			
	lda >DLICASTSMOK	
	sta VDSLST+1	
		
	lda REGA
	rti
	
DLICASTSMOK
	sta REGA
		
	lda #$1E
	sta COLPM2
	sta COLPM3
		
	lda <DLICASTATARI
	sta VDSLST			
	lda >DLICASTATARI
	sta VDSLST+1	
		
	lda REGA
	rti
	
DLICASTATARI
	sta REGA
	
	lda >SETATARI
	sta CHBASE
		
	lda <DLICASTAUTO
	sta VDSLST			
	lda >DLICASTAUTO
	sta VDSLST+1	
		
	lda REGA
	rti


TEX0CAST
	.SB 'NEW RALLY-X'
	.BYTE 155
TEX1CAST	
	.SB +128, 'CAST'
	.BYTE 155
TEX2CAST
	.SB +128, '/ MY CAR'
	.BYTE 155
TEX3CAST
	.BYTE 30+64				; ? Parche 1
	.SB +128 ' RED CAR'
	.BYTE 155
TEX4CAST
	.SB +128, '  CHECK POINT'
	.BYTE 155
TEX5CAST
	.SB +128, '  SUPER CHECK POINT'
	.BYTE 155
TEX6CAST
	.SB +128, '  LUCKY CHECK POINT'
	.BYTE 155
TEX7CAST
	.BYTE 32+192				; @  Parche 2
	.SB +128, ' ROCK ( DANGER ! )'
	.BYTE 155
TEX8CAST
	.SB +128, '  SMOKE SCREEN'
	.BYTE 155
TEX9CAST
;	.SB 'ATARIWARE.CL'
	.BYTE 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46   ;,47,48,49
	.BYTE 155
