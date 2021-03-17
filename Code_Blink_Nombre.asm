#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000	; processor reset vector
    GOTO START		; go to beginning of program
 
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE		; let linker place main program

;variables
i equ 0x30
j equ 0x31
k equ 0x32

;INICIO DE PROGRAMA
START

    MOVLW 0x07
    MOVWF CMCON
    
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0

inicio: 
    bcf PORTB,0     ;poner el puerto B0 (bit 0 del puerto B) en 0
    call tiempoA
    bsf PORTB,0     ;poner el puerto B0 (bit 0 del puerto B) en 1
    call tiempoB
    goto inicio     ;regresa al inicio, para repetir

;LOOP DE NOMBRE
tiempoA: 
    MOVLW d'174'
    MOVWF i
    DECFSZ i
    goto $-1
    MOVLW d'36'
    MOVWF i
loopi: 
    MOVLW d'51'
    MOVWF j
loopj: 
    MOVLW d'59'
    MOVWF k
    DECFSZ k
    goto $-1
    DECFSZ j
    goto loopj
    DECFSZ i
    goto loopi
    nop
    nop
    return

;LOOP DE APELLIDO
tiempoB: 
    nop
    nop
    MOVLW d'94'
    MOVWF i
    DECFSZ i
    goto $-1
    MOVLW d'73'
    MOVWF i
loopa: 
    MOVLW d'51'
    MOVWF j
loopb: 
    MOVLW d'58'
    MOVWF k
    DECFSZ k
    goto $-1
    nop
    DECFSZ j
    goto loopb
    DECFSZ i
    goto loopa
    return
END
