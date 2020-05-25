RECORD
	jsr INI_MODOTEXT
	
	ldx #4
C1_RECORD
	lda COLORRECORD,X		;Toma colores definidos para pantalla
	sta COLOR0,X			;guarda en registos PF0 a PF4
	dex
	bpl C1_RECORD
		
	ldx #0
C2_RECORD	
	lda PUNTAJE,X			;Cuenta digitos validos
	bne J1_RECORD			;Guarda en X
	inx
	jmp C2_RECORD

J1_RECORD		
	ldy #0
C3_RECORD
	clc	
	lda PUNTAJE,X			;Ajusta digitos a ATASCII
	adc #$10
	sta TEX3RECORD+1,Y
	iny	

	inx
	cpx #6				;Control ultimo digito
	bne C3_RECORD
	
	lda #$7				;Cierre comillas
	sta TEX3RECORD+1,Y
		
	iny
	lda #$9B				;EOF
	sta TEX3RECORD+1,Y

C4_RECORD	
	cpy #7
	beq J2_RECORD
	iny
	lda #$0
	sta TEX3RECORD+1,Y
	jmp C4_RECORD
	
J2_RECORD	
	lda #<TEX0RECORD
	sta PUNTFUE
	lda #>TEX0RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+3)		;YOU DID IT
	sta PUNTDES
	lda #>(MEMOGR1+3)
	sta PUNTDES+1
	
	jsr PRINT

 	lda #<TEX1RECORD
	sta PUNTFUE
	lda #>TEX1RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+1*20+2)	;THE HIGH SCORE
	sta PUNTDES
	lda #>(MEMOGR1+1*20+2)
	sta PUNTDES+1

	jsr PRINT

	lda #<TEX2RECORD
	sta PUNTFUE
	lda #>TEX2RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+2*20+5)	;OF THE DAY
	sta PUNTDES
	lda #>(MEMOGR1+2*20+5)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<TEX3RECORD
	sta PUNTFUE
	lda #>TEX3RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+3*20+6)	;"123456"
	sta PUNTDES
	lda #>(MEMOGR1+3*20+6)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<TEX4RECORD
	sta PUNTFUE
	lda #>TEX4RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+4*20+2)	;GO FOR THE WORLD
	sta PUNTDES
	lda #>(MEMOGR1+4*20+2)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<TEX5RECORD
	sta PUNTFUE
	lda #>TEX5RECORD
	sta PUNTFUE+1
	lda #<(MEMOGR1+5*20+4)	;RECORD NOW !!
	sta PUNTDES
	lda #>(MEMOGR1+5*20+4)
	sta PUNTDES+1

	jsr PRINT
	
	lda #<T1RECORD			;Inicia 1er Track de Melodia, dos Track***
	sta TRACK1
	lda #>T1RECORD
	sta TRACK1+1
			
	lda #<T2RECORD			;Inicia 2do Track
	sta TRACK2
	lda #>T2RECORD
	sta TRACK2+1
	
	lda #2				;Duracion de notas ***
	sta DNM+1	
	sta NOTATIM 
	
	jsr ON_MUSICA
		
	sta NOTATIM
	sta NOTACNT
	
	;lda #$AA				;Distorcion 10 - Volumen 10, (AA)
	;sta AUDC1
	;sta AUDC2
	
	jsr MOMENTO
		
	lda #<DLRECORD			;Lista de Despliege
	sta SDLSTL
    lda #>DLRECORD
	sta SDLSTL+1
	
	lda #0			
	sta GRACTL
	
	lda #$22				;PLAYFIELD NORMAL
	sta SDMCTL 			
	
	lda #$40				;Deshabilita DLI - Habilita VBI
	sta NMIEN
	
	ldy #<PLAY_MUSICA
	ldx #>PLAY_MUSICA
	lda #7
	jsr SETVBV				;Inicia rutina VBI
	
C5_RECORD	
	jsr J4_RECORD
	
J3_RECORD	
	lda NOTACNT			;Espera que se reproduscan 128 Notas *** (Largo para esta melodia)
	cmp #127
	bcc C5_RECORD	
	
	jsr MUTE
	
	ldy #21
C6_RECORD
	jsr J4_RECORD
	dey
	bne C6_RECORD
	
	ldx #5
C7_RECORD
	lda PUNTAJE,X
	sta PUNTHI,X
	dex
	bpl C7_RECORD
	rts
	
J4_RECORD
	lda #16
	jsr PAUSA
	
	ldx #6
	
	lda REC
	cmp #AEMPTY8
	beq J5_RECORD

	ldx #AEMPTY8
J5_RECORD
	stx REC
	rts


;**********
COLORRECORD
	.BYTE $34, $00, $1C, $0F, $70	;Rojo - Negro - Amarillo - Blanco - Azul
	
TEX0RECORD
	.SB 'YOU DID IT !!'
	.BYTE $9B
TEX1RECORD	
	.SB 'the high score'
	.BYTE $9B
TEX2RECORD
	.SB 'of de day.'
	.BYTE $9B
TEX3RECORD
	.BYTE 7
	.SB '000000  '
TEX4RECORD
	.SB +128 'GO FOR THE WORLD'
	.BYTE $9B
TEX5RECORD
	.SB +128 'RECORD NOW !!'
	.BYTE $9B
	
;***		Melodia Record - MOMENTANEA !!!
T1RECORD
	.BYTE $28,$28,$28,0,$2F,$2F,0,$28,$1D,$1D,$1D,0,$28,$28,0,$2F
	.BYTE $2D,$2D,0,$2D,$2D,$2D,0,$2D,$2D,$2D,$2D,$2D,$2D,$2D,0,0
	.BYTE $2D,$2D,$2D,0,$35,$35,0,$2D,$1F,$1F,$1F,0,$2D,$2D,0,$35
	.BYTE $2F,$2F,0,$2F,$2D,$2D,0,$2D,$28,$28,$28,$28,$28,0,0,0
	
	.BYTE $28,$28,$28,0,$2F,$2F,0,$28,$1D,$1D,$1D,0,$28,$28,0,$2F
	.BYTE $2D,$2D,0,$2D,$28,$28,0,$28,$23,$23,$23,$23,$23,$23,0,0
	.BYTE $1F,$1F,$1F,0,$1A,$1A,0,$23,$28,$28,$28,0,$2F,$2F,$2F,0
	.BYTE $28,$28,0,$2D,$35,$35,$35,0,$3C,$3C,$3C,$3C,$3C,0,0,0
	
T2RECORD
	.BYTE $60,$60,$60,$60,$51,$51,$51,$51,$60,$60,$60,$60,$51,$51,$51,$51
	.BYTE $6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B,$6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B
	.BYTE $6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B,$6C,$6C,$6C,$6C,$5B,$5B,$5B,$5B
	.BYTE $79,$79,$79,$79,$6C,$6C,$6C,$6C,$60,$60,$60,$60,$60,$60,$60,$60
	
	.BYTE $60,$60,$60,$60,$51,$51,$51,$51,$60,$60,$60,$60,$51,0,0,0
	.BYTE $5B,$5B,$5B,$5B,$48,$48,$48,$48,$5B,$5B,$5B,$5B,$48,$48,$48,$48
	.BYTE $40,$40,$40,$40,$48,$48,$48,$48,$51,$51,$51,$51,$40,$40,$40,$40
	.BYTE $3C,$3C,$3C,$3C,$60,$60,$60,$60,$79,$79,$79,$79,$79,$79,$79,$79
	