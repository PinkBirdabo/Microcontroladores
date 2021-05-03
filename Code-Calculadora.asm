#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG         _CONFIG1,       _LVP_OFF & _FCMEN_OFF & _IESO_OFF & _BOR_ON & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _INTOSCIO 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
  
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
  
  GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

i equ 0x30
j equ 0x31
noup equ 0x32
nodwn equ 0x33
nores equ 0x34
btn equ 0x35
aux equ 0x36

START

INITIALIZATION
                      
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'11111111'
    MOVWF TRISA		;configuración de PORT A como input
    MOVLW b'11111111'
    MOVWF TRISB		;configuración de PORT B como input
    MOVLW b'00000001'
    MOVWF TRISE		;configuración de PORT E como input    
    CLRF TRISC
    CLRF TRISD		;configuración de puertos restantes como output (para pantalla LCD)
    BCF STATUS, RP0    
    
    BCF PORTC,1
    BCF PORTC,0

INITLCD
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
        
INICIO                      
    MOVFW PORTA		;inicializacion de variables de entrada
    MOVWF noup
    MOVFW PORTB
    MOVWF nodwn    
        
    ;-------------------------------Display LCD---------------------------------
    ;;;;;;;;;;;;;;;;;;;;;;;;;LINEA 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time    
    
    BTFSS PORTE,0		;message1
    CALL sumaDis
    BTFSC PORTE,0
    CALL restaDis
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x88		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    BTFSS noup,7	;continuacion message1
    MOVLW b'00110000'
    BTFSC noup,7
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS noup,6
    MOVLW b'00110000'
    BTFSC noup,6    
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec        
    BTFSS noup,5
    MOVLW b'00110000'
    BTFSC noup,5
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS noup,4
    MOVLW b'00110000'
    BTFSC noup,4
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS noup,3
    MOVLW b'00110000'
    BTFSC noup,3
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS noup,2
    MOVLW b'00110000'
    BTFSC noup,2
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec  
    BTFSS noup,1
    MOVLW b'00110000'
    BTFSC noup,1
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS noup,0
    MOVLW b'00110000'
    BTFSC noup,0
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;LINEA 2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC7		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    BTFSS PORTE,0	;message2
    MOVLW '+'
    BTFSC PORTE,0
    MOVLW '-'        
    MOVWF PORTD
    CALL exec
    
    BTFSS nodwn,7	;message2
    MOVLW b'00110000'
    BTFSC nodwn,7
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nodwn,6
    MOVLW b'00110000'
    BTFSC nodwn,6    
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec        
    BTFSS nodwn,5
    MOVLW b'00110000'
    BTFSC nodwn,5
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS nodwn,4
    MOVLW b'00110000'
    BTFSC nodwn,4
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS nodwn,3
    MOVLW b'00110000'
    BTFSC nodwn,3
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nodwn,2
    MOVLW b'00110000'
    BTFSC nodwn,2
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec  
    BTFSS nodwn,1
    MOVLW b'00110000'
    BTFSC nodwn,1
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nodwn,0
    MOVLW b'00110000'
    BTFSC nodwn,0
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;LINEA 3;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x96		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW '-'		;message3
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;OPERACIONES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    CLRF nores
    CLRF aux
    BCF STATUS,C	;limpia las variables a usar        
    
    BTFSS PORTE,0
    CALL suma		
    BTFSC PORTE,0
    CALL resta		;aquí se eligue si es suma o resta
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;LINEA 4;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xD7		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    BTFSS STATUS,C
    MOVLW ' '
    BTFSC STATUS,C
    MOVLW b'00110001'
    BTFSC aux,0
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    BTFSS nores,7	;message4
    MOVLW b'00110000'
    BTFSC nores,7
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nores,6
    MOVLW b'00110000'
    BTFSC nores,6    
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec        
    BTFSS nores,5
    MOVLW b'00110000'
    BTFSC nores,5
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS nores,4
    MOVLW b'00110000'
    BTFSC nores,4
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS nores,3
    MOVLW b'00110000'
    BTFSC nores,3
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nores,2
    MOVLW b'00110000'
    BTFSC nores,2
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec  
    BTFSS nores,1
    MOVLW b'00110000'
    BTFSC nores,1
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS nores,0
    MOVLW b'00110000'
    BTFSC nores,0
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x81		;LCD position
    MOVWF PORTD
    CALL exec
        
    GOTO INICIO
    
exec
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    RETURN
    
time			;ciclo de tiempo
    CLRF i
    MOVLW d'10'
    MOVWF j
    ciclo    
	MOVLW d'80'
	MOVWF i
	DECFSZ i
	GOTO $-1
	DECFSZ j
	GOTO ciclo
    RETURN 

sumaDis			;impresión de palabra 'SUMA'
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'U'
    MOVWF PORTD
    CALL exec
    MOVLW 'M'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    RETURN
    
restaDis		;impresión de palabra RESTA
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    RETURN
    
suma
    MOVFW nodwn
    ADDWF noup,0
    MOVWF nores
    RETURN
  
resta
    MOVFW nodwn
    BCF STATUS,C
    SUBWF noup,0
    BTFSC STATUS,C
    CALL positiva
    BTFSS STATUS,C
    CALL negativa
    BCF STATUS,C
    RETURN
    
positiva
    MOVFW nodwn
    SUBWF noup,0
    MOVWF nores
    MOVLW b'00000000'
    MOVWF aux
    BSF STATUS,C
    RETURN
    
negativa
    MOVFW noup
    SUBWF nodwn,0
    MOVWF nores   
    MOVLW b'00000001'
    MOVWF aux 
    BCF STATUS,C
    RETURN
    
    END