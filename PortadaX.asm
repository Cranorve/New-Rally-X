/***************************************/
/*  Use MADS http://mads.atari8.info/  */
/*  Mode: DLI (char mode)              */
/***************************************/

scr48	= %00111111	;screen 48b
scr40	= %00111110	;screen 40b
scr32	= %00111101	;screen 32b

cloc	= $0014		;(1)
byt2	= $0000		;(1) <$0100
byt3	= $0100		;(1) >$00FF

;-- BASIC switch OFF
 org $4000
 mva #$ff $d301
 rts
 ini $4000

;-- MAIN PROGRAM
 org $4000
 ant	ANTIC_PROGRAM scr,ant

scr	SCREEN_DATA

	ALIGN $0400
fnt	FONTS

	ALIGN $1000
	.ds $0300
pmg	SPRITES

main
;-- init PMG
 mva >pmg $d407	;missiles and players data address
 mva #3 $d01d		;enable players and missiles

 ift .def CHANGES		;if label CHANGES defined
 jsr save_color		;then save all COLPFs and set value 0 for all COLPFs
 eif

 lda:cmp:req 20		;wait 1 frame

 sei				;stop interrups
 mva #0 $d40e		;stop all interrupts
 mva #$fe $d301		;switch off ROM to get 16k more ram

 mwa #nmi $fffa		;new NMI handler

 mva #$c0 $d40e		;switch on NMI+DLI again

 ift .def CHANGES		;if label CHANGES defined
 jsr fade_in			;fade in COLPFs
 jmp jjjj
BUTTON
 lda GRAFP3		;STRIG0
 sta ATRACT
 bne BUTTON		;1 = Abierto

C_BUTTON?
 lda GRAFP3		;STRIG0
 beq C_BUTTON?		;0 = Cerrado
	
 lda RTCLOK+2
C_TIME1
 cmp RTCLOK+2
 beq C_TIME1
jjjj
 jsr fade_out		;fade out COLPFs
 
 lda #24
 clc
 adc RTCLOK+2
 sta WT+1
		
J_TIME2
 lda RTCLOK+2
WT
 cmp #0
 bne J_TIME2
	
 mva #0   $d01d		;PMG disabled
 mva #$ff $d301		;ROM switch on
 mva #$40 $d40e		;only NMI interrupts, DLI disabled
 cli				;IRQ enabled
 
 lda #<INICIO
 sta DOSINI
 lda #>INICIO
 sta DOSINI+1
 jmp INICIO			;($a)		;jump to DOS
 
 els
null jmp dli1			;CPU is busy here, so no more routines allowed
 eif

;-- DLI PROGRAM

 ?old_dli = *

dli1
 lda $d40b
 cmp #2
 bne dli1
 :3 sta $d40a
 DLINEW dli8

dli_start
dli8

 sta $d40a                   ;line=8
 sta $d40a                   ;line=9
 sta $d40a                   ;line=10
c9 lda #$20
 sta $d40a                   ;line=11
 sta COLPF0
 DLINEW dli9

dli9

 sta $d40a                   ;line=24
 sta $d40a                   ;line=25
c10 lda #$22
 sta $d40a                   ;line=26
 sta COLPF0
 DLINEW dli10

dli10

 sta $d40a                   ;line=32
 sta $d40a                   ;line=33
 sta $d40a                   ;line=34
c11 lda #$00
 sta $d40a                   ;line=35
 sta COLPF1
 sta $d40a                   ;line=36
 sta $d40a                   ;line=37
 sta $d40a                   ;line=38
c12 lda #$70
 sta $d40a                   ;line=39
 sta COLPF2
 sta $d40a                   ;line=40
 sta $d40a                   ;line=41
 sta $d40a                   ;line=42
 sta $d40a                   ;line=43
 sta $d40a                   ;line=44
 sta $d40a                   ;line=45
c13 lda #$24
 sta $d40a                   ;line=46
 sta COLPF0
 DLINEW dli11

dli11

c14 lda #$72
 sta $d40a                   ;line=56
 sta COLPF2
 sta $d40a                   ;line=57
 sta $d40a                   ;line=58
 sta $d40a                   ;line=59
 sta $d40a                   ;line=60
 sta $d40a                   ;line=61
 sta $d40a                   ;line=62
c15 lda #$08
 sta $d40a                   ;line=63
 sta COLPF1
 sta $d40a                   ;line=64
 sta $d40a                   ;line=65
c16 lda #$26
 sta $d40a                   ;line=66
 sta COLPF0
 sta $d40a                   ;line=67
 sta $d40a                   ;line=68
 sta $d40a                   ;line=69
 sta $d40a                   ;line=70
c17 lda #$06
 sta $d40a                   ;line=71
 sta COLPF1
 lda >fnt+$400*$01
