PROCESO
	lda DIRMAPA
	cmp #SUR
	bne J1_PROCESO
	
	lda ROWCRS
	cmp #11
	bcc J1_PROCESO
		
	ldy #47
C2_CLRSMOKABAJO
	lda (CLRSMOK),Y
	cmp #14
	bcs J2_CLRSMOKABAJO
	cmp #1
	bcc J2_CLRSMOKABAJO
		
	lda #0
	sta (CLRSMOK),Y
		
J2_CLRSMOKABAJO
	dey
	bpl C2_CLRSMOKABAJO

J1_PROCESO
	JMP J1_REGISTRE ; <-- Salto para no mostrar el proceso en pantalla
	
	INC UNIDAD
	LDA UNIDAD
	CMP #10
	BNE J1_REGISTRE
	LDA #0
	STA UNIDAD
	
	INC UNIDAD+1
	LDA UNIDAD+1
	CMP #10
	BNE J1_REGISTRE
	LDA #0
	STA UNIDAD+1
	
	INC UNIDAD+2
	LDA UNIDAD+2
	CMP #10
	BNE J1_REGISTRE
	LDA #0
	STA UNIDAD+2
J1_REGISTRE

	lda STATUS
	bne J1_PROCESO
	jmp J_VUMETER   ; <-- Salto para no mostrar el proceso en pantalla
	
VUMETER
	LDA UNIDAD+2
	CLC
	ASL
	STA PROSEC
	CLC
	ADC #1
	STA PROSEC+1
	
	LDA UNIDAD+1
	CLC
	ASL
	STA PROSEC+2
	CLC
	ADC #1
	STA PROSEC+3
	
	LDA UNIDAD
	CLC
	ASL
	STA PROSEC+4
	CLC
	ADC #1
	STA PROSEC+5
	
	LDA #0
	STA UNIDAD
	STA UNIDAD+1
	STA UNIDAD+2
					
J_VUMETER	
	inc STATUS
	lda CTRMODO+1
	beq RUN
	
NORMAL
	lda PMBARRA
	bne J2_PROCESO
	
	lda RTCLOK
	bne DESACELERA
PARA	jmp PARA

DESACELERA
	dec VELOCIDAD
	beq J1_DESACELERA
	rts

J1_DESACELERA
	lda RTCLOK+1
	lsr
	sta VELOCIDAD
	jmp J3_PROCESO

J2_PROCESO
	lda RTCLOK+2
	and #127
	bne J3_PROCESO
	
	jsr CTR_FUEL

J3_PROCESO
	lda CTRCPOINT
	beq CTR_LPOINT
	jsr CTR_DSCORE
		
	lda CTRROUND
	beq CTR_SONIDOS
	rts					;Vuelve a GAME, 10 banderas capturadas
	
CTR_LPOINT
	lda CTRLPOINT
	beq CTR_SONIDOS
	jsr CTR_DSCORE
	jsr BONUS_LPOINT
			
;***		SONIDOS TEMPORALES		
CTR_SONIDOS
	lda CTRS+1				;Si es 0, es motor
	beq RUN
		
	lda NOTATEM			;Contador de Notas Temp.
CTRS	cmp #0				;Cantidad de NT.
	bne J1_CTR_SONIDOS		;Sigue reproduciendo NT.
	
	jsr ON_MOTOR			
	jmp RUN				;Termino sonido temp.
	
J1_CTR_SONIDOS
	dec NOTTIMT 			;Control duracion de nota temporal
	bpl RUN				;No es 255, manten nota actual
	
	tay
	lda (TRACK3),Y			;Lee nota temporal, 3er canal	
	bne J2_CTR_SONIDOS	
	
	sta VCM+1				;OFF temporal
	jmp J3_CTR_SONIDOS				

J2_CTR_SONIDOS	
	sta NCM+1				;Repruduce nota
	
	lda #$AF				;Distorcion 10 - Volumen 15, (AF),temporal
	sta VCM+1

J3_CTR_SONIDOS
	
TIMT	lda #2
	sta NOTTIMT			;Reinicia duracion
	
	inc NOTATEM			;Proxima nota
		
RUN
	;jsr ANIMA_ENEMIGOS
	jsr CONTROL
	jsr ANIMA_AUTO
		
SALIDA					;Memoria pantalla
	clc
	lda ROWCRS
	asl
	sta PUNTFUE
	lda #0
	adc #0
	sta PUNTFUE+1
	
	clc
	lda #<TABLADL
	adc PUNTFUE
	sta MS1+1
	sta MS2+1
	lda #>TABLADL
	adc PUNTFUE+1
	sta MS1+2
	sta MS2+2
	
J1_RUN
	rts					; Resfresco de imagen Ok!
	

;***		MUEVE BARRA FUEL
CTR_FUEL
	inc POSBARRA+1

	lda POSBARRA+1
	cmp #144				;Pos. parche
	bne J1_CTR_FUEL
	
	jsr AJUST_PARCHE
	rts
	
J1_CTR_FUEL
	cmp #148				;Corta barra
	bcc J2_CTR_FUEL
	
	dec CTRBARRA
	bne J2_CTR_FUEL
	
	tax
	asl PMBARRA
		
	ldy #3
	lda PMBARRA

C1_CTR_FUEL
	sta (YLOCB),Y
	dey
	bpl C1_CTR_FUEL
	
	lda #4
	sta CTRBARRA
	txa
	
J2_CTR_FUEL
	cmp #169				;Pos. Fuel bajo
	bne J3_CTR_FUEL
					
CBL	lda #$36				;Color Barra low
	sta COLORBARRA+1		;Pinta barra
	
	lda #255
	sta RTCLOK+1
	sta RTCLOK
	dec RTCLOK
	
J3_CTR_FUEL
	rts	
	
;***		DESPLIEGA SCORE
CTR_DSCORE
	ldx #5
		
C1_CTR_DSCORE
	dex
	jsr CSCORE
		
HIDIGITO
	cpx #6
	bne C1_CTR_DSCORE
			
	lda CTRHISCORE
	beq J2_CTR_DSCORE
	
J1_CTR_DSCORE			
	ldy #11
C2_CTR_DSCORE
	lda UBISCORE,Y	
	sta UBIHISCORE,Y
	dey
	lda UBISCORE,Y
	sta UBIHISCORE,Y
	dey
	bpl C2_CTR_DSCORE
	rts
			
J2_CTR_DSCORE
	ldx #0
C3_CTR_DSCORE
	lda PUNTAJE,X
	cmp PUNTHI,X
	bcc J4_CTR_DSCORE
	beq J3_CTR_DSCORE
	
	inc CTRHISCORE
	jmp J1_CTR_DSCORE

J3_CTR_DSCORE
	inx
	cpx #6
	bne C3_CTR_DSCORE

J4_CTR_DSCORE
	rts
	
;*****	
CSCORE
	txa
	asl
	tay
	
	clc
	lda PUNTAJE,X
	adc #0
	asl
	sta UBISCORE,Y
	
	iny
	clc
	adc #1
	sta UBISCORE,Y
		
	lda #0
	sta TIPOBJ
	sta CTRCPOINT
	rts
	