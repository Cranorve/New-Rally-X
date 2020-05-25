;*** LABELS DEL PROGRAMA
;Distribucion de memoria
;Areas , constantes y registros

;Distribucion de memoria
INICIO 	= $0400	;15360	- Rutinas
TABLADL	= $3E00	;384	- Valores precalculados para DL 
AREA 	= $4000	;24080	- Pantalla de Juego
MEMLOAD	= $7000	;2048	- Carga datos extras

VENTANA = $9E10	;1145	- Panel de info
SETAREA = $A000	;1024	- Font de objetos
SETVENT = $A400 ;768	- Font especial de Panel
SETATARI= $A700	;256	- Font namco
SETNRX 	= $A800	;512	- Font New Rally X

MAPA  	= $AA00	;1792	- Mapa Texto
MUSICA 	= $B100	;1792	- Musica

MEMOGR1	= $B800	;256	- Pantalla de textos
PLAYMISS= $B800	;2048	- Player/Missiles
BANCO 	= $C000	;4096	- Memoria bajo ROM

MAPA1	= BANCO	;896	- Mapas comprimidos
MAPA2	= MAPA1+$E0
MAPA3	= MAPA2+$E0
MAPA4	= MAPA3+$E0
;EXTRA 	= $C400

;Constantes

PIS 	= 32
CUA 	= 35
MYC 	= 77
ENE 	= 69
CHE 	= 67
SPE 	= 83
LUC 	= 76
ROC 	= 82
HUM 	= 72

CP = 28
SP = 34
LP = 37
RK = 42+128
EN = 69

COLUMNAS = 44
LINEAS = 28
OBJHOR = 46			;32 + 14
OBJVER = 57			;56 + 1
ANCAREA = OBJHOR*3	;caracteres 138
ALTAREA = OBJVER*3	;caracteres 171

ANCVENT = 21
ALTVENT = 6
MODAREA = 4
MODVENT = 6

NORTE = 14
SUR = 13
OESTE = 11
ESTE = 7
FNV = 0
FEH = 1
FSV = 2
FOH = 3
GNV = 4
GEH = 5
GSV =6
GOH =7

GRUESO = 4

UU = $10
UR = $20
RR = $30
RD = $40
DD = $50
DL = $60
LL = $70
LU = $80


POSENE_1 = MAPA+$68F 
POSENE_2 = POSENE_1-2
POSENE_3 = POSENE_1+2
POSENE_4 = POSENE_1-4
POSENE_5 = POSENE_1+4
POSENE_6 = MAPA+$2F
POSENE_7 = POSENE_6+2

BOTON = 1

;***	PAGINA CERO
	ORG $20
ONOFFPUNTO .DS 1
TEMPLINPUNT .DS 1
DIRENE .DS 1
POSCENE .DS 1
POSRENE .DS 1
COLENE .DS 1
ROWENE .DS 1

;***	PAGINA CERO PROGRAMA
	ORG $80
	
;***	GENERALES
CTRCPOINT .DS 1
CTRSPOINT .DS 1
POSSPOINT .DS 1
CTRLPOINT .DS 1
CTRROUND .DS 1
CTRHISCORE .DS 1
CONCPOINT .DS 1		;Contador de Banderas
CONVIDAS .DS 1
CONTENE .DS 1		;Contador de enemigos
MULCPOINT .DS 1

TEMPA .DS 1
TEMPX .DS 1
TEMPY .DS 1
TEMP0 .DS 2
TEMP1 .DS 2
TEMP2 .DS 2
TEMP3 .DS 2
PUNTFUE .DS 2		;Fuente
PUNTDES .DS 2		;Destino
PUNTOBJ .DS 2
PTABLADL .DS 2

;***	SROLL
COLCTR .DS 1
COLCON .DS 1
COLRADAR .DS 1
ROWCTR .DS 1
ROWCON .DS 1
LINRADAR .DS 2

;***	ANIMACION
ESTADO .DS 1
DIRMAPA .DS 1
DIRAUTO .DS 1
AUTOXY .DS 2		;168*LINMAP+COLMAP*3
CTRCOLRADAR .DS 1
CTRLINRADAR .DS 1
CTRANIM .DS 1
POSCAR .DS 2
TIPOBJ .DS 1
CTRSMOK .DS 2		;Control de Smok
CLRSMOK .DS 2
VELOCIDAD .DS 1
CLOCK .DS 2

;***	REGVENTANA
UNIDAD .DS 3		;
PUNTAJE .DS 6
PUNTHI .DS 6
PMBARRA .DS 1
CTRBARRA .DS 1
CONTZONA .DS 1
CONTCZONA .DS 1
CONTLZONA .DS 1

;*** REGMUSICA
TRACK1 .DS 2
TRACK2 .DS 2
TRACK3 .DS 2
TRACK4 .DS 2

PUNTRACK1 .DS 2
PUNTRACK2 .DS 2
PUNTRACK3 .DS 2
PUNTRACK4 .DS 2

NOTATIM .DS 1		;Tiempo de nota
NOTACNT .DS 2		;Contador de notas
NOTTIMT .DS 1		;Tiempo de nota temporal
NOTATEM .DS 1		;Contador de nota temporal

;*** REGPM
BCOLOR0 .DS 1
BCOLOR1 .DS 1
BCOLOR2 .DS 1
BCOLOR3 .DS 1
YLOC0 .DS 2 		
YLOC1 .DS 2
YLOC2 .DS 2
YLOC3 .DS 2
YLOCB .DS 2

;*** REGDLI
REGA .DS 1
REGX .DS 1
REGY .DS 1

;***COLORES
	ORG = $F1
COLORAREA
	.DS 5

COLORVENT
	.BYTE $0F,$1C,$34,$C6,$00	;Blanco, Amarillo, Rojo, Verde, Negro
	
COLORPM
	.BYTE $74,$00,$0E,$00,$00	;P/M : azul, negro, blanco, negro, negro
	