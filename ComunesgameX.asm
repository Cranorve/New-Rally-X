;*************************************
DISPLAY
	jsr INC_ROUND
	jsr SET_VIDAS

	ldx #11				;Limpia SCORE
CLR_SCORES
	lda SCORE,X
	sta UBISCORE,X
	dex
	bpl CLR_SCORES
	
	lda #0				;Limpia Puntaje
	ldx #5
CLR_PUNTAJE
	sta PUNTAJE,X
	dex
	bpl CLR_PUNTAJE
				
COMENZADO
	jsr MOMENTO
	jsr SALIDA			;Inicia pantalla AREA
	jsr SCROLL_GRUESO	;Ajusta LMS de 24 lineas
	jsr CLR_PMG
	jsr INI_BARRA
	jsr INI_PMG
		 	
	lda #<DLIAREA		;1ra Rutina DLI
	sta VDSLST
	lda #>DLIAREA
	sta VDSLST+1
	
	lda #<DLAREA 		;Lista de Despliege Area
	sta SDLSTL
    lda #>DLAREA 
	sta SDLSTL+1
	
	lda #3			
	sta GRACTL 			;Habilita Players y Missiles
		
	lda #$2F				
	sta SDMCTL			;Playfield ancho - P/M Resolucion Doble
	
	lda #$C0
	sta NMIEN			;DLI y VBI
	
	lda #255
	sta CONTCZONA
	
	rts


;********
INC_ROUND
	sei
	sed
	ldx #1

C1_ROUND		
	clc
	lda ROUND,X
	adc #1
	tay
	and #$0F
	sta ROUND,X
	
	tya
	and #$F0
	beq J1_ROUND
	lsr
	lsr
	lsr
	lsr
	
	dex
	bpl C1_ROUND
			
J1_ROUND
	cld
	cli

	stx RODIG+1
		
	ldx #2			;Pon round
C1_PON_ROUND
	dex
	jsr J1_PON_ROUND
	
RODIG
	cpx #0
	bne C1_PON_ROUND
	rts
		
J1_PON_ROUND
	txa
	asl
	tay
	
	clc
	lda ROUND,X
	adc #0
	asl
	sta UBIROUND,Y
	
	iny
	clc
	adc #1
	sta UBIROUND,Y
	inc CONTROUND
	rts
	
ROUND .DS 2				;2 Decimales 99	
CONTROUND .DS 1			;Real


;****************************************
SET_VIDAS					;Coloca tres vidas
	lda <UBIVIDASA
	sta TEMP2
	lda >UBIVIDASA
	sta TEMP2+1
		
	clc
	lda TEMP2
	adc #48
	sta TEMP3
	
	lda TEMP2+1
	adc #0
	sta TEMP3+1 
	
	lda CONVIDAS
	asl
	tay
	dey
C1_SETVIDA
	ldx #1
C2_SETVIDA
	lda OBJVIDA,X
	sta (TEMP2),Y
	
	lda OBJVIDA+2,X
	sta (TEMP3),Y
	
	dey
	bmi J_SETVIDA

	dex
	bpl C2_SETVIDA
	jmp C1_SETVIDA

J_SETVIDA
	rts
	
OBJVIDA					;4 Bytes
	.BYTE 38,39,40,41	


;******************************************		
INI_BARRA					;Barra FUEL completa
	clc
	lda >PLAYMISS
	adc #2
	sta TEMP1+1
	sta YLOCB+1
	inc YLOCB+1
		
	lda #$E9
	sta  TEMP1			;Parche P1
	lda #$69
	sta YLOCB			;Barrar P2

	ldy #3
	lda #$FF
PON_BARRA
	sta (TEMP1),Y
	sta (YLOCB),Y
	dey
	bpl PON_BARRA
		
	sta PMBARRA	
	
	lda #135
	sta POSBARRA+1		;Nivel de combustible
		
	lda #144
	sta POSPARCHE+1

CBI	lda #$1A			;Color Barra Inicio
	sta COLORBARRA+1
	sta COLORPARCHE+1
	
AJUST_PARCHE
	lda POSBARRA+1
	cmp #135
	beq J1_AJUST_BARRA
	
	cmp #144
	bne J1_AJUST_BARRA
	
	clc
	adc #12
	sta POSPARCHE+1
	
	lda #0
	sta COLORPARCHE+1
	
	lda #$E9
	sta  TEMP1			;Parche P1
	lda YLOCB+1
	sta TEMP1+1
	dec TEMP1+1
	
	lda #7
	ldy #3
