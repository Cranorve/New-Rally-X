CONTROL					;Desde PROCESO
	lda CTRSMOK
	bpl CHKCOLISION			;Si <> 255 no lee Boton
	
	lda STRIG0
	bne CHKCOLISION		;Si es presion, controla nueva secuencia
	
	lda #3
	sta CTRSMOK
	
	lda TIPOBJ
	bne CHKCOLISION
	jmp LEE_STICK


;**********
CHKCOLISION
	lda DIRMAPA
	cmp #ESTE
	bne NOES_ESTE
	jmp CHKCOLISION_DERECHA
	
NOES_ESTE
	cmp #SUR
	bne NOES_SUR
	jmp CHKCOLISION_ABAJO
	
NOES_SUR
	cmp #OESTE
	bne CHKCOLISION_ARRIBA
	jmp CHKCOLISION_IZQUIERDA
	

;--------------------
CHKCOLISION_ARRIBA
	;lda ROWCON			;TEMVSC
	;cmp #2
	;bne NADACAMBIA_ARRIBA
	
	lda #4				;Bandera?
	bit HPOSM0
	bne OBJETO_ARRIBA?
	
	lda #1				;Roca?
	bit HPOSM0
	beq NADACAMBIA_ARRIBA

	lda TIPOBJ
	cmp #RK
	beq CHKTERMINAL_ARRIBA
	
	cmp #EN
	bne NADACAMBIA_ARRIBA
	
CHKTERMINAL_ARRIBA
	jmp ES_COLISION
	
OBJETO_ARRIBA?
	lda TIPOBJ
	cmp #CP				;Check CP
	beq TRANSFORMA_ARRIBA

	cmp #SP				;Check SP
	bne CHKLP_ARRIBA
	
	lda #17
	sta SSP+1
	
	jsr INC_SPOINT
	jmp TRANSFORMA_ARRIBA
	
CHKLP_ARRIBA	
	cmp #LP
	beq TRANSFORMALP_ARRIBA
	
NADACAMBIA_ARRIBA
	jmp LEE_STICK		

	
;----------------------
TRANSFORMALP_ARRIBA
	inc CTRLPOINT

TRANSFORMA_ARRIBA
	jsr INC_CPOINT
	
	lda LINEA09
	sta PUNTDES
	lda LINEA09+1
	sta PUNTDES+1
	
	lda #0
	ldy #21
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
		
	lda LINEA10
	sta PUNTDES
	lda LINEA10+1
	sta PUNTDES+1
		
	ldy #21
	lda GANANCIA
	sta (PUNTDES),Y
	iny
	lda GANANCIA+1
	sta (PUNTDES),Y
	iny
	lda GANANCIA+2
	sta (PUNTDES),Y
		
	lda CONCPOINT
	cmp #10
	bne J1_TRANSFORMA_ARRIBA
	
	jsr PON_CERO
		
J1_TRANSFORMA_ARRIBA
	lda LINEA11
	sta PUNTDES
	lda LINEA11+1
	sta PUNTDES+1
	
	ldy #21
	lda GANANCIA+3
	sta (PUNTDES),Y
	iny
	lda GANANCIA+4
	sta (PUNTDES),Y
	iny
	lda GANANCIA+5
	sta (PUNTDES),Y
	
	lda CTRROUND
	beq J2_TRANSFORMA_ARRIBA
	rts						;Vuelve a Proceso

J2_TRANSFORMA_ARRIBA
	lda TIPOBJ
	cmp #LP
	bne J3_TRANSFORMA_ARRIBA
	jsr BONUS_LPOINT
	
J3_TRANSFORMA_ARRIBA
	jmp LEE_STICK


;----------------------
CHKCOLISION_DERECHA
	;lda COLCON			;TEMVSC
	;cmp #8
	;bne NADACAMBIA_DERECHA
	
	lda #4				;Bandera?
	bit HPOSM0
	bne OBJETO_DERECHA?
	
	lda #1				;Roca?
	bit HPOSM0
	beq NADACAMBIA_DERECHA
	
	lda TIPOBJ
	cmp #RK
	beq CHKTERMINAL_DERECHA
	
	cmp #EN
	bne NADACAMBIA_DERECHA
	
CHKTERMINAL_DERECHA
	jmp ES_COLISION
	
OBJETO_DERECHA?
	lda TIPOBJ
	cmp #CP				;Check CP
	beq TRANSFORMA_DERECHA

	cmp #SP				;Check SP
	bne CHKLP_DERECHA
	
	lda #17
	sta SSP+1
	
	jsr INC_SPOINT
	jmp TRANSFORMA_DERECHA
	
CHKLP_DERECHA
	cmp #LP
	beq TRANSFORMALP_DERECHA
	
NADACAMBIA_DERECHA
	jmp LEE_STICK
	
;------------------	
TRANSFORMALP_DERECHA
	inc CTRLPOINT
	
TRANSFORMA_DERECHA
	jsr INC_CPOINT
	
	lda LINEA11
	sta PUNTDES
	lda LINEA11+1
	sta PUNTDES+1
	
	lda #0	
	ldy #22
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
		
	lda LINEA12
	sta PUNTDES
	lda LINEA12+1
	sta PUNTDES+1
	
	ldy #22
	lda GANANCIA
	sta (PUNTDES),Y
	iny
	lda GANANCIA+1
	sta (PUNTDES),Y
	iny
	lda GANANCIA+2
	sta (PUNTDES),Y
	
	lda CONCPOINT
	cmp #10
	bne J1_TRANSFORMA_DERECHA

	jsr PON_CERO
	
