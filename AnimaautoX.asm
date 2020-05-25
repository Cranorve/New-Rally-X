;***		ANIMACION DE AUTITO		;NACHO !!!!
ANIMA_AUTO
	lda ESTADO
	and #$F0
	cmp DIRAUTO
	bne SIanimaAUTO
	lda #0
	sta CTRANIM
	rts

SIanimaAUTO
	;sta HITCLR
	lda CTRANIM
	bne Ncuadros
	
	jsr giraAUTO
	sta DIRAUTO
	
	lda #6			;Cuadros por Pausa
	sta CTRANIM

Ncuadros
	dec CTRANIM
	rts

giraAUTO
	lda ESTADO
	and #3
	cmp #FNV			;Actual es 
	beq GIRAUP
	jmp noNORTE

GIRAUP				;NORTE
	lda DIRAUTO		;Va hacia el SUR?
	cmp #DD
	bne noestaDOWN
	lda RANDOM
	bpl JUD
	jmp GIRO6 		; DIAGONAL ABAJO-IZQUIRDA
JUD	
	jmp GIRO4 		; DIAGONAL ABAJO-DERECHA
	
noestaDOWN	
	cmp #DL
	bne noDLUP
	jmp GIRO7 		; IZQUIERDA
	
noDLUP
	cmp #LL
	bne noLLUP
	jmp GIRO8 		; DIAGONAL ARRIBA-IZQUIERDA
	
noLLUP
	cmp #RD
	bne noRDUP
	jmp GIRO3 		; DERECHA;********
	
noRDUP
	cmp #RR
	bne ALNORTE
	jmp GIRO2 		; DIAGONAL ARRIBA-DERECHA
	
ALNORTE
	jmp GIRO1 		; ARRIBA
	

noNORTE				;SUR
	cmp #FSV			
	beq GIRADOWN
	jmp noSUR

GIRADOWN
	lda DIRAUTO		;Va hacia el Norte
	cmp #UU
	bne noestaUP
	lda RANDOM
	bpl JDU
	jmp GIRO8 		; DIAGONAL ARRIBA-IZQUIERDA
JDU
	jmp GIRO2 		; DIAGONAL ARRIBA-DERECHA
	 
noestaUP
	cmp #UR
	bne noURDOWN
	jmp GIRO3 		; DERECHA;********
	
noURDOWN
	cmp #RR
	bne noRRDOWN
	jmp GIRO4 		; DIAGONAL ABAJO-DERECHA
	
noRRDOWN
	cmp #LU
	bne noLLDOWN
	jmp GIRO7 		; IZQUIERDA
	
noLLDOWN
	cmp #LL
	bne ALSUR
	jmp GIRO6 		; DIAGONAL ABAJO-IZQUIRDA

ALSUR
	jmp GIRO5 		; ABAJO;******

noSUR
	cmp #FEH
	beq GIRARIGHT
	jmp noESTE

GIRARIGHT
	lda DIRAUTO		;ESTE
	cmp #LL
	bne noestaLEFT
	lda RANDOM
	bpl JRL
	jmp GIRO8 		; DIAGONAL ARRIBA-IZQUIERDA
JRL
	jmp GIRO6 		; DIAGONAL ABAJO-IZQUIRDA
	
noestaLEFT
	cmp #LU
	bne noURRIGHT
	jmp GIRO1		;ARRIBA
	
noURRIGHT
	cmp #UU
	bne noUURIGHT
	jmp GIRO2 		; DIAGONAL ARRIBA-DERECHA
	
noUURIGHT
	cmp #DL
	bne noLURIGHT
	jmp GIRO5 		; ABAJO;******
	
noLURIGHT
	cmp #DD
	bne ALESTE
	jmp GIRO4		; DIAGONAL ABAJO-DERECHA
	
ALESTE
	jmp GIRO3 		; DERECHA;********
	
noESTE	
	lda DIRAUTO			;MOVER A IZQUIERDA
	cmp #RR
	bne noestaRIGHT
	lda RANDOM
	bpl JUR
	jmp GIRO2 		; DIAGONAL ARRIBA-DERECHA
JUR	
	jmp GIRO4		; DIAGONAL ABAJO-DERECHA
	
noestaRIGHT
	cmp #UR
	bne noURLEFT
	jmp GIRO1		;ARRIBA
	
	
noURLEFT
	cmp #UU
	bne noUULEFT
	jmp GIRO8 		; DIAGONAL ARRIBA-IZQUIERDA

noUULEFT
	cmp #RD
	bne noDDLEFT
	jmp GIRO5 		; ABAJO;******
	
noDDLEFT
	cmp #DD
	bne ALOESTE
	jmp GIRO6 		; DIAGONAL ABAJO-IZQUIRDA

ALOESTE
	jmp GIRO7 		; IZQUIERDA


GIRO1 ; ARRIBA;******
	ldy #7
C_GIRO1
	lda CHANORTE,Y
	sta (YLOC0),Y
	lda RUENORTE,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO1
	lda #UU
	rts

GIRO2 ; DIAGONAL ARRIBA-DERECHA
	ldy #7
C_GIRO2
	lda DIAG1A,Y
	sta (YLOC0),Y
	lda DIAG1B,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO2
	lda #UR
	rts

GIRO3 ; DERECHA;********
	ldy #7
C_GIRO3
	lda CHAESTE,Y
	sta (YLOC0),Y
	lda RUEESTE,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO3
	lda #RR
	rts

GIRO4 ; DIAGONAL ABAJO-DERECHA
	ldy #7
C_GIRO4
	lda DIAG2A,Y
	sta (YLOC0),Y
	lda DIAG2B,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO4
	lda #RD
	rts

GIRO5 ; ABAJO;******
	ldy #7
C_GIRO5
	lda CHASUR,Y
	sta (YLOC0),Y
	lda RUESUR,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO5
	lda #DD
	rts

GIRO6 ; DIAGONAL ABAJO-IZQUIRDA
	ldy #7
C_GIRO6
	lda DIAG3A,Y
	sta (YLOC0),Y
	lda DIAG3B,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO6
	lda #DL
	rts

GIRO7 ; IZQUIERDA;********
	ldy #7
C_GIRO7
	lda CHAOESTE,Y
	sta (YLOC0),Y
	lda RUEOESTE,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO7
	lda #LL
	rts

GIRO8 ; DIAGONAL ARRIBA-IZQUIERDA
	ldy #7
C_GIRO8
	lda DIAG4A,Y
	sta (YLOC0),Y
	lda DIAG4B,Y
	sta (YLOC1),Y
	dey
	bpl C_GIRO8
	lda #LU
	rts
	