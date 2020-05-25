MODODEMO
	lda #<MAPA1
	sta FUE+1
	lda #>MAPA1
	sta FUE+2

	lda #<ARBOL1MAP
	sta DAM+1
	lda #>ARBOL1MAP
	sta DAM+2

	lda #<COLOR1MAP
	sta DCM+1
	lda #>COLOR1MAP
	sta DCM+2
	
	jsr MUEVE_MAPA
	jsr CASTING

	beq J_MODODEMO		;Termina DEMO!
	
	jsr CLR_VIDAS
	
	lda #0
	sta ROUND
	sta ROUND+1
	sta CONTROUND
	inc CONTROUND
	sta CONCPOINT
	sta GANANCIA+4
	sta GANANCIA+5
	sta CONVIDAS
	inc CONVIDAS
	
	jsr CREA_AREA
	jsr DISPLAY
		
	lda #60
	jsr PAUSA
		
	jsr CLR_VIDA
	jsr PARTIDA
	
	lda #0
	sta RTCLOK+1
	sta RTCLOK+2
			
	sta HITCLR
	
C_DEMO
	jsr PROCESO
			
	lda STRIG0
	beq J_MODODEMO	;BOTON ON  ...Juege!!!
	
	lda RTCLOK+1		
    cmp #6			;25 Segundos +/-
	bne C_DEMO		;Espera
	
	lda #0
	sta DMACTL		;Deshabilita ANTIC
		
	jmp MODODEMO	;Otro ciclo
	
J_MODODEMO
	rts
	