J1_TRANSFORMA_DERECHA
	
	lda LINEA13
	sta PUNTDES
	lda LINEA13+1
	sta PUNTDES+1
	
	ldy #22
	lda GANANCIA+3
	sta (PUNTDES),Y
	iny
	lda GANANCIA+4
	sta (PUNTDES),Y
	iny
	lda GANANCIA+5
	sta (PUNTDES),Y
	
	lda CTRROUND
	beq J2_TRANSFORMA_DERECHA
	rts				;Vuelve a Proceso

J2_TRANSFORMA_DERECHA	
	lda TIPOBJ
	cmp #LP
	bne J3_TRANSFORMA_DERECHA
	jsr BONUS_LPOINT
	
J3_TRANSFORMA_DERECHA
	jmp LEE_STICK


;-------------------
CHKCOLISION_ABAJO
	;lda ROWCON			;TEMVSC
	;cmp #0
	;bne NADACAMBIA_ABAJO

	lda #4				;Bandera?
	bit HPOSM0
	bne OBJETO_ABAJO?
	
	lda #1				;Roca?
	bit HPOSM0
	beq NADACAMBIA_ABAJO
	
	lda TIPOBJ
	cmp #RK
	beq CHKTERMINAL_ABAJO
	
	cmp #EN
	bne NADACAMBIA_ABAJO
	
CHKTERMINAL_ABAJO
	jmp ES_COLISION
	
OBJETO_ABAJO?
	lda TIPOBJ
	cmp #CP				;Check CP
	beq TRANSFORMA_ABAJO

	cmp #SP				;Check SP
	bne CHKLP_ABAJO
	
	lda #17
	sta SSP+1
	
	jsr INC_SPOINT
	jmp TRANSFORMA_ABAJO
	
CHKLP_ABAJO	
	cmp #LP
	beq TRANSFORMALP_ABAJO
	
NADACAMBIA_ABAJO
	jmp LEE_STICK		


;--------------
TRANSFORMALP_ABAJO
	inc CTRLPOINT
	
TRANSFORMA_ABAJO	
	jsr INC_CPOINT
	
	lda LINEA12
	sta PUNTDES
	lda LINEA12+1
	sta PUNTDES+1
	
	lda #0	
	ldy #21
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
		
	lda LINEA13
	sta PUNTDES
	lda LINEA13+1
	sta PUNTDES+1
	
	ldy #21
	lda GANANCIA
	sta (PUNTDES),Y
	iny
	lda GANANCIA+1
	sta (PUNTDES),Y
	iny
	lda GANANCIA+2
	sta (PUNTDES),Y
	
	lda CONCPOINT
	cmp #10
	bne J1_TRANSFORMA_ABAJO

	jsr PON_CERO
	
J1_TRANSFORMA_ABAJO
	lda LINEA14
	sta PUNTDES
	lda LINEA14+1
	sta PUNTDES+1
	
	ldy #21
	lda GANANCIA+3
	sta (PUNTDES),Y
	iny
	lda GANANCIA+4
	sta (PUNTDES),Y
	iny
	lda GANANCIA+5
	sta (PUNTDES),Y
	
	lda CTRROUND
	beq J2_TRANSFORMA_ABAJO
	rts

J2_TRANSFORMA_ABAJO
	lda TIPOBJ
	cmp #LP
	bne J3_TRANSFORMA_ABAJO
	jsr BONUS_LPOINT
	
J3_TRANSFORMA_ABAJO	
	jmp LEE_STICK


;-----------------------
CHKCOLISION_IZQUIERDA
	;lda COLCON			;TEMVSC
	;cmp #9
	;bne NADACAMBIA_IZQUIERDA
	
	lda #4				;Bandera?
	bit HPOSM0
	bne OBJETO_IZQUIERDA?
	
	lda #1				;Roca?
	bit HPOSM0
	beq NADACAMBIA_IZQUIERDA
	
	lda TIPOBJ
	cmp #RK
	beq CHKTERMINAL_IZQUIERDA
	
	cmp #EN
	bne NADACAMBIA_IZQUIERDA
	
CHKTERMINAL_IZQUIERDA
	jmp ES_COLISION
	
OBJETO_IZQUIERDA?
	lda TIPOBJ
	cmp #CP				;Check CP
	beq TRANSFORMA_IZQUIERDA

	cmp #SP				;Check SP
	bne CHKLP_IZQUIERDA
	
	lda #17
	sta SSP+1
	
	jsr INC_SPOINT
	jmp TRANSFORMA_IZQUIERDA
	
CHKLP_IZQUIERDA	
	cmp #LP
	beq TRANSFORMALP_IZQUIERDA
	
NADACAMBIA_IZQUIERDA
	jmp LEE_STICK		

	
;----------------------
TRANSFORMALP_IZQUIERDA
	inc CTRLPOINT

TRANSFORMA_IZQUIERDA
	jsr INC_CPOINT
	
	lda LINEA11
	sta PUNTDES
	lda LINEA11+1
	sta PUNTDES+1
	
	lda #0
	ldy #19
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
	iny
	sta (PUNTDES),Y
		
	lda LINEA12
	sta PUNTDES
	lda LINEA12+1
	sta PUNTDES+1
	
	ldy #19
	lda GANANCIA
	sta (PUNTDES),Y
	iny
	lda GANANCIA+1
	sta (PUNTDES),Y
	iny
	lda GANANCIA+2
	sta (PUNTDES),Y
	
	lda CONCPOINT
	cmp #10
	bne J1_TRANSFORMA_IZQUIERDA

	jsr PON_CERO
	
