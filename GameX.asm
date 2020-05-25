GAME
	jsr PUSH_FIRE
	
	lda #0
	sta ROUND
	sta ROUND+1
	sta CONTROUND
	inc CONTROUND
	sta CONCPOINT
	sta GANANCIA+4
	sta GANANCIA+5
	sta CTRHISCORE
	sta CONTENE
	
	lda #3
	sta CONVIDAS
	
	jsr CREA_AREA
		
	lda #10				;1,5 Seg.
	jsr PAUSA			;Manten pantalla
		
	jsr DISPLAY

MANTEN					;Espera Intro 1ra parte	
	lda NOTACNT
	cmp #88				;Espera que se reproduscan 88 Notas ***
	bne MANTEN				
		
	jsr MUTE
	jsr CLR_VIDA
			
	inc CTRMODO+1
			
OTRA_VEZ
	jsr INI_MELODIA
	jsr PARTIDA

	ldx #0
	stx RTCLOK+1
	inx
	stx RTCLOK+2
	stx VELOCIDAD
	stx CTRBARRA
	stx STATUS

;******
C1_GAME
	jsr PROCESO			;Control, animaciones y logica 
	
	lda CONCPOINT
	cmp #10
	beq FLAG_10			;Round superado!
	
	lda HPOSM0
	and #1
	beq  C1_GAME		;Continua jugando!
	
	jmp QUE_PASO?		;Colision fatal!


;*********		ULTIMA BANDERA
FLAG_10
	ldx #3
	clc
	lda #1
	jsr C2_INC_CPOINT
	jsr CTR_DSCORE
	
	lda #0
	tay
	sta (LINRADAR),Y	;Borra banderra en radar
	
	lda #<T1MIL			;Inicia 1er Track
	sta TRACK1
	lda #>T1MIL
	sta TRACK1+1
			
	lda #<T2MIL			;Inicia 2do Track
	sta TRACK2
	lda #>T2MIL
	sta TRACK2+1
	
	lda #0
	sta NOTACNT
	sta NOTATIM 		;Inicia duracion
	sta VCM+1			;OFF motor
		
	LDA #2
	sta DNM+1	
			
	ldy #<PLAY_MUSICA
	ldx #>PLAY_MUSICA
	lda #7
	jsr SETVBV			;Habilita VBI

C_FLAG_10
	lda NOTACNT
	cmp #32
	bne C_FLAG_10		;Espera fin de melodia
	
	lda #0
	sta VC1+1
	sta VC2+1
	
	jsr BONUS_LPOINT		
	jsr MUTE
	
	lda #0
	sta BHPOS3+1		;Chassis OFF
	sta BHPOS2+1		;Ruedas OFF
	sta BHPOS1+1		;Cabina OFF
	sta BHPOS0+1
	sta CONCPOINT
	sta COLRADAR		;Punto OFF
	sta HPOSM0
	
	lda #50
	jsr PAUSA
		
	lda CONTROUND
	and #3
	eor #3
	bne NOES_CHALLENGE
	
	jsr CHALLENGE
	
	
	jsr INC_ROUND
	jsr CREA_AREA
	jsr INI_AREA
		
ES_CHALLENGE	
	lda NOTACNT			
	cmp #128			;Espera que se reproduscan 128 Notas ***
	bne ES_CHALLENGE
		
	jsr MUTE
	jsr COMENZADO
	
	jmp OTRA_VEZ

NOES_CHALLENGE
	lda CONTROUND
	and #$F
	cmp #4
	bne CHECK_MAPA3

	lda #<MAPA2
	sta FUE+1
	lda #>MAPA2
	sta FUE+2
		
	lda #<ARBOL2MAP
	sta DAM+1
	lda #>ARBOL2MAP
	sta DAM+2
	
	lda #<COLOR2MAP
	sta DCM+1
	lda #>COLOR2MAP
	sta DCM+2
	
	jmp CAMBIA_MAPA
	
