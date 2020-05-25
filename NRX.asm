;	********************************
;	*	NEW RALLY X - ATARI XL/XE  *
;	*	     ATARIWARE.CL	       *
;	*		  2005-2008		       *
;	********************************
; 	por NRXteam
;	25.07.2008 - version en desarrollo
;	25.05.2020 - version de prueba en emuladores Altirra y Atari800

	opt l-
	icl 'Sysequ.asm'
	icl 'SysequX.asm'
	opt l+
	icl 'InicioX.asm'			;Inicio y Display List Interrupt principal
	icl 'MododemoX.asm'		    ;Modo game demo
	icl 'GameX.asm'			    ;Modo play, Inicio de etapas
	icl 'ProcesoX.asm'			;Etapa UNO
	icl 'AnimaautoX.asm'		;Animacion auto azul
	icl 'ControlX.asm'			;Etapa DOS
	;icl 'AnimaenemigosX.asm'	;Animacion autos rojos
		
	icl 'CastingX.asm'			;Pantallas de textos
	icl 'PushfireX.asm'
	icl 'ChallengingX.asm'
	icl 'RecordX.asm'
	
	icl 'ComunestextX.asm'		;Rutinas recurrentes en pantallas de textos	
	icl 'ComunesgameX.asm'	    ;Rutinas recurrentes en grafica de juego
	icl 'SetareaX.asm'			;Dibuja area de juego y radar
	icl 'PmggameX.asm'		    ;Players y Missiles	
	icl 'VbiX.asm'			    ;Scrolling y control de sonidos				
		
	icl 'DatasX.asm'			;Mozaicos de objetos, colores y Tabla DL
	icl 'DatagrafX.asm'		    ;$9E10 - 1145 Bytes	Ventana y Display List's
	icl 'FontX.asm'			    ;$A000 - 2560 Bytes	Set de caracteres, area, ventana, textos y namco
	icl 'MusicaX.asm'			;$B100 - 1792 Bytes	Data tema principal
	
	;icl 'PortadaX.asm'		    ;$6800 Archivo graph2font 
	icl 'MapasX.asm'			;$7000 - 896 Bytes	Datos comprimidos
				
	ini INICIO
	