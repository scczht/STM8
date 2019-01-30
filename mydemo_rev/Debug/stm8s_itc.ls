   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 44 uint8_t ITC_GetCPUCC(void)
  44                     ; 45 {
  46                     .text:	section	.text,new
  47  0000               _ITC_GetCPUCC:
  51                     ; 47   _asm("push cc");
  54  0000 8a            push cc
  56                     ; 48   _asm("pop a");
  59  0001 84            pop a
  61                     ; 49   return; /* Ignore compiler warning, the returned value is in A register */
  64  0002 81            	ret
  87                     ; 74 void ITC_DeInit(void)
  87                     ; 75 {
  88                     .text:	section	.text,new
  89  0000               _ITC_DeInit:
  93                     ; 76     ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  95  0000 35ff7f70      	mov	32624,#255
  96                     ; 77     ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  98  0004 35ff7f71      	mov	32625,#255
  99                     ; 78     ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 101  0008 35ff7f72      	mov	32626,#255
 102                     ; 79     ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 104  000c 35ff7f73      	mov	32627,#255
 105                     ; 80     ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 107  0010 35ff7f74      	mov	32628,#255
 108                     ; 81     ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 110  0014 35ff7f75      	mov	32629,#255
 111                     ; 82     ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 113  0018 35ff7f76      	mov	32630,#255
 114                     ; 83     ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 116  001c 35ff7f77      	mov	32631,#255
 117                     ; 84 }
 120  0020 81            	ret
 145                     ; 91 uint8_t ITC_GetSoftIntStatus(void)
 145                     ; 92 {
 146                     .text:	section	.text,new
 147  0000               _ITC_GetSoftIntStatus:
 151                     ; 93     return (uint8_t)(ITC_GetCPUCC() & CPU_CC_I1I0);
 153  0000 cd0000        	call	_ITC_GetCPUCC
 155  0003 a428          	and	a,#40
 158  0005 81            	ret
 422                     .const:	section	.text
 423  0000               L62:
 424  0000 003c          	dc.w	L14
 425  0002 003c          	dc.w	L14
 426  0004 003c          	dc.w	L14
 427  0006 003c          	dc.w	L14
 428  0008 0045          	dc.w	L34
 429  000a 0045          	dc.w	L34
 430  000c 0045          	dc.w	L34
 431  000e 0045          	dc.w	L34
 432  0010 0079          	dc.w	L112
 433  0012 0079          	dc.w	L112
 434  0014 004e          	dc.w	L54
 435  0016 004e          	dc.w	L54
 436  0018 0057          	dc.w	L74
 437  001a 0057          	dc.w	L74
 438  001c 0057          	dc.w	L74
 439  001e 0057          	dc.w	L74
 440  0020 0060          	dc.w	L15
 441  0022 0060          	dc.w	L15
 442  0024 0060          	dc.w	L15
 443  0026 0060          	dc.w	L15
 444  0028 0069          	dc.w	L35
 445  002a 0069          	dc.w	L35
 446  002c 0069          	dc.w	L35
 447  002e 0069          	dc.w	L35
 448  0030 0072          	dc.w	L55
 449                     ; 101 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum)
 449                     ; 102 {
 450                     .text:	section	.text,new
 451  0000               _ITC_GetSoftwarePriority:
 453  0000 88            	push	a
 454  0001 89            	pushw	x
 455       00000002      OFST:	set	2
 458                     ; 104     uint8_t Value = 0;
 460  0002 0f02          	clr	(OFST+0,sp)
 461                     ; 105     uint8_t Mask = 0;
 463                     ; 108     assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 465  0004 a119          	cp	a,#25
 466  0006 2403          	jruge	L41
 467  0008 4f            	clr	a
 468  0009 2010          	jra	L61
 469  000b               L41:
 470  000b ae006c        	ldw	x,#108
 471  000e 89            	pushw	x
 472  000f ae0000        	ldw	x,#0
 473  0012 89            	pushw	x
 474  0013 ae0064        	ldw	x,#L502
 475  0016 cd0000        	call	_assert_failed
 477  0019 5b04          	addw	sp,#4
 478  001b               L61:
 479                     ; 111     Mask = (uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U));
 481  001b 7b03          	ld	a,(OFST+1,sp)
 482  001d a403          	and	a,#3
 483  001f 48            	sll	a
 484  0020 5f            	clrw	x
 485  0021 97            	ld	xl,a
 486  0022 a603          	ld	a,#3
 487  0024 5d            	tnzw	x
 488  0025 2704          	jreq	L02
 489  0027               L22:
 490  0027 48            	sll	a
 491  0028 5a            	decw	x
 492  0029 26fc          	jrne	L22
 493  002b               L02:
 494  002b 6b01          	ld	(OFST-1,sp),a
 495                     ; 113     switch (IrqNum)
 497  002d 7b03          	ld	a,(OFST+1,sp)
 499                     ; 185     default:
 499                     ; 186         break;
 500  002f a119          	cp	a,#25
 501  0031 2407          	jruge	L42
 502  0033 5f            	clrw	x
 503  0034 97            	ld	xl,a
 504  0035 58            	sllw	x
 505  0036 de0000        	ldw	x,(L62,x)
 506  0039 fc            	jp	(x)
 507  003a               L42:
 508  003a 203d          	jra	L112
 509  003c               L14:
 510                     ; 115     case ITC_IRQ_TLI: /* TLI software priority can be read but has no meaning */
 510                     ; 116     case ITC_IRQ_AWU:
 510                     ; 117     case ITC_IRQ_CLK:
 510                     ; 118     case ITC_IRQ_PORTA:
 510                     ; 119         Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 512  003c c67f70        	ld	a,32624
 513  003f 1401          	and	a,(OFST-1,sp)
 514  0041 6b02          	ld	(OFST+0,sp),a
 515                     ; 120         break;
 517  0043 2034          	jra	L112
 518  0045               L34:
 519                     ; 121     case ITC_IRQ_PORTB:
 519                     ; 122     case ITC_IRQ_PORTC:
 519                     ; 123     case ITC_IRQ_PORTD:
 519                     ; 124     case ITC_IRQ_PORTE:
 519                     ; 125         Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 521  0045 c67f71        	ld	a,32625
 522  0048 1401          	and	a,(OFST-1,sp)
 523  004a 6b02          	ld	(OFST+0,sp),a
 524                     ; 126         break;
 526  004c 202b          	jra	L112
 527  004e               L54:
 528                     ; 136     case ITC_IRQ_SPI:
 528                     ; 137     case ITC_IRQ_TIM1_OVF:
 528                     ; 138         Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 530  004e c67f72        	ld	a,32626
 531  0051 1401          	and	a,(OFST-1,sp)
 532  0053 6b02          	ld	(OFST+0,sp),a
 533                     ; 139         break;
 535  0055 2022          	jra	L112
 536  0057               L74:
 537                     ; 140     case ITC_IRQ_TIM1_CAPCOM:
 537                     ; 141 #ifdef STM8S903
 537                     ; 142     case ITC_IRQ_TIM5_OVFTRI:
 537                     ; 143     case ITC_IRQ_TIM5_CAPCOM:
 537                     ; 144 #else
 537                     ; 145     case ITC_IRQ_TIM2_OVF:
 537                     ; 146     case ITC_IRQ_TIM2_CAPCOM:
 537                     ; 147 #endif /*STM8S903*/
 537                     ; 148 
 537                     ; 149     case ITC_IRQ_TIM3_OVF:
 537                     ; 150         Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 539  0057 c67f73        	ld	a,32627
 540  005a 1401          	and	a,(OFST-1,sp)
 541  005c 6b02          	ld	(OFST+0,sp),a
 542                     ; 151         break;
 544  005e 2019          	jra	L112
 545  0060               L15:
 546                     ; 152     case ITC_IRQ_TIM3_CAPCOM:
 546                     ; 153     case ITC_IRQ_UART1_TX:
 546                     ; 154     case ITC_IRQ_UART1_RX:
 546                     ; 155     case ITC_IRQ_I2C:
 546                     ; 156         Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 548  0060 c67f74        	ld	a,32628
 549  0063 1401          	and	a,(OFST-1,sp)
 550  0065 6b02          	ld	(OFST+0,sp),a
 551                     ; 157         break;
 553  0067 2010          	jra	L112
 554  0069               L35:
 555                     ; 159     case ITC_IRQ_UART2_TX:
 555                     ; 160     case ITC_IRQ_UART2_RX:
 555                     ; 161 #endif /*STM8S105 or STM8AF626x*/
 555                     ; 162 
 555                     ; 163 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 555                     ; 164     defined(STM8AF62Ax)
 555                     ; 165     case ITC_IRQ_UART3_TX:
 555                     ; 166     case ITC_IRQ_UART3_RX:
 555                     ; 167     case ITC_IRQ_ADC2:
 555                     ; 168 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 555                     ; 169 
 555                     ; 170 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 555                     ; 171     defined(STM8S903) || defined(STM8AF626x)
 555                     ; 172     case ITC_IRQ_ADC1:
 555                     ; 173 #endif /*STM8S105, STM8S103 or STM8S905 or STM8AF626x */
 555                     ; 174 
 555                     ; 175 #ifdef STM8S903
 555                     ; 176     case ITC_IRQ_TIM6_OVFTRI:
 555                     ; 177 #else
 555                     ; 178     case ITC_IRQ_TIM4_OVF:
 555                     ; 179 #endif /*STM8S903*/
 555                     ; 180         Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 557  0069 c67f75        	ld	a,32629
 558  006c 1401          	and	a,(OFST-1,sp)
 559  006e 6b02          	ld	(OFST+0,sp),a
 560                     ; 181         break;
 562  0070 2007          	jra	L112
 563  0072               L55:
 564                     ; 182     case ITC_IRQ_EEPROM_EEC:
 564                     ; 183         Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 566  0072 c67f76        	ld	a,32630
 567  0075 1401          	and	a,(OFST-1,sp)
 568  0077 6b02          	ld	(OFST+0,sp),a
 569                     ; 184         break;
 571  0079               L75:
 572                     ; 185     default:
 572                     ; 186         break;
 574  0079               L112:
 575                     ; 189     Value >>= (uint8_t)(((uint8_t)IrqNum % 4u) * 2u);
 577  0079 7b03          	ld	a,(OFST+1,sp)
 578  007b a403          	and	a,#3
 579  007d 48            	sll	a
 580  007e 5f            	clrw	x
 581  007f 97            	ld	xl,a
 582  0080 7b02          	ld	a,(OFST+0,sp)
 583  0082 5d            	tnzw	x
 584  0083 2704          	jreq	L03
 585  0085               L23:
 586  0085 44            	srl	a
 587  0086 5a            	decw	x
 588  0087 26fc          	jrne	L23
 589  0089               L03:
 590  0089 6b02          	ld	(OFST+0,sp),a
 591                     ; 191     return((ITC_PriorityLevel_TypeDef)Value);
 593  008b 7b02          	ld	a,(OFST+0,sp)
 596  008d 5b03          	addw	sp,#3
 597  008f 81            	ret
 663                     	switch	.const
 664  0032               L66:
 665  0032 0091          	dc.w	L312
 666  0034 0091          	dc.w	L312
 667  0036 0091          	dc.w	L312
 668  0038 0091          	dc.w	L312
 669  003a 00a3          	dc.w	L512
 670  003c 00a3          	dc.w	L512
 671  003e 00a3          	dc.w	L512
 672  0040 00a3          	dc.w	L512
 673  0042 010d          	dc.w	L762
 674  0044 010d          	dc.w	L762
 675  0046 00b5          	dc.w	L712
 676  0048 00b5          	dc.w	L712
 677  004a 00c7          	dc.w	L122
 678  004c 00c7          	dc.w	L122
 679  004e 00c7          	dc.w	L122
 680  0050 00c7          	dc.w	L122
 681  0052 00d9          	dc.w	L322
 682  0054 00d9          	dc.w	L322
 683  0056 00d9          	dc.w	L322
 684  0058 00d9          	dc.w	L322
 685  005a 00eb          	dc.w	L522
 686  005c 00eb          	dc.w	L522
 687  005e 00eb          	dc.w	L522
 688  0060 00eb          	dc.w	L522
 689  0062 00fd          	dc.w	L722
 690                     ; 208 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 690                     ; 209 {
 691                     .text:	section	.text,new
 692  0000               _ITC_SetSoftwarePriority:
 694  0000 89            	pushw	x
 695  0001 89            	pushw	x
 696       00000002      OFST:	set	2
 699                     ; 211     uint8_t Mask = 0;
 701                     ; 212     uint8_t NewPriority = 0;
 703                     ; 215     assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 705  0002 9e            	ld	a,xh
 706  0003 a119          	cp	a,#25
 707  0005 2403          	jruge	L63
 708  0007 4f            	clr	a
 709  0008 2010          	jra	L04
 710  000a               L63:
 711  000a ae00d7        	ldw	x,#215
 712  000d 89            	pushw	x
 713  000e ae0000        	ldw	x,#0
 714  0011 89            	pushw	x
 715  0012 ae0064        	ldw	x,#L502
 716  0015 cd0000        	call	_assert_failed
 718  0018 5b04          	addw	sp,#4
 719  001a               L04:
 720                     ; 216     assert_param(IS_ITC_PRIORITY_OK(PriorityValue));
 722  001a 7b04          	ld	a,(OFST+2,sp)
 723  001c a102          	cp	a,#2
 724  001e 2710          	jreq	L44
 725  0020 7b04          	ld	a,(OFST+2,sp)
 726  0022 a101          	cp	a,#1
 727  0024 270a          	jreq	L44
 728  0026 0d04          	tnz	(OFST+2,sp)
 729  0028 2706          	jreq	L44
 730  002a 7b04          	ld	a,(OFST+2,sp)
 731  002c a103          	cp	a,#3
 732  002e 2603          	jrne	L24
 733  0030               L44:
 734  0030 4f            	clr	a
 735  0031 2010          	jra	L64
 736  0033               L24:
 737  0033 ae00d8        	ldw	x,#216
 738  0036 89            	pushw	x
 739  0037 ae0000        	ldw	x,#0
 740  003a 89            	pushw	x
 741  003b ae0064        	ldw	x,#L502
 742  003e cd0000        	call	_assert_failed
 744  0041 5b04          	addw	sp,#4
 745  0043               L64:
 746                     ; 219     assert_param(IS_ITC_INTERRUPTS_DISABLED);
 748  0043 cd0000        	call	_ITC_GetSoftIntStatus
 750  0046 a128          	cp	a,#40
 751  0048 2603          	jrne	L05
 752  004a 4f            	clr	a
 753  004b 2010          	jra	L25
 754  004d               L05:
 755  004d ae00db        	ldw	x,#219
 756  0050 89            	pushw	x
 757  0051 ae0000        	ldw	x,#0
 758  0054 89            	pushw	x
 759  0055 ae0064        	ldw	x,#L502
 760  0058 cd0000        	call	_assert_failed
 762  005b 5b04          	addw	sp,#4
 763  005d               L25:
 764                     ; 223     Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 766  005d 7b03          	ld	a,(OFST+1,sp)
 767  005f a403          	and	a,#3
 768  0061 48            	sll	a
 769  0062 5f            	clrw	x
 770  0063 97            	ld	xl,a
 771  0064 a603          	ld	a,#3
 772  0066 5d            	tnzw	x
 773  0067 2704          	jreq	L45
 774  0069               L65:
 775  0069 48            	sll	a
 776  006a 5a            	decw	x
 777  006b 26fc          	jrne	L65
 778  006d               L45:
 779  006d 43            	cpl	a
 780  006e 6b01          	ld	(OFST-1,sp),a
 781                     ; 226     NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 783  0070 7b03          	ld	a,(OFST+1,sp)
 784  0072 a403          	and	a,#3
 785  0074 48            	sll	a
 786  0075 5f            	clrw	x
 787  0076 97            	ld	xl,a
 788  0077 7b04          	ld	a,(OFST+2,sp)
 789  0079 5d            	tnzw	x
 790  007a 2704          	jreq	L06
 791  007c               L26:
 792  007c 48            	sll	a
 793  007d 5a            	decw	x
 794  007e 26fc          	jrne	L26
 795  0080               L06:
 796  0080 6b02          	ld	(OFST+0,sp),a
 797                     ; 228     switch (IrqNum)
 799  0082 7b03          	ld	a,(OFST+1,sp)
 801                     ; 314     default:
 801                     ; 315         break;
 802  0084 a119          	cp	a,#25
 803  0086 2407          	jruge	L46
 804  0088 5f            	clrw	x
 805  0089 97            	ld	xl,a
 806  008a 58            	sllw	x
 807  008b de0032        	ldw	x,(L66,x)
 808  008e fc            	jp	(x)
 809  008f               L46:
 810  008f 207c          	jra	L762
 811  0091               L312:
 812                     ; 231     case ITC_IRQ_TLI: /* TLI software priority can be written but has no meaning */
 812                     ; 232     case ITC_IRQ_AWU:
 812                     ; 233     case ITC_IRQ_CLK:
 812                     ; 234     case ITC_IRQ_PORTA:
 812                     ; 235         ITC->ISPR1 &= Mask;
 814  0091 c67f70        	ld	a,32624
 815  0094 1401          	and	a,(OFST-1,sp)
 816  0096 c77f70        	ld	32624,a
 817                     ; 236         ITC->ISPR1 |= NewPriority;
 819  0099 c67f70        	ld	a,32624
 820  009c 1a02          	or	a,(OFST+0,sp)
 821  009e c77f70        	ld	32624,a
 822                     ; 237         break;
 824  00a1 206a          	jra	L762
 825  00a3               L512:
 826                     ; 239     case ITC_IRQ_PORTB:
 826                     ; 240     case ITC_IRQ_PORTC:
 826                     ; 241     case ITC_IRQ_PORTD:
 826                     ; 242     case ITC_IRQ_PORTE:
 826                     ; 243         ITC->ISPR2 &= Mask;
 828  00a3 c67f71        	ld	a,32625
 829  00a6 1401          	and	a,(OFST-1,sp)
 830  00a8 c77f71        	ld	32625,a
 831                     ; 244         ITC->ISPR2 |= NewPriority;
 833  00ab c67f71        	ld	a,32625
 834  00ae 1a02          	or	a,(OFST+0,sp)
 835  00b0 c77f71        	ld	32625,a
 836                     ; 245         break;
 838  00b3 2058          	jra	L762
 839  00b5               L712:
 840                     ; 255     case ITC_IRQ_SPI:
 840                     ; 256     case ITC_IRQ_TIM1_OVF:
 840                     ; 257         ITC->ISPR3 &= Mask;
 842  00b5 c67f72        	ld	a,32626
 843  00b8 1401          	and	a,(OFST-1,sp)
 844  00ba c77f72        	ld	32626,a
 845                     ; 258         ITC->ISPR3 |= NewPriority;
 847  00bd c67f72        	ld	a,32626
 848  00c0 1a02          	or	a,(OFST+0,sp)
 849  00c2 c77f72        	ld	32626,a
 850                     ; 259         break;
 852  00c5 2046          	jra	L762
 853  00c7               L122:
 854                     ; 261     case ITC_IRQ_TIM1_CAPCOM:
 854                     ; 262 #ifdef STM8S903
 854                     ; 263     case ITC_IRQ_TIM5_OVFTRI:
 854                     ; 264     case ITC_IRQ_TIM5_CAPCOM:
 854                     ; 265 #else
 854                     ; 266     case ITC_IRQ_TIM2_OVF:
 854                     ; 267     case ITC_IRQ_TIM2_CAPCOM:
 854                     ; 268 #endif /*STM8S903*/
 854                     ; 269 
 854                     ; 270     case ITC_IRQ_TIM3_OVF:
 854                     ; 271         ITC->ISPR4 &= Mask;
 856  00c7 c67f73        	ld	a,32627
 857  00ca 1401          	and	a,(OFST-1,sp)
 858  00cc c77f73        	ld	32627,a
 859                     ; 272         ITC->ISPR4 |= NewPriority;
 861  00cf c67f73        	ld	a,32627
 862  00d2 1a02          	or	a,(OFST+0,sp)
 863  00d4 c77f73        	ld	32627,a
 864                     ; 273         break;
 866  00d7 2034          	jra	L762
 867  00d9               L322:
 868                     ; 275     case ITC_IRQ_TIM3_CAPCOM:
 868                     ; 276     case ITC_IRQ_UART1_TX:
 868                     ; 277     case ITC_IRQ_UART1_RX:
 868                     ; 278     case ITC_IRQ_I2C:
 868                     ; 279         ITC->ISPR5 &= Mask;
 870  00d9 c67f74        	ld	a,32628
 871  00dc 1401          	and	a,(OFST-1,sp)
 872  00de c77f74        	ld	32628,a
 873                     ; 280         ITC->ISPR5 |= NewPriority;
 875  00e1 c67f74        	ld	a,32628
 876  00e4 1a02          	or	a,(OFST+0,sp)
 877  00e6 c77f74        	ld	32628,a
 878                     ; 281         break;
 880  00e9 2022          	jra	L762
 881  00eb               L522:
 882                     ; 284     case ITC_IRQ_UART2_TX:
 882                     ; 285     case ITC_IRQ_UART2_RX:
 882                     ; 286 #endif /*STM8S105 or STM8AF626x */
 882                     ; 287 
 882                     ; 288 #if defined(STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8AF52Ax) || \
 882                     ; 289     defined(STM8AF62Ax)
 882                     ; 290     case ITC_IRQ_UART3_TX:
 882                     ; 291     case ITC_IRQ_UART3_RX:
 882                     ; 292     case ITC_IRQ_ADC2:
 882                     ; 293 #endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */
 882                     ; 294 
 882                     ; 295 #if defined(STM8S105) || defined(STM8S005) || defined(STM8S103) || defined(STM8S003) || \
 882                     ; 296     defined(STM8S903) || defined(STM8AF626x)
 882                     ; 297     case ITC_IRQ_ADC1:
 882                     ; 298 #endif /*STM8S105, STM8S103 or STM8S905 or STM8AF626x */
 882                     ; 299 
 882                     ; 300 #ifdef STM8S903
 882                     ; 301     case ITC_IRQ_TIM6_OVFTRI:
 882                     ; 302 #else
 882                     ; 303     case ITC_IRQ_TIM4_OVF:
 882                     ; 304 #endif /*STM8S903*/
 882                     ; 305         ITC->ISPR6 &= Mask;
 884  00eb c67f75        	ld	a,32629
 885  00ee 1401          	and	a,(OFST-1,sp)
 886  00f0 c77f75        	ld	32629,a
 887                     ; 306         ITC->ISPR6 |= NewPriority;
 889  00f3 c67f75        	ld	a,32629
 890  00f6 1a02          	or	a,(OFST+0,sp)
 891  00f8 c77f75        	ld	32629,a
 892                     ; 307         break;
 894  00fb 2010          	jra	L762
 895  00fd               L722:
 896                     ; 309     case ITC_IRQ_EEPROM_EEC:
 896                     ; 310         ITC->ISPR7 &= Mask;
 898  00fd c67f76        	ld	a,32630
 899  0100 1401          	and	a,(OFST-1,sp)
 900  0102 c77f76        	ld	32630,a
 901                     ; 311         ITC->ISPR7 |= NewPriority;
 903  0105 c67f76        	ld	a,32630
 904  0108 1a02          	or	a,(OFST+0,sp)
 905  010a c77f76        	ld	32630,a
 906                     ; 312         break;
 908  010d               L132:
 909                     ; 314     default:
 909                     ; 315         break;
 911  010d               L762:
 912                     ; 319 }
 915  010d 5b04          	addw	sp,#4
 916  010f 81            	ret
 929                     	xdef	_ITC_GetSoftwarePriority
 930                     	xdef	_ITC_SetSoftwarePriority
 931                     	xdef	_ITC_GetSoftIntStatus
 932                     	xdef	_ITC_DeInit
 933                     	xdef	_ITC_GetCPUCC
 934                     	xref	_assert_failed
 935                     	switch	.const
 936  0064               L502:
 937  0064 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
 938  0076 697665725c73  	dc.b	"iver\src\stm8s_itc"
 939  0088 2e6300        	dc.b	".c",0
 959                     	end
