;Coloca banderas
;Escribe bordes de area.
;Lee mapa descomprimido, en zona MAPA = $AA00 - 1792 Bytes
;lee caracte, reconoce cuadra, lee entorno, enciende flag en VISOR
;ordena caracteres de cuadra segun flag
;Dibuja contorno,cuadras,pistas y objetos en area de juego y ordena radar

;***************************************
CREA_AREA
	ldx #95
	lda #0
C_CLRRADAR
	sta RADAR,X		;Limpia Radar
	dex
	bpl C_CLRRADAR
	
	ldx #11
C_CLRZONAS
	sta ZONAS,X
	dex
	bpl C_CLRZONAS
	
	sta PUNTFUE
	lda #>MAPA
	sta PUNTFUE+1
	
	tay
C_CLRMAPA
	lda (PUNTFUE),Y
	cmp #$23
	beq J_CLRMAPA
	
	cmp #$20
	beq J_CLRMAPA
	
	lda #$20
	sta (PUNTFUE),Y

J_CLRMAPA
	iny
	bne C_CLRMAPA
	inc PUNTFUE+1
	lda PUNTFUE+1
	cmp #(>MAPA+$07)
	bne C_CLRMAPA

PONENEMIGO
	ldy #$45
	sty POSENE_1
	ldx #%00110000	;48 - Un enemigo
	
	lda CONTROUND
	cmp #1
	beq J2_PONENEMIGO
		
	sty POSENE_2
	
	cmp #2
	bne J1_PONENEMIGO
		
	ldx #%11110000	;244 - Dos enemigo
	jmp J2_PONENEMIGO
	
J1_PONENEMIGO
	sty POSENE_3
	sty POSENE_4
	sty POSENE_5
	sty POSENE_6
	sty POSENE_7
	
	lda #%00001111	;Dos enemigos arriba
	sta ZONA_01
	sta ZONA_01+1
			
	ldx #%11111111
	
J2_PONENEMIGO
	stx ZONA_10+4
	stx ZONA_10+5
			
DESCARTA			;Descarta 1 zonas de 11	
	lda RANDOM
	and #$0F
	cmp #12
	bpl DESCARTA
	
	cmp #10
	beq DESCARTA
	
	sta TEMP1		;Zona descartada
	sta CRX+1
	inc CRX+1				
	
ZONAS_ESPECIALES
	ldx #1
	
C1_ZONAS_ESPECIALES	;Escoje zonas S y L	
	lda RANDOM		
	and #$0F
	cmp #12
	bpl C1_ZONAS_ESPECIALES
	
	cmp TEMP1		;Es zona descartada 1?
	beq C1_ZONAS_ESPECIALES
	
	cmp #10			;Es zona 10?
	beq C1_ZONAS_ESPECIALES
		
	sta TEMP2,X		;Zona SUPER
	dex
	bpl C1_ZONAS_ESPECIALES
	
	cmp TEMP2+1		;Zona LUCKY?
	bne POSXYOBJ
	
	inx
	jmp C1_ZONAS_ESPECIALES
	
POSXYOBJ
	lda #<MAPA
	sta PUNTFUE
	lda #>MAPA
	sta PUNTFUE+1
	
	lda #0
	sta TEMPX		;Inicia Zonas
	
	jmp INI_LINEA

C1_POSXYOBJ
	ldx TEMPX
			
	lda PUNTFUE
	sta PUNTOBJ
	lda PUNTFUE+1
	sta PUNTOBJ+1

	cpx TEMP1		;Control de zonas descartada 1
	beq J1_POSXYOBJ
	
	cpx #10			;Control de zona descartadas inicial
	bne POSYY

J1_POSXYOBJ
	jmp ESTA_NO

POSYY	
	lda RANDOM		;Lineas al Azar
	and #$3
	sta TEMP1+1
	
	cmp #1
	bne J1_POSYY
	
	lda ZONA_01
	bne POSYY
		
J1_POSYY	
	lda TEMP3		;Control columna radar cero?
	beq J2_POSYY