J1_TRANSFORMA_IZQUIERDA
	lda LINEA13
	sta PUNTDES
	lda LINEA13+1
	sta PUNTDES+1
	
	ldy #19
	lda GANANCIA+3
	sta (PUNTDES),Y
	iny
	lda GANANCIA+4
	sta (PUNTDES),Y
	iny
	lda GANANCIA+5
	sta (PUNTDES),Y
				
	lda CTRROUND
	beq J2_TRANSFORMA_IZQUIERDA
	rts

J2_TRANSFORMA_IZQUIERDA
	lda TIPOBJ
	cmp #LP
	bne LEE_STICK
	jsr BONUS_LPOINT
	
;*******
LEE_STICK
	lda CTRMODO+1
	beq J1_LEE_STICK
	
	lda STICK0
	jmp ES_STICK_ARRIBA?

J1_LEE_STICK
	lda DIRMAPA
	sta STICK0

ES_STICK_ARRIBA?
	cmp #NORTE
	beq STICK_ARRIBA
	jmp ES_STICK_DERECHA?

;**********
STICK_ARRIBA
	lda DIRMAPA
	cmp #SUR
	beq ES_ARRIBA

CTR_ARRIBA
	lda COLCON
	cmp COLCTR
	bne J2_CTR_ARRIBA
	
	lda ROWCON
	cmp ROWCTR
	bne J2_CTR_ARRIBA
		
	jsr CHECK_NORTE
	beq ES_ARRIBA
	
	lda COLCON
	cmp #5
	beq J1_CTR_ARRIBA
	
	lda #SUR
	sta STICK0
	jmp ES_STICK_ABAJO?
	
J1_CTR_ARRIBA	
	lda ESTADO
	and #1
	bne J3_CTR_ARRIBA		;V		
	
	jsr CHECK_ESTE
	bne AL_OESTE
	
	lda #ESTE
	sta STICK0
	jmp ES_DERECHA

AL_OESTE
	lda #OESTE
	sta STICK0
	jmp ES_IZQUIERDA
	
J2_CTR_ARRIBA
	lda DIRMAPA
	cmp STICK0
	beq SIGUE_ARRIBA

J3_CTR_ARRIBA
	lda #2
	sta TEMVSC
	lda #5
	sta ROWCON
	sta ROWCTR
	
	lda DIRMAPA
	sta STICK0
	jmp ES_STICK_DERECHA?

;---------
ES_ARRIBA
	lda STICK0
	sta DIRMAPA		;14-13-11-7

;------------
SIGUE_ARRIBA				
	dec ROWCON		;Contador lineas por mozaico
	bpl NOLINEA_MINIMA	;Controla limite superior, <0
	
	lda #11
	sta ROWCON		;Actualiza limite inferior, nuevo mozaico

NOLINEA_MINIMA
	dec TEMVSC		;Scroll hacia abajo
	dec TEMVSC		;dos lineas, (registros temporales) 
	bpl CHKSMOK_ARRIBA	;Si <0, controla smok
	jmp ESGRUESO_ARRIBA
	
;---------------
CHKSMOK_ARRIBA
	lda #UU+FNV		;Actualiza Estado de Auto rojo
	sta ESTADO		;Direccion Grueso Up, Fino Norte Vertical
	
	lda CTRSMOK				;Check Humo
	bmi J2_SMOKARRIBA			;SI < 0 ( = 255 )
	beq J1_SMOKARRIBA			;SI = 0 lee boton	
	
	lda ROWCON
	cmp #6					;Punto comienzo de dibujado
	bne J2_SMOKARRIBA
			
	clc
	lda LINEA16				;Linea de dibujado Smok
	adc #21
	sta PUNTDES
	lda LINEA16+1
	adc #0
	sta PUNTDES+1
	
	ldy #1
	lda (PUNTDES),Y				;Es pista?
	bne J2_SMOKARRIBA			;Salta; sino lo es!
		
;DIBUJA SMOK
	ldx #8				
	ldy #2
C1_SMOKARRIBA	
	lda HUMO,X
	sta (PUNTDES),Y
	dex
	dey
	bpl C1_SMOKARRIBA
	
	clc
	lda LINEA15
	adc #21
	sta PUNTDES

	lda LINEA15+1
	adc #0
	sta PUNTDES+1
	
	ldy #2
C2_SMOKARRIBA
	lda HUMO,X
	sta (PUNTDES),Y
	dex
	dey
	bpl C2_SMOKARRIBA
	
	clc
	lda LINEA14
	adc #21
	sta PUNTDES

	lda LINEA14+1
	adc #0
	sta PUNTDES+1

	ldy #2
C3_SMOKARRIBA	
	lda HUMO,X
	sta (PUNTDES),Y
	dex
	dey
	bpl C3_SMOKARRIBA
	
	dec CTRSMOK
	jmp SON_HUMO		;Sonido
		
J1_SMOKARRIBA	
	lda STRIG0
	beq J2_SMOKARRIBA
	
	lda #255
	sta CTRSMOK
	
J2_SMOKARRIBA
	rts
	
