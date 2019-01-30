   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
 110                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 110                     ; 48 {
 112                     .text:	section	.text,new
 113  0000               _GPIO_DeInit:
 117                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 119  0000 7f            	clr	(x)
 120                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 122  0001 6f02          	clr	(2,x)
 123                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 125  0003 6f03          	clr	(3,x)
 126                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 128  0005 6f04          	clr	(4,x)
 129                     ; 53 }
 132  0007 81            	ret
 373                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 373                     ; 66 {
 374                     .text:	section	.text,new
 375  0000               _GPIO_Init:
 377  0000 89            	pushw	x
 378       00000000      OFST:	set	0
 381                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 383  0001 0d06          	tnz	(OFST+6,sp)
 384  0003 2742          	jreq	L21
 385  0005 7b06          	ld	a,(OFST+6,sp)
 386  0007 a140          	cp	a,#64
 387  0009 273c          	jreq	L21
 388  000b 7b06          	ld	a,(OFST+6,sp)
 389  000d a120          	cp	a,#32
 390  000f 2736          	jreq	L21
 391  0011 7b06          	ld	a,(OFST+6,sp)
 392  0013 a160          	cp	a,#96
 393  0015 2730          	jreq	L21
 394  0017 7b06          	ld	a,(OFST+6,sp)
 395  0019 a1a0          	cp	a,#160
 396  001b 272a          	jreq	L21
 397  001d 7b06          	ld	a,(OFST+6,sp)
 398  001f a1e0          	cp	a,#224
 399  0021 2724          	jreq	L21
 400  0023 7b06          	ld	a,(OFST+6,sp)
 401  0025 a180          	cp	a,#128
 402  0027 271e          	jreq	L21
 403  0029 7b06          	ld	a,(OFST+6,sp)
 404  002b a1c0          	cp	a,#192
 405  002d 2718          	jreq	L21
 406  002f 7b06          	ld	a,(OFST+6,sp)
 407  0031 a1b0          	cp	a,#176
 408  0033 2712          	jreq	L21
 409  0035 7b06          	ld	a,(OFST+6,sp)
 410  0037 a1f0          	cp	a,#240
 411  0039 270c          	jreq	L21
 412  003b 7b06          	ld	a,(OFST+6,sp)
 413  003d a190          	cp	a,#144
 414  003f 2706          	jreq	L21
 415  0041 7b06          	ld	a,(OFST+6,sp)
 416  0043 a1d0          	cp	a,#208
 417  0045 2603          	jrne	L01
 418  0047               L21:
 419  0047 4f            	clr	a
 420  0048 2010          	jra	L41
 421  004a               L01:
 422  004a ae0047        	ldw	x,#71
 423  004d 89            	pushw	x
 424  004e ae0000        	ldw	x,#0
 425  0051 89            	pushw	x
 426  0052 ae0000        	ldw	x,#L771
 427  0055 cd0000        	call	_assert_failed
 429  0058 5b04          	addw	sp,#4
 430  005a               L41:
 431                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 433  005a 0d05          	tnz	(OFST+5,sp)
 434  005c 2703          	jreq	L61
 435  005e 4f            	clr	a
 436  005f 2010          	jra	L02
 437  0061               L61:
 438  0061 ae0048        	ldw	x,#72
 439  0064 89            	pushw	x
 440  0065 ae0000        	ldw	x,#0
 441  0068 89            	pushw	x
 442  0069 ae0000        	ldw	x,#L771
 443  006c cd0000        	call	_assert_failed
 445  006f 5b04          	addw	sp,#4
 446  0071               L02:
 447                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 449  0071 1e01          	ldw	x,(OFST+1,sp)
 450  0073 7b05          	ld	a,(OFST+5,sp)
 451  0075 43            	cpl	a
 452  0076 e404          	and	a,(4,x)
 453  0078 e704          	ld	(4,x),a
 454                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 456  007a 7b06          	ld	a,(OFST+6,sp)
 457  007c a580          	bcp	a,#128
 458  007e 271f          	jreq	L102
 459                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 461  0080 7b06          	ld	a,(OFST+6,sp)
 462  0082 a510          	bcp	a,#16
 463  0084 2708          	jreq	L302
 464                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 466  0086 1e01          	ldw	x,(OFST+1,sp)
 467  0088 f6            	ld	a,(x)
 468  0089 1a05          	or	a,(OFST+5,sp)
 469  008b f7            	ld	(x),a
 471  008c 2007          	jra	L502
 472  008e               L302:
 473                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 475  008e 1e01          	ldw	x,(OFST+1,sp)
 476  0090 7b05          	ld	a,(OFST+5,sp)
 477  0092 43            	cpl	a
 478  0093 f4            	and	a,(x)
 479  0094 f7            	ld	(x),a
 480  0095               L502:
 481                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 483  0095 1e01          	ldw	x,(OFST+1,sp)
 484  0097 e602          	ld	a,(2,x)
 485  0099 1a05          	or	a,(OFST+5,sp)
 486  009b e702          	ld	(2,x),a
 488  009d 2009          	jra	L702
 489  009f               L102:
 490                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 492  009f 1e01          	ldw	x,(OFST+1,sp)
 493  00a1 7b05          	ld	a,(OFST+5,sp)
 494  00a3 43            	cpl	a
 495  00a4 e402          	and	a,(2,x)
 496  00a6 e702          	ld	(2,x),a
 497  00a8               L702:
 498                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 500  00a8 7b06          	ld	a,(OFST+6,sp)
 501  00aa a540          	bcp	a,#64
 502  00ac 270a          	jreq	L112
 503                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 505  00ae 1e01          	ldw	x,(OFST+1,sp)
 506  00b0 e603          	ld	a,(3,x)
 507  00b2 1a05          	or	a,(OFST+5,sp)
 508  00b4 e703          	ld	(3,x),a
 510  00b6 2009          	jra	L312
 511  00b8               L112:
 512                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 514  00b8 1e01          	ldw	x,(OFST+1,sp)
 515  00ba 7b05          	ld	a,(OFST+5,sp)
 516  00bc 43            	cpl	a
 517  00bd e403          	and	a,(3,x)
 518  00bf e703          	ld	(3,x),a
 519  00c1               L312:
 520                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 522  00c1 7b06          	ld	a,(OFST+6,sp)
 523  00c3 a520          	bcp	a,#32
 524  00c5 270a          	jreq	L512
 525                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 527  00c7 1e01          	ldw	x,(OFST+1,sp)
 528  00c9 e604          	ld	a,(4,x)
 529  00cb 1a05          	or	a,(OFST+5,sp)
 530  00cd e704          	ld	(4,x),a
 532  00cf 2009          	jra	L712
 533  00d1               L512:
 534                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 536  00d1 1e01          	ldw	x,(OFST+1,sp)
 537  00d3 7b05          	ld	a,(OFST+5,sp)
 538  00d5 43            	cpl	a
 539  00d6 e404          	and	a,(4,x)
 540  00d8 e704          	ld	(4,x),a
 541  00da               L712:
 542                     ; 125 }
 545  00da 85            	popw	x
 546  00db 81            	ret
 592                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 592                     ; 136 {
 593                     .text:	section	.text,new
 594  0000               _GPIO_Write:
 596  0000 89            	pushw	x
 597       00000000      OFST:	set	0
 600                     ; 137     GPIOx->ODR = PortVal;
 602  0001 7b05          	ld	a,(OFST+5,sp)
 603  0003 1e01          	ldw	x,(OFST+1,sp)
 604  0005 f7            	ld	(x),a
 605                     ; 138 }
 608  0006 85            	popw	x
 609  0007 81            	ret
 656                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 656                     ; 149 {
 657                     .text:	section	.text,new
 658  0000               _GPIO_WriteHigh:
 660  0000 89            	pushw	x
 661       00000000      OFST:	set	0
 664                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 666  0001 f6            	ld	a,(x)
 667  0002 1a05          	or	a,(OFST+5,sp)
 668  0004 f7            	ld	(x),a
 669                     ; 151 }
 672  0005 85            	popw	x
 673  0006 81            	ret
 720                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 720                     ; 162 {
 721                     .text:	section	.text,new
 722  0000               _GPIO_WriteLow:
 724  0000 89            	pushw	x
 725       00000000      OFST:	set	0
 728                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 730  0001 7b05          	ld	a,(OFST+5,sp)
 731  0003 43            	cpl	a
 732  0004 f4            	and	a,(x)
 733  0005 f7            	ld	(x),a
 734                     ; 164 }
 737  0006 85            	popw	x
 738  0007 81            	ret
 785                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 785                     ; 175 {
 786                     .text:	section	.text,new
 787  0000               _GPIO_WriteReverse:
 789  0000 89            	pushw	x
 790       00000000      OFST:	set	0
 793                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 795  0001 f6            	ld	a,(x)
 796  0002 1805          	xor	a,	(OFST+5,sp)
 797  0004 f7            	ld	(x),a
 798                     ; 177 }
 801  0005 85            	popw	x
 802  0006 81            	ret
 840                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 840                     ; 186 {
 841                     .text:	section	.text,new
 842  0000               _GPIO_ReadOutputData:
 846                     ; 187     return ((uint8_t)GPIOx->ODR);
 848  0000 f6            	ld	a,(x)
 851  0001 81            	ret
 888                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 888                     ; 197 {
 889                     .text:	section	.text,new
 890  0000               _GPIO_ReadInputData:
 894                     ; 198     return ((uint8_t)GPIOx->IDR);
 896  0000 e601          	ld	a,(1,x)
 899  0002 81            	ret
 967                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 967                     ; 208 {
 968                     .text:	section	.text,new
 969  0000               _GPIO_ReadInputPin:
 971  0000 89            	pushw	x
 972       00000000      OFST:	set	0
 975                     ; 210     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin) ? SET : RESET);
 977  0001 e601          	ld	a,(1,x)
 978  0003 1505          	bcp	a,(OFST+5,sp)
 979  0005 2704          	jreq	L04
 980  0007 a601          	ld	a,#1
 981  0009 2001          	jra	L24
 982  000b               L04:
 983  000b 4f            	clr	a
 984  000c               L24:
 987  000c 85            	popw	x
 988  000d 81            	ret
1067                     ; 220 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
1067                     ; 221 {
1068                     .text:	section	.text,new
1069  0000               _GPIO_ExternalPullUpConfig:
1071  0000 89            	pushw	x
1072       00000000      OFST:	set	0
1075                     ; 223     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1077  0001 0d05          	tnz	(OFST+5,sp)
1078  0003 2703          	jreq	L64
1079  0005 4f            	clr	a
1080  0006 2010          	jra	L05
1081  0008               L64:
1082  0008 ae00df        	ldw	x,#223
1083  000b 89            	pushw	x
1084  000c ae0000        	ldw	x,#0
1085  000f 89            	pushw	x
1086  0010 ae0000        	ldw	x,#L771
1087  0013 cd0000        	call	_assert_failed
1089  0016 5b04          	addw	sp,#4
1090  0018               L05:
1091                     ; 224     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1093  0018 0d06          	tnz	(OFST+6,sp)
1094  001a 2706          	jreq	L45
1095  001c 7b06          	ld	a,(OFST+6,sp)
1096  001e a101          	cp	a,#1
1097  0020 2603          	jrne	L25
1098  0022               L45:
1099  0022 4f            	clr	a
1100  0023 2010          	jra	L65
1101  0025               L25:
1102  0025 ae00e0        	ldw	x,#224
1103  0028 89            	pushw	x
1104  0029 ae0000        	ldw	x,#0
1105  002c 89            	pushw	x
1106  002d ae0000        	ldw	x,#L771
1107  0030 cd0000        	call	_assert_failed
1109  0033 5b04          	addw	sp,#4
1110  0035               L65:
1111                     ; 226     if (NewState != DISABLE) /* External Pull-Up Set*/
1113  0035 0d06          	tnz	(OFST+6,sp)
1114  0037 270a          	jreq	L574
1115                     ; 228         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1117  0039 1e01          	ldw	x,(OFST+1,sp)
1118  003b e603          	ld	a,(3,x)
1119  003d 1a05          	or	a,(OFST+5,sp)
1120  003f e703          	ld	(3,x),a
1122  0041 2009          	jra	L774
1123  0043               L574:
1124                     ; 231         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1126  0043 1e01          	ldw	x,(OFST+1,sp)
1127  0045 7b05          	ld	a,(OFST+5,sp)
1128  0047 43            	cpl	a
1129  0048 e403          	and	a,(3,x)
1130  004a e703          	ld	(3,x),a
1131  004c               L774:
1132                     ; 233 }
1135  004c 85            	popw	x
1136  004d 81            	ret
1149                     	xdef	_GPIO_ExternalPullUpConfig
1150                     	xdef	_GPIO_ReadInputPin
1151                     	xdef	_GPIO_ReadOutputData
1152                     	xdef	_GPIO_ReadInputData
1153                     	xdef	_GPIO_WriteReverse
1154                     	xdef	_GPIO_WriteLow
1155                     	xdef	_GPIO_WriteHigh
1156                     	xdef	_GPIO_Write
1157                     	xdef	_GPIO_Init
1158                     	xdef	_GPIO_DeInit
1159                     	xref	_assert_failed
1160                     .const:	section	.text
1161  0000               L771:
1162  0000 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
1163  0012 697665725c73  	dc.b	"iver\src\stm8s_gpi"
1164  0024 6f2e6300      	dc.b	"o.c",0
1184                     	end
