   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  45                     ; 47 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  45                     ; 48 {
  46                     .text:	section	.text,new
  47  0000               f_NonHandledInterrupt:
  51                     ; 52 }
  54  0000 80            	iret
  76                     ; 60 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  76                     ; 61 {
  77                     .text:	section	.text,new
  78  0000               f_TRAP_IRQHandler:
  82                     ; 65 }
  85  0000 80            	iret
 107                     ; 72 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 107                     ; 73 
 107                     ; 74 {
 108                     .text:	section	.text,new
 109  0000               f_TLI_IRQHandler:
 113                     ; 78 }
 116  0000 80            	iret
 138                     ; 85 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 138                     ; 86 {
 139                     .text:	section	.text,new
 140  0000               f_AWU_IRQHandler:
 144                     ; 90 }
 147  0000 80            	iret
 169                     ; 97 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 169                     ; 98 {
 170                     .text:	section	.text,new
 171  0000               f_CLK_IRQHandler:
 175                     ; 102 }
 178  0000 80            	iret
 201                     ; 109 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 201                     ; 110 {
 202                     .text:	section	.text,new
 203  0000               f_EXTI_PORTA_IRQHandler:
 207                     ; 114 }
 210  0000 80            	iret
 233                     ; 121 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 233                     ; 122 {
 234                     .text:	section	.text,new
 235  0000               f_EXTI_PORTB_IRQHandler:
 239                     ; 126 }
 242  0000 80            	iret
 265                     ; 133 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 265                     ; 134 {
 266                     .text:	section	.text,new
 267  0000               f_EXTI_PORTC_IRQHandler:
 271                     ; 138 }
 274  0000 80            	iret
 297                     ; 145 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 297                     ; 146 {
 298                     .text:	section	.text,new
 299  0000               f_EXTI_PORTD_IRQHandler:
 303                     ; 150 }
 306  0000 80            	iret
 329                     ; 157 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 329                     ; 158 {
 330                     .text:	section	.text,new
 331  0000               f_EXTI_PORTE_IRQHandler:
 335                     ; 162 }
 338  0000 80            	iret
 360                     ; 209 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 360                     ; 210 {
 361                     .text:	section	.text,new
 362  0000               f_SPI_IRQHandler:
 366                     ; 214 }
 369  0000 80            	iret
 392                     ; 221 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 392                     ; 222 {
 393                     .text:	section	.text,new
 394  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 398                     ; 226 }
 401  0000 80            	iret
 424                     ; 233 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 424                     ; 234 {
 425                     .text:	section	.text,new
 426  0000               f_TIM1_CAP_COM_IRQHandler:
 430                     ; 238 }
 433  0000 80            	iret
 456                     ; 271  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 456                     ; 272  {
 457                     .text:	section	.text,new
 458  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 462                     ; 276  }
 465  0000 80            	iret
 488                     ; 283  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 488                     ; 284  {
 489                     .text:	section	.text,new
 490  0000               f_TIM2_CAP_COM_IRQHandler:
 494                     ; 288  }
 497  0000 80            	iret
 520                     ; 298  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 520                     ; 299  {
 521                     .text:	section	.text,new
 522  0000               f_TIM3_UPD_OVF_BRK_IRQHandler:
 526                     ; 303  }
 529  0000 80            	iret
 552                     ; 310  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 552                     ; 311  {
 553                     .text:	section	.text,new
 554  0000               f_TIM3_CAP_COM_IRQHandler:
 558                     ; 315  }
 561  0000 80            	iret
 583                     ; 351 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 583                     ; 352 {
 584                     .text:	section	.text,new
 585  0000               f_I2C_IRQHandler:
 589                     ; 356 }
 592  0000 80            	iret
 615                     ; 364  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 615                     ; 365  {
 616                     .text:	section	.text,new
 617  0000               f_UART2_TX_IRQHandler:
 621                     ; 369  }
 624  0000 80            	iret
 650                     ; 376  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 650                     ; 377  {
 651                     .text:	section	.text,new
 652  0000               f_UART2_RX_IRQHandler:
 654  0000 3b0002        	push	c_x+2
 655  0003 be00          	ldw	x,c_x
 656  0005 89            	pushw	x
 657  0006 3b0002        	push	c_y+2
 658  0009 be00          	ldw	x,c_y
 659  000b 89            	pushw	x
 662                     ; 381     		UART2_ClearITPendingBit(UART2_IT_RXNE);
 664  000c ae0255        	ldw	x,#597
 665  000f cd0000        	call	_UART2_ClearITPendingBit
 667                     ; 382 		UART2_SendData8(UART2_ReceiveData8());
 669  0012 cd0000        	call	_UART2_ReceiveData8
 671  0015 cd0000        	call	_UART2_SendData8
 673                     ; 383  }
 676  0018 85            	popw	x
 677  0019 bf00          	ldw	c_y,x
 678  001b 320002        	pop	c_y+2
 679  001e 85            	popw	x
 680  001f bf00          	ldw	c_x,x
 681  0021 320002        	pop	c_x+2
 682  0024 80            	iret
 704                     ; 432  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 704                     ; 433  {
 705                     .text:	section	.text,new
 706  0000               f_ADC1_IRQHandler:
 710                     ; 437  }
 713  0000 80            	iret
 736                     ; 458  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 736                     ; 459  {
 737                     .text:	section	.text,new
 738  0000               f_TIM4_UPD_OVF_IRQHandler:
 742                     ; 463  }
 745  0000 80            	iret
 768                     ; 471 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 768                     ; 472 {
 769                     .text:	section	.text,new
 770  0000               f_EEPROM_EEC_IRQHandler:
 774                     ; 476 }
 777  0000 80            	iret
 789                     	xdef	f_EEPROM_EEC_IRQHandler
 790                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 791                     	xdef	f_ADC1_IRQHandler
 792                     	xdef	f_UART2_TX_IRQHandler
 793                     	xdef	f_UART2_RX_IRQHandler
 794                     	xdef	f_I2C_IRQHandler
 795                     	xdef	f_TIM3_CAP_COM_IRQHandler
 796                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 797                     	xdef	f_TIM2_CAP_COM_IRQHandler
 798                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 799                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 800                     	xdef	f_TIM1_CAP_COM_IRQHandler
 801                     	xdef	f_SPI_IRQHandler
 802                     	xdef	f_EXTI_PORTE_IRQHandler
 803                     	xdef	f_EXTI_PORTD_IRQHandler
 804                     	xdef	f_EXTI_PORTC_IRQHandler
 805                     	xdef	f_EXTI_PORTB_IRQHandler
 806                     	xdef	f_EXTI_PORTA_IRQHandler
 807                     	xdef	f_CLK_IRQHandler
 808                     	xdef	f_AWU_IRQHandler
 809                     	xdef	f_TLI_IRQHandler
 810                     	xdef	f_TRAP_IRQHandler
 811                     	xdef	f_NonHandledInterrupt
 812                     	xref	_UART2_ClearITPendingBit
 813                     	xref	_UART2_SendData8
 814                     	xref	_UART2_ReceiveData8
 815                     	xref.b	c_x
 816                     	xref.b	c_y
 835                     	end
