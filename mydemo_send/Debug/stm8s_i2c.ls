   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 61 void I2C_DeInit(void)
  44                     ; 62 {
  46                     .text:	section	.text,new
  47  0000               _I2C_DeInit:
  51                     ; 63   I2C->CR1 = I2C_CR1_RESET_VALUE;
  53  0000 725f5210      	clr	21008
  54                     ; 64   I2C->CR2 = I2C_CR2_RESET_VALUE;
  56  0004 725f5211      	clr	21009
  57                     ; 65   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  59  0008 725f5212      	clr	21010
  60                     ; 66   I2C->OARL = I2C_OARL_RESET_VALUE;
  62  000c 725f5213      	clr	21011
  63                     ; 67   I2C->OARH = I2C_OARH_RESET_VALUE;
  65  0010 725f5214      	clr	21012
  66                     ; 68   I2C->ITR = I2C_ITR_RESET_VALUE;
  68  0014 725f521a      	clr	21018
  69                     ; 69   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  71  0018 725f521b      	clr	21019
  72                     ; 70   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  74  001c 725f521c      	clr	21020
  75                     ; 71   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  77  0020 3502521d      	mov	21021,#2
  78                     ; 72 }
  81  0024 81            	ret
 261                     .const:	section	.text
 262  0000               L44:
 263  0000 00061a81      	dc.l	400001
 264  0004               L05:
 265  0004 000186a1      	dc.l	100001
 266  0008               L25:
 267  0008 000f4240      	dc.l	1000000
 268                     ; 90 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 268                     ; 91               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 268                     ; 92               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 268                     ; 93 {
 269                     .text:	section	.text,new
 270  0000               _I2C_Init:
 272  0000 5209          	subw	sp,#9
 273       00000009      OFST:	set	9
 276                     ; 94   uint16_t result = 0x0004;
 278                     ; 95   uint16_t tmpval = 0;
 280                     ; 96   uint8_t tmpccrh = 0;
 282  0002 0f07          	clr	(OFST-2,sp)
 283                     ; 99   assert_param(IS_I2C_ACK_OK(Ack));
 285  0004 0d13          	tnz	(OFST+10,sp)
 286  0006 270c          	jreq	L21
 287  0008 7b13          	ld	a,(OFST+10,sp)
 288  000a a101          	cp	a,#1
 289  000c 2706          	jreq	L21
 290  000e 7b13          	ld	a,(OFST+10,sp)
 291  0010 a102          	cp	a,#2
 292  0012 2603          	jrne	L01
 293  0014               L21:
 294  0014 4f            	clr	a
 295  0015 2010          	jra	L41
 296  0017               L01:
 297  0017 ae0063        	ldw	x,#99
 298  001a 89            	pushw	x
 299  001b ae0000        	ldw	x,#0
 300  001e 89            	pushw	x
 301  001f ae000c        	ldw	x,#L131
 302  0022 cd0000        	call	_assert_failed
 304  0025 5b04          	addw	sp,#4
 305  0027               L41:
 306                     ; 100   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 308  0027 0d14          	tnz	(OFST+11,sp)
 309  0029 2706          	jreq	L02
 310  002b 7b14          	ld	a,(OFST+11,sp)
 311  002d a180          	cp	a,#128
 312  002f 2603          	jrne	L61
 313  0031               L02:
 314  0031 4f            	clr	a
 315  0032 2010          	jra	L22
 316  0034               L61:
 317  0034 ae0064        	ldw	x,#100
 318  0037 89            	pushw	x
 319  0038 ae0000        	ldw	x,#0
 320  003b 89            	pushw	x
 321  003c ae000c        	ldw	x,#L131
 322  003f cd0000        	call	_assert_failed
 324  0042 5b04          	addw	sp,#4
 325  0044               L22:
 326                     ; 101   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 328  0044 1e10          	ldw	x,(OFST+7,sp)
 329  0046 a30400        	cpw	x,#1024
 330  0049 2403          	jruge	L42
 331  004b 4f            	clr	a
 332  004c 2010          	jra	L62
 333  004e               L42:
 334  004e ae0065        	ldw	x,#101
 335  0051 89            	pushw	x
 336  0052 ae0000        	ldw	x,#0
 337  0055 89            	pushw	x
 338  0056 ae000c        	ldw	x,#L131
 339  0059 cd0000        	call	_assert_failed
 341  005c 5b04          	addw	sp,#4
 342  005e               L62:
 343                     ; 102   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 345  005e 0d12          	tnz	(OFST+9,sp)
 346  0060 2706          	jreq	L23
 347  0062 7b12          	ld	a,(OFST+9,sp)
 348  0064 a140          	cp	a,#64
 349  0066 2603          	jrne	L03
 350  0068               L23:
 351  0068 4f            	clr	a
 352  0069 2010          	jra	L43
 353  006b               L03:
 354  006b ae0066        	ldw	x,#102
 355  006e 89            	pushw	x
 356  006f ae0000        	ldw	x,#0
 357  0072 89            	pushw	x
 358  0073 ae000c        	ldw	x,#L131
 359  0076 cd0000        	call	_assert_failed
 361  0079 5b04          	addw	sp,#4
 362  007b               L43:
 363                     ; 103   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 365  007b 0d15          	tnz	(OFST+12,sp)
 366  007d 2709          	jreq	L63
 367  007f 7b15          	ld	a,(OFST+12,sp)
 368  0081 a111          	cp	a,#17
 369  0083 2403          	jruge	L63
 370  0085 4f            	clr	a
 371  0086 2010          	jra	L04
 372  0088               L63:
 373  0088 ae0067        	ldw	x,#103
 374  008b 89            	pushw	x
 375  008c ae0000        	ldw	x,#0
 376  008f 89            	pushw	x
 377  0090 ae000c        	ldw	x,#L131
 378  0093 cd0000        	call	_assert_failed
 380  0096 5b04          	addw	sp,#4
 381  0098               L04:
 382                     ; 104   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 384  0098 96            	ldw	x,sp
 385  0099 1c000c        	addw	x,#OFST+3
 386  009c cd0000        	call	c_lzmp
 388  009f 2712          	jreq	L24
 389  00a1 96            	ldw	x,sp
 390  00a2 1c000c        	addw	x,#OFST+3
 391  00a5 cd0000        	call	c_ltor
 393  00a8 ae0000        	ldw	x,#L44
 394  00ab cd0000        	call	c_lcmp
 396  00ae 2403          	jruge	L24
 397  00b0 4f            	clr	a
 398  00b1 2010          	jra	L64
 399  00b3               L24:
 400  00b3 ae0068        	ldw	x,#104
 401  00b6 89            	pushw	x
 402  00b7 ae0000        	ldw	x,#0
 403  00ba 89            	pushw	x
 404  00bb ae000c        	ldw	x,#L131
 405  00be cd0000        	call	_assert_failed
 407  00c1 5b04          	addw	sp,#4
 408  00c3               L64:
 409                     ; 109   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 411  00c3 c65212        	ld	a,21010
 412  00c6 a4c0          	and	a,#192
 413  00c8 c75212        	ld	21010,a
 414                     ; 111   I2C->FREQR |= InputClockFrequencyMHz;
 416  00cb c65212        	ld	a,21010
 417  00ce 1a15          	or	a,(OFST+12,sp)
 418  00d0 c75212        	ld	21010,a
 419                     ; 115   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 421  00d3 72115210      	bres	21008,#0
 422                     ; 118   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 424  00d7 c6521c        	ld	a,21020
 425  00da a430          	and	a,#48
 426  00dc c7521c        	ld	21020,a
 427                     ; 119   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 429  00df 725f521b      	clr	21019
 430                     ; 122   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 432  00e3 96            	ldw	x,sp
 433  00e4 1c000c        	addw	x,#OFST+3
 434  00e7 cd0000        	call	c_ltor
 436  00ea ae0004        	ldw	x,#L05
 437  00ed cd0000        	call	c_lcmp
 439  00f0 2403          	jruge	L45
 440  00f2 cc017f        	jp	L331
 441  00f5               L45:
 442                     ; 125     tmpccrh = I2C_CCRH_FS;
 444  00f5 a680          	ld	a,#128
 445  00f7 6b07          	ld	(OFST-2,sp),a
 446                     ; 127     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 448  00f9 0d12          	tnz	(OFST+9,sp)
 449  00fb 2630          	jrne	L531
 450                     ; 130       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 452  00fd 96            	ldw	x,sp
 453  00fe 1c000c        	addw	x,#OFST+3
 454  0101 cd0000        	call	c_ltor
 456  0104 a603          	ld	a,#3
 457  0106 cd0000        	call	c_smul
 459  0109 96            	ldw	x,sp
 460  010a 1c0001        	addw	x,#OFST-8
 461  010d cd0000        	call	c_rtol
 463  0110 7b15          	ld	a,(OFST+12,sp)
 464  0112 b703          	ld	c_lreg+3,a
 465  0114 3f02          	clr	c_lreg+2
 466  0116 3f01          	clr	c_lreg+1
 467  0118 3f00          	clr	c_lreg
 468  011a ae0008        	ldw	x,#L25
 469  011d cd0000        	call	c_lmul
 471  0120 96            	ldw	x,sp
 472  0121 1c0001        	addw	x,#OFST-8
 473  0124 cd0000        	call	c_ludv
 475  0127 be02          	ldw	x,c_lreg+2
 476  0129 1f08          	ldw	(OFST-1,sp),x
 478  012b 2034          	jra	L731
 479  012d               L531:
 480                     ; 135       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 482  012d 96            	ldw	x,sp
 483  012e 1c000c        	addw	x,#OFST+3
 484  0131 cd0000        	call	c_ltor
 486  0134 a619          	ld	a,#25
 487  0136 cd0000        	call	c_smul
 489  0139 96            	ldw	x,sp
 490  013a 1c0001        	addw	x,#OFST-8
 491  013d cd0000        	call	c_rtol
 493  0140 7b15          	ld	a,(OFST+12,sp)
 494  0142 b703          	ld	c_lreg+3,a
 495  0144 3f02          	clr	c_lreg+2
 496  0146 3f01          	clr	c_lreg+1
 497  0148 3f00          	clr	c_lreg
 498  014a ae0008        	ldw	x,#L25
 499  014d cd0000        	call	c_lmul
 501  0150 96            	ldw	x,sp
 502  0151 1c0001        	addw	x,#OFST-8
 503  0154 cd0000        	call	c_ludv
 505  0157 be02          	ldw	x,c_lreg+2
 506  0159 1f08          	ldw	(OFST-1,sp),x
 507                     ; 137       tmpccrh |= I2C_CCRH_DUTY;
 509  015b 7b07          	ld	a,(OFST-2,sp)
 510  015d aa40          	or	a,#64
 511  015f 6b07          	ld	(OFST-2,sp),a
 512  0161               L731:
 513                     ; 141     if (result < (uint16_t)0x01)
 515  0161 1e08          	ldw	x,(OFST-1,sp)
 516  0163 2605          	jrne	L141
 517                     ; 144       result = (uint16_t)0x0001;
 519  0165 ae0001        	ldw	x,#1
 520  0168 1f08          	ldw	(OFST-1,sp),x
 521  016a               L141:
 522                     ; 150     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 524  016a 7b15          	ld	a,(OFST+12,sp)
 525  016c 97            	ld	xl,a
 526  016d a603          	ld	a,#3
 527  016f 42            	mul	x,a
 528  0170 a60a          	ld	a,#10
 529  0172 cd0000        	call	c_sdivx
 531  0175 5c            	incw	x
 532  0176 1f05          	ldw	(OFST-4,sp),x
 533                     ; 151     I2C->TRISER = (uint8_t)tmpval;
 535  0178 7b06          	ld	a,(OFST-3,sp)
 536  017a c7521d        	ld	21021,a
 538  017d 2043          	jra	L341
 539  017f               L331:
 540                     ; 158     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 542  017f 96            	ldw	x,sp
 543  0180 1c000c        	addw	x,#OFST+3
 544  0183 cd0000        	call	c_ltor
 546  0186 3803          	sll	c_lreg+3
 547  0188 3902          	rlc	c_lreg+2
 548  018a 3901          	rlc	c_lreg+1
 549  018c 3900          	rlc	c_lreg
 550  018e 96            	ldw	x,sp
 551  018f 1c0001        	addw	x,#OFST-8
 552  0192 cd0000        	call	c_rtol
 554  0195 7b15          	ld	a,(OFST+12,sp)
 555  0197 b703          	ld	c_lreg+3,a
 556  0199 3f02          	clr	c_lreg+2
 557  019b 3f01          	clr	c_lreg+1
 558  019d 3f00          	clr	c_lreg
 559  019f ae0008        	ldw	x,#L25
 560  01a2 cd0000        	call	c_lmul
 562  01a5 96            	ldw	x,sp
 563  01a6 1c0001        	addw	x,#OFST-8
 564  01a9 cd0000        	call	c_ludv
 566  01ac be02          	ldw	x,c_lreg+2
 567  01ae 1f08          	ldw	(OFST-1,sp),x
 568                     ; 161     if (result < (uint16_t)0x0004)
 570  01b0 1e08          	ldw	x,(OFST-1,sp)
 571  01b2 a30004        	cpw	x,#4
 572  01b5 2405          	jruge	L541
 573                     ; 164       result = (uint16_t)0x0004;
 575  01b7 ae0004        	ldw	x,#4
 576  01ba 1f08          	ldw	(OFST-1,sp),x
 577  01bc               L541:
 578                     ; 170     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 580  01bc 7b15          	ld	a,(OFST+12,sp)
 581  01be 4c            	inc	a
 582  01bf c7521d        	ld	21021,a
 583  01c2               L341:
 584                     ; 175   I2C->CCRL = (uint8_t)result;
 586  01c2 7b09          	ld	a,(OFST+0,sp)
 587  01c4 c7521b        	ld	21019,a
 588                     ; 176   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 590  01c7 7b08          	ld	a,(OFST-1,sp)
 591  01c9 a40f          	and	a,#15
 592  01cb 1a07          	or	a,(OFST-2,sp)
 593  01cd c7521c        	ld	21020,a
 594                     ; 179   I2C->CR1 |= I2C_CR1_PE;
 596  01d0 72105210      	bset	21008,#0
 597                     ; 182   I2C_AcknowledgeConfig(Ack);
 599  01d4 7b13          	ld	a,(OFST+10,sp)
 600  01d6 cd0000        	call	_I2C_AcknowledgeConfig
 602                     ; 185   I2C->OARL = (uint8_t)(OwnAddress);
 604  01d9 7b11          	ld	a,(OFST+8,sp)
 605  01db c75213        	ld	21011,a
 606                     ; 186   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 606                     ; 187                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 608  01de 7b10          	ld	a,(OFST+7,sp)
 609  01e0 97            	ld	xl,a
 610  01e1 7b11          	ld	a,(OFST+8,sp)
 611  01e3 9f            	ld	a,xl
 612  01e4 a403          	and	a,#3
 613  01e6 97            	ld	xl,a
 614  01e7 4f            	clr	a
 615  01e8 02            	rlwa	x,a
 616  01e9 4f            	clr	a
 617  01ea 01            	rrwa	x,a
 618  01eb 48            	sll	a
 619  01ec 59            	rlcw	x
 620  01ed 9f            	ld	a,xl
 621  01ee 6b04          	ld	(OFST-5,sp),a
 622  01f0 7b14          	ld	a,(OFST+11,sp)
 623  01f2 aa40          	or	a,#64
 624  01f4 1a04          	or	a,(OFST-5,sp)
 625  01f6 c75214        	ld	21012,a
 626                     ; 188 }
 629  01f9 5b09          	addw	sp,#9
 630  01fb 81            	ret
 686                     ; 196 void I2C_Cmd(FunctionalState NewState)
 686                     ; 197 {
 687                     .text:	section	.text,new
 688  0000               _I2C_Cmd:
 690  0000 88            	push	a
 691       00000000      OFST:	set	0
 694                     ; 200   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 696  0001 4d            	tnz	a
 697  0002 2704          	jreq	L26
 698  0004 a101          	cp	a,#1
 699  0006 2603          	jrne	L06
 700  0008               L26:
 701  0008 4f            	clr	a
 702  0009 2010          	jra	L46
 703  000b               L06:
 704  000b ae00c8        	ldw	x,#200
 705  000e 89            	pushw	x
 706  000f ae0000        	ldw	x,#0
 707  0012 89            	pushw	x
 708  0013 ae000c        	ldw	x,#L131
 709  0016 cd0000        	call	_assert_failed
 711  0019 5b04          	addw	sp,#4
 712  001b               L46:
 713                     ; 202   if (NewState != DISABLE)
 715  001b 0d01          	tnz	(OFST+1,sp)
 716  001d 2706          	jreq	L571
 717                     ; 205     I2C->CR1 |= I2C_CR1_PE;
 719  001f 72105210      	bset	21008,#0
 721  0023 2004          	jra	L771
 722  0025               L571:
 723                     ; 210     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 725  0025 72115210      	bres	21008,#0
 726  0029               L771:
 727                     ; 212 }
 730  0029 84            	pop	a
 731  002a 81            	ret
 767                     ; 220 void I2C_GeneralCallCmd(FunctionalState NewState)
 767                     ; 221 {
 768                     .text:	section	.text,new
 769  0000               _I2C_GeneralCallCmd:
 771  0000 88            	push	a
 772       00000000      OFST:	set	0
 775                     ; 224   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 777  0001 4d            	tnz	a
 778  0002 2704          	jreq	L27
 779  0004 a101          	cp	a,#1
 780  0006 2603          	jrne	L07
 781  0008               L27:
 782  0008 4f            	clr	a
 783  0009 2010          	jra	L47
 784  000b               L07:
 785  000b ae00e0        	ldw	x,#224
 786  000e 89            	pushw	x
 787  000f ae0000        	ldw	x,#0
 788  0012 89            	pushw	x
 789  0013 ae000c        	ldw	x,#L131
 790  0016 cd0000        	call	_assert_failed
 792  0019 5b04          	addw	sp,#4
 793  001b               L47:
 794                     ; 226   if (NewState != DISABLE)
 796  001b 0d01          	tnz	(OFST+1,sp)
 797  001d 2706          	jreq	L712
 798                     ; 229     I2C->CR1 |= I2C_CR1_ENGC;
 800  001f 721c5210      	bset	21008,#6
 802  0023 2004          	jra	L122
 803  0025               L712:
 804                     ; 234     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 806  0025 721d5210      	bres	21008,#6
 807  0029               L122:
 808                     ; 236 }
 811  0029 84            	pop	a
 812  002a 81            	ret
 848                     ; 246 void I2C_GenerateSTART(FunctionalState NewState)
 848                     ; 247 {
 849                     .text:	section	.text,new
 850  0000               _I2C_GenerateSTART:
 852  0000 88            	push	a
 853       00000000      OFST:	set	0
 856                     ; 250   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 858  0001 4d            	tnz	a
 859  0002 2704          	jreq	L201
 860  0004 a101          	cp	a,#1
 861  0006 2603          	jrne	L001
 862  0008               L201:
 863  0008 4f            	clr	a
 864  0009 2010          	jra	L401
 865  000b               L001:
 866  000b ae00fa        	ldw	x,#250
 867  000e 89            	pushw	x
 868  000f ae0000        	ldw	x,#0
 869  0012 89            	pushw	x
 870  0013 ae000c        	ldw	x,#L131
 871  0016 cd0000        	call	_assert_failed
 873  0019 5b04          	addw	sp,#4
 874  001b               L401:
 875                     ; 252   if (NewState != DISABLE)
 877  001b 0d01          	tnz	(OFST+1,sp)
 878  001d 2706          	jreq	L142
 879                     ; 255     I2C->CR2 |= I2C_CR2_START;
 881  001f 72105211      	bset	21009,#0
 883  0023 2004          	jra	L342
 884  0025               L142:
 885                     ; 260     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 887  0025 72115211      	bres	21009,#0
 888  0029               L342:
 889                     ; 262 }
 892  0029 84            	pop	a
 893  002a 81            	ret
 929                     ; 270 void I2C_GenerateSTOP(FunctionalState NewState)
 929                     ; 271 {
 930                     .text:	section	.text,new
 931  0000               _I2C_GenerateSTOP:
 933  0000 88            	push	a
 934       00000000      OFST:	set	0
 937                     ; 274   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 939  0001 4d            	tnz	a
 940  0002 2704          	jreq	L211
 941  0004 a101          	cp	a,#1
 942  0006 2603          	jrne	L011
 943  0008               L211:
 944  0008 4f            	clr	a
 945  0009 2010          	jra	L411
 946  000b               L011:
 947  000b ae0112        	ldw	x,#274
 948  000e 89            	pushw	x
 949  000f ae0000        	ldw	x,#0
 950  0012 89            	pushw	x
 951  0013 ae000c        	ldw	x,#L131
 952  0016 cd0000        	call	_assert_failed
 954  0019 5b04          	addw	sp,#4
 955  001b               L411:
 956                     ; 276   if (NewState != DISABLE)
 958  001b 0d01          	tnz	(OFST+1,sp)
 959  001d 2706          	jreq	L362
 960                     ; 279     I2C->CR2 |= I2C_CR2_STOP;
 962  001f 72125211      	bset	21009,#1
 964  0023 2004          	jra	L562
 965  0025               L362:
 966                     ; 284     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 968  0025 72135211      	bres	21009,#1
 969  0029               L562:
 970                     ; 286 }
 973  0029 84            	pop	a
 974  002a 81            	ret
