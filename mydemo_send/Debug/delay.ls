   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  56                     ; 4 void simple_delay_us(unsigned short n) 
  56                     ; 5 {
  58                     .text:	section	.text,new
  59  0000               _simple_delay_us:
  61  0000 89            	pushw	x
  62       00000000      OFST:	set	0
  65  0001 200a          	jra	L33
  66  0003               L72:
  67                     ; 8         _asm("nop"); //在STM8里面，16M晶振，_nop_() 延时了 333ns
  70  0003 9d            nop
  72                     ; 9         _asm("nop"); 
  75  0004 9d            nop
  77                     ; 10         _asm("nop"); 
  80  0005 9d            nop
  82                     ; 6     for(;n>0;n--) 
  84  0006 1e01          	ldw	x,(OFST+1,sp)
  85  0008 1d0001        	subw	x,#1
  86  000b 1f01          	ldw	(OFST+1,sp),x
  87  000d               L33:
  90  000d 1e01          	ldw	x,(OFST+1,sp)
  91  000f 26f2          	jrne	L72
  92                     ; 13 }
  95  0011 85            	popw	x
  96  0012 81            	ret
 140                     ; 16 void simple_delay_ms(unsigned short time) 
 140                     ; 17 { 
 141                     .text:	section	.text,new
 142  0000               _simple_delay_ms:
 144  0000 89            	pushw	x
 145  0001 89            	pushw	x
 146       00000002      OFST:	set	2
 149  0002 2016          	jra	L36
 150  0004               L16:
 151                     ; 21         for(i=900;i>0;i--) 
 153  0004 ae0384        	ldw	x,#900
 154  0007 1f01          	ldw	(OFST-1,sp),x
 155  0009               L76:
 156                     ; 22             simple_delay_us(1);
 158  0009 ae0001        	ldw	x,#1
 159  000c cd0000        	call	_simple_delay_us
 161                     ; 21         for(i=900;i>0;i--) 
 163  000f 1e01          	ldw	x,(OFST-1,sp)
 164  0011 1d0001        	subw	x,#1
 165  0014 1f01          	ldw	(OFST-1,sp),x
 168  0016 1e01          	ldw	x,(OFST-1,sp)
 169  0018 26ef          	jrne	L76
 170  001a               L36:
 171                     ; 19     while(time--)
 173  001a 1e03          	ldw	x,(OFST+1,sp)
 174  001c 1d0001        	subw	x,#1
 175  001f 1f03          	ldw	(OFST+1,sp),x
 176  0021 1c0001        	addw	x,#1
 177  0024 a30000        	cpw	x,#0
 178  0027 26db          	jrne	L16
 179                     ; 25 }
 182  0029 5b04          	addw	sp,#4
 183  002b 81            	ret
 217                     ; 28 void delay_us(unsigned int us)
 217                     ; 29 {
 218                     .text:	section	.text,new
 219  0000               _delay_us:
 221  0000 89            	pushw	x
 222       00000000      OFST:	set	0
 225  0001 2002          	jra	L511
 226  0003               L311:
 227                     ; 32 		_asm("nop");
 230  0003 9d            nop
 232                     ; 33 		_asm("nop");
 235  0004 9d            nop
 237  0005               L511:
 238                     ; 30 	while(us--)
 240  0005 1e01          	ldw	x,(OFST+1,sp)
 241  0007 1d0001        	subw	x,#1
 242  000a 1f01          	ldw	(OFST+1,sp),x
 243  000c 1c0001        	addw	x,#1
 244  000f a30000        	cpw	x,#0
 245  0012 26ef          	jrne	L311
 246                     ; 35 }
 249  0014 85            	popw	x
 250  0015 81            	ret
 293                     ; 38 void delay_ms(unsigned int ms)
 293                     ; 39 {
 294                     .text:	section	.text,new
 295  0000               _delay_ms:
 297  0000 89            	pushw	x
 298  0001 89            	pushw	x
 299       00000002      OFST:	set	2
 302  0002 2012          	jra	L541
 303  0004               L341:
 304                     ; 43 		for(i=0;i<1250;i++);
 306  0004 5f            	clrw	x
 307  0005 1f01          	ldw	(OFST-1,sp),x
 308  0007               L151:
 312  0007 1e01          	ldw	x,(OFST-1,sp)
 313  0009 1c0001        	addw	x,#1
 314  000c 1f01          	ldw	(OFST-1,sp),x
 317  000e 9c            	rvf
 318  000f 1e01          	ldw	x,(OFST-1,sp)
 319  0011 a304e2        	cpw	x,#1250
 320  0014 2ff1          	jrslt	L151
 321  0016               L541:
 322                     ; 41 	while(ms--)
 324  0016 1e03          	ldw	x,(OFST+1,sp)
 325  0018 1d0001        	subw	x,#1
 326  001b 1f03          	ldw	(OFST+1,sp),x
 327  001d 1c0001        	addw	x,#1
 328  0020 a30000        	cpw	x,#0
 329  0023 26df          	jrne	L341
 330                     ; 45 }
 333  0025 5b04          	addw	sp,#4
 334  0027 81            	ret
 368                     ; 48 void _delay_us(unsigned short i)
 368                     ; 49 {
 369                     .text:	section	.text,new
 370  0000               __delay_us:
 372  0000 89            	pushw	x
 373       00000000      OFST:	set	0
 376                     ; 50     i *= 3; 
 378  0001 1e01          	ldw	x,(OFST+1,sp)
 379  0003 90ae0003      	ldw	y,#3
 380  0007 cd0000        	call	c_imul
 382  000a 1f01          	ldw	(OFST+1,sp),x
 384  000c               L771:
 385                     ; 51     while(--i);
 387  000c 1e01          	ldw	x,(OFST+1,sp)
 388  000e 1d0001        	subw	x,#1
 389  0011 1f01          	ldw	(OFST+1,sp),x
 390  0013 26f7          	jrne	L771
 391                     ; 52 }
 394  0015 85            	popw	x
 395  0016 81            	ret
 430                     ; 54 void _delay_ms(unsigned short i)
 430                     ; 55 {
 431                     .text:	section	.text,new
 432  0000               __delay_ms:
 434  0000 89            	pushw	x
 435       00000000      OFST:	set	0
 438  0001 2006          	jra	L322
 439  0003               L122:
 440                     ; 58         _delay_us(1000);
 442  0003 ae03e8        	ldw	x,#1000
 443  0006 cd0000        	call	__delay_us
 445  0009               L322:
 446                     ; 56     while(i--)
 448  0009 1e01          	ldw	x,(OFST+1,sp)
 449  000b 1d0001        	subw	x,#1
 450  000e 1f01          	ldw	(OFST+1,sp),x
 451  0010 1c0001        	addw	x,#1
 452  0013 a30000        	cpw	x,#0
 453  0016 26eb          	jrne	L122
 454                     ; 60 }
 457  0018 85            	popw	x
 458  0019 81            	ret
 471                     	xdef	_delay_ms
 472                     	xdef	_delay_us
 473                     	xdef	__delay_ms
 474                     	xdef	__delay_us
 475                     	xdef	_simple_delay_ms
 476                     	xdef	_simple_delay_us
 477                     	xref.b	c_x
 496                     	xref	c_imul
 497                     	end
