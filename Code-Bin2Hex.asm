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
no1 equ  0x32
no2 equ 0x33
no equ 0x34

START

INITIALIZATION
                  
;    BANKSEL PORTA ;
;    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'11111111'
    MOVWF TRISA		;configuración de PORT A como input            
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE		;configuración de puertos restantes como output (para pantalla LCD)
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
    ;-------------------------------Display LCD---------------------------------
    ;;;;;;;;;;;;;;;;;;;;;;;;;MENSAJE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW 'B'		;message1
    MOVWF PORTD
    CALL exec
    MOVLW 'i'
    MOVWF PORTD
    CALL exec
    MOVLW 'n'
    MOVWF PORTD
    CALL exec
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    MOVLW 'r'
    MOVWF PORTD
    CALL exec
    MOVLW 'i'
    MOVWF PORTD
    CALL exec
    MOVLW 'o'
    MOVWF PORTD
    CALL exec
    MOVLW b'00111010'
    MOVWF PORTD
    CALL exec
    
    MOVFW PORTA
    ;MOVLW b'10011101'
    MOVWF no		    ;ingresa el número binario para conversión
    
    MOVFW no		        
    ANDLW b'00001111'
    MOVWF no1		    ;guarda los primeros 4 dígitos en una variable copia
    MOVFW no
    ANDLW b'11110000'
    MOVWF no2		    
    SWAPF no2,1		    ;guarda los últimos 4 dígitos en una variable copia
    
    BTFSS no,7
    MOVLW b'00110000'
    BTFSC no,7
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS no,6
    MOVLW b'00110000'
    BTFSC no,6    
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec        
    BTFSS no,5
    MOVLW b'00110000'
    BTFSC no,5
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS no,4
    MOVLW b'00110000'
    BTFSC no,4
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec    
    BTFSS no,3
    MOVLW b'00110000'
    BTFSC no,3
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS no,2
    MOVLW b'00110000'
    BTFSC no,2
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec  
    BTFSS no,1
    MOVLW b'00110000'
    BTFSC no,1
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    BTFSS no,0
    MOVLW b'00110000'
    BTFSC no,0
    MOVLW b'00110001'
    MOVWF PORTD
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;MENSAJE 2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC0		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW 'H'		;message2
    MOVWF PORTD
    CALL exec
    MOVLW 'e'
    MOVWF PORTD
    CALL exec
    MOVLW 'x'
    MOVWF PORTD
    CALL exec
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    MOVLW 'd'
    MOVWF PORTD
    CALL exec
    MOVLW 'e'
    MOVWF PORTD
    CALL exec
    MOVLW 'c'
    MOVWF PORTD
    CALL exec
    MOVLW 'i'
    MOVWF PORTD
    CALL exec
    MOVLW 'm'
    MOVWF PORTD
    CALL exec
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    MOVLW 'l'
    MOVWF PORTD
    CALL exec
    MOVLW b'00111010'
    MOVWF PORTD
    CALL exec
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    MOVLW 'x'
    MOVWF PORTD
    CALL exec              
    
    MOVFW no2		;mueve los últimos 4 dígitos a W.
    ADDLW 0x30		;agrega 0x30 al número en W.
    MOVWF PORTD		;mueve el número en W al PORTD.
    BCF STATUS,C	;pone en ceros al CARRY, para asegurar que esté en 0.
    SUBLW 0x39		;resta 0x39 a W, para comprobar si es negativo.
    BTFSC STATUS,C	
    GOTO $+4
    MOVFW no2
    ADDLW 0x37		;en caso de no ser negativo, indica que el número es 
    MOVWF PORTD		;mayor a 10 y entonces realiza otro set de instrucciones.
    CALL exec		;ejecuta la instrucción para poder imprimir el número en PORTD
    
    MOVFW no1		;estás son las mismas instrucciones que las anteriores,
    ADDLW 0x30		;pero ahora con los primeros 4 dígitos del binario.
    MOVWF PORTD
    BCF STATUS,C
    SUBLW 0x39
    BTFSC STATUS,C
    GOTO $+4
    MOVFW no1
    ADDLW 0x37
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
    
time
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
    
    END