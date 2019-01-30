   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 44 void SPI_DeInit(void)
  44                     ; 45 {
  46                     .text:	section	.text,new
  47  0000               _SPI_DeInit:
  51                     ; 46     SPI->CR1    = SPI_CR1_RESET_VALUE;
  53  0000 725f5200      	clr	20992
  54                     ; 47     SPI->CR2    = SPI_CR2_RESET_VALUE;
  56  0004 725f5201      	clr	20993
  57                     ; 48     SPI->ICR    = SPI_ICR_RESET_VALUE;
  59  0008 725f5202      	clr	20994
  60                     ; 49     SPI->SR     = SPI_SR_RESET_VALUE;
  62  000c 35025203      	mov	20995,#2
  63                     ; 50     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  65  0010 35075205      	mov	20997,#7
  66                     ; 51 }
  69  0014 81            	ret
 386                     ; 72 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 386                     ; 73 {
 387                     .text:	section	.text,new
 388  0000               _SPI_Init:
 390  0000 89            	pushw	x
 391  0001 88            	push	a
 392       00000001      OFST:	set	1
 395                     ; 75     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 397  0002 9e            	ld	a,xh
 398  0003 4d            	tnz	a
 399  0004 2705          	jreq	L21
 400  0006 9e            	ld	a,xh
 401  0007 a180          	cp	a,#128
 402  0009 2603          	jrne	L01
 403  000b               L21:
 404  000b 4f            	clr	a
 405  000c 2010          	jra	L41
 406  000e               L01:
 407  000e ae004b        	ldw	x,#75
 408  0011 89            	pushw	x
 409  0012 ae0000        	ldw	x,#0
 410  0015 89            	pushw	x
 411  0016 ae0000        	ldw	x,#L302
 412  0019 cd0000        	call	_assert_failed
 414  001c 5b04          	addw	sp,#4
 415  001e               L41:
 416                     ; 76     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 418  001e 0d03          	tnz	(OFST+2,sp)
 419  0020 272a          	jreq	L02
 420  0022 7b03          	ld	a,(OFST+2,sp)
 421  0024 a108          	cp	a,#8
 422  0026 2724          	jreq	L02
 423  0028 7b03          	ld	a,(OFST+2,sp)
 424  002a a110          	cp	a,#16
 425  002c 271e          	jreq	L02
 426  002e 7b03          	ld	a,(OFST+2,sp)
 427  0030 a118          	cp	a,#24
 428  0032 2718          	jreq	L02
 429  0034 7b03          	ld	a,(OFST+2,sp)
 430  0036 a120          	cp	a,#32
 431  0038 2712          	jreq	L02
 432  003a 7b03          	ld	a,(OFST+2,sp)
 433  003c a128          	cp	a,#40
 434  003e 270c          	jreq	L02
 435  0040 7b03          	ld	a,(OFST+2,sp)
 436  0042 a130          	cp	a,#48
 437  0044 2706          	jreq	L02
 438  0046 7b03          	ld	a,(OFST+2,sp)
 439  0048 a138          	cp	a,#56
 440  004a 2603          	jrne	L61
 441  004c               L02:
 442  004c 4f            	clr	a
 443  004d 2010          	jra	L22
 444  004f               L61:
 445  004f ae004c        	ldw	x,#76
 446  0052 89            	pushw	x
 447  0053 ae0000        	ldw	x,#0
 448  0056 89            	pushw	x
 449  0057 ae0000        	ldw	x,#L302
 450  005a cd0000        	call	_assert_failed
 452  005d 5b04          	addw	sp,#4
 453  005f               L22:
 454                     ; 77     assert_param(IS_SPI_MODE_OK(Mode));
 456  005f 7b06          	ld	a,(OFST+5,sp)
 457  0061 a104          	cp	a,#4
 458  0063 2704          	jreq	L62
 459  0065 0d06          	tnz	(OFST+5,sp)
 460  0067 2603          	jrne	L42
 461  0069               L62:
 462  0069 4f            	clr	a
 463  006a 2010          	jra	L03
 464  006c               L42:
 465  006c ae004d        	ldw	x,#77
 466  006f 89            	pushw	x
 467  0070 ae0000        	ldw	x,#0
 468  0073 89            	pushw	x
 469  0074 ae0000        	ldw	x,#L302
 470  0077 cd0000        	call	_assert_failed
 472  007a 5b04          	addw	sp,#4
 473  007c               L03:
 474                     ; 78     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 476  007c 0d07          	tnz	(OFST+6,sp)
 477  007e 2706          	jreq	L43
 478  0080 7b07          	ld	a,(OFST+6,sp)
 479  0082 a102          	cp	a,#2
 480  0084 2603          	jrne	L23
 481  0086               L43:
 482  0086 4f            	clr	a
 483  0087 2010          	jra	L63
 484  0089               L23:
 485  0089 ae004e        	ldw	x,#78
 486  008c 89            	pushw	x
 487  008d ae0000        	ldw	x,#0
 488  0090 89            	pushw	x
 489  0091 ae0000        	ldw	x,#L302
 490  0094 cd0000        	call	_assert_failed
 492  0097 5b04          	addw	sp,#4
 493  0099               L63:
 494                     ; 79     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 496  0099 0d08          	tnz	(OFST+7,sp)
 497  009b 2706          	jreq	L24
 498  009d 7b08          	ld	a,(OFST+7,sp)
 499  009f a101          	cp	a,#1
 500  00a1 2603          	jrne	L04
 501  00a3               L24:
 502  00a3 4f            	clr	a
 503  00a4 2010          	jra	L44
 504  00a6               L04:
 505  00a6 ae004f        	ldw	x,#79
 506  00a9 89            	pushw	x
 507  00aa ae0000        	ldw	x,#0
 508  00ad 89            	pushw	x
 509  00ae ae0000        	ldw	x,#L302
 510  00b1 cd0000        	call	_assert_failed
 512  00b4 5b04          	addw	sp,#4
 513  00b6               L44:
 514                     ; 80     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 516  00b6 0d09          	tnz	(OFST+8,sp)
 517  00b8 2712          	jreq	L05
 518  00ba 7b09          	ld	a,(OFST+8,sp)
 519  00bc a104          	cp	a,#4
 520  00be 270c          	jreq	L05
 521  00c0 7b09          	ld	a,(OFST+8,sp)
 522  00c2 a180          	cp	a,#128
 523  00c4 2706          	jreq	L05
 524  00c6 7b09          	ld	a,(OFST+8,sp)
 525  00c8 a1c0          	cp	a,#192
 526  00ca 2603          	jrne	L64
 527  00cc               L05:
 528  00cc 4f            	clr	a
 529  00cd 2010          	jra	L25
 530  00cf               L64:
 531  00cf ae0050        	ldw	x,#80
 532  00d2 89            	pushw	x
 533  00d3 ae0000        	ldw	x,#0
 534  00d6 89            	pushw	x
 535  00d7 ae0000        	ldw	x,#L302
 536  00da cd0000        	call	_assert_failed
 538  00dd 5b04          	addw	sp,#4
 539  00df               L25:
 540                     ; 81     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 542  00df 7b0a          	ld	a,(OFST+9,sp)
 543  00e1 a102          	cp	a,#2
 544  00e3 2704          	jreq	L65
 545  00e5 0d0a          	tnz	(OFST+9,sp)
 546  00e7 2603          	jrne	L45
 547  00e9               L65:
 548  00e9 4f            	clr	a
 549  00ea 2010          	jra	L06
 550  00ec               L45:
 551  00ec ae0051        	ldw	x,#81
 552  00ef 89            	pushw	x
 553  00f0 ae0000        	ldw	x,#0
 554  00f3 89            	pushw	x
 555  00f4 ae0000        	ldw	x,#L302
 556  00f7 cd0000        	call	_assert_failed
 558  00fa 5b04          	addw	sp,#4
 559  00fc               L06:
 560                     ; 82     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 562  00fc 0d0b          	tnz	(OFST+10,sp)
 563  00fe 2703          	jreq	L26
 564  0100 4f            	clr	a
 565  0101 2010          	jra	L46
 566  0103               L26:
 567  0103 ae0052        	ldw	x,#82
 568  0106 89            	pushw	x
 569  0107 ae0000        	ldw	x,#0
 570  010a 89            	pushw	x
 571  010b ae0000        	ldw	x,#L302
 572  010e cd0000        	call	_assert_failed
 574  0111 5b04          	addw	sp,#4
 575  0113               L46:
 576                     ; 85     SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 576                     ; 86                     (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 578  0113 7b07          	ld	a,(OFST+6,sp)
 579  0115 1a08          	or	a,(OFST+7,sp)
 580  0117 6b01          	ld	(OFST+0,sp),a
 581  0119 7b02          	ld	a,(OFST+1,sp)
 582  011b 1a03          	or	a,(OFST+2,sp)
 583  011d 1a01          	or	a,(OFST+0,sp)
 584  011f c75200        	ld	20992,a
 585                     ; 89     SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 587  0122 7b09          	ld	a,(OFST+8,sp)
 588  0124 1a0a          	or	a,(OFST+9,sp)
 589  0126 c75201        	ld	20993,a
 590                     ; 91     if (Mode == SPI_MODE_MASTER)
 592  0129 7b06          	ld	a,(OFST+5,sp)
 593  012b a104          	cp	a,#4
 594  012d 2606          	jrne	L502
 595                     ; 93         SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 597  012f 72105201      	bset	20993,#0
 599  0133 2004          	jra	L702
 600  0135               L502:
 601                     ; 97         SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 603  0135 72115201      	bres	20993,#0
 604  0139               L702:
 605                     ; 101     SPI->CR1 |= (uint8_t)(Mode);
 607  0139 c65200        	ld	a,20992
 608  013c 1a06          	or	a,(OFST+5,sp)
 609  013e c75200        	ld	20992,a
 610                     ; 104     SPI->CRCPR = (uint8_t)CRCPolynomial;
 612  0141 7b0b          	ld	a,(OFST+10,sp)
 613  0143 c75205        	ld	20997,a
 614                     ; 105 }
 617  0146 5b03          	addw	sp,#3
 618  0148 81            	ret
 674                     ; 113 void SPI_Cmd(FunctionalState NewState)
 674                     ; 114 {
 675                     .text:	section	.text,new
 676  0000               _SPI_Cmd:
 678  0000 88            	push	a
 679       00000000      OFST:	set	0
 682                     ; 116     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 684  0001 4d            	tnz	a
 685  0002 2704          	jreq	L27
 686  0004 a101          	cp	a,#1
 687  0006 2603          	jrne	L07
 688  0008               L27:
 689  0008 4f            	clr	a
 690  0009 2010          	jra	L47
 691  000b               L07:
 692  000b ae0074        	ldw	x,#116
 693  000e 89            	pushw	x
 694  000f ae0000        	ldw	x,#0
 695  0012 89            	pushw	x
 696  0013 ae0000        	ldw	x,#L302
 697  0016 cd0000        	call	_assert_failed
 699  0019 5b04          	addw	sp,#4
 700  001b               L47:
 701                     ; 118     if (NewState != DISABLE)
 703  001b 0d01          	tnz	(OFST+1,sp)
 704  001d 2706          	jreq	L732
 705                     ; 120         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 707  001f 721c5200      	bset	20992,#6
 709  0023 2004          	jra	L142
 710  0025               L732:
 711                     ; 124         SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 713  0025 721d5200      	bres	20992,#6
 714  0029               L142:
 715                     ; 126 }
 718  0029 84            	pop	a
 719  002a 81            	ret
 829                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 829                     ; 136 {
 830                     .text:	section	.text,new
 831  0000               _SPI_ITConfig:
 833  0000 89            	pushw	x
 834  0001 88            	push	a
 835       00000001      OFST:	set	1
 838                     ; 137     uint8_t itpos = 0;
 840                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 842  0002 9e            	ld	a,xh
 843  0003 a117          	cp	a,#23
 844  0005 270f          	jreq	L201
 845  0007 9e            	ld	a,xh
 846  0008 a106          	cp	a,#6
 847  000a 270a          	jreq	L201
 848  000c 9e            	ld	a,xh
 849  000d a105          	cp	a,#5
 850  000f 2705          	jreq	L201
 851  0011 9e            	ld	a,xh
 852  0012 a134          	cp	a,#52
 853  0014 2603          	jrne	L001
 854  0016               L201:
 855  0016 4f            	clr	a
 856  0017 2010          	jra	L401
 857  0019               L001:
 858  0019 ae008b        	ldw	x,#139
 859  001c 89            	pushw	x
 860  001d ae0000        	ldw	x,#0
 861  0020 89            	pushw	x
 862  0021 ae0000        	ldw	x,#L302
 863  0024 cd0000        	call	_assert_failed
 865  0027 5b04          	addw	sp,#4
 866  0029               L401:
 867                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 869  0029 0d03          	tnz	(OFST+2,sp)
 870  002b 2706          	jreq	L011
 871  002d 7b03          	ld	a,(OFST+2,sp)
 872  002f a101          	cp	a,#1
 873  0031 2603          	jrne	L601
 874  0033               L011:
 875  0033 4f            	clr	a
 876  0034 2010          	jra	L211
 877  0036               L601:
 878  0036 ae008c        	ldw	x,#140
 879  0039 89            	pushw	x
 880  003a ae0000        	ldw	x,#0
 881  003d 89            	pushw	x
 882  003e ae0000        	ldw	x,#L302
 883  0041 cd0000        	call	_assert_failed
 885  0044 5b04          	addw	sp,#4
 886  0046               L211:
 887                     ; 143     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 889  0046 7b02          	ld	a,(OFST+1,sp)
 890  0048 a40f          	and	a,#15
 891  004a 5f            	clrw	x
 892  004b 97            	ld	xl,a
 893  004c a601          	ld	a,#1
 894  004e 5d            	tnzw	x
 895  004f 2704          	jreq	L411
 896  0051               L611:
 897  0051 48            	sll	a
 898  0052 5a            	decw	x
 899  0053 26fc          	jrne	L611
 900  0055               L411:
 901  0055 6b01          	ld	(OFST+0,sp),a
 902                     ; 145     if (NewState != DISABLE)
 904  0057 0d03          	tnz	(OFST+2,sp)
 905  0059 270a          	jreq	L313
 906                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 908  005b c65202        	ld	a,20994
 909  005e 1a01          	or	a,(OFST+0,sp)
 910  0060 c75202        	ld	20994,a
 912  0063 2009          	jra	L513
 913  0065               L313:
 914                     ; 151         SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 916  0065 7b01          	ld	a,(OFST+0,sp)
 917  0067 43            	cpl	a
 918  0068 c45202        	and	a,20994
 919  006b c75202        	ld	20994,a
 920  006e               L513:
 921                     ; 153 }
 924  006e 5b03          	addw	sp,#3
 925  0070 81            	ret
 959                     ; 159 void SPI_SendData(uint8_t Data)
 959                     ; 160 {
 960                     .text:	section	.text,new
 961  0000               _SPI_SendData:
 965                     ; 161     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 967  0000 c75204        	ld	20996,a
 968                     ; 162 }
 971  0003 81            	ret
 994                     ; 169 uint8_t SPI_ReceiveData(void)
 994                     ; 170 {
 995                     .text:	section	.text,new
 996  0000               _SPI_ReceiveData:
1000                     ; 171     return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
1002  0000 c65204        	ld	a,20996
1005  0003 81            	ret
1042                     ; 180 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
1042                     ; 181 {
1043                     .text:	section	.text,new
1044  0000               _SPI_NSSInternalSoftwareCmd:
1046  0000 88            	push	a
1047       00000000      OFST:	set	0
1050                     ; 183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1052  0001 4d            	tnz	a
1053  0002 2704          	jreq	L031
1054  0004 a101          	cp	a,#1
1055  0006 2603          	jrne	L621
1056  0008               L031:
1057  0008 4f            	clr	a
1058  0009 2010          	jra	L231
1059  000b               L621:
1060  000b ae00b7        	ldw	x,#183
1061  000e 89            	pushw	x
1062  000f ae0000        	ldw	x,#0
1063  0012 89            	pushw	x
1064  0013 ae0000        	ldw	x,#L302
1065  0016 cd0000        	call	_assert_failed
1067  0019 5b04          	addw	sp,#4
1068  001b               L231:
1069                     ; 185     if (NewState != DISABLE)
1071  001b 0d01          	tnz	(OFST+1,sp)
1072  001d 2706          	jreq	L363
1073                     ; 187         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
1075  001f 72105201      	bset	20993,#0
1077  0023 2004          	jra	L563
1078  0025               L363:
1079                     ; 191         SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
1081  0025 72115201      	bres	20993,#0
1082  0029               L563:
1083                     ; 193 }
1086  0029 84            	pop	a
1087  002a 81            	ret
1110                     ; 200 void SPI_TransmitCRC(void)
1110                     ; 201 {
1111                     .text:	section	.text,new
1112  0000               _SPI_TransmitCRC:
1116                     ; 202     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
1118  0000 72185201      	bset	20993,#4
1119                     ; 203 }
1122  0004 81            	ret
1159                     ; 211 void SPI_CalculateCRCCmd(FunctionalState NewState)
1159                     ; 212 {
1160                     .text:	section	.text,new
1161  0000               _SPI_CalculateCRCCmd:
1163  0000 88            	push	a
1164       00000000      OFST:	set	0
1167                     ; 214     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1169  0001 4d            	tnz	a
1170  0002 2704          	jreq	L241
1171  0004 a101          	cp	a,#1
1172  0006 2603          	jrne	L041
1173  0008               L241:
1174  0008 4f            	clr	a
1175  0009 2010          	jra	L441
1176  000b               L041:
1177  000b ae00d6        	ldw	x,#214
1178  000e 89            	pushw	x
1179  000f ae0000        	ldw	x,#0
1180  0012 89            	pushw	x
1181  0013 ae0000        	ldw	x,#L302
1182  0016 cd0000        	call	_assert_failed
1184  0019 5b04          	addw	sp,#4
1185  001b               L441:
1186                     ; 216     if (NewState != DISABLE)
1188  001b 0d01          	tnz	(OFST+1,sp)
1189  001d 2706          	jreq	L514
1190                     ; 218         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
1192  001f 721a5201      	bset	20993,#5
1194  0023 2004          	jra	L714
1195  0025               L514:
1196                     ; 222         SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
1198  0025 721b5201      	bres	20993,#5
1199  0029               L714:
1200                     ; 224 }
1203  0029 84            	pop	a
1204  002a 81            	ret
1269                     ; 231 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
1269                     ; 232 {
1270                     .text:	section	.text,new
1271  0000               _SPI_GetCRC:
1273  0000 88            	push	a
1274  0001 88            	push	a
1275       00000001      OFST:	set	1
1278                     ; 233     uint8_t crcreg = 0;
1280                     ; 236     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1282  0002 a101          	cp	a,#1
1283  0004 2703          	jreq	L251
1284  0006 4d            	tnz	a
1285  0007 2603          	jrne	L051
1286  0009               L251:
1287  0009 4f            	clr	a
1288  000a 2010          	jra	L451
1289  000c               L051:
1290  000c ae00ec        	ldw	x,#236
1291  000f 89            	pushw	x
1292  0010 ae0000        	ldw	x,#0
1293  0013 89            	pushw	x
1294  0014 ae0000        	ldw	x,#L302
1295  0017 cd0000        	call	_assert_failed
1297  001a 5b04          	addw	sp,#4
1298  001c               L451:
1299                     ; 238     if (SPI_CRC != SPI_CRC_RX)
1301  001c 0d02          	tnz	(OFST+1,sp)
1302  001e 2707          	jreq	L354
1303                     ; 240         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1305  0020 c65207        	ld	a,20999
1306  0023 6b01          	ld	(OFST+0,sp),a
1308  0025 2005          	jra	L554
1309  0027               L354:
1310                     ; 244         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1312  0027 c65206        	ld	a,20998
1313  002a 6b01          	ld	(OFST+0,sp),a
1314  002c               L554:
1315                     ; 248     return crcreg;
1317  002c 7b01          	ld	a,(OFST+0,sp)
1320  002e 85            	popw	x
1321  002f 81            	ret
1346                     ; 256 void SPI_ResetCRC(void)
1346                     ; 257 {
1347                     .text:	section	.text,new
1348  0000               _SPI_ResetCRC:
1352                     ; 260     SPI_CalculateCRCCmd(ENABLE);
1354  0000 a601          	ld	a,#1
1355  0002 cd0000        	call	_SPI_CalculateCRCCmd
1357                     ; 263     SPI_Cmd(ENABLE);
1359  0005 a601          	ld	a,#1
1360  0007 cd0000        	call	_SPI_Cmd
1362                     ; 264 }
1365  000a 81            	ret
1389                     ; 271 uint8_t SPI_GetCRCPolynomial(void)
1389                     ; 272 {
1390                     .text:	section	.text,new
1391  0000               _SPI_GetCRCPolynomial:
1395                     ; 273     return SPI->CRCPR; /* Return the CRC polynomial register */
1397  0000 c65205        	ld	a,20997
1400  0003 81            	ret
1457                     ; 281 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1457                     ; 282 {
1458                     .text:	section	.text,new
1459  0000               _SPI_BiDirectionalLineConfig:
1461  0000 88            	push	a
1462       00000000      OFST:	set	0
1465                     ; 284     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1467  0001 4d            	tnz	a
1468  0002 2704          	jreq	L661
1469  0004 a101          	cp	a,#1
1470  0006 2603          	jrne	L461
1471  0008               L661:
1472  0008 4f            	clr	a
1473  0009 2010          	jra	L071
1474  000b               L461:
1475  000b ae011c        	ldw	x,#284
1476  000e 89            	pushw	x
1477  000f ae0000        	ldw	x,#0
1478  0012 89            	pushw	x
1479  0013 ae0000        	ldw	x,#L302
1480  0016 cd0000        	call	_assert_failed
1482  0019 5b04          	addw	sp,#4
1483  001b               L071:
1484                     ; 286     if (SPI_Direction != SPI_DIRECTION_RX)
1486  001b 0d01          	tnz	(OFST+1,sp)
1487  001d 2706          	jreq	L525
1488                     ; 288         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1490  001f 721c5201      	bset	20993,#6
1492  0023 2004          	jra	L725
1493  0025               L525:
1494                     ; 292         SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1496  0025 721d5201      	bres	20993,#6
1497  0029               L725:
1498                     ; 294 }
1501  0029 84            	pop	a
1502  002a 81            	ret
1624                     ; 304 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1624                     ; 305 {
1625                     .text:	section	.text,new
1626  0000               _SPI_GetFlagStatus:
1628  0000 88            	push	a
1629  0001 88            	push	a
1630       00000001      OFST:	set	1
1633                     ; 306     FlagStatus status = RESET;
1635                     ; 308     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1637  0002 a140          	cp	a,#64
1638  0004 2718          	jreq	L671
1639  0006 a120          	cp	a,#32
1640  0008 2714          	jreq	L671
1641  000a a110          	cp	a,#16
1642  000c 2710          	jreq	L671
1643  000e a108          	cp	a,#8
1644  0010 270c          	jreq	L671
1645  0012 a102          	cp	a,#2
1646  0014 2708          	jreq	L671
1647  0016 a101          	cp	a,#1
1648  0018 2704          	jreq	L671
1649  001a a180          	cp	a,#128
1650  001c 2603          	jrne	L471
1651  001e               L671:
1652  001e 4f            	clr	a
1653  001f 2010          	jra	L002
1654  0021               L471:
1655  0021 ae0134        	ldw	x,#308
1656  0024 89            	pushw	x
1657  0025 ae0000        	ldw	x,#0
1658  0028 89            	pushw	x
1659  0029 ae0000        	ldw	x,#L302
1660  002c cd0000        	call	_assert_failed
1662  002f 5b04          	addw	sp,#4
1663  0031               L002:
1664                     ; 311     if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1666  0031 c65203        	ld	a,20995
1667  0034 1502          	bcp	a,(OFST+1,sp)
1668  0036 2706          	jreq	L506
1669                     ; 313         status = SET; /* SPI_FLAG is set */
1671  0038 a601          	ld	a,#1
1672  003a 6b01          	ld	(OFST+0,sp),a
1674  003c 2002          	jra	L706
1675  003e               L506:
1676                     ; 317         status = RESET; /* SPI_FLAG is reset*/
1678  003e 0f01          	clr	(OFST+0,sp)
1679  0040               L706:
1680                     ; 321     return status;
1682  0040 7b01          	ld	a,(OFST+0,sp)
1685  0042 85            	popw	x
1686  0043 81            	ret
1722                     ; 339 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1722                     ; 340 {
1723                     .text:	section	.text,new
1724  0000               _SPI_ClearFlag:
1726  0000 88            	push	a
1727       00000000      OFST:	set	0
1730                     ; 341     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1732  0001 a110          	cp	a,#16
1733  0003 2704          	jreq	L602
1734  0005 a108          	cp	a,#8
1735  0007 2603          	jrne	L402
1736  0009               L602:
1737  0009 4f            	clr	a
1738  000a 2010          	jra	L012
1739  000c               L402:
1740  000c ae0155        	ldw	x,#341
1741  000f 89            	pushw	x
1742  0010 ae0000        	ldw	x,#0
1743  0013 89            	pushw	x
1744  0014 ae0000        	ldw	x,#L302
1745  0017 cd0000        	call	_assert_failed
1747  001a 5b04          	addw	sp,#4
1748  001c               L012:
1749                     ; 343     SPI->SR = (uint8_t)(~SPI_FLAG);
1751  001c 7b01          	ld	a,(OFST+1,sp)
1752  001e 43            	cpl	a
1753  001f c75203        	ld	20995,a
1754                     ; 344 }
1757  0022 84            	pop	a
1758  0023 81            	ret
1841                     ; 359 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1841                     ; 360 {
1842                     .text:	section	.text,new
1843  0000               _SPI_GetITStatus:
1845  0000 88            	push	a
1846  0001 89            	pushw	x
1847       00000002      OFST:	set	2
1850                     ; 361     ITStatus pendingbitstatus = RESET;
1852                     ; 362     uint8_t itpos = 0;
1854                     ; 363     uint8_t itmask1 = 0;
1856                     ; 364     uint8_t itmask2 = 0;
1858                     ; 365     uint8_t enablestatus = 0;
1860                     ; 366     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1862  0002 a165          	cp	a,#101
1863  0004 2714          	jreq	L612
1864  0006 a155          	cp	a,#85
1865  0008 2710          	jreq	L612
1866  000a a145          	cp	a,#69
1867  000c 270c          	jreq	L612
1868  000e a134          	cp	a,#52
1869  0010 2708          	jreq	L612
1870  0012 a117          	cp	a,#23
1871  0014 2704          	jreq	L612
1872  0016 a106          	cp	a,#6
1873  0018 2603          	jrne	L412
1874  001a               L612:
1875  001a 4f            	clr	a
1876  001b 2010          	jra	L022
1877  001d               L412:
1878  001d ae016e        	ldw	x,#366
1879  0020 89            	pushw	x
1880  0021 ae0000        	ldw	x,#0
1881  0024 89            	pushw	x
1882  0025 ae0000        	ldw	x,#L302
1883  0028 cd0000        	call	_assert_failed
1885  002b 5b04          	addw	sp,#4
1886  002d               L022:
1887                     ; 368     itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1889  002d 7b03          	ld	a,(OFST+1,sp)
1890  002f a40f          	and	a,#15
1891  0031 5f            	clrw	x
1892  0032 97            	ld	xl,a
1893  0033 a601          	ld	a,#1
1894  0035 5d            	tnzw	x
1895  0036 2704          	jreq	L222
1896  0038               L422:
1897  0038 48            	sll	a
1898  0039 5a            	decw	x
1899  003a 26fc          	jrne	L422
1900  003c               L222:
1901  003c 6b01          	ld	(OFST-1,sp),a
1902                     ; 371     itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1904  003e 7b03          	ld	a,(OFST+1,sp)
1905  0040 4e            	swap	a
1906  0041 a40f          	and	a,#15
1907  0043 6b02          	ld	(OFST+0,sp),a
1908                     ; 373     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1910  0045 7b02          	ld	a,(OFST+0,sp)
1911  0047 5f            	clrw	x
1912  0048 97            	ld	xl,a
1913  0049 a601          	ld	a,#1
1914  004b 5d            	tnzw	x
1915  004c 2704          	jreq	L622
1916  004e               L032:
1917  004e 48            	sll	a
1918  004f 5a            	decw	x
1919  0050 26fc          	jrne	L032
1920  0052               L622:
1921  0052 6b02          	ld	(OFST+0,sp),a
1922                     ; 375     enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1924  0054 c65203        	ld	a,20995
1925  0057 1402          	and	a,(OFST+0,sp)
1926  0059 6b02          	ld	(OFST+0,sp),a
1927                     ; 377     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1929  005b c65202        	ld	a,20994
1930  005e 1501          	bcp	a,(OFST-1,sp)
1931  0060 270a          	jreq	L176
1933  0062 0d02          	tnz	(OFST+0,sp)
1934  0064 2706          	jreq	L176
1935                     ; 380         pendingbitstatus = SET;
1937  0066 a601          	ld	a,#1
1938  0068 6b02          	ld	(OFST+0,sp),a
1940  006a 2002          	jra	L376
1941  006c               L176:
1942                     ; 385         pendingbitstatus = RESET;
1944  006c 0f02          	clr	(OFST+0,sp)
1945  006e               L376:
1946                     ; 388     return  pendingbitstatus;
1948  006e 7b02          	ld	a,(OFST+0,sp)
1951  0070 5b03          	addw	sp,#3
1952  0072 81            	ret
1998                     ; 404 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1998                     ; 405 {
1999                     .text:	section	.text,new
2000  0000               _SPI_ClearITPendingBit:
2002  0000 88            	push	a
2003  0001 88            	push	a
2004       00000001      OFST:	set	1
2007                     ; 406     uint8_t itpos = 0;
2009                     ; 407     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
2011  0002 a145          	cp	a,#69
2012  0004 2704          	jreq	L632
2013  0006 a134          	cp	a,#52
2014  0008 2603          	jrne	L432
2015  000a               L632:
2016  000a 4f            	clr	a
2017  000b 2010          	jra	L042
2018  000d               L432:
2019  000d ae0197        	ldw	x,#407
2020  0010 89            	pushw	x
2021  0011 ae0000        	ldw	x,#0
2022  0014 89            	pushw	x
2023  0015 ae0000        	ldw	x,#L302
2024  0018 cd0000        	call	_assert_failed
2026  001b 5b04          	addw	sp,#4
2027  001d               L042:
2028                     ; 412     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
2030  001d 7b02          	ld	a,(OFST+1,sp)
2031  001f a4f0          	and	a,#240
2032  0021 4e            	swap	a
2033  0022 a40f          	and	a,#15
2034  0024 5f            	clrw	x
2035  0025 97            	ld	xl,a
2036  0026 a601          	ld	a,#1
2037  0028 5d            	tnzw	x
2038  0029 2704          	jreq	L242
2039  002b               L442:
2040  002b 48            	sll	a
2041  002c 5a            	decw	x
2042  002d 26fc          	jrne	L442
2043  002f               L242:
2044  002f 6b01          	ld	(OFST+0,sp),a
2045                     ; 414     SPI->SR = (uint8_t)(~itpos);
2047  0031 7b01          	ld	a,(OFST+0,sp)
2048  0033 43            	cpl	a
2049  0034 c75203        	ld	20995,a
2050                     ; 416 }
2053  0037 85            	popw	x
2054  0038 81            	ret
2067                     	xdef	_SPI_ClearITPendingBit
2068                     	xdef	_SPI_GetITStatus
2069                     	xdef	_SPI_ClearFlag
2070                     	xdef	_SPI_GetFlagStatus
2071                     	xdef	_SPI_BiDirectionalLineConfig
2072                     	xdef	_SPI_GetCRCPolynomial
2073                     	xdef	_SPI_ResetCRC
2074                     	xdef	_SPI_GetCRC
2075                     	xdef	_SPI_CalculateCRCCmd
2076                     	xdef	_SPI_TransmitCRC
2077                     	xdef	_SPI_NSSInternalSoftwareCmd
2078                     	xdef	_SPI_ReceiveData
2079                     	xdef	_SPI_SendData
2080                     	xdef	_SPI_ITConfig
2081                     	xdef	_SPI_Cmd
2082                     	xdef	_SPI_Init
2083                     	xdef	_SPI_DeInit
2084                     	xref	_assert_failed
2085                     .const:	section	.text
2086  0000               L302:
2087  0000 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
2088  0012 697665725c73  	dc.b	"iver\src\stm8s_spi"
2089  0024 2e6300        	dc.b	".c",0
2109                     	end