PON_PARCHE
	sta (TEMP1),Y
	dey
	bpl PON_PARCHE
			
J1_AJUST_BARRA	
	rts

;******
PARTIDA
	lda CONTCZONA
	bpl PARTIDA
	
	lda #255
	sta CTRSMOK
			
	lda #123
	sta BHPOS0+1
	sta BHPOS1+1		;Chassis y ruedas ON
	
	lda #124				
	sta BHPOS2+1		;Cabina ON
			
	lda #192
	sta COLRADAR		;PUNTO ON
		
	lda #6
	sta CTRCOLRADAR
	
	lda #3
	sta CTRLINRADAR
	
	lda #10
	sta CONTZONA
	
	lda #3
	sta CONTLZONA
	
	lda #2
	sta CONTCZONA
	
	lda #$F0			
	sta COLOR4
	
	lda #1
	sta ONUP+1			;Libera UP, destella
			
	lda #0
	sta TIPOBJ
	sta MULCPOINT
	sta CTRCPOINT
	sta CTRSPOINT
	sta CTRLPOINT
	sta CTRROUND
	sta GANANCIA+4
	sta GANANCIA+5
	sta PPP+1
					
	lda #<GANANCIA
	sta PUNTOBJ 
	lda #>GANANCIA
	sta PUNTOBJ +1
	
	jsr COLOR_AUTOS
	jsr GIRO1
	
	ldy #<VBI
	ldx #>VBI
	lda #7
	jsr SETVBV			;Habilita VBI
	rts

;***
INI_MELODIA
	lda <T1MUSICA		;Inicia 1er Track
	sta PUNTFUE
	lda >T1MUSICA
	sta PUNTFUE+1
			
	lda <T2MUSICA		;Inicia 2do Track
	sta TEMP1
	lda >T2MUSICA
	sta TEMP1+1
	
	lda <MUSICA
	sta TRACK1
	sta TRACK2
	sta NOTACNT
	
	ldx >MUSICA
	stx TRACK1+1
	inx
	inx
	stx TRACK2+1		;+ Dos paginas
	
	lda #2
	sta NOTACNT+1

MUEVE_TMUSICA
	ldy NOTACNT
	lda (PUNTFUE),Y
	sta (TRACK1),Y
	
	lda (TEMP1),Y
	sta (TRACK2),Y
	
	inc NOTACNT
	bne MUEVE_TMUSICA

	dec NOTACNT+1
	beq J1_MUEVE_TMUSICA
		
	inc PUNTFUE+1
	inc TRACK1+1
	inc TRACK2+1
	jmp MUEVE_TMUSICA
	
J1_MUEVE_TMUSICA
	lda #0
	sta NOTACNT
						
	lda >MUSICA
	sta TRACK1+1
	clc
	adc #2
	sta TRACK2+1
		
	lda #2
	sta NOTACNT+1
			
	LDA #2
	sta DNM+1	
	sta NOTATIM 		;Inicia duracion

	lda #32
	jsr PAUSA

	jsr ON_MUSICA
	jsr ON_MOTOR
	rts
	

;******************************************
;Controles On/Off de Musica y Ruido de Motor
;Datos de Musica
ON_MUSICA
	lda CTRMODO
	beq MUTE
	
	lda #$AA
	sta VC3+1
	sta VC2+1
	sta VC1+1
		
	lda #0
	;sta NOTATEM 
	;sta NOTTIMT
	rts

ON_MOTOR
	lda #$6A			;MOTOR
	sta VCM+1
	
	lda #45
	sta NCM+1
	
	lda #0
	sta CTRS+1
	sta NOTATEM
	rts

MUTE

;	jsr $D510
	lda #0
	sta VC3+1
	sta VC2+1
	sta VC1+1
	sta VCM+1
	rts
	
VBI_BIPASS			;Interrupcion Vertical Temporal
	ldy #<VBIPASS
	ldx #>VBIPASS
	lda #7
	jsr SETVBV
	rts	