CRX	cpx #$FF		;Control columna descartada +1
	beq J2_POSYY
	
	cpx #11
	beq J2_POSYY
	
	lda TEMP1+1
	cmp DELTAR		;Control repitio valor anterior?
	beq POSYY				
	
J2_POSYY
	lda TEMP1+1
	sta DELTAR		;Conserva Linea en Caracter, 0-3
	bne J3_POSYY	;Control > a 0
	
	cpx #3
	bcs J4_POSYY	;Salta si es Mayor
	
	ldy #0			;Linea extremo superior
	jmp C1_POSYY			
		
J3_POSYY
	cmp #3
	bne J4_POSYY	;Control linea < a 3
	
	cpx #9
	bcc J4_POSYY	;Salta si es Menor
	
	ldy #13			;Linea extremo inferiror
	jmp C1_POSYY
		
J4_POSYY
	ldy DELTAR	
	lda LZONA,Y		;1,5,8 y 12

J5_POSYY	
	tay
		
C1_POSYY
	beq POSXX		;Offset linea
	
	clc
	lda PUNTOBJ
	adc #32
	sta PUNTOBJ
	lda PUNTOBJ+1
	adc #0
	sta PUNTOBJ+1
	dey
	jmp C1_POSYY

POSXX	
	lda RANDOM		;Columna al Azar
	and #$03
	sta DELTAC		;Conserva columna
	
	cpx #3
	bcc J1_POSXX
	
	txa
	sec
	sbc #3
	tay
	
	lda ZONAS,Y
	tay
	lda RADAR,Y
	
	ldx #4

C1_POSXX
	dex
	ror
	ror
	bcc C1_POSXX
	
	txa
	cmp DELTAC
	beq POSXX
	
J1_POSXX	
	lda TEMP3		;Columna 0 - 3
	asl
	asl
			
	clc
	adc DELTAC
	tay
	lda CZONA,Y
	tay
	lda (PUNTOBJ),Y
	cmp #$20
	bne J2_POSXX	;Control posicion pista
	
	jmp ESTA_LIBRE
	
J2_POSXX
	jsr INI_LIBRE
	
	lda TEMP3
	cmp #1
	beq BUSCALIBRE	;Columna central?
	bcc J3_POSXX 	;Columna izquierda?
	
	lda DELTAC
	cmp #3		
	beq J1_TESTVERT	;Es Extremo derecho!!
	jmp BUSCALIBRE
	
J3_POSXX			;Columna izquierda
	lda DELTAC
	beq J1_TESTVERT	;Es Extremo izquierdo!!
	jmp BUSCALIBRE
	
J1_TESTVERT							
	lda RANDOM		;Comienzo arriba o abajo?
	and #$01
	bne J2_TESTVERT
		
	ldy #1			;Comprueba arriba antes
	lda (PUNTOBJ),Y
	cmp #$20
	beq ESTA_LIBRE
		
	ldy #65
	lda (PUNTOBJ),Y
	cmp #$20
	beq ESTA_LIBRE
	
	jmp C1_POSXYOBJ
	
J2_TESTVERT			;Comprueba abajo antes			
	ldy #65
	lda (PUNTOBJ),Y
	cmp #$20
	beq ESTA_LIBRE
	
	ldy #1
	lda (PUNTOBJ),Y
	cmp #$20
	beq ESTA_LIBRE
	
	jmp C1_POSXYOBJ	;Pista extrema inhabiliada
	
BUSCALIBRE
	lda RANDOM
	and #7
	
	sta CXI+1
			
	tax
	jmp J3_BUSCALIBRE

C1_BUSCALIBRE
	lda CERCANO,X
	tay
		
J2_BUSCALIBRE
	lda (PUNTOBJ),Y
	cmp #$20
	beq ESTA_LIBRE
	
CXI	cpx #$FF
	beq J4_BUSCALIBRE

J3_BUSCALIBRE	
	inx
	cpx #8
	bne C1_BUSCALIBRE
	
	ldx #0 	 
	jmp C1_BUSCALIBRE
	
J4_BUSCALIBRE
	jmp C1_POSXYOBJ	;Pista inhabiliada
	