;--------------------------
ESGRUESO_ARRIBA
	lda #6		
	sta TEMVSC
	
	lda #UU+GNV
	sta ESTADO
	
	dec ROWCRS
	dec CTRLINRADAR
		
	lda CTRLINRADAR
	bpl CLRSMOK_ARRIBA
	
	lda #0
	tay
	sta (LINRADAR),Y
	dec LINRADAR
	lda #1
	sta (LINRADAR),Y
	lda #10
	sta CTRLINRADAR
	
	dec CONTLZONA
	bne CLRSMOK_ARRIBA	
	
	lda #4
	sta CONTLZONA
	
	sec
	lda CONTZONA
	sbc #3
	sta CONTZONA
	
;---------------
CLRSMOK_ARRIBA		
	lda LINEA23			;		
	sta PUNTDES
	lda LINEA23+1
	sta PUNTDES+1
	
	ldy #44
C_CLRSMOK_ARRIBA
	lda (PUNTDES),Y
	cmp #14
	bcs J1_CLRSMOK_ARRIBA
	cmp #1
	bcc J1_CLRSMOK_ARRIBA
	
	lda #0
	sta (PUNTDES),Y
		
J1_CLRSMOK_ARRIBA
	dey
	bpl C_CLRSMOK_ARRIBA
	rts


;***************
ES_STICK_DERECHA?
	cmp #ESTE
	beq STICK_DERECHA
	jmp ES_STICK_ABAJO?
	
;---------------
STICK_DERECHA
	lda DIRMAPA
	cmp #OESTE
	beq ES_DERECHA	
	
CTR_DERECHA
	lda ROWCON
	cmp ROWCTR
	bne J2_CTR_DERECHA
	
	lda COLCON
	cmp COLCTR
	bne J2_CTR_DERECHA
	
	jsr CHECK_ESTE
	beq ES_DERECHA
	
	lda ROWCON
	cmp #6
	beq J1_CTR_DERECHA
	
	lda #OESTE
	sta STICK0
	jmp ES_STICK_IZQUIERDA?
	
J1_CTR_DERECHA	
	lda ESTADO
	and #1
	beq J3_CTR_DERECHA		;H	
	
	jsr CHECK_SUR
	bne AL_NORTE
	
	lda #SUR
	sta STICK0
	jmp ES_ABAJO

AL_NORTE
	lda #NORTE
	sta STICK0
	jmp ES_ARRIBA
	
J2_CTR_DERECHA
	lda DIRMAPA
	cmp STICK0
	beq SIGUE_DERECHA
	
J3_CTR_DERECHA	
	lda #4
	sta TEMHSC
	sta COLCON
	sta COLCTR
	
	lda DIRMAPA
	sta STICK0
	jmp ES_STICK_ARRIBA?
	
;-----------
ES_DERECHA	
	lda STICK0
	sta DIRMAPA
	
;--------------
SIGUE_DERECHA	
	dec COLCON
	bpl NOCOLUMNA_MAXIMA
	
	lda #11
	sta COLCON
	
NOCOLUMNA_MAXIMA
	dec TEMHSC
	lda TEMHSC
	cmp #3
	bne CHKSMOK_DERECHA
	jmp ESGRUESO_DERECHA

;------------------
CHKSMOK_DERECHA
	lda #RR+FEH
	sta ESTADO
	
	lda CTRSMOK
	bmi J2_SMOKDERECHA
	beq J1_SMOKDERECHA
	
	lda COLCON
	cmp #6
	bne  J2_SMOKDERECHA
			
	clc
	lda LINEA13
	adc #18
	sta PUNTDES

	lda LINEA13+1
	adc #0
	sta PUNTDES+1
	
	ldy #1
	lda (PUNTDES),Y
	bne  J2_SMOKDERECHA
	
	ldx #8
	ldy #2
C1_SMOKDERECHA	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C1_SMOKDERECHA
	
	clc
	lda LINEA12
	adc #18
	sta PUNTDES

	lda LINEA12+1
	adc #0
	sta PUNTDES+1
	
	ldy #2
C2_SMOKDERECHA	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C2_SMOKDERECHA
	
	clc
	lda LINEA11
	adc #18
	sta PUNTDES

	lda LINEA11+1
	adc #0
	sta PUNTDES+1

	ldy #2
C3_SMOKDERECHA	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C3_SMOKDERECHA
	
	dec CTRSMOK
	jmp SON_HUMO

J1_SMOKDERECHA
	lda STRIG0
	beq J2_SMOKDERECHA
	
	lda #255
	sta CTRSMOK
	
J2_SMOKDERECHA
	rts

;-----------------
ESGRUESO_DERECHA
	lda #7
	sta TEMHSC
	
	lda #RR+GEH
	sta ESTADO
		
	inc COLCRS
	inc CTRCOLRADAR	
	
	lda CTRCOLRADAR
	cmp #9
	bne CLRSMOK_DERECHA
	
	inc COLRADAR
CRD	lda #0
	sta CTRCOLRADAR
		
	inc CONTCZONA
	lda CONTCZONA
	cmp #5
	bne CLRSMOK_DERECHA
	
	lda #1
	sta CONTCZONA
	
	inc CONTZONA
		
;----------------
CLRSMOK_DERECHA
	ldx #69
	
C_CLRSMOK_DERECHA
	lda LINEA00,X
	sta PUNTDES
	lda LINEA00+1,X
	sta PUNTDES+1
		
	ldy #1
	lda (PUNTDES),Y
	cmp #14
	bcs J_CLRSMOK_DERECHA
	cmp #1
	bcc J_CLRSMOK_DERECHA
		
	lda #0
	sta (PUNTDES),Y
	
