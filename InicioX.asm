;***	Inicio y Display List Interrupt principal
	
	ORG INICIO
	lda #0
	sta SDMCTL		;Deshabilita ANTIC
	sta IRQEN		;Deshabilita interrupciones
	sta AUDCTL		;Inicializa sonidos
	sta CTRMODO+1
		
	jsr OFF_ROM
	
	sec				;Mueve Ram a Rom
	lda #>(BANCO+$380)
	sbc #>BANCO
	tax
C1_MUEVERAM
PMB	lda MEMLOAD,Y
	sta BANCO,Y
	iny
	bne C1_MUEVERAM
	dex
	beq C2_MUEVERAM
	inc PMB+2
	inc PMB+5
	jmp C1_MUEVERAM
C2_MUEVERAM
	lda MEMLOAD+$0300,Y
	sta BANCO+$0300,Y
	iny
	cpy #$80
	bne C2_MUEVERAM
	
	jsr ON_ROM

C1_INICIO
	ldx #11			;Limpia SCORE
CLR_HSCORES
	lda HISCORE,X
	sta UBIHISCORE,X
	dex
	bpl CLR_HSCORES
	
	ldx #5
CLR_INIHSCORE
	lda INIHSCORE,X
	sta PUNTHI,X
	dex
	bpl CLR_INIHSCORE
	
	lda #>PLAYMISS
	sta PMBASE

	jsr MODODEMO	;Ciclo de descanso

	ldx #1
	lda #0
	
C2_INICIO
	sta TEX1CHALLENGE+3,X
	sta TEX2CHALLENGE+4,X
	dex
	bpl C2_INICIO
	
	sta CTRROCK
	sta CTRNO
	
	jsr GAME		;Etapas del juego
	jmp C1_INICIO


;RUTINAS - Interrupciones de lista de despligue
;***		Rutina Uno
;Carga colores para mapa
DLIAREA
	sta REGA
	stx REGX
		
BHPOS0		
	lda #0 			;#123				
	sta HPOSP0		;CHASSIS
BHPOS1
	lda #0 			;#123
	sta HPOSP1		;RUEDAS
BHPOS2	
	lda #0				
	sta HPOSP2		;CABINA
BHPOS3	
	lda #0
	sta HPOSP3
		
	lda #1
	sta PRIOR
		
	lda #0
	sta SIZEP1
	sta SIZEP2
	sta SIZEP3
			
	ldx #4
	jmp J_DLIAREA
	
	sta WSYNC	
C_DLIAREA
	lda COLORPM,X
	sta COLPM0,X

J_DLIAREA
	lda COLORAREA,X		;Toma colores definidos para mapa
	sta COLPF0,X		;guarda en registos PF0 a PF4
	dex
	bpl C_DLIAREA
	
	lda #>SETAREA
	sta CHBASE
	
	lda #<DLIVENTANA	;Aca cambia punteros
	sta VDSLST			;proxima DLI, Area Ventana
	
	lda #>DLIVENTANA
	sta VDSLST+1
				
	ldx REGX
	lda REGA
	rti


;***		Rutina Dos
;Carga colores para ventana
DLIVENTANA
	sta REGA
	stx REGX
	sty REGY
		
	lda #0
	sta STATUS		;Libera sincronismo vertical de AREA
	
	ldx #4
	sta WSYNC
		
C1_DLIVENTANA
	lda COLORVENT,X		;Toma colores definidos para ventana
	sta COLPF0,X		;guarda en registos PF0 a PF4
	dex
	bpl C1_DLIVENTANA
		
	lda RTCLOK+2		;Destello punto en Radar
	and #7
	bne J2_DLIVENTANA	;No es tiempo!!!
PPP	
	lda #$0				;OFF punto				
	ldx ONOFFPUNTO
	bne J1_DLIVENTANA
	
	lda #$0F			;ON punto
J1_DLIVENTANA
	sta ONOFFPUNTO

J2_DLIVENTANA
	lda ONOFFPUNTO
	sta COLPM0
	
	lda RTCLOK+2		;Destello punto en Super check Point
	and #15
	bne J4_DLIVENTANA	;No es tiempo!!!

DPS	
	ldx #0
	ldy POSSPOINT
	lda RADAR,Y
	beq J3_DLIVENTANA
	
	ldx #$0			;ON punto
J3_DLIVENTANA
	txa
	sta RADAR,Y
	sta RADAR+1,Y

J4_DLIVENTANA
	lda COLRADAR	
	sta HPOSM0		;Posicion Horizontal punto auto en radar
		
	lda #$72
	sta COLPM3		;Radar Azul
		
	lda #184				
	sta HPOSP3		;Posicion Horizontal RADAR
		
	lda #2
	sta PRIOR
		
	lda #3			
	sta SIZEP1
	sta SIZEP2
	sta SIZEP3
		
	lda #>SETVENT
	sta CHBASE
			
	lda #<DLIHISCORE	;Aca cambia punteros
	sta VDSLST			;proxima DLI, Area Ventana
	
	lda #>DLIHISCORE
	sta VDSLST+1
			
	ldy REGY
	ldx REGX
	lda REGA
	rti


;***		Rutina Tres
;Carga colores para HiScore y Barra	
DLIHISCORE
	sta REGA
				
	lda #$34		;Rojo
	sta COLPF0		;HI SCORE
POSPARCHE		
	lda #0	 		;Posicion
	sta HPOSP1		;Parche
COLORPARCHE	
	lda #0		 	;Color
	sta COLPM1		;Parche
POSBARRA	
	lda #0			;Posicion				
	sta HPOSP2		;Barra
COLORBARRA	
	lda #0			;Color
	sta COLPM2		;Barra
	
	lda #<DLIUP
	sta VDSLST

	lda #>DLIUP
	sta VDSLST+1
		
	lda REGA
	rti


;***		Rutina Cuatro
;Carga colores para UP
DLIUP
	sta REGA
	stx REGX
CTRMODO	
	lda #0
ONUP	
	and #1
	beq J2_DLIUP		;Manten UP on
	
	lda RTCLOK+2		;Control destello UP
	and #31
	bne J2_DLIUP		;No es tiempo
	
	lda #$0				;OFF UP
	ldx ONOFFUP+1
	bne J1_DLIUP
	lda #$0F			;ON UP

J1_DLIUP
	sta ONOFFUP+1
	
J2_DLIUP
ONOFFUP
	lda #1
	sta COLPF0			;Destello
		
	lda #<DLISCORE
	sta VDSLST
	
	lda #>DLISCORE
	sta VDSLST+1

	ldx REGX
	lda REGA
	rti
	
	
;***		Rutina Cinco
;Carga colores para Score
DLISCORE
	sta REGA
			
	lda #$86			;Azul
	sta COLPF0			;SCORE
			
	lda #<DLIROUND
	sta VDSLST
	
	lda #>DLIROUND
	sta VDSLST+1

	lda REGA
	rti


;***		Rutina Seis
;Carga colores para ventana
DLIROUND
	sta REGA
	
	lda #$0F			;Blanco
	sta COLPF0			;ROUND
	
PL	lda #<DLIAREA
	sta VDSLST
	
PH	lda #>DLIAREA
	sta VDSLST+1
	
	lda REGA
	rti	