INI_LIBRE
	clc
	tya
	adc PUNTOBJ
	sta PUNTOBJ
	lda PUNTOBJ+1
	adc #0
	sta PUNTOBJ+1
		
	sec
	lda PUNTOBJ
	sbc #33
	sta PUNTOBJ
	lda PUNTOBJ+1
	sbc #0
	sta PUNTOBJ+1
	rts	
		
ESTA_LIBRE
	ldx TEMPX

	lda #$43		;CHECK
	cpx TEMP2		;Super Check Point
	bne TEST_POINT

	lda #$53		;SUPER
	jmp PON_POINT
		
TEST_POINT
	cpx TEMP2+1		;Lucky Check Point
	bne PON_POINT
	
	lda #$4C		;LUCKY
PON_POINT
	sta (PUNTOBJ),Y
	sta TEMP3+1		;Bandera
	
	ldy DELTAC
	lda COLBYTE,Y
	sta INSDAT

	txa
	asl
	asl
	asl				
	
	asl TEMP1+1
	
	clc
	adc TEMP1+1
	tay
		
	lda RADAR,Y
	ora INSDAT
	
	sta RADAR,Y
	sta RADAR+1,Y
	
	lda TEMP3+1		;Que bandera es?
	cmp #$53
	bne ESTA_NO
	
	sty POSSPOINT	
	
	lda RADAR,Y
	sta DPS+1
		
ESTA_NO
	tya
	sta ZONAS,X

	inx
	cpx #12
	bne PROXIMA_ZONA
	
	jmp DIBUJA_AREA	;Banderas Ok!
	
PROXIMA_ZONA
	inc TEMPX
	
	inc TEMP3
	lda TEMP3
	cmp #3
	bne J1_PROXIMA_ZONA
	
SUMA384
	clc
	lda PUNTFUE
	adc #$AB
	sta PUNTFUE
	lda PUNTFUE+1
	adc #$1
	sta PUNTFUE+1
	
INI_LINEA
	lda #0
	sta TEMP3
	
	lda #11
	sta SM+1
	
	jmp C1_POSXYOBJ 
	
J1_PROXIMA_ZONA
	clc
	lda PUNTFUE
SM	adc #11
	sta PUNTFUE
	lda PUNTFUE+1
	adc #0
	sta PUNTFUE+1
	
	dec SM+1
	
	jmp C1_POSXYOBJ

	
CERCANO
	.BYTE 0,1,2,32,34,64,65,66
		
COLBYTE
	.BYTE 128,32,8,2
	
CZONA
	.BYTE 0,2,5,8
	.BYTE 0,3,6,9
	.BYTE 2,5,8,10
		
LZONA
	.BYTE 2,4,8,11
	
ZONAS .DS 12


;*********************************************************
DIBUJA_AREA
	lda #0
	sta POSX		;Columnas en Mapa
	sta POSY		;Lineas en Mapa
	sta COLCRS		;Columnas en Memoria 
	sta ROWCRS		;Lineas en Memoria
	
	jsr MOMENTO
;*** Linea superior e inferior de "ARBOLES"
C_CREA_AREA
	lda #<ARBOL		;Carga puntero objeto/arbol
	sta PUNTOBJ
	lda #>ARBOL
	sta PUNTOBJ+1
	
	jsr PON_PUNTTABLADL	;Inicio de una linea de area segun TABLADL a Destino
	jsr PON_CARACTERES	;Dibuja un objeto. mosaico de 9 caracteres, Arbol
	inc POSX
	lda POSX
	cmp #46	
	beq J_CREA_AREA

	inc COLCRS
	inc COLCRS
	inc COLCRS
	jmp C_CREA_AREA

;*** Copia 4 lineas de ARBOLES
J_CREA_AREA
	lda #4
	sta POSY
	lda #12
	sta ROWCRS
	
	lda #<MAPA		;Posicion Primer Objeto
	sta POSCAR
	lda #>MAPA	
	sta POSCAR+1
		
;***Lineas de MAPA
PON_AREA
	lda #0
	sta COLCRS
	sta POSX
	
	jsr PON_OBJETOS	;Proximo Linea de Mapa - Dibuja Mapa Arboles, Pistas y Arboles
	
	lda POSY		;control de Linea
	cmp #59
	beq INI_AREA	;Linea de Mapa Ok!
	inc POSY
	inc ROWCRS
	inc ROWCRS
	inc ROWCRS	
	jmp PON_AREA