J_CLRSMOK_DERECHA
	dex
	dex
	dex
	bpl C_CLRSMOK_DERECHA
	rts


;*************
ES_STICK_ABAJO?
	cmp #SUR
	beq STICK_ABAJO
	jmp ES_STICK_IZQUIERDA?
	
;*********
STICK_ABAJO
	lda DIRMAPA
	cmp #NORTE
	beq ES_ABAJO
	
CTR_ABAJO
	lda COLCON
	cmp COLCTR
	bne J2_CTR_ABAJO
	
	lda ROWCON
	cmp ROWCTR
	bne J2_CTR_ABAJO
		
	jsr CHECK_SUR
	beq ES_ABAJO

	lda COLCON
	cmp #5
	beq J1_CTR_ABAJO
	
	lda #NORTE
	sta STICK0
	jmp ES_STICK_ARRIBA?

J1_CTR_ABAJO
	lda ESTADO
	and #1
	bne J3_CTR_ABAJO		;V		
	
	jsr CHECK_OESTE
	bne AL_ESTE
	
	lda #OESTE
	sta STICK0
	jmp ES_IZQUIERDA

AL_ESTE
	lda #ESTE
	sta STICK0
	jmp ES_DERECHA
	
J2_CTR_ABAJO
	lda DIRMAPA
	cmp STICK0
	beq SIGUE_ABAJO

J3_CTR_ABAJO
	lda #6
	sta TEMVSC
	lda #7
	sta ROWCON
	sta ROWCTR
	
	lda DIRMAPA
	sta STICK0
	jmp ES_STICK_DERECHA?
	
;--------
ES_ABAJO
	lda STICK0
	sta DIRMAPA

;------------
SIGUE_ABAJO	
	inc ROWCON
	lda ROWCON
	cmp #12
	bne NOLINEA_MAXIMA
	
	lda #0
	sta ROWCON

NOLINEA_MAXIMA
	inc TEMVSC
	inc TEMVSC
	
	lda TEMVSC
	cmp #8
	bne CHKSMOK_ABAJO
	jmp ESGRUESO_ABAJO

;---------------
CHKSMOK_ABAJO
	lda #DD+FSV
	sta ESTADO
	
	lda CTRSMOK
	bmi J2_SMOKABAJO
	beq J1_SMOKABAJO
	
	lda ROWCON
	cmp #5
	bne  J2_SMOKABAJO
			
	clc
	lda LINEA10
	adc #21
	sta PUNTDES

	lda LINEA10+1
	adc #0
	sta PUNTDES+1
	
	ldy #1
	lda (PUNTDES),Y
	bne  J2_SMOKABAJO
	
	ldx #8
	ldy #2
C1_SMOKABAJO	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C1_SMOKABAJO
	
	clc
	lda LINEA09
	adc #21
	sta PUNTDES

	lda LINEA09+1
	adc #0
	sta PUNTDES+1
	
	ldy #2
C2_SMOKABAJO	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C2_SMOKABAJO
	
	clc
	lda LINEA08
	adc #21
	sta PUNTDES

	lda LINEA08+1
	adc #0
	sta PUNTDES+1

	ldy #2
C3_SMOKABAJO	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C3_SMOKABAJO
	dec CTRSMOK
	jmp SON_HUMO
	
J1_SMOKABAJO
	lda STRIG0
	beq J2_SMOKABAJO
	
	lda #255
	sta CTRSMOK
	
J2_SMOKABAJO
	rts

;-------------
ESGRUESO_ABAJO
	lda #0				
	sta TEMVSC
	
	lda #DD+GSV
	sta ESTADO
	
	inc ROWCRS
	inc CTRLINRADAR
	
	lda CTRLINRADAR
	cmp #11
	bne CLRSMOK_ABAJO
	
	lda #0
	sta CTRLINRADAR
	tay
	sta (LINRADAR),Y
	inc LINRADAR
	lda #1
	sta (LINRADAR),Y
	
	inc CONTLZONA
	lda CONTLZONA
	cmp #5
	bne CLRSMOK_ABAJO	
	
	lda #1
	sta CONTLZONA
	
	clc
	lda CONTZONA
	adc #3
	sta CONTZONA

;------------------
CLRSMOK_ABAJO
	lda ROWCRS
	cmp #11
	bcc J1_CLRSMOK_ABAJO	
	
	lda LINEA00
	sta CLRSMOK
	lda LINEA00+1
	sta CLRSMOK+1
		
J1_CLRSMOK_ABAJO
	rts


;****************
ES_STICK_IZQUIERDA?
	cmp #OESTE
	beq STICK_IZQUIERDA
	jmp NO_MOVIO
	
;*************
STICK_IZQUIERDA			;Movio a la izquierda
	lda DIRMAPA
	cmp #ESTE
	beq ES_IZQUIERDA		;Direccion actual

CTR_IZQUIERDA
	lda ROWCON
	cmp ROWCTR			;Control posicion Vert.
	bne J2_CTR_IZQUIERDA		;Espera posicion de giro
	
	lda COLCON
	cmp COLCTR			;Control posicion Hor.
	bne J2_CTR_IZQUIERDA		;Espera posicion de giro
	
	jsr CHECK_OESTE			;Controla obtaculo
	beq  ES_IZQUIERDA		;Pista limpia
	
	lda ROWCON
	cmp #6
	beq J1_CTR_IZQUIERDA
	
	lda #ESTE				
	sta STICK0
	jmp ES_STICK_DERECHA?	
	
