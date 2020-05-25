PUSH_FIRE
	jsr SOLTO_BOTON?
	
	lda #$0
	sta SDMCTL		;deshabilitab ANTIC
	sta NMIRES			;reset NMI
	
	lda #0			
	sta GRACTL
	
	jsr INI_MODOTEXT
			
	ldx #4
C1_PUSHFIRE
	lda COLORPUSHFIRE,X		;Toma colores definidos para pantalla
	sta COLOR0,X			;guarda en registos PF0 a PF4
	dex
	bpl C1_PUSHFIRE
			
	lda #<TEX0PUSHFIRE
	sta PUNTFUE
	lda #>TEX0PUSHFIRE
	sta PUNTFUE+1
	lda #<(MEMOGR1+7*20+2)	;PUSH FIRE BUTTON
	sta PUNTDES
	lda #>(MEMOGR1+7*20+2)
	sta PUNTDES+1
	
	jsr PRINT

 	lda #<TEX1PUSHFIRE
	sta PUNTFUE
	lda #>TEX1PUSHFIRE
	sta PUNTFUE+1
	lda #<(MEMOGR1+10*20)	;1ST BONUS  20000 PTS
	sta PUNTDES
	lda #>(MEMOGR1+10*20)
	sta PUNTDES+1

	jsr PRINT

	lda #<TEX2PUSHFIRE
	sta PUNTFUE
	lda #>TEX2PUSHFIRE
	sta PUNTFUE+1
	lda #<(MEMOGR1+12*20)	;2ND BONUS 120000 PTS
	sta PUNTDES
	lda #>(MEMOGR1+12*20)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<TEX3PUSHFIRE
	sta PUNTFUE
	lda #>TEX3PUSHFIRE
	sta PUNTFUE+1
	lda #<(MEMOGR1+15*20+6)	;CREDIR  1
	sta PUNTDES
	lda #>(MEMOGR1+15*20+6)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<TEX4PUSHFIRE
	sta PUNTFUE
	lda #>TEX4PUSHFIRE
	sta PUNTFUE+1
	lda #<(MEMOGR1+21*20+7)	;ATARI
	sta PUNTDES
	lda #>(MEMOGR1+21*20+7)
	sta PUNTDES+1

	jsr PRINT
			
	lda #<T1CREDIT			;Inicia 1er Track Primera Melodia, dos Track***
	sta TRACK1
	lda #>T1CREDIT
	sta TRACK1+1
			
	lda #<T2CREDIT			;Inicia 2do Track Primera Melodia ***
	sta TRACK2
	lda #>T2CREDIT
	sta TRACK2+1

	jsr MOMENTO
	
	lda #<DLPUSHFIRE		;Lista de Despliege modo texto
	sta SDLSTL
       	lda #>DLPUSHFIRE
	sta SDLSTL+1
				
	lda #$22				;Playfield normal
	sta SDMCTL 			
								
	lda #$40
	sta NMIEN				;Deshabilita DLI - Habilita VBI
	
	jsr ON_MUSICA
	
	sta DNM+1	
	sta NOTATIM
	sta NOTACNT
	
	lda #1
	sta CTRMODO+1
	
	ldy #<TMUSICA
	ldx #>TMUSICA
	lda #7
	jsr SETVBV				;Inicia rutina VBI para Credit
	
C2_PUSH_FIRE	
	lda NOTACNT			;Espera que se reproduscan 128 Notas *** (Largo para esta melodia)
	cmp #16
	bne C2_PUSH_FIRE
	
	jsr MUTE
	jsr LEE_BOTON
		
	lda #<T1START			;Inicia 1er Track Segunda Melodia, tres Track ***
	sta TRACK1
	lda #>T1START
	sta TRACK1+1
			
	lda #<T2START			;Inicia 2do Track ***
	sta TRACK2
	lda #>T2START
	sta TRACK2+1
	
	lda #<T3START			;Inicia 3do Track ***
	sta TRACK3
	lda #>T3START
	sta TRACK3+1
		
	lda #2				;Duracion de notas ***
	sta DNM+1
	
	jsr ON_MUSICA
		
	sta CTRMODO+1
	sta NOTATIM
	sta NOTACNT
	rts

COLORPUSHFIRE
	.BYTE $0F,$00,$36,$0,$0	;Blanco - Negro - Rojo - Negro - Negro
	
TEX0PUSHFIRE
	.SB 'PUSH FIRE BUTTON'
	.BYTE 155
TEX1PUSHFIRE	
	.SB '1ST BONUS  20000 PTS'
	.BYTE 155
TEX2PUSHFIRE
	.SB '2ND BONUS 120000 PTS'
	.BYTE 155
TEX3PUSHFIRE
	.SB 'CREDIT 1'
	.BYTE 155
TEX4PUSHFIRE
	.SB +128,'ATARI'
	.BYTE 155
;TEX5PUSHFIRE
	;.SB 1,2,3,4,5,6,7,8,9,10,11,0,12,13	 ;'NAMCO c'
	;.BYTE 155
	