INI_AREA
	lda #45
	sta COLCRS		;Columna caracter
	
	lda #5			;Centrado horizontal
	sta TEMHSC
	sta HSCROL
	sta COLCON
	sta COLCTR
		
	lda #154
	sta ROWCRS		;Linea caracteres
	
	lda #4			;Centrado vertical
	sta TEMVSC			
	sta VSCROL
	
	lda #6
	sta ROWCON		;Contador por objeto	
	sta ROWCTR
	
	lda #UU+FNV
	sta DIRAUTO		;10/Auto hacia ARRIBA+Fino,Vertical,Norte
	
	lda #NORTE		
	sta DIRMAPA
	
	lda #$0F		;UP
	sta ONOFFUP+1	;Blanco
	
	lda #0
	sta ONUP+1		;Mantiene UP encendido
	sta BHPOS3+1	;Chassis OFF
	sta BHPOS2+1	;Ruedas OFF
	sta BHPOS1+1	;Cabina OFF
	sta BHPOS0+1
	rts
	
	
;*** Ordena mozaicos de objetos
PON_OBJETOS
	lda #$B1		;lda (PUNTOBJ),Y	 
	sta NN
	lda #PUNTOBJ	
	sta NN+1
	
	lda POSX
	cmp #7			;Margen superior/izquierdo
	bcc ESARBOL		;Si A<7
	
	lda POSX
	cmp #39			;Margen superior/derecho
	bcs ESARBOL		;Si A>=39
	
	jmp PISTAS

ESARBOL
	ldy #<ARBOL
	ldx #>ARBOL
	jmp CARGAOBJ
	
PISTAS
	ldy #0
	lda (POSCAR),y
	cmp #PIS
	bne CUADRA?
	
	lda #$A9		;lda #0
	sta NN
	lda #0
	sta NN+1

	;ldy #<Pista
	;ldx #>Pista
	jmp OBJETO
	
CUADRA?
	cmp #CUA
	bne ENEMIGO?
	
	jsr EXAMINA_ADYACENTES	;********************************
	ldy #<CUADRA
	ldx #>CUADRA
	jmp OBJETO
	
ENEMIGO?
	cmp #ENE
	bne CHECK?
	
	ldy #<ENEMIGO1
	ldx #>ENEMIGO1
	jmp OBJETO
	
CHECK?
	cmp #CHE
	bne ESPECIAL?
	
	ldy #<CPOINT
	ldx #>CPOINT
	jmp OBJETO

ESPECIAL?
	cmp #SPE
	bne LUCKY?
	
	ldy #<SCPOINT
	ldx #>SCPOINT
	jmp OBJETO
	
LUCKY?
	cmp #LUC
	bne ROCK?
	
	ldy #<LCPOINT
	ldx #>LCPOINT
	jmp OBJETO
	
ROCK?
	ldy #<ROCK
	ldx #>ROCK
	
OBJETO
	clc
	lda POSCAR
	adc #1
	sta POSCAR
	lda POSCAR+1
	adc #0
	sta POSCAR+1
		
CARGAOBJ
	sty PUNTOBJ
	stx PUNTOBJ+1
	jsr PON_PUNTTABLADL	;Lineas mapa
	jsr PON_CARACTERES
	inc POSX	
	lda POSX
	cmp #46
	bne J_PON_OBJETO
	rts

J_PON_OBJETO
	inc COLCRS
	inc COLCRS
	inc COLCRS

	jmp PON_OBJETOS
	
;*** Dibuja cuadras con aceras

VISOR = ESTADO	;Banderas de entorno
CONTCAR = DIRENE;Contador de caracteres 1 a 9
COLMEM = COLCTR	;columna area
COLMAP = COLCON	;columna mapa
ROWMEN = ROWCTR	;linea area
ROWMAP = ROWCON	;linea mapa