J1_CTR_IZQUIERDA
	lda ESTADO
	and #1
	beq J3_CTR_IZQUIERDA		
	
	jsr CHECK_NORTE
	bne AL_SUR
	
	lda #NORTE
	sta STICK0
	jmp ES_ARRIBA

AL_SUR
	lda #SUR
	sta STICK0
	jmp ES_ABAJO
	
J2_CTR_IZQUIERDA
	lda DIRMAPA
	cmp STICK0
	beq SIGUE_IZQUIERDA
	
J3_CTR_IZQUIERDA	
	lda #6
	sta TEMHSC
	sta COLCON
	sta COLCTR
	
	lda DIRMAPA
	sta STICK0
	jmp ES_STICK_ARRIBA?
	
;-------------
ES_IZQUIERDA
	lda STICK0
	sta DIRMAPA
	
;----------------
SIGUE_IZQUIERDA	
	inc COLCON
	lda COLCON
	cmp #12
	bne NOCOLUMNA_MINIMA
	
	lda #0
	sta COLCON
	
NOCOLUMNA_MINIMA
	inc TEMHSC
	lda TEMHSC
	cmp #8
	bne CHKSMOK_IZQUIERDA
	jmp ESGRUESO_IZQUIERDA
	
;--------------------
CHKSMOK_IZQUIERDA
	lda #LL+FOH
	sta ESTADO	
	
	lda CTRSMOK
	bmi J2_SMOKIZQUIERDA
	beq J1_SMOKIZQUIERDA
	
	lda COLCON
	cmp #3
	bne  J2_SMOKIZQUIERDA
			
	clc
	lda LINEA13
	adc #23
	sta PUNTDES

	lda LINEA13+1
	adc #0
	sta PUNTDES+1
	
	ldy #1
	lda (PUNTDES),Y
	bne  J2_SMOKIZQUIERDA
		
	ldx #8
	ldy #2
C1_SMOKIZQUIERDA	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C1_SMOKIZQUIERDA
	
	clc
	lda LINEA12
	adc #23
	sta PUNTDES

	lda LINEA12+1
	adc #0
	sta PUNTDES+1
	
	ldy #2
C2_SMOKIZQUIERDA
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C2_SMOKIZQUIERDA
	
	clc
	lda LINEA11
	adc #23
	sta PUNTDES

	lda LINEA11+1
	adc #0
	sta PUNTDES+1

	ldy #2
C3_SMOKIZQUIERDA	
	lda HUMO,X
	sta (PUNTDES),Y
		
	dex
	dey
	bpl C3_SMOKIZQUIERDA
	
	dec CTRSMOK
	jmp SON_HUMO
	
J1_SMOKIZQUIERDA	
	lda STRIG0
	beq J2_SMOKIZQUIERDA
	
	lda #255
	sta CTRSMOK

J2_SMOKIZQUIERDA	
	rts

;-----------------
ESGRUESO_IZQUIERDA	
	lda #4
	sta TEMHSC
	
	lda #LL+GOH
	sta ESTADO
	
	dec COLCRS
	dec CTRCOLRADAR
	
	lda CTRCOLRADAR
	bpl CLRSMOK_IZQUIERDA
	
	dec COLRADAR
CRI	lda #8
	sta CTRCOLRADAR
	
	dec CONTCZONA
	bne CLRSMOK_IZQUIERDA	
	
	lda #4
	sta CONTCZONA
	
	dec CONTZONA
	
;--------------------	
CLRSMOK_IZQUIERDA
	ldx #69
	
C_CLRSMOK_IZQUIERDA
	lda LINEA00,X
	sta PUNTDES
	lda LINEA00+1,X
	sta PUNTDES+1
		
	ldy #44
	lda (PUNTDES),Y
	cmp #14
	bcs J_CLRSMOK_IZQUIERDA
	cmp #1
	bcc J_CLRSMOK_IZQUIERDA
		
	lda #0
	sta (PUNTDES),Y
	
J_CLRSMOK_IZQUIERDA
	dex
	dex
	dex
	bpl C_CLRSMOK_IZQUIERDA
	rts
	
;********
PON_CERO
	iny
	lda (PUNTDES),Y
	bne J1_PON_CERO
	
	lda GANANCIA+2
	jmp J2_PON_CERO
	
J1_PON_CERO
	lda #127

J2_PON_CERO	
	sta (PUNTDES),Y
	sty CTRROUND
	rts
	
;********
NO_MOVIO
	lda ESTADO
	and #1
	bne J1_NO_MOVIO
	
	lda #5
	sta TEMHSC
	sta COLCON
	sta COLCTR	
	
	lda ROWCON			;Es vertical
	cmp #6
	bne J2_NO_MOVIO
	
J1_NO_MOVIO				;Es horizontal
	lda #4
	sta TEMVSC
	lda #6
	sta ROWCON
	sta ROWCTR
		
	lda COLCON
	cmp #5
	bne J2_NO_MOVIO
				
J2_NO_MOVIO
	lda DIRMAPA
	sta STICK0
	jmp ES_STICK_ARRIBA?


;*********		
CHECK_NORTE
	ldy #22
	lda LINEA09
	sta AUTOXY
	lda LINEA09+1
	jmp CHECK
	