;***		Melodia Push Fire Button Inicial - MOMENTANEA !!!
T1CREDIT
	.BYTE $2F,$2F,$2F,$2F,$2F,0,$2A,$2A,0,$23,$23,$23,$23,0,$1C,$1C
	.BYTE $1C,$1C,$1C,0,0,0,$23,$23,0,$2A,$2A,$2A,$2A,0,0,0
	.BYTE 0,$2F,$2F,$2F,0,0,0,$2A,$2A,0,$23,$23,$23,0,0,$1D
	.BYTE $1D,$1D,$1D,0,0,0,0,$23,$23,0,$2A,$2A,$2A,0,0,0
	
	.BYTE 0,0,$2F,$2F,$2F,$2F,$2F,0,$2A,$2A,0,$23,$23,$23,$23,0
	.BYTE $1C,$1C,$1C,$1C,$1C,0,0,0,0,$23,$23,$1C,$1C,$1C,0,0
	.BYTE 0,$1A,$1A,0,$17,$17,$17,0,0,$1A,$1A,0,$1C,$1C,$1C,0
	.BYTE 0,$23,$23,0,$1C,$1C,$1C,0,0,0,$23,$23,$23,0,0,0
	
T2CREDIT
	.BYTE $C1,$C1,$C1,$C1,$C1,$C1,$C1,0,0,0,0,0,0,0,$72,$72
	.BYTE $72,$72,$72,$72,$72,$72,0,0,0,0,0,0,0,0,0,0
	.BYTE 0,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,0,0,0,0,0,0,$79
	.BYTE $79,$79,$79,$79,$79,$79,$79,0,0,0,0,0,0,0,0,0
	
	.BYTE 0,0,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,0,0,0,0,0,0
	.BYTE $72,$72,$72,$72,$72,$72,$72,$72,0,0,0,0,0,0,0,0
	.BYTE 0,0,0,0,$60,$60,$60,$60,0,$6C,$6C,0,$72,$72,$72,$72
	.BYTE 0,$90,$90,0,$72,$72,$72,$72,$72,0,$90,$90,$90,$90,$90,0

;***		Melodia Push Fire Button Final - - MOMENTANEA ???
T1START 
	.BYTE $51,$51,$51,$51,$48,$48,$3C,$3C
	.BYTE $3C,$3C,$2F,$2F,$2F,$2F,$2F,$3C
	.BYTE $48,$48,$48,$48,$48,$48,$51,$51
	.BYTE $51,$51,$48,$3C,$3C,$3C,$3C,$32
	.BYTE $32,$32,$32,$32,$3C,$3C,$48,$48
	.BYTE $48,$48,$48,$51,$51,$51,$51,$48
	.BYTE $3C,$3C,$3C,$3C,$2F,$2F,$2F,$2F
	.BYTE $2F,$2F,$3C,$2F,$2F,$2F,$2F,$2D
	.BYTE $28,$28,$28,$28,$2D,$2D,$32,$32
	.BYTE $32,$32,$3C,$32,$32,$32,$32,$3C
	.BYTE $3C,$3C,$3C,$3C,$3C,$3C,$0,$0
	
T2START 
	.BYTE $28,$28,$28,$28,$28,$28,$28,$28
	.BYTE $28,$28,$28,$2F,$2F,$2F,$2F,$2F
	.BYTE $3C,$3C,$3C,$3C,$3C,$3C,$28,$28
	.BYTE $28,$28,$28,$28,$28,$28,$28,$28
	.BYTE $32,$32,$32,$32,$32,$32,$3C,$3C
	.BYTE $3C,$3C,$3C,$28,$28,$28,$28,$28
	.BYTE $28,$28,$28,$28,$28,$28,$2F,$2F
	.BYTE $2F,$2F,$2F,$3C,$3C,$3C,$3C,$28
	.BYTE $35,$35,$35,$35,$28,$28,$2D,$2D
	.BYTE $2D,$2D,$28,$40,$40,$40,$40,$3C
	.BYTE $3C,$3C,$3C,$3C,$3C,$3C,$0,$0
	
T3START 	
	.BYTE $F3,$F3,$F3,$F3,$F3,$F3,$79,$79
	.BYTE $79,$79,$79,$F3,$F3,$F3,$F3,$F3
	.BYTE $79,$79,$79,$79,$79,$79,$F3,$F3
	.BYTE $F3,$F3,$F3,$79,$79,$79,$79,$79
	.BYTE $F3,$F3,$F3,$F3,$F3,$F3,$79,$79
	.BYTE $79,$79,$79,$F3,$F3,$F3,$F3,$F3
	.BYTE $79,$79,$79,$79,$79,$79,$F3,$F3
	.BYTE $F3,$F3,$F3,$79,$79,$79,$79,$79
	.BYTE $B5,$B5,$B5,$B5,$B5,$B5,$A2,$A2
	.BYTE $A2,$A2,$A2,$F3,$F3,$F3,$F3,$F3
	.BYTE $F3,$F3,$F3,$F3,$F3,$F3,$0,$0