c18 ldx #$08
 sta $d40a                   ;line=72
 sta chbase
 stx COLPF0
 sta $d40a                   ;line=73
 sta $d40a                   ;line=74
 sta $d40a                   ;line=75
 sta $d40a                   ;line=76
 sta $d40a                   ;line=77
c19 lda #$74
 sta $d40a                   ;line=78
 sta COLPF2
 sta $d40a                   ;line=79
 sta $d40a                   ;line=80
c20 lda #$00
c21 ldx #$08
 sta $d40a                   ;line=81
 sta COLPF0
 stx COLPF1
 sta $d40a                   ;line=82
c22 lda #$20
 sta $d40a                   ;line=83
 sta COLPF2
 DLINEW dli12

dli12

 sta $d40a                   ;line=96
 sta $d40a                   ;line=97
c23 lda #$22
 ldx #$00
 ldy #$7C
 sta $d40a                   ;line=98
 sta COLPF2
 stx sizep1
 sty hposp1
c24 lda #$74
 sta $d40a                   ;line=99
 sta COLPF1
c25 lda #$08
 sta $d40a                   ;line=100
 sta COLPF1
c26 lda #$74
 sta $d40a                   ;line=101
 sta COLPF1
 lda #$03
 ldx #$65
 sta $d40a                   ;line=102
 sta sizep1
 stx hposp1
 sta $d40a                   ;line=103
 sta $d40a                   ;line=104
 lda #$71
 sta $d40a                   ;line=105
 sta hposp1
 DLINEW dli13

dli13

 sta $d40a                   ;line=112
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 sta $d40a                   ;line=115
 sta $d40a                   ;line=116
 sta $d40a                   ;line=117
c27 lda #$80
c28 ldx #$24
 sta $d40a                   ;line=118
 sta COLPF1
 stx COLPF2
 sta $d40a                   ;line=119
c29 lda #$82
 sta $d40a                   ;line=120
 sta COLPF1
 sta $d40a                   ;line=121
c30 lda #$84
 sta $d40a                   ;line=122
 sta COLPF1
 sta $d40a                   ;line=123
c31 lda #$86
 sta $d40a                   ;line=124
 sta COLPF1
 sta $d40a                   ;line=125
c32 lda #$88
 sta $d40a                   ;line=126
 sta COLPF1
 DLINEW dli2


dli2
 lda >fnt+$400*$02
c33 ldx #$8A
 sta $d40a                   ;line=128
 sta chbase
 stx COLPF1
 sta $d40a                   ;line=129
c34 lda #$8C
 sta $d40a                   ;line=130
 sta COLPF1
c35 lda #$74
 sta $d40a                   ;line=131
 sta COLPF1
 DLINEW dli14

dli14

 sta $d40a                   ;line=136
 sta $d40a                   ;line=137
c36 lda #$08
 sta $d40a                   ;line=138
 sta COLPF2
 sta $d40a                   ;line=139
 sta $d40a                   ;line=140
c37 lda #$06
 sta $d40a                   ;line=141
 sta COLPF1
 DLINEW dli15

dli15

c38 lda #$24
 ldx #$00
 ldy #$88
 sta $d40a                   ;line=144
 sta COLPF1
 stx sizep1
 sty hposp1
 sta $d40a                   ;line=145
 sta $d40a                   ;line=146
c39 lda #$74
 sta $d40a                   ;line=147
 sta COLPF2
 DLINEW dli16

dli16

c40 lda #$08
 sta $d40a                   ;line=152
 sta COLPF1
 sta $d40a                   ;line=153
c41 lda #$20
 sta $d40a                   ;line=154
 sta COLPF1
 DLINEW dli17

dli17

 sta $d40a                   ;line=160
c42 lda #$80
 sta $d40a                   ;line=161
 sta COLPF2
 DLINEW dli3

dli3
 lda >fnt+$400*$03
 sta $d40a                   ;line=168
 sta chbase
c43 lda #$22
 sta $d40a                   ;line=169
 sta COLPF1
 DLINEW dli18

dli18

 sta $d40a                   ;line=176
c44 lda #$82
 sta $d40a                   ;line=177
 sta COLPF2
 DLINEW dli19

dli19

 lda #$3C
 ldx #$65
 sta $d40a                   ;line=184
 sta sizem
 stx hposm2
 sta $d40a                   ;line=185
 sta $d40a                   ;line=186
 sta $d40a                   ;line=187
 sta $d40a                   ;line=188
c45 lda #$24
 sta $d40a                   ;line=189
 sta COLPF1
 DLINEW dli20

dli20

 sta $d40a                   ;line=192
 sta $d40a                   ;line=193
 sta $d40a                   ;line=194
 sta $d40a                   ;line=195
 sta $d40a                   ;line=196
c46 lda #$84
 sta $d40a                   ;line=197
 sta COLPF2
 DLINEW dli4

dli4
 lda >fnt+$400*$04
 sta $d40a                   ;line=200
 sta chbase
 DLINEW dli21