CHECK_ESTE
	ldy #25
	lda LINEA12
	sta AUTOXY
	lda LINEA12+1
	jmp CHECK
		
CHECK_SUR
	ldy #22
	lda LINEA15
	sta AUTOXY
	lda LINEA15+1
	jmp CHECK
	
CHECK_OESTE
	ldy #19
	lda LINEA12
	sta AUTOXY
	lda LINEA12+1
	
CHECK
	sta AUTOXY+1

	lda #0
	sta TIPOBJ
	sta HITCLR
	
	lda (AUTOXY),Y
				
	cmp #27+128			;Cuadra?
	bcs J1_CHECK
	cmp #14+128
	bcc J1_CHECK
	jmp ES_OBTACULO
	
J1_CHECK	
	cmp #51+128		;Arbol?
	beq ES_OBTACULO
	
	sta TIPOBJ
	bne J2_CHECK
	sta HITCLR
	
J2_CHECK	
	lda #5
	sta COLCTR
	lda #6
	sta ROWCTR
	lda #0
	rts

ES_OBTACULO
	lda #1
	rts


;***		SONIDO DE HUMO
SON_HUMO	
	lda #<T1SM			;Inicia Sonido
	sta TRACK3
	lda #>T1SM
	sta TRACK3+1
			
	lda #6				;Cantidad de Notas a leer
	sta CTRS+1
	
	lda #0				;Duracion de nota, regresivo
	sta TIMT+1				;de N a 255
	rts
	
T1SM
	.BYTE $66,$69,$4C,$41,$35,0,0,0	
	;.BYTE $E6,$D9,$CC,$C1,$B5,0,0,0		;Humo
	
	
;***		SUMA PUNTAJE CHECK POINT
INC_CPOINT
	ldy CONTZONA
	lda ZONAS,Y
			
	tay
	lda RADAR,Y
	eor #$FF
	and RADAR,Y
	
	sta RADAR,Y			;Borra Punto/Bandera de Radar
	sta RADAR+1,Y
		
	inc CONCPOINT			;Suma bandera
	
	lda CONCPOINT
	ldx CTRSPOINT
	beq J1_INC_CPOINT
	sta MULCPOINT			;Factor mutiplicador 1/2
				
J1_INC_CPOINT
	cmp #10
	bne J2_INC_CPOINT
	
	ldy #8
	jmp J3_INC_CPOINT
	
J2_INC_CPOINT
	asl
	asl
	asl					
	tay
	
J3_INC_CPOINT
	ldx #0
	stx DHP+1

C1_INC_CPOINT
	lda PUNTOS,Y			;Lee Data puntos, 100,200,300...
	sta CPPUNT,X			;Escribe a set AREA

	iny
	inx
	cpx #8
	bne C1_INC_CPOINT
		
	sei
	sed

	clc
	lda CONCPOINT			;Lee Nbandera, 1,2,3...
	adc MULCPOINT			;Suma para multiplicar *1, *2
	
	ldx #3
	jsr C2_INC_CPOINT
	jmp J6_INC_CPOINT
	
C2_INC_CPOINT	
	adc PUNTAJE,X			;Suma Nbandera+3Digito de puntaje, 999.999
	tay					    ;Conservo resultado en Decimal
	and #$0F				;Recupero digito bajo
	sta PUNTAJE,X
	
	tya
	and #$F0
	beq J4_INC_CPOINT
	lsr
	lsr
	lsr
	lsr
	
	dex
	stx DHP+1
	jmp C2_INC_CPOINT
		
J4_INC_CPOINT
	cld
	cli

DHP 	lda #0
	beq J5_INC_CPOINT
	tax
	
J5_INC_CPOINT	
	stx HIDIGITO+1
	rts

J6_INC_CPOINT
	inc CTRCPOINT
	
	lda CTRS+1
	bne J7_INC_CPOINT

	lda #<T1CP				;Inicia Sonido CP y SP
	sta TRACK3
	lda #>T1CP
	sta TRACK3+1
	
SSP	lda #6				;Cantidad de Notas a leer check point
	sta CTRS+1
	
	lda #6				;Recupera sonido simple
	sta SSP+1
	
	lda #1				;Duracion de nota, regresivo
	sta TIMT+1				;de N a 255

J7_INC_CPOINT
	sta HITCLR
	rts
	
T1CP
	.BYTE $28,$23,$1F,$1A,$13,0		;Check y Super
	.BYTE $28,$23,$1F,$1A,$13,0
	.BYTE $28,$23,$1F,$1A,$13
	
;***		SUMA PUNTAJE SUPER POINT  X2
INC_SPOINT
	lda #0
	sta DPS+1
	
	lda #12
	sta GANANCIA+4
	lda #13
	sta GANANCIA+5
		
	inc CTRSPOINT
	rts
	
;***		BONUS BANDERA DE LA SUERTE
BONUS_LPOINT
	jsr CTR_DSCORE
	
	lda #0
	tay
	lda (LINRADAR),Y
	sta TEMPLINPUNT
	
	tya
	sta (LINRADAR),Y
		
	lda #$0F				;UP
	sta ONOFFUP+1			;Blanco
	sta PPP+1
	
	lda #0
	sta ONUP+1			;Mantiene UP encendido
	sta NOTTIMT
	sta NOTATEM
	
	lda #9
	sta CTRL+1
		
	lda #<T1LP				;Inicia Sonido LP
	sta TRACK3
	lda #>T1LP
	sta TRACK3+1
			
	ldy #<PLAY_MUSICA
	ldx #>PLAY_MUSICA
	lda #7
	jsr SETVBV				;Habilita VBI
	
	lda POSBARRA+1
	sta TEMP2
	
	lda #$1A
	sta CBL+1
	
