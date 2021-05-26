#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
 
RES_VECT  CODE    0x0000    ; processor reset vector
    GOTO    START                  

INT_VECT  CODE	  0x0004     
    GOTO ISR		    ; el código de la interrupción
    
    ; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      

 i equ 0x30
 j equ 0x31
 k equ 0x32 
 
START
    
    MOVLW b'10010000'	    ; HABILITAR INTERRUPCIÓN EXTERNA
    MOVWF INTCON 
    
    MOVLW 0x07
    MOVWF CMCON		    ; Apagar comparadores
    BCF STATUS, RP1	    ; BCF Bit Clear F
    BSF STATUS, RP0    
    CLRF TRISA		    ; PORTA como output
    MOVLW b'00000001'	    ; RB0 = input
    MOVWF TRISB
    BCF STATUS, RP0
    
    MOVLW 0x00
    MOVWF PORTA
    
inicio:	        
    BCF PORTB,7
    CALL tiempo
    CALL tiempo
    BSF PORTB,7
    CALL tiempo
    CALL tiempo
    GOTO inicio		    ; regresar y repetir
  
tiempo:			    ;rutina de tiempo de ... segundos
    nop 
    nop
    nop
    nop
    movlw d'54'		    ; establecer valor de la variable i
    movwf i
    iloop:                
	nop
	nop   
	nop
	nop
	nop
	movlw d'50'	    ; establecer valor de la variable j
	movwf j
	jloop:	 
	    nop    
	    movlw d'60'	    ; establecer valor de la variable k
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
    
ISR: 
    BCF INTCON, GIE ;Disable all interrupts inside interrupt service routine
        
    INCF PORTA,1
    MOVFW PORTA    
    BCF STATUS,C	;pone en ceros al CARRY, para asegurar que esté en 0.
    SUBLW 0x09		;resta 0x09 a W, para comprobar si es negativo.
    BTFSC STATUS,C	
    GOTO $+3
    MOVLW 0x00
    MOVWF PORTA		;en caso de no ser negativo, indica que el número es
        
    BCF INTCON,INTF ;Clear external interrupt flag bit
    BSF INTCON, GIE ;Enable all interrupts on exit
    RETFIE		
			
    END