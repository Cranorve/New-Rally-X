CHALLENGE
	lda #$0
	sta SDMCTL			;deshabilitab ANTIC
	sta NMIRES				;reset NMI
	
	lda CTRROCK
	cmp #5
	beq J1_CHALLENGE
		
	ldy CTRROCK
	lda CONTROCK,Y
	
	clc
	sei
	sed
	adc #0
	cld
	cli
	
	tax
	and #$0F
	tay
	txa
	ldx #0
	and #$F0
	beq J2_CHALLENGE
	
	lsr
	lsr
	lsr
	lsr
	
	clc
	adc #$90
	sta TEX2CHALLENGE+4,X
	
	inx
J2_CHALLENGE
	tya
	clc
	adc #$90
	sta TEX2CHALLENGE+4,X
	
	inc CTRROCK
J1_CHALLENGE
	inc CTRNO
	lda CTRNO
	
	clc
	sei
	sed
	adc #0
	cld
	cli
	
	tax
	and #$0F
	tay
	txa
	ldx #0
	and #$F0
	beq J3_CHALLENGE
	
	lsr
	lsr
	lsr
	lsr
	
	clc
	adc #$90
	sta TEX1CHALLENGE+3,X
	
	inx
J3_CHALLENGE
	tya
	clc
	adc #$90
	sta TEX1CHALLENGE+3,X
				
	lda #<DLCHALLENGE		;Lista de Despliege modo texto
	sta SDLSTL
       	lda #>DLCHALLENGE
	sta SDLSTL+1
	
	lda #<DLICHALLENGEROCK	;DLI uno
	sta VDSLST
	lda #>DLICHALLENGEROCK
	sta VDSLST+1
	
	jsr INI_PANTALLA
		
	lda #<T1CHALLENGE		;Inicia 1er Track ***
	sta TRACK1
	lda #>T1CHALLENGE
	sta TRACK1+1
			
	lda #<T2CHALLENGE		;Inicia 2do Track
	sta TRACK2
	lda #>T2CHALLENGE
	sta TRACK2+1
				
	lda #2				;Duracion de notas ***
	sta DNM+1	
	
	jsr ON_MUSICA
		
	sta NOTATIM
	sta NOTACNT
	
	jsr MOMENTO
	
	lda #$C0
	sta NMIEN				;Activa ANTIC

	ldy #<VBI
	ldx #>VBI
	lda #7
	jsr SETVBV
							
	lda #<TEX0CHALLENGE
	sta PUNTFUE
	lda #>TEX0CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+1)			;CHALLENGE STAGE
	sta PUNTDES
	lda #>(MEMOGR1+1)
	sta PUNTDES+1
	
	jsr PUT_TEXTO
	
	lda #<TEX1CHALLENGE
	sta PUNTFUE
	lda #>TEX1CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+20+7)		;NO.1
	sta PUNTDES
	lda #>(MEMOGR1+20+7)	
	sta PUNTDES+1

	jsr PUT_TEXTO
	
	lda #103
	sta TEMP0
	sta TEMP1
	sta TEMP2
	sta TEMP3
			
	ldy #23
C_CHALLENGE_ROCK
	lda RTEXT,Y
	sta (TEMP0),Y
	lda RTEXT+24,Y
	sta (TEMP1),Y
	lda RTEXT+48,Y
	sta (TEMP2),Y
	lda RTEXT+72,Y
	sta (TEMP3),Y
	dey
	bpl C_CHALLENGE_ROCK
	
	lda #26+192
	sta MEMOGR1+2*20+7
		
		
	lda #<TEX2CHALLENGE
	sta PUNTFUE
	lda #>TEX2CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+3*20+7)		;= 5
	sta PUNTDES
	lda #>(MEMOGR1+3*20+7)
	sta PUNTDES+1

	jsr PUT_TEXTO

	clc
	lda TEMP0
	adc #45
	sta TEMP0
	sta TEMP1
	
	ldy #7
C_CHALLENGE_REDCAR
	lda CHANORTE,Y
	sta (TEMP0),Y
	dec TEMP0
	sta (TEMP0),Y
		
	lda RUENORTE,Y
	sta (TEMP1),Y
	dec TEMP1
	sta (TEMP1),Y
			
	dey
	bpl C_CHALLENGE_REDCAR
	
	lda #<TEX3CHALLENGE
	sta PUNTFUE
	lda #>TEX3CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+4*20+7)	;= 7
	sta PUNTDES
	lda #>(MEMOGR1+4*20+7)
	sta PUNTDES+1

	jsr PUT_TEXTO
	
	lda #<TEX4CHALLENGE
	sta PUNTFUE
	lda #>TEX4CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+5*20+1)	;RED CARS DON'T MOVE
	sta PUNTDES
	lda #>(MEMOGR1+5*20+1)
	sta PUNTDES+1

	jsr PUT_TEXTO
	
	lda #<TEX5CHALLENGE
	sta PUNTFUE
	lda #>TEX5CHALLENGE
	sta PUNTFUE+1
	lda #<(MEMOGR1+6*20)	;UNTIL FULL RUNS OUT
	sta PUNTDES
	lda #>(MEMOGR1+6*20)
	sta PUNTDES+1

	jsr PUT_TEXTO
	rts					;Vuelve a game!
	