;***		OTRA VIDA
SCROLL_SOFT
	ldx CONTCZONA
	ldy CONTLZONA

	clc
 	lda TABLADL+308,Y	;296
	adc #45
	sta LINEA00,X
	
	iny
	sty CONTLZONA
	
	lda TABLADL+308,Y
	adc #0
	sta LINEA00+1,X
	
	inx
	stx CONTCZONA
	
	cpx #23*3+1
	beq J_SCROLL
		
	inc CONTLZONA
	inc CONTCZONA
	inc CONTCZONA
	
	jmp XITVBV

J_SCROLL
	lda <VBIPASS
	sta VVBLKD
	lda >VBIPASS
	sta VVBLKD+1
	
	lda #255
	sta CONTCZONA
	jmp XITVBV
		

;********
CLR_VIDAS				;Limpia tres vidas
	lda CONVIDAS
	pha
C_CLRVIDAS
	jsr CLR_VIDA
	bpl C_CLRVIDAS
	pla
	sta CONVIDAS
	rts

CLR_VIDA				;Limpia de una vida
	lda CONVIDAS
	asl
	sta TEMP1
	dec TEMP1
	dec TEMP1
	
	clc
	lda #<UBIVIDASA
	adc TEMP1
	sta TEMP2
	lda #>UBIVIDASA
	adc #0
	sta TEMP2+1
		
	clc
	lda TEMP2
	adc #48
	sta TEMP3
	lda TEMP2+1
	adc #0
	sta TEMP3+1 

	ldy #1
C_CLRVIDA
	lda #64				;Espacio vacio
	sta (TEMP2),Y
	sta (TEMP3),Y
	dey	
	bpl C_CLRVIDA
	dec CONVIDAS
	rts


;****		ESPERA N VERTICAL BLANK
PAUSA
	clc
	adc RTCLOK+2
	sta ESPERA+1
	
J_PAUSA	
	lda RTCLOK+2
ESPERA
	cmp #0
	bne J_PAUSA
	rts
	
;***		ESPERA UN VERTICAL BLANK
MOMENTO				;Espera un cuadro
	lda RTCLOK+2
C_MOMENTO
	cmp RTCLOK+2
	beq C_MOMENTO
J_MOMENTO	
	rts


LEE_BOTON				;ON/OFF
	lda GRAFP3			;STRIG0
	sta ATRACT
	bne LEE_BOTON		;1 = Abierto

SOLTO_BOTON?
	lda GRAFP3			;STRIG0
	beq SOLTO_BOTON?	;0 = Cerrado
	
	jsr MOMENTO	
	rts

;***********************************
MUEVE_MAPA
	LDA #<MAPA			;Destino de datos
	STA PUNTDES
	LDA #>MAPA
	STA PUNTDES+1
		
	jsr OFF_ROM

C1_DESCOMPRIME
FUE	LDA $FFFF	
	STA TEMP0
	
	LDX #8
C2_DESCOMPRIME
	LDA #$23

	ROL TEMP0
	BCS J1_DESCOMPRIME
	LDA #$20
	
J1_DESCOMPRIME
	STA (PUNTDES),Y
	INY
	BNE J2_DESCOMPRIME
	
	INC PUNTDES+1
	LDA PUNTDES+1
	CMP #(>MAPA+$07)
	BEQ MUEVE_ARBOL

J2_DESCOMPRIME
	DEX
	BNE C2_DESCOMPRIME
	INC FUE+1
	BNE C1_DESCOMPRIME
	INC FUE+2
	JMP C1_DESCOMPRIME
	
MUEVE_ARBOL
	ldy #71
C1_MUEVE_ARBOL
DAM	lda $FFFF,Y
	sta DATARBOL,Y
	dey
	bpl C1_MUEVE_ARBOL
	
	ldy #4
C1_MUEVE_COLOR
DCM	lda $FFFF,Y
	sta COLORAREA,Y
	dey
	bpl C1_MUEVE_COLOR

	jsr ON_ROM
	rts

;**********************************	
OFF_ROM
	sei				;deshabilita IRQs
	lda NMIEN
	sta LNFLG
	
	ldy #0
	sty NMIEN		;deshabilita NMIs
			
	lda #$FE
	sta PORTB		;deshabilita ROM
	rts

;**********************************	
ON_ROM
	lda #$FF
	sta PORTB		;habilita ROM
	
	lda LNFLG
	sta NMIEN		;habilita NMIs
	cli				;habilita IRQs
	rts