CHECK_MAPA3
	cmp #8
	bne CHECK_MAPA4
	
	lda #<MAPA3
	sta FUE+1
	lda #>MAPA3
	sta FUE+2
		
	lda #<ARBOL3MAP
	sta DAM+1
	lda #>ARBOL3MAP
	sta DAM+2
	
	lda #<COLOR3MAP
	sta DCM+1
	lda #>COLOR3MAP
	sta DCM+2
	
	jmp CAMBIA_MAPA

CHECK_MAPA4	
	cmp #12
	bne CHECK_MAPA1
	
	lda #<MAPA4
	sta FUE+1
	lda #>MAPA4
	sta FUE+2
		
	lda #<ARBOL4MAP
	sta DAM+1
	lda #>ARBOL4MAP
	sta DAM+2
	
	lda #<COLOR4MAP
	sta DCM+1
	lda #>COLOR4MAP
	sta DCM+2
	
	jmp CAMBIA_MAPA

CHECK_MAPA1
	cmp #0
	bne MANTEN_MAPA
	
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
	
CAMBIA_MAPA
	jsr MOMENTO
	jsr MUEVE_MAPA
	
	lda #$0
	sta NMIRES			;reset NMI
	sta SDMCTL			;deshabilitab ANTIC
	;sta NMIEN			;deshabilita NMIs
		
	jsr CREA_AREA
	jsr COMENZADO
	jmp J_MANTEN_MAPA
	
	
MANTEN_MAPA
	jsr CREA_AREA
	jsr INI_PMG
	
J_MANTEN_MAPA	
	jsr OTRO_ROUND
	jsr INC_ROUND
	jmp OTRA_VEZ
	
;----------
QUE_PASO?
	lda TIPOBJ
	cmp #RK
	beq TERMINAL?
	
	cmp #EN
	beq TERMINAL?

	sta HITCLR
	jmp C1_GAME
	
T1MIL
	.BYTE $3C,$3C,0,0,$2F,$2F,0,0,$28,$28,0,0,$35,$35,0,0
	.BYTE $2D,$2D,0,0,$2F,$2F,0,0,$1D,$1D,0,0,0,0,0,0
T2MIL
	.BYTE 0,0,$3C,0,0,0,$2F,0,0,0,$28,0,0,0,$35,0
	.BYTE 0,0,$2D,0,0,0,$2F,0,0,0,$1D,0,0,0,0,0

;--------
TERMINAL?
	lda #0
	tay
	sta (LINRADAR),Y

	jsr MUTE
	
	lda #$F1			;Pos. Vertical inicial punto en radar
	sta LINRADAR
	
	lda CONVIDAS
	
	beq GAME_OVER
	
	jsr OTRO_ROUND
	jsr CLR_VIDA
	jmp OTRA_VEZ
	
OTRO_ROUND
	lda #0
	sta CONTCZONA
	sta CONTLZONA
	
	ldy #<SCROLL_SOFT
	ldx #>SCROLL_SOFT
	lda #7
	jsr SETVBV
				
	jsr INI_AREA		;Con vidas
	jsr INI_BARRA
	rts
	
;-----------	
GAME_OVER
	lda #$2E					
	sta YLOC0	
	sta YLOC2
	
	lda #$AE
	sta YLOC1
	sta YLOC3
	
	ldy #16
C1_GOVER
	lda GAMEOVER,Y
	sta (YLOC0),Y
	lda GAMEOVER+17,Y
	sta (YLOC1),Y
	lda GAMEOVER+34,Y
	sta (YLOC2),Y
	lda GAMEOVER+51,Y
	sta (YLOC3),Y
	dey
	bpl C1_GOVER
	
	ldx #3
	lda #$0F
C2_GOVER
	sta COLORPM,X
	dex
	bpl C2_GOVER
	
	lda #136
	sta BHPOS3+1
	
	lda #128
	sta BHPOS2+1
	
	lda #120
	sta BHPOS1+1
	
	lda #112
	sta BHPOS0+1
	
	lda #120		;2 Seg.
	jsr PAUSA
C3_GOVER	
	lda CTRHISCORE
	beq J1_GOVER
	
	jsr RECORD
	
J1_GOVER
	jsr MOMENTO
	rts				;Vuelve a NRX
	