EXAMINA_ADYACENTES
;Examina cuadras adyacentes
	lda #0
	tax
	sta CONTCAR
	sta TEMPY
	lda #255
	sta VISOR
		
	sec				;Calculo de posicion 
	lda POSCAR		;caracater superior izquierdo
	sbc #33			
	sta PUNTFUE
	lda POSCAR+1
	sbc #0
	sta PUNTFUE+1

	lda POSX		;Controla Bordes
	cmp #7			;Limite Izquierdo Area
	beq ADYACENTE_UP
	
	lda POSY
	cmp #4			;Limite Superior Area
	beq ADYACENTE_UP
	
	jsr EXAMINA
	bne ADYACENTE_UP
	
	lda #%01111111		
	sta VISOR
		
ADYACENTE_UP
	lda visor
	inc TEMPY
	lda POSY			
	cmp #4			;Limite Superior Area
	beq ADYACENTE_UPRIGHT
		
	jsr EXAMINA
	bne ADYACENTE_UPRIGHT
	
	lda VISOR
	and #%10111111
	sta VISOR
	
ADYACENTE_UPRIGHT
	inc TEMPY
	lda POSX
	cmp #38		;39			;Limite Derecho Area
	beq ADYACENTE_LEFT
	
	lda POSY			
	cmp #4			;Limite Superior Area
	beq ADYACENTE_LEFT
		
	jsr EXAMINA
	bne ADYACENTE_LEFT
	
	lda VISOR
	and #%11011111
	sta VISOR
	
ADYACENTE_LEFT
	lda #32
	sta TEMPY
	
	lda POSX			
	cmp #7		
	beq ADYACENTE_RIGHT
	
	jsr EXAMINA
	bne ADYACENTE_RIGHT
	
	lda VISOR
	and #%11101111
	sta VISOR
		
ADYACENTE_RIGHT
	inc TEMPY
	inc TEMPY
	
	lda POSX			
	cmp #38		;39			;Limite derecho		
	beq ADYACENTE_DOWNLEFT
	
	jsr EXAMINA
	bne ADYACENTE_DOWNLEFT
	
	lda VISOR
	and #%11110111
	sta VISOR
	
ADYACENTE_DOWNLEFT
	lda #64
	sta TEMPY
	
	lda POSX
	cmp #7		;Limite izquierdo
	beq ADYACENTE_DOWN
	
	lda POSY
	cmp #59		;Limite inferior
	beq ADYACENTE_DOWN
	
	jsr EXAMINA
	bne ADYACENTE_DOWN
	
	lda VISOR
	and #%11111011
	sta VISOR
	
ADYACENTE_DOWN
	inc TEMPY
	
	lda POSY
	cmp #59		;Limite inferior
	beq ADYACENTE_RIGHTDOWN
	
	jsr EXAMINA
	bne ADYACENTE_RIGHTDOWN
	
	lda VISOR
	and #%11111101
	sta VISOR

ADYACENTE_RIGHTDOWN
	inc TEMPY
	
	lda POSX
	cmp #38 	;39			;limite derecho
	beq BUSCA_LINEAUNO
	
	lda POSY
	cmp #59		;Limite inferior
	beq BUSCA_LINEAUNO
	
	jsr EXAMINA
	bne BUSCA_LINEAUNO
	
	lda VISOR
	and #%11111110
	sta VISOR

;Busca font de acera
BUSCA_LINEAUNO
	ldy VISOR
	tya
	and #%10000000			;U/L?
	beq J3_BUSCA_LINEAUNO	;Salta si es pista
	tya
	and #%1010000
	cmp #%1010000
	bne J1_BUSCA_LINEAUNO	;No es centro!
	jsr FONT_CENTRO
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTUP 
	
J1_BUSCA_LINEAUNO			;NOCENTRO
	cmp #%1000000			;UP?
	beq J2_BUSCA_LINEAUNO
L1MU	jsr FONT_MEDIOUP
	jsr FONT_MEDIOUP
	jmp  BUSCA_RIGHTUP
	
J2_BUSCA_LINEAUNO			;ESLEFT
L1ML	jsr FONT_MEDIOLEFT
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTUP
	