;**************
DLICHALLENGEROCK
	sta REGA
	
	lda #$02
	sta COLPM0
	sta COLPM1
	lda #$36
	sta COLPM2
	sta COLPM3
	
	lda #103
	sta HPOSP0
	sta HPOSP2
	lda #111
	sta HPOSP1
	sta HPOSP3
				
	lda #<DLICHALLENGEENEMIGO
	sta VDSLST			
	lda #>DLICHALLENGEENEMIGO	
	sta VDSLST+1	
		
	lda REGA
	rti

;*****************	
DLICHALLENGEENEMIGO
	sta REGA
	
	lda #$36
	sta COLPM0
		
	lda #104
	sta HPOSP0
	sta HPOSP1
		
	lda #<DLICHALLENGEROCK	
	sta VDSLST			
	lda #>DLICHALLENGEROCK		
	sta VDSLST+1	
		
	lda REGA
	rti


;************
COLORCHALLENGE
	.BYTE $36,$28,$1E,$C4,$02	;Rojo, Naranjo, Amarillo, Verde, Cafe

TEX0CHALLENGE
	.SB 'CHALLENGING STAGE'
	.BYTE 155
TEX1CHALLENGE	
	.SB +128,'NO.1 '
	.BYTE 155
TEX2CHALLENGE
	.BYTE $DF
	.SB +128,' = 5 '
	.BYTE 155
TEX3CHALLENGE
	.BYTE $4F				;BY +64, '/'
	.SB +128,' = 7 '
	.BYTE 155
TEX4CHALLENGE
	.SB +128,'RED CARS DON'
	.BYTE 128+7
	.SB +128,'T MOVE'
	.BYTE 155
TEX5CHALLENGE
	.SB +128,'UNTIL FULL RUNS OUT.'
	.BYTE 155

CTRNO 	.DS 1
CTRROCK 	.DS 1
CONTROCK	.BYTE 5, 7, 10, 10, 12


;**********
T1CHALLENGE
	.BYTE $28,$28,$28,0,$2F,$2F,0,$28,$1D,$1D,$1D,0,$28,$28,0,$2F
	.BYTE $2D,$2D,0,$2D,$2D,$2D,0,$2D,$2D,$2D,$2D,$2D,$2D,$2D,0,0
	.BYTE $2D,$2D,$2D,0,$35,$35,0,$2D,$1F,$1F,$1F,0,$2D,$2D,0,$35
	.BYTE $2F,$2F,0,$2F,$2D,$2D,0,$2D,$28,$28,$28,$28,$28,0,0,0

	.BYTE $28,$28,$28,0,$2F,$2F,0,$28,$1D,$1D,$1D,0,$28,$28,0,$2F
	.BYTE $2D,$2D,0,$2D,$28,$28,0,$28,$23,$23,$23,$23,$23,$23,0,0
	.BYTE $1F,$1F,$1F,0,$1A,$1A,0,$23,$28,$28,$28,0,$2F,$2F,$2F,0
	.BYTE $28,$28,0,$2D,$35,$35,$35,0,$3C,$3C,$3C,$3C,$3C,0,0,0

T2CHALLENGE
	.BYTE $60,$60,$60,$60,$51,$51,$51,$51,$60,$60,$60,$60,$51,$51,$51,$51
	.BYTE $6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B,$6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B
	.BYTE $6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B,$6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B
	.BYTE $79,$79,$79,$79,$6C,$6C,$6C,$6C,$60,$60,$60,$60,$60,$60,$60,$60

	.BYTE $60,$60,$60,$60,$51,$51,$51,$51,$60,$60,$60,$60,$51,0,0,0
	.BYTE $5B,$5B,$5B,$5B,$48,$48,$48,$48,$5B,$5B,$5B,$5B,$48,$48,$48,$48
	.BYTE $40,$40,$40,$40,$48,$48,$48,$48,$51,$51,$51,$51,$40,$40,$40,$40
	.BYTE $3C,$3C,$3C,$3C,$60,$60,$60,$60,$79,$79,$79,$79,$79,$79,$79,$79
	
	