dli21

 sta $d40a                   ;line=208
c47 lda #$26
 sta $d40a                   ;line=209
 sta COLPF1
 sta $d40a                   ;line=210
 sta $d40a                   ;line=211
 sta $d40a                   ;line=212
 sta $d40a                   ;line=213
c48 lda #$08
 sta $d40a                   ;line=214
 sta COLPF2
 sta $d40a                   ;line=215
 sta $d40a                   ;line=216
c49 lda #$06
 sta $d40a                   ;line=217
 sta COLPF1
 DLINEW dli22

dli22

 sta $d40a                   ;line=224
 sta $d40a                   ;line=225
 sta $d40a                   ;line=226
 sta $d40a                   ;line=227
 sta $d40a                   ;line=228
c50 lda #$04
 sta $d40a                   ;line=229
 sta COLPF0
 DLINEW dli5

dli5
 lda >fnt+$400*$00
 sta $d40a                   ;line=232
 sta chbase
 jmp NmiQuit

;--

CHANGES

nmi
 sta TEMPA
 stx TEMPX
 sty TEMPY

 bit $d40f
 bpl vbl

dliv jmp dli_start

vbl			;VBL routine
 sta $d40f		;reset NMI flag

 inc cloc		;little timer

 mwa #ant   $d402		;ANTIC address program
 mva #scr40 $d400	;set new screen's width

;-- first line of screen initialization

 lda >fnt+$400*$00
 sta chbase
c0 lda #$0E
 sta colbk
c1 lda #$04
 sta COLPF0
c2 lda #$06
 sta COLPF1
c3 lda #$08
 sta COLPF2
c4 lda #$0E
 sta COLPF3
 lda #$04
 sta prior
 lda #$03
 sta sizep1
 lda #$65
 sta hposp1
c5 lda #$FE
 sta colpm1
 lda #$00
 sta sizep2
 lda #$7D
 sta hposp2
c6 lda #$FE
 sta colpm2
 lda #$00
 sta sizem
 lda #$67
 sta hposm2
 lda #$01
 sta sizep0
 lda #$62
 sta hposp0
c7 lda #$1C
 sta colpm0
 lda #$01
 sta sizep3
 lda #$65
 sta hposp3
c8 lda #$D4
 sta colpm3
 lda #$54
 sta hposm1

 mwa #dli_start dliv+1	;set the first address of DLI interrupt

;this area is for yours routines

NmiQuit
 lda TEMPA
 ldx TEMPX
 ldy TEMPY
 rti

;--
 icl 'PortadaX.fad'
 
 run main

*---

.macro SPRITES
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$30,$30,$30
 dta $30,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $2C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$FD,$FE,$FF,$FF,$FF,$FF,$BB
 dta $BB,$FB,$FB,$FF,$FF,$FF,$7F,$7F,$7F,$FF,$FF,$7F,$7F,$7F,$FF,$FF
 dta $FE,$FE,$FF,$FD,$FD,$78,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18
 dta $18,$C0,$E0,$E0,$E0,$F8,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$FB
 dta $FF,$7F,$7F,$7F,$7F,$7F,$7F,$BF,$FF,$FF,$7F,$7F,$7F,$7F,$3F,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$3F,$7F,$FF,$7F,$7E,$7C,$7C,$70
 dta $E1,$C1,$41,$83,$87,$9F,$BF,$7F,$FF,$7F,$7E,$FC,$F7,$CF,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FE,$FE,$FE,$FE,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $FC,$FC,$FE,$FC,$FF,$FF,$FF,$F7,$F7,$73,$33,$31,$B1,$B9,$B9,$3D
 dta $29,$7F,$6F,$7F,$7F,$7F,$5F,$5F,$DF,$BF,$FB,$FD,$FB,$E9,$EF,$ED
 dta $F4,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F7,$FF,$FF,$FF,$FE,$FF,$FE
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8,$FB,$F0,$FE,$FF,$FF,$C2,$91,$11
 dta $27,$37,$9F,$DF,$FF,$FF,$FF,$FF,$FE,$FC,$BF,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

.endm

.macro DLINEW
 ift .hi(?old_dli)==.hi(:1)
  mva <:1 dliv+1
 els
  mwa #:1 dliv+1
 eif

 jmp NmiQuit

 ?old_dli = *
.endm

.macro ALIGN
 ift (*/:1)*:1<>*
  org (*/:1)*:1+:1
 eif
.endm

.macro ANTIC_PROGRAM
 dta $C4,a(:1),$04,$84,$84,$04,$04,$84,$04,$04,$04,$04,$84,$04,$84,$04,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$04,$84,$84,$04
 dta $41,a(:2)
.endm

.macro SCREEN_DATA
 ins 'portadaX.scr'
.endm

.macro FONTS
 ins 'portadaX.fnt'
.endm


