#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program

i equ 0x30
j equ 0x31
k equ 0x32

;Inicio de Programa 
START

    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0
    BCF PORTB, 0
    BCF PORTB, 1
    BCF PORTB, 2
    BCF PORTB, 3
    BCF PORTB, 4
    BCF PORTB, 5 ;0,3 = Verde   -   1,4 = Amarillo   -   2,5 = Rojo
 
inicio:
    BSF PORTB, 0
    BSF PORTB, 5
    BCF PORTB, 4
    BCF PORTB, 2
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop; 5 Segundos
    BCF PORTB, 0
    BSF PORTB, 1
    call tiempo
    call tiempo
    nop
    nop
    nop
    nop
    nop
    nop
    nop    
    nop; 1 Segundo
    BCF PORTB, 1
    BSF PORTB, 2
    BCF PORTB, 5
    BSF PORTB, 3
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    call tiempo
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop; 5 Segundos
    BCF PORTB, 3
    BSF PORTB, 4
    call tiempo
    call tiempo
    nop
    nop
    nop
    nop
    nop
    nop    
    goto inicio; 1 Segundo

;rutina de tiempo
tiempo:                              
    nop 
    nop
    nop
    nop
    movlw d'54' ;establecer valor de la variable i
    movwf i
iloop:                
    nop
    nop   
    nop
    nop
    nop
    movlw d'50' ;establecer valor de la variable j
    movwf j
jloop:	 
    nop    
    movlw d'60' ;establecer valor de la variable k
    movwf k
kloop:	
    decfsz k,f  
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop    
    return	;salir de la rutina de tiempo y regresar al 
		;valor de contador de programa
END