C2_BONUS_LPOINT
	lda PMBARRA
	beq J2_BONUS_LPOINT
	
	lda #4
	jsr PAUSA
		
	sei
	sed
	
	ldx #4
	clc
	lda #1
			
	jsr C2_INC_CPOINT
	jsr CTR_DSCORE 
	jsr CTR_FUEL
	
CTR_SLPOINT
	lda NOTATEM			;Contador de Notas Temp.
CTRL	cmp #0				;Cantidad de NT.
	bne J1_CTR_SLPOINT		;Sigue reproduciendo NT.
	
	lda #0
	sta NOTATEM
	jmp C2_BONUS_LPOINT
	
J1_CTR_SLPOINT
	tay
	lda (TRACK3),Y			;Lee nota temporal, 3to canal	
	bne J2_CTR_SLPOINT	
	
	sta VCM+1				;Silencio temporal
	jmp J3_CTR_SLPOINT				

J2_CTR_SLPOINT
	sta NCM+1				;Repruduce nota
	
	lda #$AF				;Distorcion 10 - Volumen 15, (AF)
	sta VCM+1

J3_CTR_SLPOINT
	inc NOTATEM			;Proxima nota
	jmp C2_BONUS_LPOINT
	
J2_BONUS_LPOINT
	lda CONCPOINT			
	cmp #10
	bne J3_BONUS_LPOINT
	rts
	
J3_BONUS_LPOINT
	jsr MOMENTO
	jsr INI_BARRA
		
C3_BONUS_LPOINT
	jsr CTR_FUEL
	
	lda POSBARRA+1
	cmp TEMP2
	bne C3_BONUS_LPOINT
			
	lda #1
	sta ONUP+1			;Libera UP, destella
	
	lda #$0
	sta PPP+1
	
	ldy #0
	lda TEMPLINPUNT
	sta (LINRADAR),Y
		
	lda #0
	sta CTRLPOINT	
	
	jsr ON_MOTOR
		
	ldy #<VBI
	ldx #>VBI
	lda #7
	jsr SETVBV				;Habilita VBI
		
	lda #$36
	sta CBL+1
	rts
	
T1LP
	.BYTE $1D,$1A,$17,$16,$13,$11,$0F,$0E,0				;Lucky
	;.BYTE $1D,0,$1A,0,$17,0,$16,0,$13,0,$11,0,$0F,0,$0E,0	;Lucky
	
;*********	
ES_COLISION
	lda #$0F				;UP
	sta ONOFFUP+1			;Blanco
		
	lda #0
	sta ONUP+1			;Mantiene UP encendido
					
	lda #0
	sta BHPOS0+1
	sta BHPOS1+1
	sta BHPOS2+1
	sta COLRADAR
		
	jsr CTR_ONDA
		
	lda #$31	
	sta YLOC0	
	
	lda #$B1
	sta YLOC1
		
	ldy #8
C1_BANG
	lda BANP0,Y
	sta (YLOC0),Y
	lda BANP1,Y
	sta (YLOC1),Y
	dey
	bpl C1_BANG
	
	ldx #3
	lda #0
C2_BANG
	sta COLORPM,X
	dex
	bpl C2_BANG
		
	lda #127
	sta BHPOS1+1
	
	lda #119
	sta BHPOS0+1
	
	ldx #30
	
C3_BANG
	txa
	lsr
	sta AUDC1
	sta AUDC2
	
	sec
	lda #20
	sbc AUDC1
	sta AUDF1
	
	lda RANDOM
	and #1
	beq J1_BANG
	lda AUDC2
	
J1_BANG
	sta AUDF2
	dex
	cpx #4
	beq J2_BANG
	
	lda #2
	jsr PAUSA
	jmp C3_BANG

J2_BANG
	jsr CTR_ONDA
	rts


;***		COLOCA ONDA BANG
CTR_ONDA
	jsr MUTE
	
	lda #<ONDA
	sta TOM+1
	sta PON+1
	lda #>ONDA
	sta TOM+2
	sta PON+2
		
	lda LINEA11
	sta PUNTDES
	lda LINEA11+1
	sta PUNTDES+1
	ldy #23
	jsr MUEVE_ONDA	

	lda LINEA12
	sta PUNTDES
	lda LINEA12+1
	sta PUNTDES+1
	ldy #23
	jsr MUEVE_ONDA	
	
	lda LINEA13
	sta PUNTDES
	lda LINEA13+1
	sta PUNTDES+1
	ldy #23
	jsr MUEVE_ONDA
	rts
	
MUEVE_ONDA
	ldx #2
C1_ONDA
	lda (PUNTDES),Y
	pha
		
TOM	lda ONDA,X
	sta (PUNTDES),Y
	
	pla
PON	sta ONDA,X
	dey
	dex
	bpl C1_ONDA
	
	clc
	lda TOM+1
	adc #3
	sta TOM+1
	bcc J1_ONDA
	inc TOM+2

J1_ONDA
	clc
	lda PON+1
	adc #3
	sta PON+1
	bcc J2_ONDA
	inc PON+2
	
J2_ONDA
	rts
