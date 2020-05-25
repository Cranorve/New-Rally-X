;***	Scrolling de area, modifica LMS en DL
;		Control de canales de sonido
 
VBI
	lda ESTADO
	and #4
	beq J_VBI		;SI = 0, Scroll FINO

	jsr SCROLL_GRUESO
	
J_VBI
	lda TEMHSC
	sta HSCROL

	lda TEMVSC
	sta VSCROL
	
	lda CTRMODO+1
	bne  PLAY_MUSICA
	jmp VBIPASS
		
PLAY_MUSICA
VCM	lda #$AA		;MOTOR
	sta AUDC3
	
NCM	lda #45
	sta AUDF3


TMUSICA
	dec NOTATIM 	;Control duracion de nota
	bpl VBIPASS		;No es 255, manten nota actual
	
DNM	lda #0			;Reinicia duracion
	sta NOTATIM 	;para proxima nota	
	
	ldy NOTACNT		;Control de nota	

	lda (TRACK1),Y	;Lee nota 1er canal
	bne NOTA_T1
	
	sta AUDC1		;Silencio 1er canal
	jmp J1_PLAY_MUSICA				

NOTA_T1
	sta AUDF1		;Repruduce nota
VC1	lda #$AA		;Distorcion 10 - Volumen 10, (AA)
	sta AUDC1

J1_PLAY_MUSICA	
	lda (TRACK2),Y	;Lee nota 2do canal
	bne NOTA_T2
	
	sta AUDC2		;Silencio 2do canal				
	jmp J2_PLAY_MUSICA

NOTA_T2
	sta AUDF2		;Repruduce nota
VC2	lda #$AA
	sta AUDC2		;Distorcion 10 - Volumen 10, (AA)

J2_PLAY_MUSICA
	lda CTRMODO+1
	bne J3_PLAY_MUSICA
	
	lda (TRACK3),Y	;Lee nota 1er canal
	bne NOTA_T3
	
	sta AUDC3		;Silencio 1er canal
	jmp J3_PLAY_MUSICA				

NOTA_T3
	sta AUDF3		;Repruduce nota
	
VC3	lda #$AA		;Distorcion 10 - Volumen 10, (AA)
	sta AUDC3
		
J3_PLAY_MUSICA
	inc NOTACNT		;Proxima nota
	bne VBIPASS		;No es 0, manten pagina
	
	inc TRACK1+1	;Siguiente pagina Track uno
	inc TRACK2+1	;Siguiente pagina Track dos
	
	dec NOTACNT+1	;Control largo de melodia
	bne VBIPASS		;No es 0, no es fin
	
	lda #<MUSICA	;Termino de melodia
	sta TRACK1		;Reinicia valores
	sta TRACK2		;Lectura de tracks desde el principio
	
	lda #>MUSICA
	sta TRACK1+1
	clc
	adc #2
	sta TRACK2+1
		
	lda #2
	sta NOTACNT+1
	
VBIPASS
	jmp XITVBV

;*****************************************
SCROLL_GRUESO		;LMS para 24 lineas
	ldx #0
	ldy #0

C_SCROLL_GRUESO
	clc
MS1 lda TABLADL,Y
	adc COLCRS
	sta LINEA00,X
	iny
MS2	lda TABLADL,Y
	adc #0
	sta LINEA00+1,X
	inx
	cpx #23*3+1
	beq J_SCROLL_GRUESO
	iny
	inx
	inx
	jmp C_SCROLL_GRUESO

J_SCROLL_GRUESO	
	rts