1011                     ; 294 void I2C_SoftwareResetCmd(FunctionalState NewState)
1011                     ; 295 {
1012                     .text:	section	.text,new
1013  0000               _I2C_SoftwareResetCmd:
1015  0000 88            	push	a
1016       00000000      OFST:	set	0
1019                     ; 297   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1021  0001 4d            	tnz	a
1022  0002 2704          	jreq	L221
1023  0004 a101          	cp	a,#1
1024  0006 2603          	jrne	L021
1025  0008               L221:
1026  0008 4f            	clr	a
1027  0009 2010          	jra	L421
1028  000b               L021:
1029  000b ae0129        	ldw	x,#297
1030  000e 89            	pushw	x
1031  000f ae0000        	ldw	x,#0
1032  0012 89            	pushw	x
1033  0013 ae000c        	ldw	x,#L131
1034  0016 cd0000        	call	_assert_failed
1036  0019 5b04          	addw	sp,#4
1037  001b               L421:
1038                     ; 299   if (NewState != DISABLE)
1040  001b 0d01          	tnz	(OFST+1,sp)
1041  001d 2706          	jreq	L503
1042                     ; 302     I2C->CR2 |= I2C_CR2_SWRST;
1044  001f 721e5211      	bset	21009,#7
1046  0023 2004          	jra	L703
1047  0025               L503:
1048                     ; 307     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
1050  0025 721f5211      	bres	21009,#7
1051  0029               L703:
1052                     ; 309 }
1055  0029 84            	pop	a
1056  002a 81            	ret
1093                     ; 318 void I2C_StretchClockCmd(FunctionalState NewState)
1093                     ; 319 {
1094                     .text:	section	.text,new
1095  0000               _I2C_StretchClockCmd:
1097  0000 88            	push	a
1098       00000000      OFST:	set	0
1101                     ; 321   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1103  0001 4d            	tnz	a
1104  0002 2704          	jreq	L231
1105  0004 a101          	cp	a,#1
1106  0006 2603          	jrne	L031
1107  0008               L231:
1108  0008 4f            	clr	a
1109  0009 2010          	jra	L431
1110  000b               L031:
1111  000b ae0141        	ldw	x,#321
1112  000e 89            	pushw	x
1113  000f ae0000        	ldw	x,#0
1114  0012 89            	pushw	x
1115  0013 ae000c        	ldw	x,#L131
1116  0016 cd0000        	call	_assert_failed
1118  0019 5b04          	addw	sp,#4
1119  001b               L431:
1120                     ; 323   if (NewState != DISABLE)
1122  001b 0d01          	tnz	(OFST+1,sp)
1123  001d 2706          	jreq	L723
1124                     ; 326     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
1126  001f 721f5210      	bres	21008,#7
1128  0023 2004          	jra	L133
1129  0025               L723:
1130                     ; 332     I2C->CR1 |= I2C_CR1_NOSTRETCH;
1132  0025 721e5210      	bset	21008,#7
1133  0029               L133:
1134                     ; 334 }
1137  0029 84            	pop	a
1138  002a 81            	ret
1175                     ; 343 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
1175                     ; 344 {
1176                     .text:	section	.text,new
1177  0000               _I2C_AcknowledgeConfig:
1179  0000 88            	push	a
1180       00000000      OFST:	set	0
1183                     ; 347   assert_param(IS_I2C_ACK_OK(Ack));
1185  0001 4d            	tnz	a
1186  0002 2708          	jreq	L241
1187  0004 a101          	cp	a,#1
1188  0006 2704          	jreq	L241
1189  0008 a102          	cp	a,#2
1190  000a 2603          	jrne	L041
1191  000c               L241:
1192  000c 4f            	clr	a
1193  000d 2010          	jra	L441
1194  000f               L041:
1195  000f ae015b        	ldw	x,#347
1196  0012 89            	pushw	x
1197  0013 ae0000        	ldw	x,#0
1198  0016 89            	pushw	x
1199  0017 ae000c        	ldw	x,#L131
1200  001a cd0000        	call	_assert_failed
1202  001d 5b04          	addw	sp,#4
1203  001f               L441:
1204                     ; 349   if (Ack == I2C_ACK_NONE)
1206  001f 0d01          	tnz	(OFST+1,sp)
1207  0021 2606          	jrne	L153
1208                     ; 352     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
1210  0023 72155211      	bres	21009,#2
1212  0027 2014          	jra	L353
1213  0029               L153:
1214                     ; 357     I2C->CR2 |= I2C_CR2_ACK;
1216  0029 72145211      	bset	21009,#2
1217                     ; 359     if (Ack == I2C_ACK_CURR)
1219  002d 7b01          	ld	a,(OFST+1,sp)
1220  002f a101          	cp	a,#1
1221  0031 2606          	jrne	L553
1222                     ; 362       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
1224  0033 72175211      	bres	21009,#3
1226  0037 2004          	jra	L353
1227  0039               L553:
1228                     ; 367       I2C->CR2 |= I2C_CR2_POS;
1230  0039 72165211      	bset	21009,#3
1231  003d               L353:
1232                     ; 370 }
1235  003d 84            	pop	a
1236  003e 81            	ret
1309                     ; 380 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1309                     ; 381 {
1310                     .text:	section	.text,new
1311  0000               _I2C_ITConfig:
1313  0000 89            	pushw	x
1314       00000000      OFST:	set	0
1317                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1319  0001 9e            	ld	a,xh
1320  0002 a101          	cp	a,#1
1321  0004 271e          	jreq	L251
1322  0006 9e            	ld	a,xh
1323  0007 a102          	cp	a,#2
1324  0009 2719          	jreq	L251
1325  000b 9e            	ld	a,xh
1326  000c a104          	cp	a,#4
1327  000e 2714          	jreq	L251
1328  0010 9e            	ld	a,xh
1329  0011 a103          	cp	a,#3
1330  0013 270f          	jreq	L251
1331  0015 9e            	ld	a,xh
1332  0016 a105          	cp	a,#5
1333  0018 270a          	jreq	L251
1334  001a 9e            	ld	a,xh
1335  001b a106          	cp	a,#6
1336  001d 2705          	jreq	L251
1337  001f 9e            	ld	a,xh
1338  0020 a107          	cp	a,#7
1339  0022 2603          	jrne	L051
1340  0024               L251:
1341  0024 4f            	clr	a
1342  0025 2010          	jra	L451
1343  0027               L051:
1344  0027 ae0180        	ldw	x,#384
1345  002a 89            	pushw	x
1346  002b ae0000        	ldw	x,#0
1347  002e 89            	pushw	x
1348  002f ae000c        	ldw	x,#L131
1349  0032 cd0000        	call	_assert_failed
1351  0035 5b04          	addw	sp,#4
1352  0037               L451:
1353                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1355  0037 0d02          	tnz	(OFST+2,sp)
1356  0039 2706          	jreq	L061
1357  003b 7b02          	ld	a,(OFST+2,sp)
1358  003d a101          	cp	a,#1
1359  003f 2603          	jrne	L651
1360  0041               L061:
1361  0041 4f            	clr	a
1362  0042 2010          	jra	L261
1363  0044               L651:
1364  0044 ae0181        	ldw	x,#385
1365  0047 89            	pushw	x
1366  0048 ae0000        	ldw	x,#0
1367  004b 89            	pushw	x
1368  004c ae000c        	ldw	x,#L131
1369  004f cd0000        	call	_assert_failed
1371  0052 5b04          	addw	sp,#4
1372  0054               L261:
1373                     ; 387   if (NewState != DISABLE)
1375  0054 0d02          	tnz	(OFST+2,sp)
1376  0056 270a          	jreq	L514
1377                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1379  0058 c6521a        	ld	a,21018
1380  005b 1a01          	or	a,(OFST+1,sp)
1381  005d c7521a        	ld	21018,a
1383  0060 2009          	jra	L714
1384  0062               L514:
1385                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1387  0062 7b01          	ld	a,(OFST+1,sp)
1388  0064 43            	cpl	a
1389  0065 c4521a        	and	a,21018
1390  0068 c7521a        	ld	21018,a
1391  006b               L714:
1392                     ; 397 }
1395  006b 85            	popw	x
1396  006c 81            	ret
1433                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1433                     ; 406 {
1434                     .text:	section	.text,new
1435  0000               _I2C_FastModeDutyCycleConfig:
1437  0000 88            	push	a
1438       00000000      OFST:	set	0
1441                     ; 409   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1443  0001 4d            	tnz	a
1444  0002 2704          	jreq	L071
1445  0004 a140          	cp	a,#64
1446  0006 2603          	jrne	L661
1447  0008               L071:
1448  0008 4f            	clr	a
1449  0009 2010          	jra	L271
1450  000b               L661:
1451  000b ae0199        	ldw	x,#409
1452  000e 89            	pushw	x
1453  000f ae0000        	ldw	x,#0
1454  0012 89            	pushw	x
1455  0013 ae000c        	ldw	x,#L131
1456  0016 cd0000        	call	_assert_failed
1458  0019 5b04          	addw	sp,#4
1459  001b               L271:
1460                     ; 411   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1462  001b 7b01          	ld	a,(OFST+1,sp)
1463  001d a140          	cp	a,#64
1464  001f 2606          	jrne	L734
1465                     ; 414     I2C->CCRH |= I2C_CCRH_DUTY;
1467  0021 721c521c      	bset	21020,#6
1469  0025 2004          	jra	L144
1470  0027               L734:
1471                     ; 419     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1473  0027 721d521c      	bres	21020,#6
1474  002b               L144:
1475                     ; 421 }
1478  002b 84            	pop	a
1479  002c 81            	ret
1502                     ; 428 uint8_t I2C_ReceiveData(void)
1502                     ; 429 {
1503                     .text:	section	.text,new
1504  0000               _I2C_ReceiveData:
1508                     ; 431   return ((uint8_t)I2C->DR);
1510  0000 c65216        	ld	a,21014
1513  0003 81            	ret
1579                     ; 441 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1579                     ; 442 {
1580                     .text:	section	.text,new
1581  0000               _I2C_Send7bitAddress:
1583  0000 89            	pushw	x
1584       00000000      OFST:	set	0
1587                     ; 444   assert_param(IS_I2C_ADDRESS_OK(Address));
1589  0001 9e            	ld	a,xh
1590  0002 a501          	bcp	a,#1
1591  0004 2603          	jrne	L002
1592  0006 4f            	clr	a
1593  0007 2010          	jra	L202
1594  0009               L002:
1595  0009 ae01bc        	ldw	x,#444
1596  000c 89            	pushw	x
1597  000d ae0000        	ldw	x,#0
1598  0010 89            	pushw	x
1599  0011 ae000c        	ldw	x,#L131
1600  0014 cd0000        	call	_assert_failed
1602  0017 5b04          	addw	sp,#4
1603  0019               L202:
1604                     ; 445   assert_param(IS_I2C_DIRECTION_OK(Direction));
1606  0019 0d02          	tnz	(OFST+2,sp)
1607  001b 2706          	jreq	L602
1608  001d 7b02          	ld	a,(OFST+2,sp)
1609  001f a101          	cp	a,#1
1610  0021 2603          	jrne	L402
1611  0023               L602:
1612  0023 4f            	clr	a
1613  0024 2010          	jra	L012
1614  0026               L402:
1615  0026 ae01bd        	ldw	x,#445
1616  0029 89            	pushw	x
1617  002a ae0000        	ldw	x,#0
1618  002d 89            	pushw	x
1619  002e ae000c        	ldw	x,#L131
1620  0031 cd0000        	call	_assert_failed
1622  0034 5b04          	addw	sp,#4
1623  0036               L012:
1624                     ; 448   Address &= (uint8_t)0xFE;
1626  0036 7b01          	ld	a,(OFST+1,sp)
1627  0038 a4fe          	and	a,#254
1628  003a 6b01          	ld	(OFST+1,sp),a
1629                     ; 451   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1631  003c 7b01          	ld	a,(OFST+1,sp)
1632  003e 1a02          	or	a,(OFST+2,sp)
1633  0040 c75216        	ld	21014,a
1634                     ; 452 }
1637  0043 85            	popw	x
1638  0044 81            	ret
1672                     ; 459 void I2C_SendData(uint8_t Data)
1672                     ; 460 {
1673                     .text:	section	.text,new
1674  0000               _I2C_SendData:
1678                     ; 462   I2C->DR = Data;
1680  0000 c75216        	ld	21014,a
1681                     ; 463 }
1684  0003 81            	ret
1909                     ; 579 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1909                     ; 580 {
1910                     .text:	section	.text,new
1911  0000               _I2C_CheckEvent:
1913  0000 89            	pushw	x
1914  0001 5206          	subw	sp,#6
1915       00000006      OFST:	set	6
1918                     ; 581   __IO uint16_t lastevent = 0x00;
1920  0003 5f            	clrw	x
1921  0004 1f04          	ldw	(OFST-2,sp),x
1922                     ; 582   uint8_t flag1 = 0x00 ;
1924                     ; 583   uint8_t flag2 = 0x00;
1926                     ; 584   ErrorStatus status = ERROR;
1928                     ; 587   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1930  0006 1e07          	ldw	x,(OFST+1,sp)
1931  0008 a30682        	cpw	x,#1666
1932  000b 2769          	jreq	L022
1933  000d 1e07          	ldw	x,(OFST+1,sp)
1934  000f a30202        	cpw	x,#514
1935  0012 2762          	jreq	L022
1936  0014 1e07          	ldw	x,(OFST+1,sp)
1937  0016 a31200        	cpw	x,#4608
1938  0019 275b          	jreq	L022
1939  001b 1e07          	ldw	x,(OFST+1,sp)
1940  001d a30240        	cpw	x,#576
1941  0020 2754          	jreq	L022
1942  0022 1e07          	ldw	x,(OFST+1,sp)
1943  0024 a30350        	cpw	x,#848
1944  0027 274d          	jreq	L022
1945  0029 1e07          	ldw	x,(OFST+1,sp)
1946  002b a30684        	cpw	x,#1668
1947  002e 2746          	jreq	L022
1948  0030 1e07          	ldw	x,(OFST+1,sp)
1949  0032 a30794        	cpw	x,#1940
1950  0035 273f          	jreq	L022
1951  0037 1e07          	ldw	x,(OFST+1,sp)
1952  0039 a30004        	cpw	x,#4
1953  003c 2738          	jreq	L022
1954  003e 1e07          	ldw	x,(OFST+1,sp)
1955  0040 a30010        	cpw	x,#16
1956  0043 2731          	jreq	L022
1957  0045 1e07          	ldw	x,(OFST+1,sp)
1958  0047 a30301        	cpw	x,#769
1959  004a 272a          	jreq	L022
1960  004c 1e07          	ldw	x,(OFST+1,sp)
1961  004e a30782        	cpw	x,#1922
1962  0051 2723          	jreq	L022
1963  0053 1e07          	ldw	x,(OFST+1,sp)
1964  0055 a30302        	cpw	x,#770
1965  0058 271c          	jreq	L022
1966  005a 1e07          	ldw	x,(OFST+1,sp)
1967  005c a30340        	cpw	x,#832
1968  005f 2715          	jreq	L022
1969  0061 1e07          	ldw	x,(OFST+1,sp)
1970  0063 a30784        	cpw	x,#1924
1971  0066 270e          	jreq	L022
1972  0068 1e07          	ldw	x,(OFST+1,sp)
1973  006a a30780        	cpw	x,#1920
1974  006d 2707          	jreq	L022
1975  006f 1e07          	ldw	x,(OFST+1,sp)
1976  0071 a30308        	cpw	x,#776
1977  0074 2603          	jrne	L612
1978  0076               L022:
1979  0076 4f            	clr	a
1980  0077 2010          	jra	L222
1981  0079               L612:
1982  0079 ae024b        	ldw	x,#587
1983  007c 89            	pushw	x
1984  007d ae0000        	ldw	x,#0
1985  0080 89            	pushw	x
1986  0081 ae000c        	ldw	x,#L131
1987  0084 cd0000        	call	_assert_failed
1989  0087 5b04          	addw	sp,#4
1990  0089               L222:
1991                     ; 589   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1993  0089 1e07          	ldw	x,(OFST+1,sp)
1994  008b a30004        	cpw	x,#4
1995  008e 260b          	jrne	L336
1996                     ; 591     lastevent = I2C->SR2 & I2C_SR2_AF;
1998  0090 c65218        	ld	a,21016
1999  0093 a404          	and	a,#4
2000  0095 5f            	clrw	x
2001  0096 97            	ld	xl,a
2002  0097 1f04          	ldw	(OFST-2,sp),x
2004  0099 201f          	jra	L536
2005  009b               L336:
2006                     ; 595     flag1 = I2C->SR1;
2008  009b c65217        	ld	a,21015
2009  009e 6b03          	ld	(OFST-3,sp),a
2010                     ; 596     flag2 = I2C->SR3;
2012  00a0 c65219        	ld	a,21017
2013  00a3 6b06          	ld	(OFST+0,sp),a
2014                     ; 597     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
2016  00a5 7b03          	ld	a,(OFST-3,sp)
2017  00a7 5f            	clrw	x
2018  00a8 97            	ld	xl,a
2019  00a9 1f01          	ldw	(OFST-5,sp),x
2020  00ab 7b06          	ld	a,(OFST+0,sp)
2021  00ad 5f            	clrw	x
2022  00ae 97            	ld	xl,a
2023  00af 4f            	clr	a
2024  00b0 02            	rlwa	x,a
2025  00b1 01            	rrwa	x,a
2026  00b2 1a02          	or	a,(OFST-4,sp)
2027  00b4 01            	rrwa	x,a
2028  00b5 1a01          	or	a,(OFST-5,sp)
2029  00b7 01            	rrwa	x,a
2030  00b8 1f04          	ldw	(OFST-2,sp),x
2031  00ba               L536:
2032                     ; 600   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
2034  00ba 1e04          	ldw	x,(OFST-2,sp)
2035  00bc 01            	rrwa	x,a
2036  00bd 1408          	and	a,(OFST+2,sp)
2037  00bf 01            	rrwa	x,a
2038  00c0 1407          	and	a,(OFST+1,sp)
2039  00c2 01            	rrwa	x,a
2040  00c3 1307          	cpw	x,(OFST+1,sp)
2041  00c5 2606          	jrne	L736
2042                     ; 603     status = SUCCESS;
2044  00c7 a601          	ld	a,#1
2045  00c9 6b06          	ld	(OFST+0,sp),a
2047  00cb 2002          	jra	L146
2048  00cd               L736:
2049                     ; 608     status = ERROR;
2051  00cd 0f06          	clr	(OFST+0,sp)
2052  00cf               L146:
2053                     ; 612   return status;
2055  00cf 7b06          	ld	a,(OFST+0,sp)
2058  00d1 5b08          	addw	sp,#8
2059  00d3 81            	ret
2112                     ; 629 I2C_Event_TypeDef I2C_GetLastEvent(void)
2112                     ; 630 {
2113                     .text:	section	.text,new
2114  0000               _I2C_GetLastEvent:
2116  0000 5206          	subw	sp,#6
2117       00000006      OFST:	set	6
2120                     ; 631   __IO uint16_t lastevent = 0;
2122  0002 5f            	clrw	x
2123  0003 1f05          	ldw	(OFST-1,sp),x
2124                     ; 632   uint16_t flag1 = 0;
2126                     ; 633   uint16_t flag2 = 0;
2128                     ; 635   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
2130  0005 c65218        	ld	a,21016
2131  0008 a504          	bcp	a,#4
2132  000a 2707          	jreq	L176
2133                     ; 637     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
2135  000c ae0004        	ldw	x,#4
2136  000f 1f05          	ldw	(OFST-1,sp),x
2138  0011 201b          	jra	L376
2139  0013               L176:
2140                     ; 642     flag1 = I2C->SR1;
2142  0013 c65217        	ld	a,21015
2143  0016 5f            	clrw	x
2144  0017 97            	ld	xl,a
2145  0018 1f01          	ldw	(OFST-5,sp),x
2146                     ; 643     flag2 = I2C->SR3;
2148  001a c65219        	ld	a,21017
2149  001d 5f            	clrw	x
2150  001e 97            	ld	xl,a
2151  001f 1f03          	ldw	(OFST-3,sp),x
2152                     ; 646     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
2154  0021 1e03          	ldw	x,(OFST-3,sp)
2155  0023 4f            	clr	a
2156  0024 02            	rlwa	x,a
2157  0025 01            	rrwa	x,a
2158  0026 1a02          	or	a,(OFST-4,sp)
2159  0028 01            	rrwa	x,a
2160  0029 1a01          	or	a,(OFST-5,sp)
2161  002b 01            	rrwa	x,a
2162  002c 1f05          	ldw	(OFST-1,sp),x
2163  002e               L376:
2164                     ; 649   return (I2C_Event_TypeDef)lastevent;
2166  002e 1e05          	ldw	x,(OFST-1,sp)
2169  0030 5b06          	addw	sp,#6
2170  0032 81            	ret
2386                     ; 680 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
2386                     ; 681 {
2387                     .text:	section	.text,new
2388  0000               _I2C_GetFlagStatus:
2390  0000 89            	pushw	x
2391  0001 89            	pushw	x
2392       00000002      OFST:	set	2
2395                     ; 682   uint8_t tempreg = 0;
2397  0002 0f02          	clr	(OFST+0,sp)
2398                     ; 683   uint8_t regindex = 0;
2400                     ; 684   FlagStatus bitstatus = RESET;
2402                     ; 687   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
2404  0004 a30180        	cpw	x,#384
2405  0007 274b          	jreq	L232
2406  0009 a30140        	cpw	x,#320
2407  000c 2746          	jreq	L232
2408  000e a30110        	cpw	x,#272
2409  0011 2741          	jreq	L232
2410  0013 a30108        	cpw	x,#264
2411  0016 273c          	jreq	L232
2412  0018 a30104        	cpw	x,#260
2413  001b 2737          	jreq	L232
2414  001d a30102        	cpw	x,#258
2415  0020 2732          	jreq	L232
2416  0022 a30101        	cpw	x,#257
2417  0025 272d          	jreq	L232
2418  0027 a30220        	cpw	x,#544
2419  002a 2728          	jreq	L232
2420  002c a30208        	cpw	x,#520
2421  002f 2723          	jreq	L232
2422  0031 a30204        	cpw	x,#516
2423  0034 271e          	jreq	L232
2424  0036 a30202        	cpw	x,#514
2425  0039 2719          	jreq	L232
2426  003b a30201        	cpw	x,#513
2427  003e 2714          	jreq	L232
2428  0040 a30310        	cpw	x,#784
2429  0043 270f          	jreq	L232
2430  0045 a30304        	cpw	x,#772
2431  0048 270a          	jreq	L232
2432  004a a30302        	cpw	x,#770
2433  004d 2705          	jreq	L232
2434  004f a30301        	cpw	x,#769
2435  0052 2603          	jrne	L032
2436  0054               L232:
2437  0054 4f            	clr	a
2438  0055 2010          	jra	L432
2439  0057               L032:
2440  0057 ae02af        	ldw	x,#687
2441  005a 89            	pushw	x
2442  005b ae0000        	ldw	x,#0
2443  005e 89            	pushw	x
2444  005f ae000c        	ldw	x,#L131
2445  0062 cd0000        	call	_assert_failed
2447  0065 5b04          	addw	sp,#4
2448  0067               L432:
2449                     ; 690   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
2451  0067 7b03          	ld	a,(OFST+1,sp)
2452  0069 6b01          	ld	(OFST-1,sp),a
2453                     ; 692   switch (regindex)
2455  006b 7b01          	ld	a,(OFST-1,sp)
2457                     ; 709     default:
2457                     ; 710       break;
2458  006d 4a            	dec	a
2459  006e 2708          	jreq	L576
2460  0070 4a            	dec	a
2461  0071 270c          	jreq	L776
2462  0073 4a            	dec	a
2463  0074 2710          	jreq	L107
2464  0076 2013          	jra	L5101
2465  0078               L576:
2466                     ; 695     case 0x01:
2466                     ; 696       tempreg = (uint8_t)I2C->SR1;
2468  0078 c65217        	ld	a,21015
2469  007b 6b02          	ld	(OFST+0,sp),a
2470                     ; 697       break;
2472  007d 200c          	jra	L5101
2473  007f               L776:
2474                     ; 700     case 0x02:
2474                     ; 701       tempreg = (uint8_t)I2C->SR2;
2476  007f c65218        	ld	a,21016
2477  0082 6b02          	ld	(OFST+0,sp),a
2478                     ; 702       break;
2480  0084 2005          	jra	L5101
2481  0086               L107:
2482                     ; 705     case 0x03:
2482                     ; 706       tempreg = (uint8_t)I2C->SR3;
2484  0086 c65219        	ld	a,21017
2485  0089 6b02          	ld	(OFST+0,sp),a
2486                     ; 707       break;
2488  008b               L307:
2489                     ; 709     default:
2489                     ; 710       break;
2491  008b               L5101:
2492                     ; 714   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2494  008b 7b04          	ld	a,(OFST+2,sp)
2495  008d 1502          	bcp	a,(OFST+0,sp)
2496  008f 2706          	jreq	L7101
2497                     ; 717     bitstatus = SET;
2499  0091 a601          	ld	a,#1
2500  0093 6b02          	ld	(OFST+0,sp),a
2502  0095 2002          	jra	L1201
2503  0097               L7101:
2504                     ; 722     bitstatus = RESET;
2506  0097 0f02          	clr	(OFST+0,sp)
2507  0099               L1201:
2508                     ; 725   return bitstatus;
2510  0099 7b02          	ld	a,(OFST+0,sp)
2513  009b 5b04          	addw	sp,#4
2514  009d 81            	ret
2559                     ; 760 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2559                     ; 761 {
2560                     .text:	section	.text,new
2561  0000               _I2C_ClearFlag:
2563  0000 89            	pushw	x
2564  0001 89            	pushw	x
2565       00000002      OFST:	set	2
2568                     ; 762   uint16_t flagpos = 0;
2570                     ; 764   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2572  0002 01            	rrwa	x,a
2573  0003 9f            	ld	a,xl
2574  0004 a4fd          	and	a,#253
2575  0006 97            	ld	xl,a
2576  0007 4f            	clr	a
2577  0008 02            	rlwa	x,a
2578  0009 5d            	tnzw	x
2579  000a 2607          	jrne	L042
2580  000c 1e03          	ldw	x,(OFST+1,sp)
2581  000e 2703          	jreq	L042
2582  0010 4f            	clr	a
2583  0011 2010          	jra	L242
2584  0013               L042:
2585  0013 ae02fc        	ldw	x,#764
2586  0016 89            	pushw	x
2587  0017 ae0000        	ldw	x,#0
2588  001a 89            	pushw	x
2589  001b ae000c        	ldw	x,#L131
2590  001e cd0000        	call	_assert_failed
2592  0021 5b04          	addw	sp,#4
2593  0023               L242:
2594                     ; 767   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2596  0023 7b03          	ld	a,(OFST+1,sp)
2597  0025 97            	ld	xl,a
2598  0026 7b04          	ld	a,(OFST+2,sp)
2599  0028 a4ff          	and	a,#255
2600  002a 5f            	clrw	x
2601  002b 02            	rlwa	x,a
2602  002c 1f01          	ldw	(OFST-1,sp),x
2603  002e 01            	rrwa	x,a
2604                     ; 769   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2606  002f 7b02          	ld	a,(OFST+0,sp)
2607  0031 43            	cpl	a
2608  0032 c75218        	ld	21016,a
2609                     ; 770 }
2612  0035 5b04          	addw	sp,#4
2613  0037 81            	ret
2780                     ; 792 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2780                     ; 793 {
2781                     .text:	section	.text,new
2782  0000               _I2C_GetITStatus:
2784  0000 89            	pushw	x
2785  0001 5204          	subw	sp,#4
2786       00000004      OFST:	set	4
2789                     ; 794   ITStatus bitstatus = RESET;
2791                     ; 795   __IO uint8_t enablestatus = 0;
2793  0003 0f03          	clr	(OFST-1,sp)
2794                     ; 796   uint16_t tempregister = 0;
2796                     ; 799     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2798  0005 a31680        	cpw	x,#5760
2799  0008 2737          	jreq	L052
2800  000a a31640        	cpw	x,#5696
2801  000d 2732          	jreq	L052
2802  000f a31210        	cpw	x,#4624
2803  0012 272d          	jreq	L052
2804  0014 a31208        	cpw	x,#4616
2805  0017 2728          	jreq	L052
2806  0019 a31204        	cpw	x,#4612
2807  001c 2723          	jreq	L052
2808  001e a31202        	cpw	x,#4610
2809  0021 271e          	jreq	L052
2810  0023 a31201        	cpw	x,#4609
2811  0026 2719          	jreq	L052
2812  0028 a32220        	cpw	x,#8736
2813  002b 2714          	jreq	L052
2814  002d a32108        	cpw	x,#8456
2815  0030 270f          	jreq	L052
2816  0032 a32104        	cpw	x,#8452
2817  0035 270a          	jreq	L052
2818  0037 a32102        	cpw	x,#8450
2819  003a 2705          	jreq	L052
2820  003c a32101        	cpw	x,#8449
2821  003f 2603          	jrne	L642
2822  0041               L052:
2823  0041 4f            	clr	a
2824  0042 2010          	jra	L252
2825  0044               L642:
2826  0044 ae031f        	ldw	x,#799
2827  0047 89            	pushw	x
2828  0048 ae0000        	ldw	x,#0
2829  004b 89            	pushw	x
2830  004c ae000c        	ldw	x,#L131
2831  004f cd0000        	call	_assert_failed
2833  0052 5b04          	addw	sp,#4
2834  0054               L252:
2835                     ; 801   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2837  0054 7b05          	ld	a,(OFST+1,sp)
2838  0056 97            	ld	xl,a
2839  0057 7b06          	ld	a,(OFST+2,sp)
2840  0059 9f            	ld	a,xl
2841  005a a407          	and	a,#7
2842  005c 97            	ld	xl,a
2843  005d 4f            	clr	a
2844  005e 02            	rlwa	x,a
2845  005f 4f            	clr	a
2846  0060 01            	rrwa	x,a
2847  0061 9f            	ld	a,xl
2848  0062 5f            	clrw	x
2849  0063 97            	ld	xl,a
2850  0064 1f01          	ldw	(OFST-3,sp),x
2851                     ; 804   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2853  0066 c6521a        	ld	a,21018
2854  0069 1402          	and	a,(OFST-2,sp)
2855  006b 6b03          	ld	(OFST-1,sp),a
2856                     ; 806   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2858  006d 7b05          	ld	a,(OFST+1,sp)
2859  006f 97            	ld	xl,a
2860  0070 7b06          	ld	a,(OFST+2,sp)
2861  0072 9f            	ld	a,xl
2862  0073 a430          	and	a,#48
2863  0075 97            	ld	xl,a
2864  0076 4f            	clr	a
2865  0077 02            	rlwa	x,a
2866  0078 a30100        	cpw	x,#256
2867  007b 2615          	jrne	L3311
2868                     ; 809     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2870  007d c65217        	ld	a,21015
2871  0080 1506          	bcp	a,(OFST+2,sp)
2872  0082 270a          	jreq	L5311
2874  0084 0d03          	tnz	(OFST-1,sp)
2875  0086 2706          	jreq	L5311
2876                     ; 812       bitstatus = SET;
2878  0088 a601          	ld	a,#1
2879  008a 6b04          	ld	(OFST+0,sp),a
2881  008c 2017          	jra	L1411
2882  008e               L5311:
2883                     ; 817       bitstatus = RESET;
2885  008e 0f04          	clr	(OFST+0,sp)
2886  0090 2013          	jra	L1411
2887  0092               L3311:
2888                     ; 823     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2890  0092 c65218        	ld	a,21016
2891  0095 1506          	bcp	a,(OFST+2,sp)
2892  0097 270a          	jreq	L3411
2894  0099 0d03          	tnz	(OFST-1,sp)
2895  009b 2706          	jreq	L3411
2896                     ; 826       bitstatus = SET;
2898  009d a601          	ld	a,#1
2899  009f 6b04          	ld	(OFST+0,sp),a
2901  00a1 2002          	jra	L1411
2902  00a3               L3411:
2903                     ; 831       bitstatus = RESET;
2905  00a3 0f04          	clr	(OFST+0,sp)
2906  00a5               L1411:
2907                     ; 835   return  bitstatus;
2909  00a5 7b04          	ld	a,(OFST+0,sp)
2912  00a7 5b06          	addw	sp,#6
2913  00a9 81            	ret
2959                     ; 873 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2959                     ; 874 {
2960                     .text:	section	.text,new
2961  0000               _I2C_ClearITPendingBit:
2963  0000 89            	pushw	x
2964  0001 89            	pushw	x
2965       00000002      OFST:	set	2
2968                     ; 875   uint16_t flagpos = 0;
2970                     ; 878   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2972  0002 a32220        	cpw	x,#8736
2973  0005 2714          	jreq	L062
2974  0007 a32108        	cpw	x,#8456
2975  000a 270f          	jreq	L062
2976  000c a32104        	cpw	x,#8452
2977  000f 270a          	jreq	L062
2978  0011 a32102        	cpw	x,#8450
2979  0014 2705          	jreq	L062
2980  0016 a32101        	cpw	x,#8449
2981  0019 2603          	jrne	L652
2982  001b               L062:
2983  001b 4f            	clr	a
2984  001c 2010          	jra	L262
2985  001e               L652:
2986  001e ae036e        	ldw	x,#878
2987  0021 89            	pushw	x
2988  0022 ae0000        	ldw	x,#0
2989  0025 89            	pushw	x
2990  0026 ae000c        	ldw	x,#L131
2991  0029 cd0000        	call	_assert_failed
2993  002c 5b04          	addw	sp,#4
2994  002e               L262:
2995                     ; 881   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2997  002e 7b03          	ld	a,(OFST+1,sp)
2998  0030 97            	ld	xl,a
2999  0031 7b04          	ld	a,(OFST+2,sp)
3000  0033 a4ff          	and	a,#255
3001  0035 5f            	clrw	x
3002  0036 02            	rlwa	x,a
3003  0037 1f01          	ldw	(OFST-1,sp),x
3004  0039 01            	rrwa	x,a
3005                     ; 884   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
3007  003a 7b02          	ld	a,(OFST+0,sp)
3008  003c 43            	cpl	a
3009  003d c75218        	ld	21016,a
3010                     ; 885 }
3013  0040 5b04          	addw	sp,#4
3014  0042 81            	ret
3027                     	xdef	_I2C_ClearITPendingBit
3028                     	xdef	_I2C_GetITStatus
3029                     	xdef	_I2C_ClearFlag
3030                     	xdef	_I2C_GetFlagStatus
3031                     	xdef	_I2C_GetLastEvent
3032                     	xdef	_I2C_CheckEvent
3033                     	xdef	_I2C_SendData
3034                     	xdef	_I2C_Send7bitAddress
3035                     	xdef	_I2C_ReceiveData
3036                     	xdef	_I2C_ITConfig
3037                     	xdef	_I2C_FastModeDutyCycleConfig
3038                     	xdef	_I2C_AcknowledgeConfig
3039                     	xdef	_I2C_StretchClockCmd
3040                     	xdef	_I2C_SoftwareResetCmd
3041                     	xdef	_I2C_GenerateSTOP
3042                     	xdef	_I2C_GenerateSTART
3043                     	xdef	_I2C_GeneralCallCmd
3044                     	xdef	_I2C_Cmd
3045                     	xdef	_I2C_Init
3046                     	xdef	_I2C_DeInit
3047                     	xref	_assert_failed
3048                     	switch	.const
3049  000c               L131:
3050  000c 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
3051  001e 697665725c73  	dc.b	"iver\src\stm8s_i2c"
3052  0030 2e6300        	dc.b	".c",0
3053                     	xref.b	c_lreg
3054                     	xref.b	c_x
3074                     	xref	c_sdivx
3075                     	xref	c_ludv
3076                     	xref	c_rtol
3077                     	xref	c_smul
3078                     	xref	c_lmul
3079                     	xref	c_lcmp
3080                     	xref	c_ltor
3081                     	xref	c_lzmp
3082                     	end
