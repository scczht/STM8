   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 47 void UART2_DeInit(void)
  44                     ; 48 {
  46                     .text:	section	.text,new
  47  0000               _UART2_DeInit:
  51                     ; 51     (void) UART2->SR;
  53  0000 c65240        	ld	a,21056
  54                     ; 52     (void)UART2->DR;
  56  0003 c65241        	ld	a,21057
  57                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  59  0006 725f5243      	clr	21059
  60                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  62  000a 725f5242      	clr	21058
  63                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  65  000e 725f5244      	clr	21060
  66                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  68  0012 725f5245      	clr	21061
  69                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  71  0016 725f5246      	clr	21062
  72                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  74  001a 725f5247      	clr	21063
  75                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  77  001e 725f5248      	clr	21064
  78                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  80  0022 725f5249      	clr	21065
  81                     ; 64 }
  84  0026 81            	ret
 406                     .const:	section	.text
 407  0000               L21:
 408  0000 00098969      	dc.l	625001
 409  0004               L25:
 410  0004 00000064      	dc.l	100
 411                     ; 80 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 411                     ; 81 {
 412                     .text:	section	.text,new
 413  0000               _UART2_Init:
 415  0000 520e          	subw	sp,#14
 416       0000000e      OFST:	set	14
 419                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 423                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 427                     ; 86     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 429  0002 96            	ldw	x,sp
 430  0003 1c0011        	addw	x,#OFST+3
 431  0006 cd0000        	call	c_ltor
 433  0009 ae0000        	ldw	x,#L21
 434  000c cd0000        	call	c_lcmp
 436  000f 2403          	jruge	L01
 437  0011 4f            	clr	a
 438  0012 2010          	jra	L41
 439  0014               L01:
 440  0014 ae0056        	ldw	x,#86
 441  0017 89            	pushw	x
 442  0018 ae0000        	ldw	x,#0
 443  001b 89            	pushw	x
 444  001c ae0008        	ldw	x,#L302
 445  001f cd0000        	call	_assert_failed
 447  0022 5b04          	addw	sp,#4
 448  0024               L41:
 449                     ; 87     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 451  0024 0d15          	tnz	(OFST+7,sp)
 452  0026 2706          	jreq	L02
 453  0028 7b15          	ld	a,(OFST+7,sp)
 454  002a a110          	cp	a,#16
 455  002c 2603          	jrne	L61
 456  002e               L02:
 457  002e 4f            	clr	a
 458  002f 2010          	jra	L22
 459  0031               L61:
 460  0031 ae0057        	ldw	x,#87
 461  0034 89            	pushw	x
 462  0035 ae0000        	ldw	x,#0
 463  0038 89            	pushw	x
 464  0039 ae0008        	ldw	x,#L302
 465  003c cd0000        	call	_assert_failed
 467  003f 5b04          	addw	sp,#4
 468  0041               L22:
 469                     ; 88     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 471  0041 0d16          	tnz	(OFST+8,sp)
 472  0043 2712          	jreq	L62
 473  0045 7b16          	ld	a,(OFST+8,sp)
 474  0047 a110          	cp	a,#16
 475  0049 270c          	jreq	L62
 476  004b 7b16          	ld	a,(OFST+8,sp)
 477  004d a120          	cp	a,#32
 478  004f 2706          	jreq	L62
 479  0051 7b16          	ld	a,(OFST+8,sp)
 480  0053 a130          	cp	a,#48
 481  0055 2603          	jrne	L42
 482  0057               L62:
 483  0057 4f            	clr	a
 484  0058 2010          	jra	L03
 485  005a               L42:
 486  005a ae0058        	ldw	x,#88
 487  005d 89            	pushw	x
 488  005e ae0000        	ldw	x,#0
 489  0061 89            	pushw	x
 490  0062 ae0008        	ldw	x,#L302
 491  0065 cd0000        	call	_assert_failed
 493  0068 5b04          	addw	sp,#4
 494  006a               L03:
 495                     ; 89     assert_param(IS_UART2_PARITY_OK(Parity));
 497  006a 0d17          	tnz	(OFST+9,sp)
 498  006c 270c          	jreq	L43
 499  006e 7b17          	ld	a,(OFST+9,sp)
 500  0070 a104          	cp	a,#4
 501  0072 2706          	jreq	L43
 502  0074 7b17          	ld	a,(OFST+9,sp)
 503  0076 a106          	cp	a,#6
 504  0078 2603          	jrne	L23
 505  007a               L43:
 506  007a 4f            	clr	a
 507  007b 2010          	jra	L63
 508  007d               L23:
 509  007d ae0059        	ldw	x,#89
 510  0080 89            	pushw	x
 511  0081 ae0000        	ldw	x,#0
 512  0084 89            	pushw	x
 513  0085 ae0008        	ldw	x,#L302
 514  0088 cd0000        	call	_assert_failed
 516  008b 5b04          	addw	sp,#4
 517  008d               L63:
 518                     ; 90     assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 520  008d 7b19          	ld	a,(OFST+11,sp)
 521  008f a108          	cp	a,#8
 522  0091 2730          	jreq	L24
 523  0093 7b19          	ld	a,(OFST+11,sp)
 524  0095 a140          	cp	a,#64
 525  0097 272a          	jreq	L24
 526  0099 7b19          	ld	a,(OFST+11,sp)
 527  009b a104          	cp	a,#4
 528  009d 2724          	jreq	L24
 529  009f 7b19          	ld	a,(OFST+11,sp)
 530  00a1 a180          	cp	a,#128
 531  00a3 271e          	jreq	L24
 532  00a5 7b19          	ld	a,(OFST+11,sp)
 533  00a7 a10c          	cp	a,#12
 534  00a9 2718          	jreq	L24
 535  00ab 7b19          	ld	a,(OFST+11,sp)
 536  00ad a10c          	cp	a,#12
 537  00af 2712          	jreq	L24
 538  00b1 7b19          	ld	a,(OFST+11,sp)
 539  00b3 a144          	cp	a,#68
 540  00b5 270c          	jreq	L24
 541  00b7 7b19          	ld	a,(OFST+11,sp)
 542  00b9 a1c0          	cp	a,#192
 543  00bb 2706          	jreq	L24
 544  00bd 7b19          	ld	a,(OFST+11,sp)
 545  00bf a188          	cp	a,#136
 546  00c1 2603          	jrne	L04
 547  00c3               L24:
 548  00c3 4f            	clr	a
 549  00c4 2010          	jra	L44
 550  00c6               L04:
 551  00c6 ae005a        	ldw	x,#90
 552  00c9 89            	pushw	x
 553  00ca ae0000        	ldw	x,#0
 554  00cd 89            	pushw	x
 555  00ce ae0008        	ldw	x,#L302
 556  00d1 cd0000        	call	_assert_failed
 558  00d4 5b04          	addw	sp,#4
 559  00d6               L44:
 560                     ; 91     assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 562  00d6 7b18          	ld	a,(OFST+10,sp)
 563  00d8 a488          	and	a,#136
 564  00da a188          	cp	a,#136
 565  00dc 271b          	jreq	L64
 566  00de 7b18          	ld	a,(OFST+10,sp)
 567  00e0 a444          	and	a,#68
 568  00e2 a144          	cp	a,#68
 569  00e4 2713          	jreq	L64
 570  00e6 7b18          	ld	a,(OFST+10,sp)
 571  00e8 a422          	and	a,#34
 572  00ea a122          	cp	a,#34
 573  00ec 270b          	jreq	L64
 574  00ee 7b18          	ld	a,(OFST+10,sp)
 575  00f0 a411          	and	a,#17
 576  00f2 a111          	cp	a,#17
 577  00f4 2703          	jreq	L64
 578  00f6 4f            	clr	a
 579  00f7 2010          	jra	L05
 580  00f9               L64:
 581  00f9 ae005b        	ldw	x,#91
 582  00fc 89            	pushw	x
 583  00fd ae0000        	ldw	x,#0
 584  0100 89            	pushw	x
 585  0101 ae0008        	ldw	x,#L302
 586  0104 cd0000        	call	_assert_failed
 588  0107 5b04          	addw	sp,#4
 589  0109               L05:
 590                     ; 94     UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 592  0109 72195244      	bres	21060,#4
 593                     ; 96     UART2->CR1 |= (uint8_t)WordLength; 
 595  010d c65244        	ld	a,21060
 596  0110 1a15          	or	a,(OFST+7,sp)
 597  0112 c75244        	ld	21060,a
 598                     ; 99     UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 600  0115 c65246        	ld	a,21062
 601  0118 a4cf          	and	a,#207
 602  011a c75246        	ld	21062,a
 603                     ; 101     UART2->CR3 |= (uint8_t)StopBits; 
 605  011d c65246        	ld	a,21062
 606  0120 1a16          	or	a,(OFST+8,sp)
 607  0122 c75246        	ld	21062,a
 608                     ; 104     UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 610  0125 c65244        	ld	a,21060
 611  0128 a4f9          	and	a,#249
 612  012a c75244        	ld	21060,a
 613                     ; 106     UART2->CR1 |= (uint8_t)Parity;
 615  012d c65244        	ld	a,21060
 616  0130 1a17          	or	a,(OFST+9,sp)
 617  0132 c75244        	ld	21060,a
 618                     ; 109     UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 620  0135 725f5242      	clr	21058
 621                     ; 111     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 623  0139 c65243        	ld	a,21059
 624  013c a40f          	and	a,#15
 625  013e c75243        	ld	21059,a
 626                     ; 113     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 628  0141 c65243        	ld	a,21059
 629  0144 a4f0          	and	a,#240
 630  0146 c75243        	ld	21059,a
 631                     ; 116     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 633  0149 96            	ldw	x,sp
 634  014a 1c0011        	addw	x,#OFST+3
 635  014d cd0000        	call	c_ltor
 637  0150 a604          	ld	a,#4
 638  0152 cd0000        	call	c_llsh
 640  0155 96            	ldw	x,sp
 641  0156 1c0001        	addw	x,#OFST-13
 642  0159 cd0000        	call	c_rtol
 644  015c cd0000        	call	_CLK_GetClockFreq
 646  015f 96            	ldw	x,sp
 647  0160 1c0001        	addw	x,#OFST-13
 648  0163 cd0000        	call	c_ludv
 650  0166 96            	ldw	x,sp
 651  0167 1c000b        	addw	x,#OFST-3
 652  016a cd0000        	call	c_rtol
 654                     ; 117     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 656  016d 96            	ldw	x,sp
 657  016e 1c0011        	addw	x,#OFST+3
 658  0171 cd0000        	call	c_ltor
 660  0174 a604          	ld	a,#4
 661  0176 cd0000        	call	c_llsh
 663  0179 96            	ldw	x,sp
 664  017a 1c0001        	addw	x,#OFST-13
 665  017d cd0000        	call	c_rtol
 667  0180 cd0000        	call	_CLK_GetClockFreq
 669  0183 a664          	ld	a,#100
 670  0185 cd0000        	call	c_smul
 672  0188 96            	ldw	x,sp
 673  0189 1c0001        	addw	x,#OFST-13
 674  018c cd0000        	call	c_ludv
 676  018f 96            	ldw	x,sp
 677  0190 1c0007        	addw	x,#OFST-7
 678  0193 cd0000        	call	c_rtol
 680                     ; 121     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 680                     ; 122                         << 4) / 100) & (uint8_t)0x0F); 
 682  0196 96            	ldw	x,sp
 683  0197 1c000b        	addw	x,#OFST-3
 684  019a cd0000        	call	c_ltor
 686  019d a664          	ld	a,#100
 687  019f cd0000        	call	c_smul
 689  01a2 96            	ldw	x,sp
 690  01a3 1c0001        	addw	x,#OFST-13
 691  01a6 cd0000        	call	c_rtol
 693  01a9 96            	ldw	x,sp
 694  01aa 1c0007        	addw	x,#OFST-7
 695  01ad cd0000        	call	c_ltor
 697  01b0 96            	ldw	x,sp
 698  01b1 1c0001        	addw	x,#OFST-13
 699  01b4 cd0000        	call	c_lsub
 701  01b7 a604          	ld	a,#4
 702  01b9 cd0000        	call	c_llsh
 704  01bc ae0004        	ldw	x,#L25
 705  01bf cd0000        	call	c_ludv
 707  01c2 b603          	ld	a,c_lreg+3
 708  01c4 a40f          	and	a,#15
 709  01c6 6b05          	ld	(OFST-9,sp),a
 710                     ; 123     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 712  01c8 96            	ldw	x,sp
 713  01c9 1c000b        	addw	x,#OFST-3
 714  01cc cd0000        	call	c_ltor
 716  01cf a604          	ld	a,#4
 717  01d1 cd0000        	call	c_lursh
 719  01d4 b603          	ld	a,c_lreg+3
 720  01d6 a4f0          	and	a,#240
 721  01d8 b703          	ld	c_lreg+3,a
 722  01da 3f02          	clr	c_lreg+2
 723  01dc 3f01          	clr	c_lreg+1
 724  01de 3f00          	clr	c_lreg
 725  01e0 b603          	ld	a,c_lreg+3
 726  01e2 6b06          	ld	(OFST-8,sp),a
 727                     ; 125     UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 729  01e4 7b05          	ld	a,(OFST-9,sp)
 730  01e6 1a06          	or	a,(OFST-8,sp)
 731  01e8 c75243        	ld	21059,a
 732                     ; 127     UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 734  01eb 7b0e          	ld	a,(OFST+0,sp)
 735  01ed c75242        	ld	21058,a
 736                     ; 130     UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 738  01f0 c65245        	ld	a,21061
 739  01f3 a4f3          	and	a,#243
 740  01f5 c75245        	ld	21061,a
 741                     ; 132     UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 743  01f8 c65246        	ld	a,21062
 744  01fb a4f8          	and	a,#248
 745  01fd c75246        	ld	21062,a
 746                     ; 134     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 746                     ; 135                                               UART2_CR3_CPHA | UART2_CR3_LBCL));
 748  0200 7b18          	ld	a,(OFST+10,sp)
 749  0202 a407          	and	a,#7
 750  0204 ca5246        	or	a,21062
 751  0207 c75246        	ld	21062,a
 752                     ; 137     if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 754  020a 7b19          	ld	a,(OFST+11,sp)
 755  020c a504          	bcp	a,#4
 756  020e 2706          	jreq	L502
 757                     ; 140         UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 759  0210 72165245      	bset	21061,#3
 761  0214 2004          	jra	L702
 762  0216               L502:
 763                     ; 145         UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 765  0216 72175245      	bres	21061,#3
 766  021a               L702:
 767                     ; 147     if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 769  021a 7b19          	ld	a,(OFST+11,sp)
 770  021c a508          	bcp	a,#8
 771  021e 2706          	jreq	L112
 772                     ; 150         UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 774  0220 72145245      	bset	21061,#2
 776  0224 2004          	jra	L312
 777  0226               L112:
 778                     ; 155         UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 780  0226 72155245      	bres	21061,#2
 781  022a               L312:
 782                     ; 159     if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 784  022a 7b18          	ld	a,(OFST+10,sp)
 785  022c a580          	bcp	a,#128
 786  022e 2706          	jreq	L512
 787                     ; 162         UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 789  0230 72175246      	bres	21062,#3
 791  0234 200a          	jra	L712
 792  0236               L512:
 793                     ; 166         UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 795  0236 7b18          	ld	a,(OFST+10,sp)
 796  0238 a408          	and	a,#8
 797  023a ca5246        	or	a,21062
 798  023d c75246        	ld	21062,a
 799  0240               L712:
 800                     ; 168 }
 803  0240 5b0e          	addw	sp,#14
 804  0242 81            	ret
 859                     ; 176 void UART2_Cmd(FunctionalState NewState)
 859                     ; 177 {
 860                     .text:	section	.text,new
 861  0000               _UART2_Cmd:
 865                     ; 179     if (NewState != DISABLE)
 867  0000 4d            	tnz	a
 868  0001 2706          	jreq	L742
 869                     ; 182         UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 871  0003 721b5244      	bres	21060,#5
 873  0007 2004          	jra	L152
 874  0009               L742:
 875                     ; 187         UART2->CR1 |= UART2_CR1_UARTD; 
 877  0009 721a5244      	bset	21060,#5
 878  000d               L152:
 879                     ; 189 }
 882  000d 81            	ret
