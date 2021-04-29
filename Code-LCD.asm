#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    

RES_VECT  CODE    0x0000            ; processor reset vector
    
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
  
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i EQU 0x20
j EQU 0x21

START
    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0 
    CLRF TRISB
    CLRF TRISA
    BCF STATUS, RP0
    
    BCF PORTA,1
    BCF PORTA,0
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
        
INICIO	  
   
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'E'		;message1
    MOVWF PORTB
    CALL exec
    MOVLW 'm'
    MOVWF PORTB
    CALL exec
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    MOVLW 'l'
    MOVWF PORTB
    CALL exec
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTA,0	;command mode
    CALL time
    
    MOVLW 0x8A		;LCD position 
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0	;data mode
    CALL time
        
    MOVLW b'00101000'	;smiley face
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'	
    MOVWF PORTB
    CALL exec
    MOVLW b'00101101'	
    MOVWF PORTB
    CALL exec
    MOVLW b'01011110'	
    MOVWF PORTB
    CALL exec
    MOVLW b'00101001'	
    MOVWF PORTB
    CALL exec
    MOVLW b'00101111'	
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC0		;LCD position 
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'		;message2
    MOVWF PORTB
    CALL exec
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    MOVLW 'n'
    MOVWF PORTB
    CALL exec
    MOVLW 'd'
    MOVWF PORTB
    CALL exec
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    MOVLW 'z'
    MOVWF PORTB
    CALL exec
    MOVLW b'11111110'
    MOVWF PORTB
    CALL exec
    MOVLW b'11111110'
    MOVWF PORTB
    CALL exec
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    MOVLW 'a'
    MOVWF PORTB
    CALL exec
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    MOVLW 'i'
    MOVWF PORTB
    CALL exec
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    MOVLW 's'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x81		;LCD position
    MOVWF PORTB
    CALL exec
        
    GOTO INICIO

exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
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