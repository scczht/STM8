   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  16                     .const:	section	.text
  17  0000               _HSIDivFactor:
  18  0000 01            	dc.b	1
  19  0001 02            	dc.b	2
  20  0002 04            	dc.b	4
  21  0003 08            	dc.b	8
  22  0004               _CLKPrescTable:
  23  0004 01            	dc.b	1
  24  0005 02            	dc.b	2
  25  0006 04            	dc.b	4
  26  0007 08            	dc.b	8
  27  0008 0a            	dc.b	10
  28  0009 10            	dc.b	16
  29  000a 14            	dc.b	20
  30  000b 28            	dc.b	40
  59                     ; 66 void CLK_DeInit(void)
  59                     ; 67 {
  61                     .text:	section	.text,new
  62  0000               _CLK_DeInit:
  66                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  68  0000 350150c0      	mov	20672,#1
  69                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  71  0004 725f50c1      	clr	20673
  72                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  74  0008 35e150c4      	mov	20676,#225
  75                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  77  000c 725f50c5      	clr	20677
  78                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  80  0010 351850c6      	mov	20678,#24
  81                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  83  0014 35ff50c7      	mov	20679,#255
  84                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  86  0018 35ff50ca      	mov	20682,#255
  87                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  89  001c 725f50c8      	clr	20680
  90                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  92  0020 725f50c9      	clr	20681
  94  0024               L52:
  95                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  97  0024 c650c9        	ld	a,20681
  98  0027 a501          	bcp	a,#1
  99  0029 26f9          	jrne	L52
 100                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 102  002b 725f50c9      	clr	20681
 103                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 105  002f 725f50cc      	clr	20684
 106                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 108  0033 725f50cd      	clr	20685
 109                     ; 84 }
 112  0037 81            	ret
 169                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 169                     ; 96 {
 170                     .text:	section	.text,new
 171  0000               _CLK_FastHaltWakeUpCmd:
 173  0000 88            	push	a
 174       00000000      OFST:	set	0
 177                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 179  0001 4d            	tnz	a
 180  0002 2704          	jreq	L21
 181  0004 a101          	cp	a,#1
 182  0006 2603          	jrne	L01
 183  0008               L21:
 184  0008 4f            	clr	a
 185  0009 2010          	jra	L41
 186  000b               L01:
 187  000b ae0063        	ldw	x,#99
 188  000e 89            	pushw	x
 189  000f ae0000        	ldw	x,#0
 190  0012 89            	pushw	x
 191  0013 ae000c        	ldw	x,#L75
 192  0016 cd0000        	call	_assert_failed
 194  0019 5b04          	addw	sp,#4
 195  001b               L41:
 196                     ; 101     if (NewState != DISABLE)
 198  001b 0d01          	tnz	(OFST+1,sp)
 199  001d 2706          	jreq	L16
 200                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 202  001f 721450c0      	bset	20672,#2
 204  0023 2004          	jra	L36
 205  0025               L16:
 206                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 208  0025 721550c0      	bres	20672,#2
 209  0029               L36:
 210                     ; 112 }
 213  0029 84            	pop	a
 214  002a 81            	ret
 250                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 250                     ; 120 {
 251                     .text:	section	.text,new
 252  0000               _CLK_HSECmd:
 254  0000 88            	push	a
 255       00000000      OFST:	set	0
 258                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 260  0001 4d            	tnz	a
 261  0002 2704          	jreq	L22
 262  0004 a101          	cp	a,#1
 263  0006 2603          	jrne	L02
 264  0008               L22:
 265  0008 4f            	clr	a
 266  0009 2010          	jra	L42
 267  000b               L02:
 268  000b ae007b        	ldw	x,#123
 269  000e 89            	pushw	x
 270  000f ae0000        	ldw	x,#0
 271  0012 89            	pushw	x
 272  0013 ae000c        	ldw	x,#L75
 273  0016 cd0000        	call	_assert_failed
 275  0019 5b04          	addw	sp,#4
 276  001b               L42:
 277                     ; 125     if (NewState != DISABLE)
 279  001b 0d01          	tnz	(OFST+1,sp)
 280  001d 2706          	jreq	L301
 281                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 283  001f 721050c1      	bset	20673,#0
 285  0023 2004          	jra	L501
 286  0025               L301:
 287                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 289  0025 721150c1      	bres	20673,#0
 290  0029               L501:
 291                     ; 136 }
 294  0029 84            	pop	a
 295  002a 81            	ret
 331                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 331                     ; 144 {
 332                     .text:	section	.text,new
 333  0000               _CLK_HSICmd:
 335  0000 88            	push	a
 336       00000000      OFST:	set	0
 339                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 341  0001 4d            	tnz	a
 342  0002 2704          	jreq	L23
 343  0004 a101          	cp	a,#1
 344  0006 2603          	jrne	L03
 345  0008               L23:
 346  0008 4f            	clr	a
 347  0009 2010          	jra	L43
 348  000b               L03:
 349  000b ae0093        	ldw	x,#147
 350  000e 89            	pushw	x
 351  000f ae0000        	ldw	x,#0
 352  0012 89            	pushw	x
 353  0013 ae000c        	ldw	x,#L75
 354  0016 cd0000        	call	_assert_failed
 356  0019 5b04          	addw	sp,#4
 357  001b               L43:
 358                     ; 149     if (NewState != DISABLE)
 360  001b 0d01          	tnz	(OFST+1,sp)
 361  001d 2706          	jreq	L521
 362                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 364  001f 721050c0      	bset	20672,#0
 366  0023 2004          	jra	L721
 367  0025               L521:
 368                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 370  0025 721150c0      	bres	20672,#0
 371  0029               L721:
 372                     ; 160 }
 375  0029 84            	pop	a
 376  002a 81            	ret
 412                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 412                     ; 168 {
 413                     .text:	section	.text,new
 414  0000               _CLK_LSICmd:
 416  0000 88            	push	a
 417       00000000      OFST:	set	0
 420                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 422  0001 4d            	tnz	a
 423  0002 2704          	jreq	L24
 424  0004 a101          	cp	a,#1
 425  0006 2603          	jrne	L04
 426  0008               L24:
 427  0008 4f            	clr	a
 428  0009 2010          	jra	L44
 429  000b               L04:
 430  000b ae00ab        	ldw	x,#171
 431  000e 89            	pushw	x
 432  000f ae0000        	ldw	x,#0
 433  0012 89            	pushw	x
 434  0013 ae000c        	ldw	x,#L75
 435  0016 cd0000        	call	_assert_failed
 437  0019 5b04          	addw	sp,#4
 438  001b               L44:
 439                     ; 173     if (NewState != DISABLE)
 441  001b 0d01          	tnz	(OFST+1,sp)
 442  001d 2706          	jreq	L741
 443                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 445  001f 721650c0      	bset	20672,#3
 447  0023 2004          	jra	L151
 448  0025               L741:
 449                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 451  0025 721750c0      	bres	20672,#3
 452  0029               L151:
 453                     ; 184 }
 456  0029 84            	pop	a
 457  002a 81            	ret
 493                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 493                     ; 193 {
 494                     .text:	section	.text,new
 495  0000               _CLK_CCOCmd:
 497  0000 88            	push	a
 498       00000000      OFST:	set	0
 501                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 503  0001 4d            	tnz	a
 504  0002 2704          	jreq	L25
 505  0004 a101          	cp	a,#1
 506  0006 2603          	jrne	L05
 507  0008               L25:
 508  0008 4f            	clr	a
 509  0009 2010          	jra	L45
 510  000b               L05:
 511  000b ae00c4        	ldw	x,#196
 512  000e 89            	pushw	x
 513  000f ae0000        	ldw	x,#0
 514  0012 89            	pushw	x
 515  0013 ae000c        	ldw	x,#L75
 516  0016 cd0000        	call	_assert_failed
 518  0019 5b04          	addw	sp,#4
 519  001b               L45:
 520                     ; 198     if (NewState != DISABLE)
 522  001b 0d01          	tnz	(OFST+1,sp)
 523  001d 2706          	jreq	L171
 524                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 526  001f 721050c9      	bset	20681,#0
 528  0023 2004          	jra	L371
 529  0025               L171:
 530                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 532  0025 721150c9      	bres	20681,#0
 533  0029               L371:
 534                     ; 209 }
 537  0029 84            	pop	a
 538  002a 81            	ret
 574                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 574                     ; 219 {
 575                     .text:	section	.text,new
 576  0000               _CLK_ClockSwitchCmd:
 578  0000 88            	push	a
 579       00000000      OFST:	set	0
 582                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 584  0001 4d            	tnz	a
 585  0002 2704          	jreq	L26
 586  0004 a101          	cp	a,#1
 587  0006 2603          	jrne	L06
 588  0008               L26:
 589  0008 4f            	clr	a
 590  0009 2010          	jra	L46
 591  000b               L06:
 592  000b ae00de        	ldw	x,#222
 593  000e 89            	pushw	x
 594  000f ae0000        	ldw	x,#0
 595  0012 89            	pushw	x
 596  0013 ae000c        	ldw	x,#L75
 597  0016 cd0000        	call	_assert_failed
 599  0019 5b04          	addw	sp,#4
 600  001b               L46:
 601                     ; 224     if (NewState != DISABLE )
 603  001b 0d01          	tnz	(OFST+1,sp)
 604  001d 2706          	jreq	L312
 605                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 607  001f 721250c5      	bset	20677,#1
 609  0023 2004          	jra	L512
 610  0025               L312:
 611                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 613  0025 721350c5      	bres	20677,#1
 614  0029               L512:
 615                     ; 235 }
 618  0029 84            	pop	a
 619  002a 81            	ret
 656                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 656                     ; 246 {
 657                     .text:	section	.text,new
 658  0000               _CLK_SlowActiveHaltWakeUpCmd:
 660  0000 88            	push	a
 661       00000000      OFST:	set	0
 664                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 666  0001 4d            	tnz	a
 667  0002 2704          	jreq	L27
 668  0004 a101          	cp	a,#1
 669  0006 2603          	jrne	L07
 670  0008               L27:
 671  0008 4f            	clr	a
 672  0009 2010          	jra	L47
 673  000b               L07:
 674  000b ae00f9        	ldw	x,#249
 675  000e 89            	pushw	x
 676  000f ae0000        	ldw	x,#0
 677  0012 89            	pushw	x
 678  0013 ae000c        	ldw	x,#L75
 679  0016 cd0000        	call	_assert_failed
 681  0019 5b04          	addw	sp,#4
 682  001b               L47:
 683                     ; 251     if (NewState != DISABLE)
 685  001b 0d01          	tnz	(OFST+1,sp)
 686  001d 2706          	jreq	L532
 687                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 689  001f 721a50c0      	bset	20672,#5
 691  0023 2004          	jra	L732
 692  0025               L532:
 693                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 695  0025 721b50c0      	bres	20672,#5
 696  0029               L732:
 697                     ; 262 }
 700  0029 84            	pop	a
 701  002a 81            	ret
 861                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 861                     ; 273 {
 862                     .text:	section	.text,new
 863  0000               _CLK_PeripheralClockConfig:
 865  0000 89            	pushw	x
 866       00000000      OFST:	set	0
 869                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 871  0001 9f            	ld	a,xl
 872  0002 4d            	tnz	a
 873  0003 2705          	jreq	L201
 874  0005 9f            	ld	a,xl
 875  0006 a101          	cp	a,#1
 876  0008 2603          	jrne	L001
 877  000a               L201:
 878  000a 4f            	clr	a
 879  000b 2010          	jra	L401
 880  000d               L001:
 881  000d ae0114        	ldw	x,#276
 882  0010 89            	pushw	x
 883  0011 ae0000        	ldw	x,#0
 884  0014 89            	pushw	x
 885  0015 ae000c        	ldw	x,#L75
 886  0018 cd0000        	call	_assert_failed
 888  001b 5b04          	addw	sp,#4
 889  001d               L401:
 890                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 892  001d 0d01          	tnz	(OFST+1,sp)
 893  001f 274e          	jreq	L011
 894  0021 7b01          	ld	a,(OFST+1,sp)
 895  0023 a101          	cp	a,#1
 896  0025 2748          	jreq	L011
 897  0027 7b01          	ld	a,(OFST+1,sp)
 898  0029 a103          	cp	a,#3
 899  002b 2742          	jreq	L011
 900  002d 7b01          	ld	a,(OFST+1,sp)
 901  002f a103          	cp	a,#3
 902  0031 273c          	jreq	L011
 903  0033 7b01          	ld	a,(OFST+1,sp)
 904  0035 a103          	cp	a,#3
 905  0037 2736          	jreq	L011
 906  0039 7b01          	ld	a,(OFST+1,sp)
 907  003b a104          	cp	a,#4
 908  003d 2730          	jreq	L011
 909  003f 7b01          	ld	a,(OFST+1,sp)
 910  0041 a105          	cp	a,#5
 911  0043 272a          	jreq	L011
 912  0045 7b01          	ld	a,(OFST+1,sp)
 913  0047 a105          	cp	a,#5
 914  0049 2724          	jreq	L011
 915  004b 7b01          	ld	a,(OFST+1,sp)
 916  004d a104          	cp	a,#4
 917  004f 271e          	jreq	L011
 918  0051 7b01          	ld	a,(OFST+1,sp)
 919  0053 a106          	cp	a,#6
 920  0055 2718          	jreq	L011
 921  0057 7b01          	ld	a,(OFST+1,sp)
 922  0059 a107          	cp	a,#7
 923  005b 2712          	jreq	L011
 924  005d 7b01          	ld	a,(OFST+1,sp)
 925  005f a117          	cp	a,#23
 926  0061 270c          	jreq	L011
 927  0063 7b01          	ld	a,(OFST+1,sp)
 928  0065 a113          	cp	a,#19
 929  0067 2706          	jreq	L011
 930  0069 7b01          	ld	a,(OFST+1,sp)
 931  006b a112          	cp	a,#18
 932  006d 2603          	jrne	L601
 933  006f               L011:
 934  006f 4f            	clr	a
 935  0070 2010          	jra	L211
 936  0072               L601:
 937  0072 ae0115        	ldw	x,#277
 938  0075 89            	pushw	x
 939  0076 ae0000        	ldw	x,#0
 940  0079 89            	pushw	x
 941  007a ae000c        	ldw	x,#L75
 942  007d cd0000        	call	_assert_failed
 944  0080 5b04          	addw	sp,#4
 945  0082               L211:
 946                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 948  0082 7b01          	ld	a,(OFST+1,sp)
 949  0084 a510          	bcp	a,#16
 950  0086 2633          	jrne	L323
 951                     ; 281         if (NewState != DISABLE)
 953  0088 0d02          	tnz	(OFST+2,sp)
 954  008a 2717          	jreq	L523
 955                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 957  008c 7b01          	ld	a,(OFST+1,sp)
 958  008e a40f          	and	a,#15
 959  0090 5f            	clrw	x
 960  0091 97            	ld	xl,a
 961  0092 a601          	ld	a,#1
 962  0094 5d            	tnzw	x
 963  0095 2704          	jreq	L411
 964  0097               L611:
 965  0097 48            	sll	a
 966  0098 5a            	decw	x
 967  0099 26fc          	jrne	L611
 968  009b               L411:
 969  009b ca50c7        	or	a,20679
 970  009e c750c7        	ld	20679,a
 972  00a1 2049          	jra	L133
 973  00a3               L523:
 974                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 976  00a3 7b01          	ld	a,(OFST+1,sp)
 977  00a5 a40f          	and	a,#15
 978  00a7 5f            	clrw	x
 979  00a8 97            	ld	xl,a
 980  00a9 a601          	ld	a,#1
 981  00ab 5d            	tnzw	x
 982  00ac 2704          	jreq	L021
 983  00ae               L221:
 984  00ae 48            	sll	a
 985  00af 5a            	decw	x
 986  00b0 26fc          	jrne	L221
 987  00b2               L021:
 988  00b2 43            	cpl	a
 989  00b3 c450c7        	and	a,20679
 990  00b6 c750c7        	ld	20679,a
 991  00b9 2031          	jra	L133
 992  00bb               L323:
 993                     ; 294         if (NewState != DISABLE)
 995  00bb 0d02          	tnz	(OFST+2,sp)
 996  00bd 2717          	jreq	L333
 997                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 999  00bf 7b01          	ld	a,(OFST+1,sp)
1000  00c1 a40f          	and	a,#15
1001  00c3 5f            	clrw	x
1002  00c4 97            	ld	xl,a
1003  00c5 a601          	ld	a,#1
1004  00c7 5d            	tnzw	x
1005  00c8 2704          	jreq	L421
1006  00ca               L621:
1007  00ca 48            	sll	a
1008  00cb 5a            	decw	x
1009  00cc 26fc          	jrne	L621
1010  00ce               L421:
1011  00ce ca50ca        	or	a,20682
1012  00d1 c750ca        	ld	20682,a
1014  00d4 2016          	jra	L133
1015  00d6               L333:
1016                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1018  00d6 7b01          	ld	a,(OFST+1,sp)
1019  00d8 a40f          	and	a,#15
1020  00da 5f            	clrw	x
1021  00db 97            	ld	xl,a
1022  00dc a601          	ld	a,#1
1023  00de 5d            	tnzw	x
1024  00df 2704          	jreq	L031
1025  00e1               L231:
1026  00e1 48            	sll	a
1027  00e2 5a            	decw	x
1028  00e3 26fc          	jrne	L231
1029  00e5               L031:
1030  00e5 43            	cpl	a
1031  00e6 c450ca        	and	a,20682
1032  00e9 c750ca        	ld	20682,a
1033  00ec               L133:
1034                     ; 306 }
1037  00ec 85            	popw	x
1038  00ed 81            	ret
1227                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1227                     ; 320 {
1228                     .text:	section	.text,new
1229  0000               _CLK_ClockSwitchConfig:
1231  0000 89            	pushw	x
1232  0001 5204          	subw	sp,#4
1233       00000004      OFST:	set	4
1236                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1238  0003 ae0491        	ldw	x,#1169
1239  0006 1f03          	ldw	(OFST-1,sp),x
1240                     ; 324     ErrorStatus Swif = ERROR;
1242                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1244  0008 7b06          	ld	a,(OFST+2,sp)
1245  000a a1e1          	cp	a,#225
1246  000c 270c          	jreq	L041
1247  000e 7b06          	ld	a,(OFST+2,sp)
1248  0010 a1d2          	cp	a,#210
1249  0012 2706          	jreq	L041
1250  0014 7b06          	ld	a,(OFST+2,sp)
1251  0016 a1b4          	cp	a,#180
1252  0018 2603          	jrne	L631
1253  001a               L041:
1254  001a 4f            	clr	a
1255  001b 2010          	jra	L241
1256  001d               L631:
1257  001d ae0147        	ldw	x,#327
1258  0020 89            	pushw	x
1259  0021 ae0000        	ldw	x,#0
1260  0024 89            	pushw	x
1261  0025 ae000c        	ldw	x,#L75
1262  0028 cd0000        	call	_assert_failed
1264  002b 5b04          	addw	sp,#4
1265  002d               L241:
1266                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1268  002d 0d05          	tnz	(OFST+1,sp)
1269  002f 2706          	jreq	L641
1270  0031 7b05          	ld	a,(OFST+1,sp)
1271  0033 a101          	cp	a,#1
1272  0035 2603          	jrne	L441
1273  0037               L641:
1274  0037 4f            	clr	a
1275  0038 2010          	jra	L051
1276  003a               L441:
1277  003a ae0148        	ldw	x,#328
1278  003d 89            	pushw	x
1279  003e ae0000        	ldw	x,#0
1280  0041 89            	pushw	x
1281  0042 ae000c        	ldw	x,#L75
1282  0045 cd0000        	call	_assert_failed
1284  0048 5b04          	addw	sp,#4
1285  004a               L051:
1286                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1288  004a 0d09          	tnz	(OFST+5,sp)
1289  004c 2706          	jreq	L451
1290  004e 7b09          	ld	a,(OFST+5,sp)
1291  0050 a101          	cp	a,#1
1292  0052 2603          	jrne	L251
1293  0054               L451:
1294  0054 4f            	clr	a
1295  0055 2010          	jra	L651
1296  0057               L251:
1297  0057 ae0149        	ldw	x,#329
1298  005a 89            	pushw	x
1299  005b ae0000        	ldw	x,#0
1300  005e 89            	pushw	x
1301  005f ae000c        	ldw	x,#L75
1302  0062 cd0000        	call	_assert_failed
1304  0065 5b04          	addw	sp,#4
1305  0067               L651:
1306                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1308  0067 0d0a          	tnz	(OFST+6,sp)
1309  0069 2706          	jreq	L261
1310  006b 7b0a          	ld	a,(OFST+6,sp)
1311  006d a101          	cp	a,#1
1312  006f 2603          	jrne	L061
1313  0071               L261:
1314  0071 4f            	clr	a
1315  0072 2010          	jra	L461
1316  0074               L061:
1317  0074 ae014a        	ldw	x,#330
1318  0077 89            	pushw	x
1319  0078 ae0000        	ldw	x,#0
1320  007b 89            	pushw	x
1321  007c ae000c        	ldw	x,#L75
1322  007f cd0000        	call	_assert_failed
1324  0082 5b04          	addw	sp,#4
1325  0084               L461:
1326                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1328  0084 c650c3        	ld	a,20675
1329  0087 6b01          	ld	(OFST-3,sp),a
1330                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1332  0089 7b05          	ld	a,(OFST+1,sp)
1333  008b a101          	cp	a,#1
1334  008d 2639          	jrne	L744
1335                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1337  008f 721250c5      	bset	20677,#1
1338                     ; 343         if (ITState != DISABLE)
1340  0093 0d09          	tnz	(OFST+5,sp)
1341  0095 2706          	jreq	L154
1342                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1344  0097 721450c5      	bset	20677,#2
1346  009b 2004          	jra	L354
1347  009d               L154:
1348                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1350  009d 721550c5      	bres	20677,#2
1351  00a1               L354:
1352                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1354  00a1 7b06          	ld	a,(OFST+2,sp)
1355  00a3 c750c4        	ld	20676,a
1357  00a6 2007          	jra	L164
1358  00a8               L554:
1359                     ; 357             DownCounter--;
1361  00a8 1e03          	ldw	x,(OFST-1,sp)
1362  00aa 1d0001        	subw	x,#1
1363  00ad 1f03          	ldw	(OFST-1,sp),x
1364  00af               L164:
1365                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1367  00af c650c5        	ld	a,20677
1368  00b2 a501          	bcp	a,#1
1369  00b4 2704          	jreq	L564
1371  00b6 1e03          	ldw	x,(OFST-1,sp)
1372  00b8 26ee          	jrne	L554
1373  00ba               L564:
1374                     ; 360         if (DownCounter != 0)
1376  00ba 1e03          	ldw	x,(OFST-1,sp)
1377  00bc 2706          	jreq	L764
1378                     ; 362             Swif = SUCCESS;
1380  00be a601          	ld	a,#1
1381  00c0 6b02          	ld	(OFST-2,sp),a
1383  00c2 201b          	jra	L374
1384  00c4               L764:
1385                     ; 366             Swif = ERROR;
1387  00c4 0f02          	clr	(OFST-2,sp)
1388  00c6 2017          	jra	L374
1389  00c8               L744:
1390                     ; 374         if (ITState != DISABLE)
1392  00c8 0d09          	tnz	(OFST+5,sp)
1393  00ca 2706          	jreq	L574
1394                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1396  00cc 721450c5      	bset	20677,#2
1398  00d0 2004          	jra	L774
1399  00d2               L574:
1400                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1402  00d2 721550c5      	bres	20677,#2
1403  00d6               L774:
1404                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1406  00d6 7b06          	ld	a,(OFST+2,sp)
1407  00d8 c750c4        	ld	20676,a
1408                     ; 388         Swif = SUCCESS;
1410  00db a601          	ld	a,#1
1411  00dd 6b02          	ld	(OFST-2,sp),a
1412  00df               L374:
1413                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1415  00df 0d0a          	tnz	(OFST+6,sp)
1416  00e1 260c          	jrne	L105
1418  00e3 7b01          	ld	a,(OFST-3,sp)
1419  00e5 a1e1          	cp	a,#225
1420  00e7 2606          	jrne	L105
1421                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1423  00e9 721150c0      	bres	20672,#0
1425  00ed 201e          	jra	L305
1426  00ef               L105:
1427                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1429  00ef 0d0a          	tnz	(OFST+6,sp)
1430  00f1 260c          	jrne	L505
1432  00f3 7b01          	ld	a,(OFST-3,sp)
1433  00f5 a1d2          	cp	a,#210
1434  00f7 2606          	jrne	L505
1435                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1437  00f9 721750c0      	bres	20672,#3
1439  00fd 200e          	jra	L305
1440  00ff               L505:
1441                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1443  00ff 0d0a          	tnz	(OFST+6,sp)
1444  0101 260a          	jrne	L305
1446  0103 7b01          	ld	a,(OFST-3,sp)
1447  0105 a1b4          	cp	a,#180
1448  0107 2604          	jrne	L305
1449                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1451  0109 721150c1      	bres	20673,#0
1452  010d               L305:
1453                     ; 406     return(Swif);
1455  010d 7b02          	ld	a,(OFST-2,sp)
1458  010f 5b06          	addw	sp,#6
1459  0111 81            	ret
1598                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1598                     ; 417 {
1599                     .text:	section	.text,new
1600  0000               _CLK_HSIPrescalerConfig:
1602  0000 88            	push	a
1603       00000000      OFST:	set	0
1606                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1608  0001 4d            	tnz	a
1609  0002 270c          	jreq	L271
1610  0004 a108          	cp	a,#8
1611  0006 2708          	jreq	L271
1612  0008 a110          	cp	a,#16
1613  000a 2704          	jreq	L271
1614  000c a118          	cp	a,#24
1615  000e 2603          	jrne	L071
1616  0010               L271:
1617  0010 4f            	clr	a
1618  0011 2010          	jra	L471
1619  0013               L071:
1620  0013 ae01a4        	ldw	x,#420
1621  0016 89            	pushw	x
1622  0017 ae0000        	ldw	x,#0
1623  001a 89            	pushw	x
1624  001b ae000c        	ldw	x,#L75
1625  001e cd0000        	call	_assert_failed
1627  0021 5b04          	addw	sp,#4
1628  0023               L471:
1629                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1631  0023 c650c6        	ld	a,20678
1632  0026 a4e7          	and	a,#231
1633  0028 c750c6        	ld	20678,a
1634                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1636  002b c650c6        	ld	a,20678
1637  002e 1a01          	or	a,(OFST+1,sp)
1638  0030 c750c6        	ld	20678,a
1639                     ; 428 }
1642  0033 84            	pop	a
1643  0034 81            	ret
1779                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1779                     ; 440 {
1780                     .text:	section	.text,new
1781  0000               _CLK_CCOConfig:
1783  0000 88            	push	a
1784       00000000      OFST:	set	0
1787                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1789  0001 4d            	tnz	a
1790  0002 2730          	jreq	L202
1791  0004 a104          	cp	a,#4
1792  0006 272c          	jreq	L202
1793  0008 a102          	cp	a,#2
1794  000a 2728          	jreq	L202
1795  000c a108          	cp	a,#8
1796  000e 2724          	jreq	L202
1797  0010 a10a          	cp	a,#10
1798  0012 2720          	jreq	L202
1799  0014 a10c          	cp	a,#12
1800  0016 271c          	jreq	L202
1801  0018 a10e          	cp	a,#14
1802  001a 2718          	jreq	L202
1803  001c a110          	cp	a,#16
1804  001e 2714          	jreq	L202
1805  0020 a112          	cp	a,#18
1806  0022 2710          	jreq	L202
1807  0024 a114          	cp	a,#20
1808  0026 270c          	jreq	L202
1809  0028 a116          	cp	a,#22
1810  002a 2708          	jreq	L202
1811  002c a118          	cp	a,#24
1812  002e 2704          	jreq	L202
1813  0030 a11a          	cp	a,#26
1814  0032 2603          	jrne	L002
1815  0034               L202:
1816  0034 4f            	clr	a
1817  0035 2010          	jra	L402
1818  0037               L002:
1819  0037 ae01bb        	ldw	x,#443
1820  003a 89            	pushw	x
1821  003b ae0000        	ldw	x,#0
1822  003e 89            	pushw	x
1823  003f ae000c        	ldw	x,#L75
1824  0042 cd0000        	call	_assert_failed
1826  0045 5b04          	addw	sp,#4
1827  0047               L402:
1828                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1830  0047 c650c9        	ld	a,20681
1831  004a a4e1          	and	a,#225
1832  004c c750c9        	ld	20681,a
1833                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1835  004f c650c9        	ld	a,20681
1836  0052 1a01          	or	a,(OFST+1,sp)
1837  0054 c750c9        	ld	20681,a
1838                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1840  0057 721050c9      	bset	20681,#0
1841                     ; 454 }
1844  005b 84            	pop	a
1845  005c 81            	ret
1911                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1911                     ; 465 {
1912                     .text:	section	.text,new
1913  0000               _CLK_ITConfig:
1915  0000 89            	pushw	x
1916       00000000      OFST:	set	0
1919                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1921  0001 9f            	ld	a,xl
1922  0002 4d            	tnz	a
1923  0003 2705          	jreq	L212
1924  0005 9f            	ld	a,xl
1925  0006 a101          	cp	a,#1
1926  0008 2603          	jrne	L012
1927  000a               L212:
1928  000a 4f            	clr	a
1929  000b 2010          	jra	L412
1930  000d               L012:
1931  000d ae01d4        	ldw	x,#468
1932  0010 89            	pushw	x
1933  0011 ae0000        	ldw	x,#0
1934  0014 89            	pushw	x
1935  0015 ae000c        	ldw	x,#L75
1936  0018 cd0000        	call	_assert_failed
1938  001b 5b04          	addw	sp,#4
1939  001d               L412:
1940                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1942  001d 7b01          	ld	a,(OFST+1,sp)
1943  001f a10c          	cp	a,#12
1944  0021 2706          	jreq	L022
1945  0023 7b01          	ld	a,(OFST+1,sp)
1946  0025 a11c          	cp	a,#28
1947  0027 2603          	jrne	L612
1948  0029               L022:
1949  0029 4f            	clr	a
1950  002a 2010          	jra	L222
1951  002c               L612:
1952  002c ae01d5        	ldw	x,#469
1953  002f 89            	pushw	x
1954  0030 ae0000        	ldw	x,#0
1955  0033 89            	pushw	x
1956  0034 ae000c        	ldw	x,#L75
1957  0037 cd0000        	call	_assert_failed
1959  003a 5b04          	addw	sp,#4
1960  003c               L222:
1961                     ; 471     if (NewState != DISABLE)
1963  003c 0d02          	tnz	(OFST+2,sp)
1964  003e 271a          	jreq	L707
1965                     ; 473         switch (CLK_IT)
1967  0040 7b01          	ld	a,(OFST+1,sp)
1969                     ; 481         default:
1969                     ; 482             break;
1970  0042 a00c          	sub	a,#12
1971  0044 270a          	jreq	L346
1972  0046 a010          	sub	a,#16
1973  0048 2624          	jrne	L517
1974                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1974                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1976  004a 721450c5      	bset	20677,#2
1977                     ; 477             break;
1979  004e 201e          	jra	L517
1980  0050               L346:
1981                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1981                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1983  0050 721450c8      	bset	20680,#2
1984                     ; 480             break;
1986  0054 2018          	jra	L517
1987  0056               L546:
1988                     ; 481         default:
1988                     ; 482             break;
1990  0056 2016          	jra	L517
1991  0058               L317:
1993  0058 2014          	jra	L517
1994  005a               L707:
1995                     ; 487         switch (CLK_IT)
1997  005a 7b01          	ld	a,(OFST+1,sp)
1999                     ; 495         default:
1999                     ; 496             break;
2000  005c a00c          	sub	a,#12
2001  005e 270a          	jreq	L156
2002  0060 a010          	sub	a,#16
2003  0062 260a          	jrne	L517
2004                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
2004                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
2006  0064 721550c5      	bres	20677,#2
2007                     ; 491             break;
2009  0068 2004          	jra	L517
2010  006a               L156:
2011                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
2011                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
2013  006a 721550c8      	bres	20680,#2
2014                     ; 494             break;
2015  006e               L517:
2016                     ; 500 }
2019  006e 85            	popw	x
2020  006f 81            	ret
2021  0070               L356:
2022                     ; 495         default:
2022                     ; 496             break;
2024  0070 20fc          	jra	L517
2025  0072               L127:
2026  0072 20fa          	jra	L517
2062                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
2062                     ; 508 {
2063                     .text:	section	.text,new
2064  0000               _CLK_SYSCLKConfig:
2066  0000 88            	push	a
2067       00000000      OFST:	set	0
2070                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
2072  0001 4d            	tnz	a
2073  0002 272c          	jreq	L032
2074  0004 a108          	cp	a,#8
2075  0006 2728          	jreq	L032
2076  0008 a110          	cp	a,#16
2077  000a 2724          	jreq	L032
2078  000c a118          	cp	a,#24
2079  000e 2720          	jreq	L032
2080  0010 a180          	cp	a,#128
2081  0012 271c          	jreq	L032
2082  0014 a181          	cp	a,#129
2083  0016 2718          	jreq	L032
2084  0018 a182          	cp	a,#130
2085  001a 2714          	jreq	L032
2086  001c a183          	cp	a,#131
2087  001e 2710          	jreq	L032
2088  0020 a184          	cp	a,#132
2089  0022 270c          	jreq	L032
2090  0024 a185          	cp	a,#133
2091  0026 2708          	jreq	L032
2092  0028 a186          	cp	a,#134
2093  002a 2704          	jreq	L032
2094  002c a187          	cp	a,#135
2095  002e 2603          	jrne	L622
2096  0030               L032:
2097  0030 4f            	clr	a
2098  0031 2010          	jra	L232
2099  0033               L622:
2100  0033 ae01ff        	ldw	x,#511
2101  0036 89            	pushw	x
2102  0037 ae0000        	ldw	x,#0
2103  003a 89            	pushw	x
2104  003b ae000c        	ldw	x,#L75
2105  003e cd0000        	call	_assert_failed
2107  0041 5b04          	addw	sp,#4
2108  0043               L232:
2109                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2111  0043 7b01          	ld	a,(OFST+1,sp)
2112  0045 a580          	bcp	a,#128
2113  0047 2614          	jrne	L147
2114                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2116  0049 c650c6        	ld	a,20678
2117  004c a4e7          	and	a,#231
2118  004e c750c6        	ld	20678,a
2119                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2121  0051 7b01          	ld	a,(OFST+1,sp)
2122  0053 a418          	and	a,#24
2123  0055 ca50c6        	or	a,20678
2124  0058 c750c6        	ld	20678,a
2126  005b 2012          	jra	L347
2127  005d               L147:
2128                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2130  005d c650c6        	ld	a,20678
2131  0060 a4f8          	and	a,#248
2132  0062 c750c6        	ld	20678,a
2133                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2135  0065 7b01          	ld	a,(OFST+1,sp)
2136  0067 a407          	and	a,#7
2137  0069 ca50c6        	or	a,20678
2138  006c c750c6        	ld	20678,a
2139  006f               L347:
2140                     ; 524 }
2143  006f 84            	pop	a
2144  0070 81            	ret
2201                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2201                     ; 532 {
2202                     .text:	section	.text,new
2203  0000               _CLK_SWIMConfig:
2205  0000 88            	push	a
2206       00000000      OFST:	set	0
2209                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2211  0001 4d            	tnz	a
2212  0002 2704          	jreq	L042
2213  0004 a101          	cp	a,#1
2214  0006 2603          	jrne	L632
2215  0008               L042:
2216  0008 4f            	clr	a
2217  0009 2010          	jra	L242
2218  000b               L632:
2219  000b ae0217        	ldw	x,#535
2220  000e 89            	pushw	x
2221  000f ae0000        	ldw	x,#0
2222  0012 89            	pushw	x
2223  0013 ae000c        	ldw	x,#L75
2224  0016 cd0000        	call	_assert_failed
2226  0019 5b04          	addw	sp,#4
2227  001b               L242:
2228                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2230  001b 0d01          	tnz	(OFST+1,sp)
2231  001d 2706          	jreq	L377
2232                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2234  001f 721050cd      	bset	20685,#0
2236  0023 2004          	jra	L577
2237  0025               L377:
2238                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2240  0025 721150cd      	bres	20685,#0
2241  0029               L577:
2242                     ; 548 }
2245  0029 84            	pop	a
2246  002a 81            	ret
2270                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2270                     ; 558 {
2271                     .text:	section	.text,new
2272  0000               _CLK_ClockSecuritySystemEnable:
2276                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2278  0000 721050c8      	bset	20680,#0
2279                     ; 561 }
2282  0004 81            	ret
2307                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2307                     ; 570 {
2308                     .text:	section	.text,new
2309  0000               _CLK_GetSYSCLKSource:
2313                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2315  0000 c650c3        	ld	a,20675
2318  0003 81            	ret
2381                     ; 579 uint32_t CLK_GetClockFreq(void)
2381                     ; 580 {
2382                     .text:	section	.text,new
2383  0000               _CLK_GetClockFreq:
2385  0000 5209          	subw	sp,#9
2386       00000009      OFST:	set	9
2389                     ; 582     uint32_t clockfrequency = 0;
2391                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2393                     ; 584     uint8_t tmp = 0, presc = 0;
2397                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2399  0002 c650c3        	ld	a,20675
2400  0005 6b09          	ld	(OFST+0,sp),a
2401                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2403  0007 7b09          	ld	a,(OFST+0,sp)
2404  0009 a1e1          	cp	a,#225
2405  000b 2641          	jrne	L1501
2406                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2408  000d c650c6        	ld	a,20678
2409  0010 a418          	and	a,#24
2410  0012 6b09          	ld	(OFST+0,sp),a
2411                     ; 592         tmp = (uint8_t)(tmp >> 3);
2413  0014 0409          	srl	(OFST+0,sp)
2414  0016 0409          	srl	(OFST+0,sp)
2415  0018 0409          	srl	(OFST+0,sp)
2416                     ; 593         presc = HSIDivFactor[tmp];
2418  001a 7b09          	ld	a,(OFST+0,sp)
2419  001c 5f            	clrw	x
2420  001d 97            	ld	xl,a
2421  001e d60000        	ld	a,(_HSIDivFactor,x)
2422  0021 6b09          	ld	(OFST+0,sp),a
2423                     ; 594         clockfrequency = HSI_VALUE / presc;
2425  0023 7b09          	ld	a,(OFST+0,sp)
2426  0025 b703          	ld	c_lreg+3,a
2427  0027 3f02          	clr	c_lreg+2
2428  0029 3f01          	clr	c_lreg+1
2429  002b 3f00          	clr	c_lreg
2430  002d 96            	ldw	x,sp
2431  002e 1c0001        	addw	x,#OFST-8
2432  0031 cd0000        	call	c_rtol
2434  0034 ae2400        	ldw	x,#9216
2435  0037 bf02          	ldw	c_lreg+2,x
2436  0039 ae00f4        	ldw	x,#244
2437  003c bf00          	ldw	c_lreg,x
2438  003e 96            	ldw	x,sp
2439  003f 1c0001        	addw	x,#OFST-8
2440  0042 cd0000        	call	c_ludv
2442  0045 96            	ldw	x,sp
2443  0046 1c0005        	addw	x,#OFST-4
2444  0049 cd0000        	call	c_rtol
2447  004c 201c          	jra	L3501
2448  004e               L1501:
2449                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2451  004e 7b09          	ld	a,(OFST+0,sp)
2452  0050 a1d2          	cp	a,#210
2453  0052 260c          	jrne	L5501
2454                     ; 598         clockfrequency = LSI_VALUE;
2456  0054 aef400        	ldw	x,#62464
2457  0057 1f07          	ldw	(OFST-2,sp),x
2458  0059 ae0001        	ldw	x,#1
2459  005c 1f05          	ldw	(OFST-4,sp),x
2461  005e 200a          	jra	L3501
2462  0060               L5501:
2463                     ; 602         clockfrequency = HSE_VALUE;
2465  0060 ae2400        	ldw	x,#9216
2466  0063 1f07          	ldw	(OFST-2,sp),x
2467  0065 ae00f4        	ldw	x,#244
2468  0068 1f05          	ldw	(OFST-4,sp),x
2469  006a               L3501:
2470                     ; 605     return((uint32_t)clockfrequency);
2472  006a 96            	ldw	x,sp
2473  006b 1c0005        	addw	x,#OFST-4
2474  006e cd0000        	call	c_ltor
2478  0071 5b09          	addw	sp,#9
2479  0073 81            	ret
2579                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2579                     ; 617 {
2580                     .text:	section	.text,new
2581  0000               _CLK_AdjustHSICalibrationValue:
2583  0000 88            	push	a
2584       00000000      OFST:	set	0
2587                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2589  0001 4d            	tnz	a
2590  0002 271c          	jreq	L652
2591  0004 a101          	cp	a,#1
2592  0006 2718          	jreq	L652
2593  0008 a102          	cp	a,#2
2594  000a 2714          	jreq	L652
2595  000c a103          	cp	a,#3
2596  000e 2710          	jreq	L652
2597  0010 a104          	cp	a,#4
2598  0012 270c          	jreq	L652
2599  0014 a105          	cp	a,#5
2600  0016 2708          	jreq	L652
2601  0018 a106          	cp	a,#6
2602  001a 2704          	jreq	L652
2603  001c a107          	cp	a,#7
2604  001e 2603          	jrne	L452
2605  0020               L652:
2606  0020 4f            	clr	a
2607  0021 2010          	jra	L062
2608  0023               L452:
2609  0023 ae026c        	ldw	x,#620
2610  0026 89            	pushw	x
2611  0027 ae0000        	ldw	x,#0
2612  002a 89            	pushw	x
2613  002b ae000c        	ldw	x,#L75
2614  002e cd0000        	call	_assert_failed
2616  0031 5b04          	addw	sp,#4
2617  0033               L062:
2618                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2620  0033 c650cc        	ld	a,20684
2621  0036 a4f8          	and	a,#248
2622  0038 1a01          	or	a,(OFST+1,sp)
2623  003a c750cc        	ld	20684,a
2624                     ; 625 }
2627  003d 84            	pop	a
2628  003e 81            	ret
2652                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2652                     ; 637 {
2653                     .text:	section	.text,new
2654  0000               _CLK_SYSCLKEmergencyClear:
2658                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2660  0000 721150c5      	bres	20677,#0
2661                     ; 639 }
2664  0004 81            	ret
2818                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2818                     ; 649 {
2819                     .text:	section	.text,new
2820  0000               _CLK_GetFlagStatus:
2822  0000 89            	pushw	x
2823  0001 5203          	subw	sp,#3
2824       00000003      OFST:	set	3
2827                     ; 651     uint16_t statusreg = 0;
2829                     ; 652     uint8_t tmpreg = 0;
2831                     ; 653     FlagStatus bitstatus = RESET;
2833                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2835  0003 a30110        	cpw	x,#272
2836  0006 2728          	jreq	L072
2837  0008 a30102        	cpw	x,#258
2838  000b 2723          	jreq	L072
2839  000d a30202        	cpw	x,#514
2840  0010 271e          	jreq	L072
2841  0012 a30308        	cpw	x,#776
2842  0015 2719          	jreq	L072
2843  0017 a30301        	cpw	x,#769
2844  001a 2714          	jreq	L072
2845  001c a30408        	cpw	x,#1032
2846  001f 270f          	jreq	L072
2847  0021 a30402        	cpw	x,#1026
2848  0024 270a          	jreq	L072
2849  0026 a30504        	cpw	x,#1284
2850  0029 2705          	jreq	L072
2851  002b a30502        	cpw	x,#1282
2852  002e 2603          	jrne	L662
2853  0030               L072:
2854  0030 4f            	clr	a
2855  0031 2010          	jra	L272
2856  0033               L662:
2857  0033 ae0290        	ldw	x,#656
2858  0036 89            	pushw	x
2859  0037 ae0000        	ldw	x,#0
2860  003a 89            	pushw	x
2861  003b ae000c        	ldw	x,#L75
2862  003e cd0000        	call	_assert_failed
2864  0041 5b04          	addw	sp,#4
2865  0043               L272:
2866                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2868  0043 7b04          	ld	a,(OFST+1,sp)
2869  0045 97            	ld	xl,a
2870  0046 7b05          	ld	a,(OFST+2,sp)
2871  0048 9f            	ld	a,xl
2872  0049 a4ff          	and	a,#255
2873  004b 97            	ld	xl,a
2874  004c 4f            	clr	a
2875  004d 02            	rlwa	x,a
2876  004e 1f01          	ldw	(OFST-2,sp),x
2877  0050 01            	rrwa	x,a
2878                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2880  0051 1e01          	ldw	x,(OFST-2,sp)
2881  0053 a30100        	cpw	x,#256
2882  0056 2607          	jrne	L3221
2883                     ; 664         tmpreg = CLK->ICKR;
2885  0058 c650c0        	ld	a,20672
2886  005b 6b03          	ld	(OFST+0,sp),a
2888  005d 202f          	jra	L5221
2889  005f               L3221:
2890                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2892  005f 1e01          	ldw	x,(OFST-2,sp)
2893  0061 a30200        	cpw	x,#512
2894  0064 2607          	jrne	L7221
2895                     ; 668         tmpreg = CLK->ECKR;
2897  0066 c650c1        	ld	a,20673
2898  0069 6b03          	ld	(OFST+0,sp),a
2900  006b 2021          	jra	L5221
2901  006d               L7221:
2902                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2904  006d 1e01          	ldw	x,(OFST-2,sp)
2905  006f a30300        	cpw	x,#768
2906  0072 2607          	jrne	L3321
2907                     ; 672         tmpreg = CLK->SWCR;
2909  0074 c650c5        	ld	a,20677
2910  0077 6b03          	ld	(OFST+0,sp),a
2912  0079 2013          	jra	L5221
2913  007b               L3321:
2914                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2916  007b 1e01          	ldw	x,(OFST-2,sp)
2917  007d a30400        	cpw	x,#1024
2918  0080 2607          	jrne	L7321
2919                     ; 676         tmpreg = CLK->CSSR;
2921  0082 c650c8        	ld	a,20680
2922  0085 6b03          	ld	(OFST+0,sp),a
2924  0087 2005          	jra	L5221
2925  0089               L7321:
2926                     ; 680         tmpreg = CLK->CCOR;
2928  0089 c650c9        	ld	a,20681
2929  008c 6b03          	ld	(OFST+0,sp),a
2930  008e               L5221:
2931                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2933  008e 7b05          	ld	a,(OFST+2,sp)
2934  0090 1503          	bcp	a,(OFST+0,sp)
2935  0092 2706          	jreq	L3421
2936                     ; 685         bitstatus = SET;
2938  0094 a601          	ld	a,#1
2939  0096 6b03          	ld	(OFST+0,sp),a
2941  0098 2002          	jra	L5421
2942  009a               L3421:
2943                     ; 689         bitstatus = RESET;
2945  009a 0f03          	clr	(OFST+0,sp)
2946  009c               L5421:
2947                     ; 693     return((FlagStatus)bitstatus);
2949  009c 7b03          	ld	a,(OFST+0,sp)
2952  009e 5b05          	addw	sp,#5
2953  00a0 81            	ret
3000                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
3000                     ; 704 {
3001                     .text:	section	.text,new
3002  0000               _CLK_GetITStatus:
3004  0000 88            	push	a
3005  0001 88            	push	a
3006       00000001      OFST:	set	1
3009                     ; 706     ITStatus bitstatus = RESET;
3011                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
3013  0002 a10c          	cp	a,#12
3014  0004 2704          	jreq	L003
3015  0006 a11c          	cp	a,#28
3016  0008 2603          	jrne	L672
3017  000a               L003:
3018  000a 4f            	clr	a
3019  000b 2010          	jra	L203
3020  000d               L672:
3021  000d ae02c5        	ldw	x,#709
3022  0010 89            	pushw	x
3023  0011 ae0000        	ldw	x,#0
3024  0014 89            	pushw	x
3025  0015 ae000c        	ldw	x,#L75
3026  0018 cd0000        	call	_assert_failed
3028  001b 5b04          	addw	sp,#4
3029  001d               L203:
3030                     ; 711     if (CLK_IT == CLK_IT_SWIF)
3032  001d 7b02          	ld	a,(OFST+1,sp)
3033  001f a11c          	cp	a,#28
3034  0021 2613          	jrne	L1721
3035                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3037  0023 c650c5        	ld	a,20677
3038  0026 1402          	and	a,(OFST+1,sp)
3039  0028 a10c          	cp	a,#12
3040  002a 2606          	jrne	L3721
3041                     ; 716             bitstatus = SET;
3043  002c a601          	ld	a,#1
3044  002e 6b01          	ld	(OFST+0,sp),a
3046  0030 2015          	jra	L7721
3047  0032               L3721:
3048                     ; 720             bitstatus = RESET;
3050  0032 0f01          	clr	(OFST+0,sp)
3051  0034 2011          	jra	L7721
3052  0036               L1721:
3053                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3055  0036 c650c8        	ld	a,20680
3056  0039 1402          	and	a,(OFST+1,sp)
3057  003b a10c          	cp	a,#12
3058  003d 2606          	jrne	L1031
3059                     ; 728             bitstatus = SET;
3061  003f a601          	ld	a,#1
3062  0041 6b01          	ld	(OFST+0,sp),a
3064  0043 2002          	jra	L7721
3065  0045               L1031:
3066                     ; 732             bitstatus = RESET;
3068  0045 0f01          	clr	(OFST+0,sp)
3069  0047               L7721:
3070                     ; 737     return bitstatus;
3072  0047 7b01          	ld	a,(OFST+0,sp)
3075  0049 85            	popw	x
3076  004a 81            	ret
3113                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
3113                     ; 748 {
3114                     .text:	section	.text,new
3115  0000               _CLK_ClearITPendingBit:
3117  0000 88            	push	a
3118       00000000      OFST:	set	0
3121                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
3123  0001 a10c          	cp	a,#12
3124  0003 2704          	jreq	L013
3125  0005 a11c          	cp	a,#28
3126  0007 2603          	jrne	L603
3127  0009               L013:
3128  0009 4f            	clr	a
3129  000a 2010          	jra	L213
3130  000c               L603:
3131  000c ae02ef        	ldw	x,#751
3132  000f 89            	pushw	x
3133  0010 ae0000        	ldw	x,#0
3134  0013 89            	pushw	x
3135  0014 ae000c        	ldw	x,#L75
3136  0017 cd0000        	call	_assert_failed
3138  001a 5b04          	addw	sp,#4
3139  001c               L213:
3140                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
3142  001c 7b01          	ld	a,(OFST+1,sp)
3143  001e a10c          	cp	a,#12
3144  0020 2606          	jrne	L3231
3145                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
3147  0022 721750c8      	bres	20680,#3
3149  0026 2004          	jra	L5231
3150  0028               L3231:
3151                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
3153  0028 721750c5      	bres	20677,#3
3154  002c               L5231:
3155                     ; 764 }
3158  002c 84            	pop	a
3159  002d 81            	ret
3194                     	xdef	_CLKPrescTable
3195                     	xdef	_HSIDivFactor
3196                     	xdef	_CLK_ClearITPendingBit
3197                     	xdef	_CLK_GetITStatus
3198                     	xdef	_CLK_GetFlagStatus
3199                     	xdef	_CLK_GetSYSCLKSource
3200                     	xdef	_CLK_GetClockFreq
3201                     	xdef	_CLK_AdjustHSICalibrationValue
3202                     	xdef	_CLK_SYSCLKEmergencyClear
3203                     	xdef	_CLK_ClockSecuritySystemEnable
3204                     	xdef	_CLK_SWIMConfig
3205                     	xdef	_CLK_SYSCLKConfig
3206                     	xdef	_CLK_ITConfig
3207                     	xdef	_CLK_CCOConfig
3208                     	xdef	_CLK_HSIPrescalerConfig
3209                     	xdef	_CLK_ClockSwitchConfig
3210                     	xdef	_CLK_PeripheralClockConfig
3211                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3212                     	xdef	_CLK_FastHaltWakeUpCmd
3213                     	xdef	_CLK_ClockSwitchCmd
3214                     	xdef	_CLK_CCOCmd
3215                     	xdef	_CLK_LSICmd
3216                     	xdef	_CLK_HSICmd
3217                     	xdef	_CLK_HSECmd
3218                     	xdef	_CLK_DeInit
3219                     	xref	_assert_failed
3220                     	switch	.const
3221  000c               L75:
3222  000c 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
3223  001e 697665725c73  	dc.b	"iver\src\stm8s_clk"
3224  0030 2e6300        	dc.b	".c",0
3225                     	xref.b	c_lreg
3226                     	xref.b	c_x
3246                     	xref	c_ltor
3247                     	xref	c_ludv
3248                     	xref	c_rtol
3249                     	end