J3_BUSCA_LINEAUNO			;Es pista!
	tya
	and #%1010000
	cmp #%1010000			;UP - LEFT
	bne J5_BUSCA_LINEAUNO	;NOPUNTA!
	lda #22				;Punta!
	jsr PLANTILLA_CUADRA
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTUP
	
J5_BUSCA_LINEAUNO			;NOPUNTA
	cmp #%1000000
	beq L1ML				;LEFT!
	cmp #%10000
	beq L1MU				;UP!
	lda #14				;Esquina!
	jsr PLANTILLA_CUADRA
	jsr FONT_MEDIOUP
	
BUSCA_RIGHTUP
	ldy VISOR
	tya 
	and #%100000			;U/R?
	beq J3_BUSCA_RIGHTUP	;Salta si es pista
	tya
	and #%1001000
	cmp #%1001000			;UP - RIGHT?
	bne J1_BUSCA_RIGHTUP	;No es centro!
	jsr FONT_CENTRO
	jmp BUSCA_LINEADOS 
	
J1_BUSCA_RIGHTUP			;NOCENTRO
	cmp #%1000000			;UP?
	beq J2_BUSCA_RIGHTUP
RMU	jsr FONT_MEDIOUP
	jmp  BUSCA_LINEADOS
	
J2_BUSCA_RIGHTUP			;ESRIGHT
RMR	jsr FONT_MEDIORIGHT
	jmp BUSCA_LINEADOS
	
J3_BUSCA_RIGHTUP			;Es pista!
	tya
	and #%1001000
	cmp #%1001000			;UP - RIGHT?
	bne J5_BUSCA_RIGHTUP	;NOPUNTA!
	lda #23				;Punta!
	jsr PLANTILLA_CUADRA
	jmp BUSCA_LINEADOS
	
J5_BUSCA_RIGHTUP		;NOPUNTA
	cmp #%1000000
	beq RMR				;LEFT!
	cmp #%1000
	beq RMU				;UP!
	lda #15				;Esquina!
	jsr PLANTILLA_CUADRA
	
BUSCA_LINEADOS
	tya
	and #%10000
	beq J1_BUSCA_LINEADOS
	jsr FONT_CENTRO
	jsr FONT_CENTRO
	jmp BUSCA_RIGHT
J1_BUSCA_LINEADOS
	jsr FONT_MEDIOLEFT
	jsr FONT_CENTRO
	
BUSCA_RIGHT
	tya
	and #%1000
	beq J1_BUSCA_RIGHT
	jsr FONT_CENTRO
	jmp BUSCA_LINEATRES
J1_BUSCA_RIGHT
	jsr FONT_MEDIORIGHT
	
BUSCA_LINEATRES
	ldy VISOR
	tya
	and #%100				;D/L?
	beq J3_BUSCA_LINEATRES
	tya
	and #%10010			;DOWN-LEFT?
	cmp #%10010
	bne J1_BUSCA_LINEATRES
	jsr FONT_CENTRO
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTDOWN
	
J1_BUSCA_LINEATRES
	cmp #%10				;DOWN?
	beq J2_BUSCA_LINEATRES
L3MD jsr FONT_MEDIODOWN
	jsr FONT_MEDIODOWN
	jmp BUSCA_RIGHTDOWN
	
J2_BUSCA_LINEATRES	
L3ML jsr FONT_MEDIOLEFT
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTDOWN
	
J3_BUSCA_LINEATRES
	tya
	and #%10010			;DOWN-LEFT?
	cmp #%10010
	bne J5_BUSCA_LINEATRES
	lda #25
	jsr PLANTILLA_CUADRA
	jsr FONT_CENTRO
	jmp BUSCA_RIGHTDOWN
	
J5_BUSCA_LINEATRES
	cmp #%10
	beq L3ML
	cmp #%10000
	beq L3MD
	lda #17
	jsr PLANTILLA_CUADRA
	jsr FONT_MEDIODOWN
	
BUSCA_RIGHTDOWN
	ldy VISOR
	tya
	and #%1				;DOWN/RIGHT?
	beq J3_BUSCA_RIGHTDOWN
	tya
	and #%1010			;DOWN - RIGHT?
	cmp #%1010
	bne J1_BUSCA_RIGHTDOWN
	jsr FONT_CENTRO
	rts
	