1015                     ; 206 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
1015                     ; 207 {
1016                     .text:	section	.text,new
1017  0000               _UART2_ITConfig:
1019  0000 89            	pushw	x
1020  0001 89            	pushw	x
1021       00000002      OFST:	set	2
1024                     ; 208     uint8_t uartreg = 0, itpos = 0x00;
1028                     ; 211     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
1030  0002 a30100        	cpw	x,#256
1031  0005 271e          	jreq	L26
1032  0007 a30277        	cpw	x,#631
1033  000a 2719          	jreq	L26
1034  000c a30266        	cpw	x,#614
1035  000f 2714          	jreq	L26
1036  0011 a30205        	cpw	x,#517
1037  0014 270f          	jreq	L26
1038  0016 a30244        	cpw	x,#580
1039  0019 270a          	jreq	L26
1040  001b a30412        	cpw	x,#1042
1041  001e 2705          	jreq	L26
1042  0020 a30346        	cpw	x,#838
1043  0023 2603          	jrne	L06
1044  0025               L26:
1045  0025 4f            	clr	a
1046  0026 2010          	jra	L46
1047  0028               L06:
1048  0028 ae00d3        	ldw	x,#211
1049  002b 89            	pushw	x
1050  002c ae0000        	ldw	x,#0
1051  002f 89            	pushw	x
1052  0030 ae0008        	ldw	x,#L302
1053  0033 cd0000        	call	_assert_failed
1055  0036 5b04          	addw	sp,#4
1056  0038               L46:
1057                     ; 212     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1059  0038 0d07          	tnz	(OFST+5,sp)
1060  003a 2706          	jreq	L07
1061  003c 7b07          	ld	a,(OFST+5,sp)
1062  003e a101          	cp	a,#1
1063  0040 2603          	jrne	L66
1064  0042               L07:
1065  0042 4f            	clr	a
1066  0043 2010          	jra	L27
1067  0045               L66:
1068  0045 ae00d4        	ldw	x,#212
1069  0048 89            	pushw	x
1070  0049 ae0000        	ldw	x,#0
1071  004c 89            	pushw	x
1072  004d ae0008        	ldw	x,#L302
1073  0050 cd0000        	call	_assert_failed
1075  0053 5b04          	addw	sp,#4
1076  0055               L27:
1077                     ; 215     uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
1079  0055 7b03          	ld	a,(OFST+1,sp)
1080  0057 6b01          	ld	(OFST-1,sp),a
1081                     ; 218     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
1083  0059 7b04          	ld	a,(OFST+2,sp)
1084  005b a40f          	and	a,#15
1085  005d 5f            	clrw	x
1086  005e 97            	ld	xl,a
1087  005f a601          	ld	a,#1
1088  0061 5d            	tnzw	x
1089  0062 2704          	jreq	L47
1090  0064               L67:
1091  0064 48            	sll	a
1092  0065 5a            	decw	x
1093  0066 26fc          	jrne	L67
1094  0068               L47:
1095  0068 6b02          	ld	(OFST+0,sp),a
1096                     ; 220     if (NewState != DISABLE)
1098  006a 0d07          	tnz	(OFST+5,sp)
1099  006c 273a          	jreq	L333
1100                     ; 223         if (uartreg == 0x01)
1102  006e 7b01          	ld	a,(OFST-1,sp)
1103  0070 a101          	cp	a,#1
1104  0072 260a          	jrne	L533
1105                     ; 225             UART2->CR1 |= itpos;
1107  0074 c65244        	ld	a,21060
1108  0077 1a02          	or	a,(OFST+0,sp)
1109  0079 c75244        	ld	21060,a
1111  007c 2066          	jra	L153
1112  007e               L533:
1113                     ; 227         else if (uartreg == 0x02)
1115  007e 7b01          	ld	a,(OFST-1,sp)
1116  0080 a102          	cp	a,#2
1117  0082 260a          	jrne	L143
1118                     ; 229             UART2->CR2 |= itpos;
1120  0084 c65245        	ld	a,21061
1121  0087 1a02          	or	a,(OFST+0,sp)
1122  0089 c75245        	ld	21061,a
1124  008c 2056          	jra	L153
1125  008e               L143:
1126                     ; 231         else if (uartreg == 0x03)
1128  008e 7b01          	ld	a,(OFST-1,sp)
1129  0090 a103          	cp	a,#3
1130  0092 260a          	jrne	L543
1131                     ; 233             UART2->CR4 |= itpos;
1133  0094 c65247        	ld	a,21063
1134  0097 1a02          	or	a,(OFST+0,sp)
1135  0099 c75247        	ld	21063,a
1137  009c 2046          	jra	L153
1138  009e               L543:
1139                     ; 237             UART2->CR6 |= itpos;
1141  009e c65249        	ld	a,21065
1142  00a1 1a02          	or	a,(OFST+0,sp)
1143  00a3 c75249        	ld	21065,a
1144  00a6 203c          	jra	L153
1145  00a8               L333:
1146                     ; 243         if (uartreg == 0x01)
1148  00a8 7b01          	ld	a,(OFST-1,sp)
1149  00aa a101          	cp	a,#1
1150  00ac 260b          	jrne	L353
1151                     ; 245             UART2->CR1 &= (uint8_t)(~itpos);
1153  00ae 7b02          	ld	a,(OFST+0,sp)
1154  00b0 43            	cpl	a
1155  00b1 c45244        	and	a,21060
1156  00b4 c75244        	ld	21060,a
1158  00b7 202b          	jra	L153
1159  00b9               L353:
1160                     ; 247         else if (uartreg == 0x02)
1162  00b9 7b01          	ld	a,(OFST-1,sp)
1163  00bb a102          	cp	a,#2
1164  00bd 260b          	jrne	L753
1165                     ; 249             UART2->CR2 &= (uint8_t)(~itpos);
1167  00bf 7b02          	ld	a,(OFST+0,sp)
1168  00c1 43            	cpl	a
1169  00c2 c45245        	and	a,21061
1170  00c5 c75245        	ld	21061,a
1172  00c8 201a          	jra	L153
1173  00ca               L753:
1174                     ; 251         else if (uartreg == 0x03)
1176  00ca 7b01          	ld	a,(OFST-1,sp)
1177  00cc a103          	cp	a,#3
1178  00ce 260b          	jrne	L363
1179                     ; 253             UART2->CR4 &= (uint8_t)(~itpos);
1181  00d0 7b02          	ld	a,(OFST+0,sp)
1182  00d2 43            	cpl	a
1183  00d3 c45247        	and	a,21063
1184  00d6 c75247        	ld	21063,a
1186  00d9 2009          	jra	L153
1187  00db               L363:
1188                     ; 257             UART2->CR6 &= (uint8_t)(~itpos);
1190  00db 7b02          	ld	a,(OFST+0,sp)
1191  00dd 43            	cpl	a
1192  00de c45249        	and	a,21065
1193  00e1 c75249        	ld	21065,a
1194  00e4               L153:
1195                     ; 260 }
1198  00e4 5b04          	addw	sp,#4
1199  00e6 81            	ret
1257                     ; 267 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1257                     ; 268 {
1258                     .text:	section	.text,new
1259  0000               _UART2_IrDAConfig:
1261  0000 88            	push	a
1262       00000000      OFST:	set	0
1265                     ; 269     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1267  0001 a101          	cp	a,#1
1268  0003 2703          	jreq	L401
1269  0005 4d            	tnz	a
1270  0006 2603          	jrne	L201
1271  0008               L401:
1272  0008 4f            	clr	a
1273  0009 2010          	jra	L601
1274  000b               L201:
1275  000b ae010d        	ldw	x,#269
1276  000e 89            	pushw	x
1277  000f ae0000        	ldw	x,#0
1278  0012 89            	pushw	x
1279  0013 ae0008        	ldw	x,#L302
1280  0016 cd0000        	call	_assert_failed
1282  0019 5b04          	addw	sp,#4
1283  001b               L601:
1284                     ; 271     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1286  001b 0d01          	tnz	(OFST+1,sp)
1287  001d 2706          	jreq	L514
1288                     ; 273         UART2->CR5 |= UART2_CR5_IRLP;
1290  001f 72145248      	bset	21064,#2
1292  0023 2004          	jra	L714
1293  0025               L514:
1294                     ; 277         UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1296  0025 72155248      	bres	21064,#2
1297  0029               L714:
1298                     ; 279 }
1301  0029 84            	pop	a
1302  002a 81            	ret
1338                     ; 287 void UART2_IrDACmd(FunctionalState NewState)
1338                     ; 288 {
1339                     .text:	section	.text,new
1340  0000               _UART2_IrDACmd:
1342  0000 88            	push	a
1343       00000000      OFST:	set	0
1346                     ; 290     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1348  0001 4d            	tnz	a
1349  0002 2704          	jreq	L411
1350  0004 a101          	cp	a,#1
1351  0006 2603          	jrne	L211
1352  0008               L411:
1353  0008 4f            	clr	a
1354  0009 2010          	jra	L611
1355  000b               L211:
1356  000b ae0122        	ldw	x,#290
1357  000e 89            	pushw	x
1358  000f ae0000        	ldw	x,#0
1359  0012 89            	pushw	x
1360  0013 ae0008        	ldw	x,#L302
1361  0016 cd0000        	call	_assert_failed
1363  0019 5b04          	addw	sp,#4
1364  001b               L611:
1365                     ; 292     if (NewState != DISABLE)
1367  001b 0d01          	tnz	(OFST+1,sp)
1368  001d 2706          	jreq	L734
1369                     ; 295         UART2->CR5 |= UART2_CR5_IREN;
1371  001f 72125248      	bset	21064,#1
1373  0023 2004          	jra	L144
1374  0025               L734:
1375                     ; 300         UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1377  0025 72135248      	bres	21064,#1
1378  0029               L144:
1379                     ; 302 }
1382  0029 84            	pop	a
1383  002a 81            	ret
1443                     ; 311 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1443                     ; 312 {
1444                     .text:	section	.text,new
1445  0000               _UART2_LINBreakDetectionConfig:
1447  0000 88            	push	a
1448       00000000      OFST:	set	0
1451                     ; 314     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1453  0001 4d            	tnz	a
1454  0002 2704          	jreq	L421
1455  0004 a101          	cp	a,#1
1456  0006 2603          	jrne	L221
1457  0008               L421:
1458  0008 4f            	clr	a
1459  0009 2010          	jra	L621
1460  000b               L221:
1461  000b ae013a        	ldw	x,#314
1462  000e 89            	pushw	x
1463  000f ae0000        	ldw	x,#0
1464  0012 89            	pushw	x
1465  0013 ae0008        	ldw	x,#L302
1466  0016 cd0000        	call	_assert_failed
1468  0019 5b04          	addw	sp,#4
1469  001b               L621:
1470                     ; 316     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1472  001b 0d01          	tnz	(OFST+1,sp)
1473  001d 2706          	jreq	L174
1474                     ; 318         UART2->CR4 |= UART2_CR4_LBDL;
1476  001f 721a5247      	bset	21063,#5
1478  0023 2004          	jra	L374
1479  0025               L174:
1480                     ; 322         UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1482  0025 721b5247      	bres	21063,#5
1483  0029               L374:
1484                     ; 324 }
1487  0029 84            	pop	a
1488  002a 81            	ret
1610                     ; 336 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1610                     ; 337                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1610                     ; 338                      UART2_LinDivUp_TypeDef UART2_DivUp)
1610                     ; 339 {
1611                     .text:	section	.text,new
1612  0000               _UART2_LINConfig:
1614  0000 89            	pushw	x
1615       00000000      OFST:	set	0
1618                     ; 341     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1620  0001 9e            	ld	a,xh
1621  0002 4d            	tnz	a
1622  0003 2705          	jreq	L431
1623  0005 9e            	ld	a,xh
1624  0006 a101          	cp	a,#1
1625  0008 2603          	jrne	L231
1626  000a               L431:
1627  000a 4f            	clr	a
1628  000b 2010          	jra	L631
1629  000d               L231:
1630  000d ae0155        	ldw	x,#341
1631  0010 89            	pushw	x
1632  0011 ae0000        	ldw	x,#0
1633  0014 89            	pushw	x
1634  0015 ae0008        	ldw	x,#L302
1635  0018 cd0000        	call	_assert_failed
1637  001b 5b04          	addw	sp,#4
1638  001d               L631:
1639                     ; 342     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1641  001d 7b02          	ld	a,(OFST+2,sp)
1642  001f a101          	cp	a,#1
1643  0021 2704          	jreq	L241
1644  0023 0d02          	tnz	(OFST+2,sp)
1645  0025 2603          	jrne	L041
1646  0027               L241:
1647  0027 4f            	clr	a
1648  0028 2010          	jra	L441
1649  002a               L041:
1650  002a ae0156        	ldw	x,#342
1651  002d 89            	pushw	x
1652  002e ae0000        	ldw	x,#0
1653  0031 89            	pushw	x
1654  0032 ae0008        	ldw	x,#L302
1655  0035 cd0000        	call	_assert_failed
1657  0038 5b04          	addw	sp,#4
1658  003a               L441:
1659                     ; 343     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1661  003a 0d05          	tnz	(OFST+5,sp)
1662  003c 2706          	jreq	L051
1663  003e 7b05          	ld	a,(OFST+5,sp)
1664  0040 a101          	cp	a,#1
1665  0042 2603          	jrne	L641
1666  0044               L051:
1667  0044 4f            	clr	a
1668  0045 2010          	jra	L251
1669  0047               L641:
1670  0047 ae0157        	ldw	x,#343
1671  004a 89            	pushw	x
1672  004b ae0000        	ldw	x,#0
1673  004e 89            	pushw	x
1674  004f ae0008        	ldw	x,#L302
1675  0052 cd0000        	call	_assert_failed
1677  0055 5b04          	addw	sp,#4
1678  0057               L251:
1679                     ; 345     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1681  0057 0d01          	tnz	(OFST+1,sp)
1682  0059 2706          	jreq	L355
1683                     ; 347         UART2->CR6 |=  UART2_CR6_LSLV;
1685  005b 721a5249      	bset	21065,#5
1687  005f 2004          	jra	L555
1688  0061               L355:
1689                     ; 351         UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1691  0061 721b5249      	bres	21065,#5
1692  0065               L555:
1693                     ; 354     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1695  0065 0d02          	tnz	(OFST+2,sp)
1696  0067 2706          	jreq	L755
1697                     ; 356         UART2->CR6 |=  UART2_CR6_LASE ;
1699  0069 72185249      	bset	21065,#4
1701  006d 2004          	jra	L165
1702  006f               L755:
1703                     ; 360         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1705  006f 72195249      	bres	21065,#4
1706  0073               L165:
1707                     ; 363     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1709  0073 0d05          	tnz	(OFST+5,sp)
1710  0075 2706          	jreq	L365
1711                     ; 365         UART2->CR6 |=  UART2_CR6_LDUM;
1713  0077 721e5249      	bset	21065,#7
1715  007b 2004          	jra	L565
1716  007d               L365:
1717                     ; 369         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1719  007d 721f5249      	bres	21065,#7
1720  0081               L565:
1721                     ; 371 }
1724  0081 85            	popw	x
1725  0082 81            	ret
1761                     ; 379 void UART2_LINCmd(FunctionalState NewState)
1761                     ; 380 {
1762                     .text:	section	.text,new
1763  0000               _UART2_LINCmd:
1765  0000 88            	push	a
1766       00000000      OFST:	set	0
1769                     ; 381     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1771  0001 4d            	tnz	a
1772  0002 2704          	jreq	L061
1773  0004 a101          	cp	a,#1
1774  0006 2603          	jrne	L651
1775  0008               L061:
1776  0008 4f            	clr	a
1777  0009 2010          	jra	L261
1778  000b               L651:
1779  000b ae017d        	ldw	x,#381
1780  000e 89            	pushw	x
1781  000f ae0000        	ldw	x,#0
1782  0012 89            	pushw	x
1783  0013 ae0008        	ldw	x,#L302
1784  0016 cd0000        	call	_assert_failed
1786  0019 5b04          	addw	sp,#4
1787  001b               L261:
1788                     ; 383     if (NewState != DISABLE)
1790  001b 0d01          	tnz	(OFST+1,sp)
1791  001d 2706          	jreq	L506
1792                     ; 386         UART2->CR3 |= UART2_CR3_LINEN;
1794  001f 721c5246      	bset	21062,#6
1796  0023 2004          	jra	L706
1797  0025               L506:
1798                     ; 391         UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1800  0025 721d5246      	bres	21062,#6
1801  0029               L706:
1802                     ; 393 }
1805  0029 84            	pop	a
1806  002a 81            	ret
1842                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1842                     ; 401 {
1843                     .text:	section	.text,new
1844  0000               _UART2_SmartCardCmd:
1846  0000 88            	push	a
1847       00000000      OFST:	set	0
1850                     ; 403     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1852  0001 4d            	tnz	a
1853  0002 2704          	jreq	L071
1854  0004 a101          	cp	a,#1
1855  0006 2603          	jrne	L661
1856  0008               L071:
1857  0008 4f            	clr	a
1858  0009 2010          	jra	L271
1859  000b               L661:
1860  000b ae0193        	ldw	x,#403
1861  000e 89            	pushw	x
1862  000f ae0000        	ldw	x,#0
1863  0012 89            	pushw	x
1864  0013 ae0008        	ldw	x,#L302
1865  0016 cd0000        	call	_assert_failed
1867  0019 5b04          	addw	sp,#4
1868  001b               L271:
1869                     ; 405     if (NewState != DISABLE)
1871  001b 0d01          	tnz	(OFST+1,sp)
1872  001d 2706          	jreq	L726
1873                     ; 408         UART2->CR5 |= UART2_CR5_SCEN;
1875  001f 721a5248      	bset	21064,#5
1877  0023 2004          	jra	L136
1878  0025               L726:
1879                     ; 413         UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1881  0025 721b5248      	bres	21064,#5
1882  0029               L136:
1883                     ; 415 }
1886  0029 84            	pop	a
1887  002a 81            	ret
1924                     ; 423 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1924                     ; 424 {
1925                     .text:	section	.text,new
1926  0000               _UART2_SmartCardNACKCmd:
1928  0000 88            	push	a
1929       00000000      OFST:	set	0
1932                     ; 426     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1934  0001 4d            	tnz	a
1935  0002 2704          	jreq	L002
1936  0004 a101          	cp	a,#1
1937  0006 2603          	jrne	L671
1938  0008               L002:
1939  0008 4f            	clr	a
1940  0009 2010          	jra	L202
1941  000b               L671:
1942  000b ae01aa        	ldw	x,#426
1943  000e 89            	pushw	x
1944  000f ae0000        	ldw	x,#0
1945  0012 89            	pushw	x
1946  0013 ae0008        	ldw	x,#L302
1947  0016 cd0000        	call	_assert_failed
1949  0019 5b04          	addw	sp,#4
1950  001b               L202:
1951                     ; 428     if (NewState != DISABLE)
1953  001b 0d01          	tnz	(OFST+1,sp)
1954  001d 2706          	jreq	L156
1955                     ; 431         UART2->CR5 |= UART2_CR5_NACK;
1957  001f 72185248      	bset	21064,#4
1959  0023 2004          	jra	L356
1960  0025               L156:
1961                     ; 436         UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1963  0025 72195248      	bres	21064,#4
1964  0029               L356:
1965                     ; 438 }
1968  0029 84            	pop	a
1969  002a 81            	ret
2027                     ; 446 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
2027                     ; 447 {
2028                     .text:	section	.text,new
2029  0000               _UART2_WakeUpConfig:
2031  0000 88            	push	a
2032       00000000      OFST:	set	0
2035                     ; 448     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
2037  0001 4d            	tnz	a
2038  0002 2704          	jreq	L012
2039  0004 a108          	cp	a,#8
2040  0006 2603          	jrne	L602
2041  0008               L012:
2042  0008 4f            	clr	a
2043  0009 2010          	jra	L212
2044  000b               L602:
2045  000b ae01c0        	ldw	x,#448
2046  000e 89            	pushw	x
2047  000f ae0000        	ldw	x,#0
2048  0012 89            	pushw	x
2049  0013 ae0008        	ldw	x,#L302
2050  0016 cd0000        	call	_assert_failed
2052  0019 5b04          	addw	sp,#4
2053  001b               L212:
2054                     ; 450     UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
2056  001b 72175244      	bres	21060,#3
2057                     ; 451     UART2->CR1 |= (uint8_t)UART2_WakeUp;
2059  001f c65244        	ld	a,21060
2060  0022 1a01          	or	a,(OFST+1,sp)
2061  0024 c75244        	ld	21060,a
2062                     ; 452 }
2065  0027 84            	pop	a
2066  0028 81            	ret
2103                     ; 460 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
2103                     ; 461 {
2104                     .text:	section	.text,new
2105  0000               _UART2_ReceiverWakeUpCmd:
2107  0000 88            	push	a
2108       00000000      OFST:	set	0
2111                     ; 462     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2113  0001 4d            	tnz	a
2114  0002 2704          	jreq	L022
2115  0004 a101          	cp	a,#1
2116  0006 2603          	jrne	L612
2117  0008               L022:
2118  0008 4f            	clr	a
2119  0009 2010          	jra	L222
2120  000b               L612:
2121  000b ae01ce        	ldw	x,#462
2122  000e 89            	pushw	x
2123  000f ae0000        	ldw	x,#0
2124  0012 89            	pushw	x
2125  0013 ae0008        	ldw	x,#L302
2126  0016 cd0000        	call	_assert_failed
2128  0019 5b04          	addw	sp,#4
2129  001b               L222:
2130                     ; 464     if (NewState != DISABLE)
2132  001b 0d01          	tnz	(OFST+1,sp)
2133  001d 2706          	jreq	L127
2134                     ; 467         UART2->CR2 |= UART2_CR2_RWU;
2136  001f 72125245      	bset	21061,#1
2138  0023 2004          	jra	L327
2139  0025               L127:
2140                     ; 472         UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
2142  0025 72135245      	bres	21061,#1
2143  0029               L327:
2144                     ; 474 }
2147  0029 84            	pop	a
2148  002a 81            	ret
2171                     ; 481 uint8_t UART2_ReceiveData8(void)
2171                     ; 482 {
2172                     .text:	section	.text,new
2173  0000               _UART2_ReceiveData8:
2177                     ; 483     return ((uint8_t)UART2->DR);
2179  0000 c65241        	ld	a,21057
2182  0003 81            	ret
2216                     ; 491 uint16_t UART2_ReceiveData9(void)
2216                     ; 492 {
2217                     .text:	section	.text,new
2218  0000               _UART2_ReceiveData9:
2220  0000 89            	pushw	x
2221       00000002      OFST:	set	2
2224                     ; 493   uint16_t temp = 0;
2226                     ; 495   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
2228  0001 c65244        	ld	a,21060
2229  0004 5f            	clrw	x
2230  0005 a480          	and	a,#128
2231  0007 5f            	clrw	x
2232  0008 02            	rlwa	x,a
2233  0009 58            	sllw	x
2234  000a 1f01          	ldw	(OFST-1,sp),x
2235                     ; 497   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
2237  000c c65241        	ld	a,21057
2238  000f 5f            	clrw	x
2239  0010 97            	ld	xl,a
2240  0011 01            	rrwa	x,a
2241  0012 1a02          	or	a,(OFST+0,sp)
2242  0014 01            	rrwa	x,a
2243  0015 1a01          	or	a,(OFST-1,sp)
2244  0017 01            	rrwa	x,a
2245  0018 01            	rrwa	x,a
2246  0019 a4ff          	and	a,#255
2247  001b 01            	rrwa	x,a
2248  001c a401          	and	a,#1
2249  001e 01            	rrwa	x,a
2252  001f 5b02          	addw	sp,#2
2253  0021 81            	ret
2287                     ; 505 void UART2_SendData8(uint8_t Data)
2287                     ; 506 {
2288                     .text:	section	.text,new
2289  0000               _UART2_SendData8:
2293                     ; 508     UART2->DR = Data;
2295  0000 c75241        	ld	21057,a
2296                     ; 509 }
2299  0003 81            	ret
2333                     ; 516 void UART2_SendData9(uint16_t Data)
2333                     ; 517 {
2334                     .text:	section	.text,new
2335  0000               _UART2_SendData9:
2337  0000 89            	pushw	x
2338       00000000      OFST:	set	0
2341                     ; 519     UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
2343  0001 721d5244      	bres	21060,#6
2344                     ; 522     UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
2346  0005 54            	srlw	x
2347  0006 54            	srlw	x
2348  0007 9f            	ld	a,xl
2349  0008 a440          	and	a,#64
2350  000a ca5244        	or	a,21060
2351  000d c75244        	ld	21060,a
2352                     ; 525     UART2->DR   = (uint8_t)(Data);                    
2354  0010 7b02          	ld	a,(OFST+2,sp)
2355  0012 c75241        	ld	21057,a
2356                     ; 527 }
2359  0015 85            	popw	x
2360  0016 81            	ret
2383                     ; 534 void UART2_SendBreak(void)
2383                     ; 535 {
2384                     .text:	section	.text,new
2385  0000               _UART2_SendBreak:
2389                     ; 536     UART2->CR2 |= UART2_CR2_SBK;
2391  0000 72105245      	bset	21061,#0
2392                     ; 537 }
2395  0004 81            	ret
2430                     ; 544 void UART2_SetAddress(uint8_t UART2_Address)
2430                     ; 545 {
2431                     .text:	section	.text,new
2432  0000               _UART2_SetAddress:
2434  0000 88            	push	a
2435       00000000      OFST:	set	0
2438                     ; 547     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2440  0001 a110          	cp	a,#16
2441  0003 2403          	jruge	L042
2442  0005 4f            	clr	a
2443  0006 2010          	jra	L242
2444  0008               L042:
2445  0008 ae0223        	ldw	x,#547
2446  000b 89            	pushw	x
2447  000c ae0000        	ldw	x,#0
2448  000f 89            	pushw	x
2449  0010 ae0008        	ldw	x,#L302
2450  0013 cd0000        	call	_assert_failed
2452  0016 5b04          	addw	sp,#4
2453  0018               L242:
2454                     ; 550     UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2456  0018 c65247        	ld	a,21063
2457  001b a4f0          	and	a,#240
2458  001d c75247        	ld	21063,a
2459                     ; 552     UART2->CR4 |= UART2_Address;
2461  0020 c65247        	ld	a,21063
2462  0023 1a01          	or	a,(OFST+1,sp)
2463  0025 c75247        	ld	21063,a
2464                     ; 553 }
2467  0028 84            	pop	a
2468  0029 81            	ret
2502                     ; 561 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2502                     ; 562 {
2503                     .text:	section	.text,new
2504  0000               _UART2_SetGuardTime:
2508                     ; 564     UART2->GTR = UART2_GuardTime;
2510  0000 c7524a        	ld	21066,a
2511                     ; 565 }
2514  0003 81            	ret
2548                     ; 589 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2548                     ; 590 {
2549                     .text:	section	.text,new
2550  0000               _UART2_SetPrescaler:
2554                     ; 592     UART2->PSCR = UART2_Prescaler;
2556  0000 c7524b        	ld	21067,a
2557                     ; 593 }
2560  0003 81            	ret
2718                     ; 601 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2718                     ; 602 {
2719                     .text:	section	.text,new
2720  0000               _UART2_GetFlagStatus:
2722  0000 89            	pushw	x
2723  0001 88            	push	a
2724       00000001      OFST:	set	1
2727                     ; 603     FlagStatus status = RESET;
2729                     ; 606     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2731  0002 a30080        	cpw	x,#128
2732  0005 2737          	jreq	L452
2733  0007 a30040        	cpw	x,#64
2734  000a 2732          	jreq	L452
2735  000c a30020        	cpw	x,#32
2736  000f 272d          	jreq	L452
2737  0011 a30010        	cpw	x,#16
2738  0014 2728          	jreq	L452
2739  0016 a30008        	cpw	x,#8
2740  0019 2723          	jreq	L452
2741  001b a30004        	cpw	x,#4
2742  001e 271e          	jreq	L452
2743  0020 a30002        	cpw	x,#2
2744  0023 2719          	jreq	L452
2745  0025 a30001        	cpw	x,#1
2746  0028 2714          	jreq	L452
2747  002a a30101        	cpw	x,#257
2748  002d 270f          	jreq	L452
2749  002f a30301        	cpw	x,#769
2750  0032 270a          	jreq	L452
2751  0034 a30302        	cpw	x,#770
2752  0037 2705          	jreq	L452
2753  0039 a30210        	cpw	x,#528
2754  003c 2603          	jrne	L252
2755  003e               L452:
2756  003e 4f            	clr	a
2757  003f 2010          	jra	L652
2758  0041               L252:
2759  0041 ae025e        	ldw	x,#606
2760  0044 89            	pushw	x
2761  0045 ae0000        	ldw	x,#0
2762  0048 89            	pushw	x
2763  0049 ae0008        	ldw	x,#L302
2764  004c cd0000        	call	_assert_failed
2766  004f 5b04          	addw	sp,#4
2767  0051               L652:
2768                     ; 609     if (UART2_FLAG == UART2_FLAG_LBDF)
2770  0051 1e02          	ldw	x,(OFST+1,sp)
2771  0053 a30210        	cpw	x,#528
2772  0056 2611          	jrne	L7511
2773                     ; 611         if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2775  0058 c65247        	ld	a,21063
2776  005b 1503          	bcp	a,(OFST+2,sp)
2777  005d 2706          	jreq	L1611
2778                     ; 614             status = SET;
2780  005f a601          	ld	a,#1
2781  0061 6b01          	ld	(OFST+0,sp),a
2783  0063 2039          	jra	L5611
2784  0065               L1611:
2785                     ; 619             status = RESET;
2787  0065 0f01          	clr	(OFST+0,sp)
2788  0067 2035          	jra	L5611
2789  0069               L7511:
2790                     ; 622     else if (UART2_FLAG == UART2_FLAG_SBK)
2792  0069 1e02          	ldw	x,(OFST+1,sp)
2793  006b a30101        	cpw	x,#257
2794  006e 2611          	jrne	L7611
2795                     ; 624         if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2797  0070 c65245        	ld	a,21061
2798  0073 1503          	bcp	a,(OFST+2,sp)
2799  0075 2706          	jreq	L1711
2800                     ; 627             status = SET;
2802  0077 a601          	ld	a,#1
2803  0079 6b01          	ld	(OFST+0,sp),a
2805  007b 2021          	jra	L5611
2806  007d               L1711:
2807                     ; 632             status = RESET;
2809  007d 0f01          	clr	(OFST+0,sp)
2810  007f 201d          	jra	L5611
2811  0081               L7611:
2812                     ; 635     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2814  0081 1e02          	ldw	x,(OFST+1,sp)
2815  0083 a30302        	cpw	x,#770
2816  0086 2707          	jreq	L1021
2818  0088 1e02          	ldw	x,(OFST+1,sp)
2819  008a a30301        	cpw	x,#769
2820  008d 2614          	jrne	L7711
2821  008f               L1021:
2822                     ; 637         if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2824  008f c65249        	ld	a,21065
2825  0092 1503          	bcp	a,(OFST+2,sp)
2826  0094 2706          	jreq	L3021
2827                     ; 640             status = SET;
2829  0096 a601          	ld	a,#1
2830  0098 6b01          	ld	(OFST+0,sp),a
2832  009a 2002          	jra	L5611
2833  009c               L3021:
2834                     ; 645             status = RESET;
2836  009c 0f01          	clr	(OFST+0,sp)
2837  009e               L5611:
2838                     ; 663     return  status;
2840  009e 7b01          	ld	a,(OFST+0,sp)
2843  00a0 5b03          	addw	sp,#3
2844  00a2 81            	ret
2845  00a3               L7711:
2846                     ; 650         if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2848  00a3 c65240        	ld	a,21056
2849  00a6 1503          	bcp	a,(OFST+2,sp)
2850  00a8 2706          	jreq	L1121
2851                     ; 653             status = SET;
2853  00aa a601          	ld	a,#1
2854  00ac 6b01          	ld	(OFST+0,sp),a
2856  00ae 20ee          	jra	L5611
2857  00b0               L1121:
2858                     ; 658             status = RESET;
2860  00b0 0f01          	clr	(OFST+0,sp)
2861  00b2 20ea          	jra	L5611
2897                     ; 693 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2897                     ; 694 {
2898                     .text:	section	.text,new
2899  0000               _UART2_ClearFlag:
2901  0000 89            	pushw	x
2902       00000000      OFST:	set	0
2905                     ; 695     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2907  0001 a30020        	cpw	x,#32
2908  0004 270f          	jreq	L462
2909  0006 a30302        	cpw	x,#770
2910  0009 270a          	jreq	L462
2911  000b a30301        	cpw	x,#769
2912  000e 2705          	jreq	L462
2913  0010 a30210        	cpw	x,#528
2914  0013 2603          	jrne	L262
2915  0015               L462:
2916  0015 4f            	clr	a
2917  0016 2010          	jra	L662
2918  0018               L262:
2919  0018 ae02b7        	ldw	x,#695
2920  001b 89            	pushw	x
2921  001c ae0000        	ldw	x,#0
2922  001f 89            	pushw	x
2923  0020 ae0008        	ldw	x,#L302
2924  0023 cd0000        	call	_assert_failed
2926  0026 5b04          	addw	sp,#4
2927  0028               L662:
2928                     ; 698     if (UART2_FLAG == UART2_FLAG_RXNE)
2930  0028 1e01          	ldw	x,(OFST+1,sp)
2931  002a a30020        	cpw	x,#32
2932  002d 2606          	jrne	L3321
2933                     ; 700         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2935  002f 35df5240      	mov	21056,#223
2937  0033 201e          	jra	L5321
2938  0035               L3321:
2939                     ; 703     else if (UART2_FLAG == UART2_FLAG_LBDF)
2941  0035 1e01          	ldw	x,(OFST+1,sp)
2942  0037 a30210        	cpw	x,#528
2943  003a 2606          	jrne	L7321
2944                     ; 705         UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2946  003c 72195247      	bres	21063,#4
2948  0040 2011          	jra	L5321
2949  0042               L7321:
2950                     ; 708     else if (UART2_FLAG == UART2_FLAG_LHDF)
2952  0042 1e01          	ldw	x,(OFST+1,sp)
2953  0044 a30302        	cpw	x,#770
2954  0047 2606          	jrne	L3421
2955                     ; 710         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2957  0049 72135249      	bres	21065,#1
2959  004d 2004          	jra	L5321
2960  004f               L3421:
2961                     ; 715         UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2963  004f 72115249      	bres	21065,#0
2964  0053               L5321:
2965                     ; 717 }
2968  0053 85            	popw	x
2969  0054 81            	ret
3052                     ; 732 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
3052                     ; 733 {
3053                     .text:	section	.text,new
3054  0000               _UART2_GetITStatus:
3056  0000 89            	pushw	x
3057  0001 89            	pushw	x
3058       00000002      OFST:	set	2
3061                     ; 734     ITStatus pendingbitstatus = RESET;
3063                     ; 735     uint8_t itpos = 0;
3065                     ; 736     uint8_t itmask1 = 0;
3067                     ; 737     uint8_t itmask2 = 0;
3069                     ; 738     uint8_t enablestatus = 0;
3071                     ; 741     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
3073  0002 a30277        	cpw	x,#631
3074  0005 2723          	jreq	L472
3075  0007 a30266        	cpw	x,#614
3076  000a 271e          	jreq	L472
3077  000c a30255        	cpw	x,#597
3078  000f 2719          	jreq	L472
3079  0011 a30244        	cpw	x,#580
3080  0014 2714          	jreq	L472
3081  0016 a30235        	cpw	x,#565
3082  0019 270f          	jreq	L472
3083  001b a30346        	cpw	x,#838
3084  001e 270a          	jreq	L472
3085  0020 a30412        	cpw	x,#1042
3086  0023 2705          	jreq	L472
3087  0025 a30100        	cpw	x,#256
3088  0028 2603          	jrne	L272
3089  002a               L472:
3090  002a 4f            	clr	a
3091  002b 2010          	jra	L672
3092  002d               L272:
3093  002d ae02e5        	ldw	x,#741
3094  0030 89            	pushw	x
3095  0031 ae0000        	ldw	x,#0
3096  0034 89            	pushw	x
3097  0035 ae0008        	ldw	x,#L302
3098  0038 cd0000        	call	_assert_failed
3100  003b 5b04          	addw	sp,#4
3101  003d               L672:
3102                     ; 744     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
3104  003d 7b04          	ld	a,(OFST+2,sp)
3105  003f a40f          	and	a,#15
3106  0041 5f            	clrw	x
3107  0042 97            	ld	xl,a
3108  0043 a601          	ld	a,#1
3109  0045 5d            	tnzw	x
3110  0046 2704          	jreq	L003
3111  0048               L203:
3112  0048 48            	sll	a
3113  0049 5a            	decw	x
3114  004a 26fc          	jrne	L203
3115  004c               L003:
3116  004c 6b01          	ld	(OFST-1,sp),a
3117                     ; 746     itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
3119  004e 7b04          	ld	a,(OFST+2,sp)
3120  0050 4e            	swap	a
3121  0051 a40f          	and	a,#15
3122  0053 6b02          	ld	(OFST+0,sp),a
3123                     ; 748     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
3125  0055 7b02          	ld	a,(OFST+0,sp)
3126  0057 5f            	clrw	x
3127  0058 97            	ld	xl,a
3128  0059 a601          	ld	a,#1
3129  005b 5d            	tnzw	x
3130  005c 2704          	jreq	L403
3131  005e               L603:
3132  005e 48            	sll	a
3133  005f 5a            	decw	x
3134  0060 26fc          	jrne	L603
3135  0062               L403:
3136  0062 6b02          	ld	(OFST+0,sp),a
3137                     ; 751     if (UART2_IT == UART2_IT_PE)
3139  0064 1e03          	ldw	x,(OFST+1,sp)
3140  0066 a30100        	cpw	x,#256
3141  0069 261c          	jrne	L1131
3142                     ; 754         enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
3144  006b c65244        	ld	a,21060
3145  006e 1402          	and	a,(OFST+0,sp)
3146  0070 6b02          	ld	(OFST+0,sp),a
3147                     ; 757         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3149  0072 c65240        	ld	a,21056
3150  0075 1501          	bcp	a,(OFST-1,sp)
3151  0077 270a          	jreq	L3131
3153  0079 0d02          	tnz	(OFST+0,sp)
3154  007b 2706          	jreq	L3131
3155                     ; 760             pendingbitstatus = SET;
3157  007d a601          	ld	a,#1
3158  007f 6b02          	ld	(OFST+0,sp),a
3160  0081 2064          	jra	L7131
3161  0083               L3131:
3162                     ; 765             pendingbitstatus = RESET;
3164  0083 0f02          	clr	(OFST+0,sp)
3165  0085 2060          	jra	L7131
3166  0087               L1131:
3167                     ; 768     else if (UART2_IT == UART2_IT_LBDF)
3169  0087 1e03          	ldw	x,(OFST+1,sp)
3170  0089 a30346        	cpw	x,#838
3171  008c 261c          	jrne	L1231
3172                     ; 771         enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
3174  008e c65247        	ld	a,21063
3175  0091 1402          	and	a,(OFST+0,sp)
3176  0093 6b02          	ld	(OFST+0,sp),a
3177                     ; 773         if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
3179  0095 c65247        	ld	a,21063
3180  0098 1501          	bcp	a,(OFST-1,sp)
3181  009a 270a          	jreq	L3231
3183  009c 0d02          	tnz	(OFST+0,sp)
3184  009e 2706          	jreq	L3231
3185                     ; 776             pendingbitstatus = SET;
3187  00a0 a601          	ld	a,#1
3188  00a2 6b02          	ld	(OFST+0,sp),a
3190  00a4 2041          	jra	L7131
3191  00a6               L3231:
3192                     ; 781             pendingbitstatus = RESET;
3194  00a6 0f02          	clr	(OFST+0,sp)
3195  00a8 203d          	jra	L7131
3196  00aa               L1231:
3197                     ; 784     else if (UART2_IT == UART2_IT_LHDF)
3199  00aa 1e03          	ldw	x,(OFST+1,sp)
3200  00ac a30412        	cpw	x,#1042
3201  00af 261c          	jrne	L1331
3202                     ; 787         enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
3204  00b1 c65249        	ld	a,21065
3205  00b4 1402          	and	a,(OFST+0,sp)
3206  00b6 6b02          	ld	(OFST+0,sp),a
3207                     ; 789         if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
3209  00b8 c65249        	ld	a,21065
3210  00bb 1501          	bcp	a,(OFST-1,sp)
3211  00bd 270a          	jreq	L3331
3213  00bf 0d02          	tnz	(OFST+0,sp)
3214  00c1 2706          	jreq	L3331
3215                     ; 792             pendingbitstatus = SET;
3217  00c3 a601          	ld	a,#1
3218  00c5 6b02          	ld	(OFST+0,sp),a
3220  00c7 201e          	jra	L7131
3221  00c9               L3331:
3222                     ; 797             pendingbitstatus = RESET;
3224  00c9 0f02          	clr	(OFST+0,sp)
3225  00cb 201a          	jra	L7131
3226  00cd               L1331:
3227                     ; 803         enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
3229  00cd c65245        	ld	a,21061
3230  00d0 1402          	and	a,(OFST+0,sp)
3231  00d2 6b02          	ld	(OFST+0,sp),a
3232                     ; 805         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3234  00d4 c65240        	ld	a,21056
3235  00d7 1501          	bcp	a,(OFST-1,sp)
3236  00d9 270a          	jreq	L1431
3238  00db 0d02          	tnz	(OFST+0,sp)
3239  00dd 2706          	jreq	L1431
3240                     ; 808             pendingbitstatus = SET;
3242  00df a601          	ld	a,#1
3243  00e1 6b02          	ld	(OFST+0,sp),a
3245  00e3 2002          	jra	L7131
3246  00e5               L1431:
3247                     ; 813             pendingbitstatus = RESET;
3249  00e5 0f02          	clr	(OFST+0,sp)
3250  00e7               L7131:
3251                     ; 817     return  pendingbitstatus;
3253  00e7 7b02          	ld	a,(OFST+0,sp)
3256  00e9 5b04          	addw	sp,#4
3257  00eb 81            	ret
3294                     ; 846 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
3294                     ; 847 {
3295                     .text:	section	.text,new
3296  0000               _UART2_ClearITPendingBit:
3298  0000 89            	pushw	x
3299       00000000      OFST:	set	0
3302                     ; 848     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
3304  0001 a30255        	cpw	x,#597
3305  0004 270a          	jreq	L413
3306  0006 a30412        	cpw	x,#1042
3307  0009 2705          	jreq	L413
3308  000b a30346        	cpw	x,#838
3309  000e 2603          	jrne	L213
3310  0010               L413:
3311  0010 4f            	clr	a
3312  0011 2010          	jra	L613
3313  0013               L213:
3314  0013 ae0350        	ldw	x,#848
3315  0016 89            	pushw	x
3316  0017 ae0000        	ldw	x,#0
3317  001a 89            	pushw	x
3318  001b ae0008        	ldw	x,#L302
3319  001e cd0000        	call	_assert_failed
3321  0021 5b04          	addw	sp,#4
3322  0023               L613:
3323                     ; 851     if (UART2_IT == UART2_IT_RXNE)
3325  0023 1e01          	ldw	x,(OFST+1,sp)
3326  0025 a30255        	cpw	x,#597
3327  0028 2606          	jrne	L3631
3328                     ; 853         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
3330  002a 35df5240      	mov	21056,#223
3332  002e 2011          	jra	L5631
3333  0030               L3631:
3334                     ; 856     else if (UART2_IT == UART2_IT_LBDF)
3336  0030 1e01          	ldw	x,(OFST+1,sp)
3337  0032 a30346        	cpw	x,#838
3338  0035 2606          	jrne	L7631
3339                     ; 858         UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
3341  0037 72195247      	bres	21063,#4
3343  003b 2004          	jra	L5631
3344  003d               L7631:
3345                     ; 863         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
3347  003d 72135249      	bres	21065,#1
3348  0041               L5631:
3349                     ; 865 }
3352  0041 85            	popw	x
3353  0042 81            	ret
3366                     	xdef	_UART2_ClearITPendingBit
3367                     	xdef	_UART2_GetITStatus
3368                     	xdef	_UART2_ClearFlag
3369                     	xdef	_UART2_GetFlagStatus
3370                     	xdef	_UART2_SetPrescaler
3371                     	xdef	_UART2_SetGuardTime
3372                     	xdef	_UART2_SetAddress
3373                     	xdef	_UART2_SendBreak
3374                     	xdef	_UART2_SendData9
3375                     	xdef	_UART2_SendData8
3376                     	xdef	_UART2_ReceiveData9
3377                     	xdef	_UART2_ReceiveData8
3378                     	xdef	_UART2_ReceiverWakeUpCmd
3379                     	xdef	_UART2_WakeUpConfig
3380                     	xdef	_UART2_SmartCardNACKCmd
3381                     	xdef	_UART2_SmartCardCmd
3382                     	xdef	_UART2_LINCmd
3383                     	xdef	_UART2_LINConfig
3384                     	xdef	_UART2_LINBreakDetectionConfig
3385                     	xdef	_UART2_IrDACmd
3386                     	xdef	_UART2_IrDAConfig
3387                     	xdef	_UART2_ITConfig
3388                     	xdef	_UART2_Cmd
3389                     	xdef	_UART2_Init
3390                     	xdef	_UART2_DeInit
3391                     	xref	_assert_failed
3392                     	xref	_CLK_GetClockFreq
3393                     	switch	.const
3394  0008               L302:
3395  0008 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
3396  001a 697665725c73  	dc.b	"iver\src\stm8s_uar"
3397  002c 74322e6300    	dc.b	"t2.c",0
3398                     	xref.b	c_lreg
3399                     	xref.b	c_x
3419                     	xref	c_lursh
3420                     	xref	c_lsub
3421                     	xref	c_smul
3422                     	xref	c_ludv
3423                     	xref	c_rtol
3424                     	xref	c_llsh
3425                     	xref	c_lcmp
3426                     	xref	c_ltor
3427                     	end
