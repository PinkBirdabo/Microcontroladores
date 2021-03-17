#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program

i EQU 0x30
j EQU 0x31
k EQU 0x32
x EQU 0x33

;Inicio de Programa 
START

    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000010'
    MOVWF TRISB
    BCF STATUS, RP0
    BCF PORTB,0    
    
inicio:
    call botonOFF
    BTFSS TRISB,1   ;comando que comprueba que el botón NO esté presionado, sino salta la línea inmediata.
    goto $-2
    call botonON
    BTFSC TRISB,1   ;comando que comprueba que el botón SÍ esté presionado, sino salta la línea inmediata.
    goto $-2
    goto inicio	    ;regresa al inicio del programa
    
botonOFF:	    ;CICLO CON BOTÓN APAGADO (250 ms total)
    BCF PORTB,0	    ;poner el puerto B0 (bit 0 del puerto B) en 0
    call tiempoOFF
    BSF PORTB,0	    ;poner el puerto B0 (bit 0 del puerto B) en 1
    call tiempoOFF    
    return   	    ;regresa
            
botonON:	    ;CICLO CON BOTÓN PRENDIDO (1500 ms total)
    BCF PORTB,0	    ;poner el puerto B0 (bit 0 del puerto B) en 0
    call tiempoON
    BSF PORTB,0	    ;poner el puerto B0 (bit 0 del puerto B) en 1
    call tiempoON
    return	    ;regresa

tiempoOFF:	;CICLO DE TIEMPO DE 125 ms	        
    movlw d'7'
    movwf i
    xloop:	
	nop
	nop
	nop
	movlw d'252'
	movwf j
    yloop:
	decfsz j,f  
	goto yloop
	decfsz i,f
	goto xloop
	movlw d'13'	
	movwf i
	iloop:
	    movlw d'50' 
	    movwf j
	jloop:		
	    movlw d'60' 
	    movwf k
	kloop:		
	    decfsz k,f  
	    goto kloop
	    decfsz j,f
	    goto jloop
	    decfsz i,f
	    goto iloop
	    return
	    
tiempoON:	;CICLO DE TIEMPO DE 750 ms
    nop
    nop
    movlw d'35'
    movwf x
    decfsz x,f
    goto $-1
    movlw d'6'
    movwf x       
    call tiempoOFF
    decfsz x,f
    goto $-2
    return
    
    END
