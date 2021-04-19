#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

i equ 0x30
j equ 0x31
k equ 0x32
c equ 0x33

START
    BANKSEL PORTA 
    CLRF PORTA 
    BANKSEL ANSEL 
    CLRF ANSEL 
    CLRF ANSELH
    BANKSEL TRISA 
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS, RP1
    BCF STATUS, RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    
inicio:
    MOVLW d'20'		;inicio del display de la letra E
    MOVWF c
    letraE:
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'10000000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'01000000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'00100000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00100100'
    MOVWF PORTB
    MOVLW b'00110000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00100100'
    MOVWF PORTB
    MOVLW b'00001000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00100100'
    MOVWF PORTB
    MOVLW b'00000100'
    MOVWF PORTD
    call tiempo
    MOVLW b'00111100'
    MOVWF PORTB
    MOVLW b'00000110'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111111'
    MOVWF PORTB
    MOVLW b'00000001'
    MOVWF PORTD
    ;call tiempo    
    DECFSZ c,1		;contador de veces que se desplegará la letra
    goto letraE
    
    MOVLW d'20'		;inicio de desplay de letra M
    MOVWF c
    letraM:
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'10000000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'01000000'
    MOVWF PORTD
    call tiempo    
    MOVLW b'10111111'
    MOVWF PORTB
    MOVLW b'01101000'
    MOVWF PORTD
    call tiempo    
    MOVLW b'11011111'
    MOVWF PORTB
    MOVLW b'00010000'
    MOVWF PORTD
    call tiempo
    MOVLW b'10111111'
    MOVWF PORTB
    MOVLW b'00001000'
    MOVWF PORTD
    call tiempo    
    MOVLW b'10111111'
    MOVWF PORTB
    MOVLW b'00000100'
    MOVWF PORTD
    call tiempo    
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'00000110'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111111'
    MOVWF PORTB
    MOVLW b'00001001'
    MOVWF PORTD
    ;call tiempo
    DECFSZ c,1		;contador de veces que se desplegará la letra
    goto letraM
    
    MOVLW d'20'		;inicio del display de la letra L
    MOVWF c
    letraL:
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'10000000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'01000000'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000000'
    MOVWF PORTB
    MOVLW b'00100000'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111100'
    MOVWF PORTB
    MOVLW b'00110000'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111100'
    MOVWF PORTB
    MOVLW b'00001000'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111100'
    MOVWF PORTB
    MOVLW b'00000100'
    MOVWF PORTD
    call tiempo
    MOVLW b'11111100'
    MOVWF PORTB
    MOVLW b'00000010'
    MOVWF PORTD
    call tiempo
    MOVLW b'00000011'
    MOVWF PORTB
    MOVLW b'00000010'
    MOVWF PORTD
    ;call tiempo
    DECFSZ c,1		;contador de veces que se desplegará la letra
    goto letraL    
    
    goto inicio		;regresa al inicio del programa, para repetirlo
    
tiempo:			;subrutina de tiempo, que cuenta 6.78ms
    nop			;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    movlw d'1'		;establecer valor de la variable i
    movwf i
iloop:
    nop		;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    nop
    movlw d'36'	;establecer valor de la variable j
    movwf j
jloop:	
    nop		;NOPs de relleno (ajuste de tiempo)
    movlw d'61'	;establecer valor de la variable k
    movwf k
kloop:	
    decfsz k,f  
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop
    return			;salir de la rutina de tiempo y regresar al valor de contador de programa    		
	
 END