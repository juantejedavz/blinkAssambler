#include "p16F84A.inc"

; CONFIG __config 0x3FFA
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
	
    list	p=16F84A
    
status	    equ 03
porta	    equ 05
portb	    equ 06
trisa	    equ 05
trisb	    equ	06
	    
;subrutina delay500ms
cuenta1	    equ	20
cuenta2	    equ	21
tiempo1	    equ	d'100'
tiempo2	    equ	d'250'		

	    org 00
	
;settings
bsf	status,5
movlw	b'00000001'	    ;Input bit 0 portA
movwf	trisa
movlw	b'00000000'	    ;Output puerto B 
movwf	trisb
bcf	status,5
clrf	portb
clrf	porta
	    
inicio	    
	btfsc	porta,0			;skip if bit0 in portA is 0
	call encenderLEDS
	btfss	porta,0			;skip if bit0 in portA is 1   
	call encenderconDelay	  
	goto inicio
	
encenderLEDS
	    movlw   B'11111111'
	    movwf   portb
	    return
	    
encenderconDelay
	    movlw   B'01010101'
	    movwf   portb
	    call    delay
	    call    apagarLEDS
	    call    delay
	    return
	    
apagarLEDS
	   clrf portb
	   return
	   
delay
		movlw    tiempo1
		movwf    cuenta1
    outer	movlw    tiempo2
		movwf    cuenta2
    inner	nop
		nop
		decfsz	 cuenta2,1
		goto	 inner
		decfsz	 cuenta1,1
		goto	 outer
		return

end