J1_BUSCA_RIGHTDOWN
	cmp #%10				;DOWN?
	beq J2_BUSCA_RIGHTDOWN
DRMD jsr FONT_MEDIODOWN
	rts
	
J2_BUSCA_RIGHTDOWN
DRMR	jsr FONT_MEDIORIGHT
	rts
	
J3_BUSCA_RIGHTDOWN
	tya
	and #%1010			;DOWN - RIGHT?
	cmp #%1010
	bne J5_BUSCA_RIGHTDOWN
	lda #24
	jsr PLANTILLA_CUADRA
	rts
	
J5_BUSCA_RIGHTDOWN
	cmp #%10
	beq DRMR
	cmp #%1000
	beq DRMD
	lda #16
	jsr PLANTILLA_CUADRA
	rts
	


;*** ***
EXAMINA
	ldy TEMPY
	lda (PUNTFUE),y
	cmp #PIS
	beq J_EXAMINA
	cmp #ENE
	beq J_EXAMINA
	cmp #CHE
	beq J_EXAMINA
	cmp #SPE
	beq J_EXAMINA
	cmp #LUC
	;beq J_EXAMINA
	;cmp #ROC
J_EXAMINA
	rts


;*** ***
FONT_MEDIOUP
	lda #18
	jmp PLANTILLA_CUADRA
	
FONT_MEDIOLEFT
	lda #21
	jmp PLANTILLA_CUADRA
	
FONT_MEDIORIGHT
	lda #19
	jmp PLANTILLA_CUADRA
	
FONT_MEDIODOWN
	lda #20
	jmp PLANTILLA_CUADRA

FONT_CENTRO
	lda #26
	
PLANTILLA_CUADRA
	clc
	adc #128
	sta CUADRA,x
	inx
	rts


;*** Dibuja un objeto
PON_CARACTERES
	lda ROWCRS
	sta TEMP2
		
	ldx #2
C1_PON_CARACTERES
	
	ldy #2
C2_PON_CARACTERES
NN	lda (PUNTOBJ),Y		;Lee caracter
	sta (PUNTDES),Y		;Escribe caracter
	dey
	bpl C2_PON_CARACTERES

	dex
	bmi J_PON_CARACTERES
	jsr SUMAFUENTE
	jmp C1_PON_CARACTERES
	
J_PON_CARACTERES
	lda TEMP2
	sta ROWCRS
	rts


;*** Ajusta Nueva linea de Objeto
SUMAFUENTE
	clc
	lda PUNTOBJ
	adc #3
	sta PUNTOBJ
	
	lda PUNTOBJ+1
	adc #0
	sta PUNTOBJ+1

SUMAANCHO
	inc ROWCRS
	jsr PON_PUNTTABLADL
	rts

;*** Ajusta posicion de Siguiente Objeto 
SUMADESTINO
	clc
	lda PUNTDES
	adc #3
	sta PUNTDES
	
	lda PUNTDES+1
	adc #0
	sta PUNTDES+1
	
	inc POSX
	inc POSX
	inc POSX		;Linea Memoria
	rts

;*** Ajusta Nueva linea de MAPA
SUMAOBJETO
	clc
	lda TEMP1
	adc #$9E
	sta PUNTDES
	
	lda TEMP1+1
	adc #$01
	sta PUNTDES+1
	rts

;*** Ajusta Nueva linea de AREA
PON_PUNTTABLADL
	lda ROWCRS		;Linea Memoria
	cmp #128
	bcc J1_PON_PUNTTABLADL
	
	clc
	lda #(>TABLADL+1)
		
	sta CM1+2
	sta CM2+2
			
J1_PON_PUNTTABLADL
	lda ROWCRS		;Linea Memoria
	asl				;* 2
	tay				;Linea Mapa
		
	clc
CM1	lda TABLADL,Y
	adc COLCRS
	sta PUNTDES		;Mapa XY Lo		
	iny
CM2	lda TABLADL,Y
	adc #0
	sta PUNTDES+1	;Mapa XY Hi
	
	lda #>TABLADL
	sta CM1+2
	sta CM2+2
	rts
