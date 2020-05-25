; Player missile del Port "Nuevo Rally X"
; José I. Vila Muñoz
	
INI_PMG	
	clc
	lda #>PLAYMISS
	adc #2
	sta YLOC0+1
	sta YLOC1+1
	tax
	inx
	stx YLOC2+1
	stx YLOC3+1
	
	tax
	dex
	stx LINRADAR+1
					
	lda #$F1				;Pos. Vertical inicial punto en radar
	sta LINRADAR
		
	ldy #0
	lda #1				;Punto Autito en Radar player0
	sta (LINRADAR),Y
		
	lda #$33	
	sta YLOC2				;Posicion V. cabina		
	
	lda #$31	
	sta YLOC0				;CHASSIS P0
	lda #$B1			
	sta YLOC1				;RUEDAS  P1
	
	ldy #$3
INSERT2
	lda CABINA,Y			;Cabina P2
	sta (YLOC2),Y
	dey
	bpl INSERT2
	
;CREA RADAR		
	lda #$E3			
	sta YLOC3				;Posicion H. radar

	ldy #15
	lda #112
INSERT4
	sta (YLOC3),Y			;Radar P3					
	dey
	bpl INSERT4
		
	lda #3			
	sta SIZEP3
	
COLOR_AUTOS
	ldx #3
C1_PM
	lda COLORAUTO,X
	sta COLORPM,X
	dex
	bpl C1_PM
	rts


;*****		LIMPIA AREA DE P/M
CLR_PMG	
	lda #(>PLAYMISS+1)
	sta YLOC0+1
	
	lda #0 				
	sta GRACTL 			;Desactiva P/M
	
	sta SIZEM
	sta SIZEP0
	sta SIZEP1
	sta SIZEP2
	sta SIZEP3
	
	sta HPOSP0
	sta HPOSP1
	sta HPOSP2
	sta HPOSP3
	sta HPOSM0
	sta HPOSM1
	sta HPOSM2
	sta HPOSM3
CLR2_PMG	
	sta YLOC0
	
	tay
PMX	ldx #7
C_CLRPMG
	sta (YLOC0),Y 			
	iny 					
	bne C_CLRPMG 			
	dex
	beq J_CLRPMG
	inc YLOC0+1 			;otra pagina
	jmp C_CLRPMG
J_CLRPMG				
	rts
	

CABINA 		.BYTE 48,120,120,48

CHANORTE		.BYTE 24,24,24,36,102,36,60,36
RUENORTE 		.BYTE 0,102,102,0,0,195,195,219

CHAESTE		.BYTE 0,16,248,71,71,248,16,0
RUEESTE		.BYTE 224,230,6,128,128,6,230,224

CHASUR		.BYTE 36,60,36,102,36,24,24,24
RUESUR		.BYTE 219,195,195,0,0,102,102,0

CHAOESTE		.BYTE 0,8,31,226,226,31,8,0
RUEOESTE		.BYTE 7,103,96,1,1,96,103,7

DIAG1A 		.BYTE 3,3,126,196,76,120,240,0
DIAG1B 		.BYTE 12,236,128,3,131,128,8,120
DIAG2A 		.BYTE 0,240,120,76,196,126,3,3
DIAG2B 		.BYTE 120,8,128,131,3,128,236,12
DIAG3A 		.BYTE 0,15,30,50,35,126,192,192
DIAG3B 		.BYTE 30,16,1,193,192,1,55,48
DIAG4A 		.BYTE 192,192,126,35,50,30,15,0
DIAG4B 		.BYTE 48,55,1,192,193,1,16,30

FUELP1		.BYTE 244,132,228,132,131		
FUELP2		.BYTE 189,161,185,161,189
FUELM12		.BYTE 0,0,0,0,56

COLORAUTO	.BYTE $74,$00,$0E,$00
