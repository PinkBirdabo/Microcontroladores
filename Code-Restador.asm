#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program

i EQU 0x20

START
MOVLW 0x07
MOVWF CMCON
 
BCF STATUS, RP1; BCF Bit Clear F
BSF STATUS, RP0
CLRF TRISB
MOVLW b'00000001'; RA0= habilitada en PORTA
MOVWF TRISA
BCF STATUS, RP0
;------------------------------------------------------------------------------
Asignacion:        
    MOVLW b'00000110' ; guarda un 6 decimal en W
    MOVWF PORTB; mueve W a PORTB
    CALL Boton
    CALL Tiempo
    DECFSZ PORTB,F; decrementa 1 a PORTB; si es 0, salta la línea inferior  
    GOTO $-3
    GOTO Asignacion
    
Tiempo: ;FUNCIÓN DE CONTADOR DE 255 A 0
    MOVLW d'255'; guarda un 255 en W
    MOVWF i; guarda a W en casilla "i"
    DECFSZ i; decrementa a "i"   
    GOTO $-1
    RETURN
    
Boton: ;FUNCIÓN QUE COMPRUEBA SI UN BOTÓN ESTÁ PRESIONADO
    BTFSS TRISA,0; comprueba si el botón está activo
    GOTO $-1
    RETURN
    
END
