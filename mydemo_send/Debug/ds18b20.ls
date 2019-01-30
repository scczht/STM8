   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  68                     ; 17 void DS18B20_WriteByte( unsigned char _data )
  68                     ; 18 {
  70                     .text:	section	.text,new
  71  0000               _DS18B20_WriteByte:
  73  0000 88            	push	a
  74  0001 88            	push	a
  75       00000001      OFST:	set	1
  78                     ; 19     unsigned char i = 0;
  80                     ; 21     DS18B20_IO_OUT;
  82  0002 4bf0          	push	#240
  83  0004 4b01          	push	#1
  84  0006 ae5005        	ldw	x,#20485
  85  0009 cd0000        	call	_GPIO_Init
  87  000c 85            	popw	x
  88                     ; 22     for ( i = 0; i < 8; i++ )
  90  000d 0f01          	clr	(OFST+0,sp)
  91  000f               L33:
  92                     ; 24         DS18B20_DQ_LOW;
  94  000f 4b01          	push	#1
  95  0011 ae5005        	ldw	x,#20485
  96  0014 cd0000        	call	_GPIO_WriteLow
  98  0017 84            	pop	a
  99                     ; 25         simple_delay_us( 2 );
 101  0018 ae0002        	ldw	x,#2
 102  001b cd0000        	call	_simple_delay_us
 104                     ; 26         if ( _data & 0x01 )
 106  001e 7b02          	ld	a,(OFST+1,sp)
 107  0020 a501          	bcp	a,#1
 108  0022 2709          	jreq	L14
 109                     ; 28             DS18B20_DQ_HIGH;
 111  0024 4b01          	push	#1
 112  0026 ae5005        	ldw	x,#20485
 113  0029 cd0000        	call	_GPIO_WriteHigh
 115  002c 84            	pop	a
 116  002d               L14:
 117                     ; 30         _data >>= 1;
 119  002d 0402          	srl	(OFST+1,sp)
 120                     ; 31         simple_delay_us( 80 );
 122  002f ae0050        	ldw	x,#80
 123  0032 cd0000        	call	_simple_delay_us
 125                     ; 32         DS18B20_DQ_HIGH;
 127  0035 4b01          	push	#1
 128  0037 ae5005        	ldw	x,#20485
 129  003a cd0000        	call	_GPIO_WriteHigh
 131  003d 84            	pop	a
 132                     ; 22     for ( i = 0; i < 8; i++ )
 134  003e 0c01          	inc	(OFST+0,sp)
 137  0040 7b01          	ld	a,(OFST+0,sp)
 138  0042 a108          	cp	a,#8
 139  0044 25c9          	jrult	L33
 140                     ; 34 }
 143  0046 85            	popw	x
 144  0047 81            	ret
 192                     ; 36 unsigned char DS18B20_ReadByte( void )
 192                     ; 37 {
 193                     .text:	section	.text,new
 194  0000               _DS18B20_ReadByte:
 196  0000 89            	pushw	x
 197       00000002      OFST:	set	2
 200                     ; 38     unsigned char i = 0;
 202                     ; 39     unsigned char _data = 0;
 204  0001 0f02          	clr	(OFST+0,sp)
 205                     ; 41     for ( i = 0; i < 8; i++ )
 207  0003 0f01          	clr	(OFST-1,sp)
 208  0005               L56:
 209                     ; 43         DS18B20_IO_OUT;
 211  0005 4bf0          	push	#240
 212  0007 4b01          	push	#1
 213  0009 ae5005        	ldw	x,#20485
 214  000c cd0000        	call	_GPIO_Init
 216  000f 85            	popw	x
 217                     ; 44         DS18B20_DQ_LOW;
 219  0010 4b01          	push	#1
 220  0012 ae5005        	ldw	x,#20485
 221  0015 cd0000        	call	_GPIO_WriteLow
 223  0018 84            	pop	a
 224                     ; 45         simple_delay_us(2);
 226  0019 ae0002        	ldw	x,#2
 227  001c cd0000        	call	_simple_delay_us
 229                     ; 46         _data >>= 1;
 231  001f 0402          	srl	(OFST+0,sp)
 232                     ; 47         DS18B20_DQ_HIGH;
 234  0021 4b01          	push	#1
 235  0023 ae5005        	ldw	x,#20485
 236  0026 cd0000        	call	_GPIO_WriteHigh
 238  0029 84            	pop	a
 239                     ; 48         DS18B20_IO_IN;
 241  002a 4b40          	push	#64
 242  002c 4b01          	push	#1
 243  002e ae5005        	ldw	x,#20485
 244  0031 cd0000        	call	_GPIO_Init
 246  0034 85            	popw	x
 247                     ; 49         simple_delay_us(16);
 249  0035 ae0010        	ldw	x,#16
 250  0038 cd0000        	call	_simple_delay_us
 252                     ; 50         if (DS18B20_DQ_IN == SET)
 254  003b 4b01          	push	#1
 255  003d ae5005        	ldw	x,#20485
 256  0040 cd0000        	call	_GPIO_ReadInputPin
 258  0043 5b01          	addw	sp,#1
 259  0045 a101          	cp	a,#1
 260  0047 2606          	jrne	L37
 261                     ; 52             _data |= 0x80;
 263  0049 7b02          	ld	a,(OFST+0,sp)
 264  004b aa80          	or	a,#128
 265  004d 6b02          	ld	(OFST+0,sp),a
 266  004f               L37:
 267                     ; 55         simple_delay_us( 60 );
 269  004f ae003c        	ldw	x,#60
 270  0052 cd0000        	call	_simple_delay_us
 272                     ; 56         DS18B20_IO_OUT;
 274  0055 4bf0          	push	#240
 275  0057 4b01          	push	#1
 276  0059 ae5005        	ldw	x,#20485
 277  005c cd0000        	call	_GPIO_Init
 279  005f 85            	popw	x
 280                     ; 57         DS18B20_DQ_HIGH;
 282  0060 4b01          	push	#1
 283  0062 ae5005        	ldw	x,#20485
 284  0065 cd0000        	call	_GPIO_WriteHigh
 286  0068 84            	pop	a
 287                     ; 41     for ( i = 0; i < 8; i++ )
 289  0069 0c01          	inc	(OFST-1,sp)
 292  006b 7b01          	ld	a,(OFST-1,sp)
 293  006d a108          	cp	a,#8
 294  006f 2594          	jrult	L56
 295                     ; 59     return _data;
 297  0071 7b02          	ld	a,(OFST+0,sp)
 300  0073 85            	popw	x
 301  0074 81            	ret
 340                     ; 63 u8 DS18B20_Init(void)
 340                     ; 64 {
 341                     .text:	section	.text,new
 342  0000               _DS18B20_Init:
 344  0000 88            	push	a
 345       00000001      OFST:	set	1
 348                     ; 65     unsigned char ucounters = 0;
 350  0001 0f01          	clr	(OFST+0,sp)
 351                     ; 66     DS18B20_IO_OUT;   
 353  0003 4bf0          	push	#240
 354  0005 4b01          	push	#1
 355  0007 ae5005        	ldw	x,#20485
 356  000a cd0000        	call	_GPIO_Init
 358  000d 85            	popw	x
 359                     ; 67     DS18B20_DQ_HIGH;   
 361  000e 4b01          	push	#1
 362  0010 ae5005        	ldw	x,#20485
 363  0013 cd0000        	call	_GPIO_WriteHigh
 365  0016 84            	pop	a
 366                     ; 68     simple_delay_us(2);
 368  0017 ae0002        	ldw	x,#2
 369  001a cd0000        	call	_simple_delay_us
 371                     ; 69     DS18B20_DQ_LOW;   
 373  001d 4b01          	push	#1
 374  001f ae5005        	ldw	x,#20485
 375  0022 cd0000        	call	_GPIO_WriteLow
 377  0025 84            	pop	a
 378                     ; 70     simple_delay_us(400);     //复位脉冲
 380  0026 ae0190        	ldw	x,#400
 381  0029 cd0000        	call	_simple_delay_us
 383                     ; 72     DS18B20_DQ_HIGH;
 385  002c 4b01          	push	#1
 386  002e ae5005        	ldw	x,#20485
 387  0031 cd0000        	call	_GPIO_WriteHigh
 389  0034 84            	pop	a
 390                     ; 73     DS18B20_IO_IN;     
 392  0035 4b40          	push	#64
 393  0037 4b01          	push	#1
 394  0039 ae5005        	ldw	x,#20485
 395  003c cd0000        	call	_GPIO_Init
 397  003f 85            	popw	x
 398                     ; 74     simple_delay_us(60);     
 400  0040 ae003c        	ldw	x,#60
 401  0043 cd0000        	call	_simple_delay_us
 404  0046 2008          	jra	L511
 405  0048               L311:
 406                     ; 78         ucounters ++;
 408  0048 0c01          	inc	(OFST+0,sp)
 409                     ; 79         simple_delay_us(10);
 411  004a ae000a        	ldw	x,#10
 412  004d cd0000        	call	_simple_delay_us
 414  0050               L511:
 415                     ; 75     while((DS18B20_DQ_IN == SET) && (ucounters < 10))
 417  0050 4b01          	push	#1
 418  0052 ae5005        	ldw	x,#20485
 419  0055 cd0000        	call	_GPIO_ReadInputPin
 421  0058 5b01          	addw	sp,#1
 422  005a a101          	cp	a,#1
 423  005c 2606          	jrne	L121
 425  005e 7b01          	ld	a,(OFST+0,sp)
 426  0060 a10a          	cp	a,#10
 427  0062 25e4          	jrult	L311
 428  0064               L121:
 429                     ; 81     simple_delay_us(400);    
 431  0064 ae0190        	ldw	x,#400
 432  0067 cd0000        	call	_simple_delay_us
 434                     ; 82 }
 437  006a 84            	pop	a
 438  006b 81            	ret
 494                     ; 84 unsigned short DS18B20_ReadTemperature(void)
 494                     ; 85 {
 495                     .text:	section	.text,new
 496  0000               _DS18B20_ReadTemperature:
 498  0000 5204          	subw	sp,#4
 499       00000004      OFST:	set	4
 502                     ; 86     unsigned char TL = 0; /* DS18B20读出的温度寄存器值，TH存放高8位，TL存放低8位 */
 504                     ; 87     unsigned char TH = 0;
 506                     ; 91     DS18B20_Init();
 508  0002 cd0000        	call	_DS18B20_Init
 510                     ; 92     DS18B20_WriteByte(0xcc);
 512  0005 a6cc          	ld	a,#204
 513  0007 cd0000        	call	_DS18B20_WriteByte
 515                     ; 93     DS18B20_WriteByte(0x44);
 517  000a a644          	ld	a,#68
 518  000c cd0000        	call	_DS18B20_WriteByte
 520                     ; 95     DS18B20_Init();
 522  000f cd0000        	call	_DS18B20_Init
 524                     ; 96     DS18B20_WriteByte(0xcc);
 526  0012 a6cc          	ld	a,#204
 527  0014 cd0000        	call	_DS18B20_WriteByte
 529                     ; 97     DS18B20_WriteByte(0xbe);
 531  0017 a6be          	ld	a,#190
 532  0019 cd0000        	call	_DS18B20_WriteByte
 534                     ; 99     TL = DS18B20_ReadByte();   
 536  001c cd0000        	call	_DS18B20_ReadByte
 538  001f 6b01          	ld	(OFST-3,sp),a
 539                     ; 100     TH = DS18B20_ReadByte();
 541  0021 cd0000        	call	_DS18B20_ReadByte
 543  0024 6b02          	ld	(OFST-2,sp),a
 544                     ; 101     temp = (TH << 8) | TL;  
 546  0026 7b02          	ld	a,(OFST-2,sp)
 547  0028 5f            	clrw	x
 548  0029 97            	ld	xl,a
 549  002a 7b01          	ld	a,(OFST-3,sp)
 550  002c 02            	rlwa	x,a
 551  002d 1f03          	ldw	(OFST-1,sp),x
 552                     ; 102     return temp;
 554  002f 1e03          	ldw	x,(OFST-1,sp)
 557  0031 5b04          	addw	sp,#4
 558  0033 81            	ret
 604                     ; 106 void DS18B20_WorkTemperature(unsigned char *data)
 604                     ; 107 {
 605                     .text:	section	.text,new
 606  0000               _DS18B20_WorkTemperature:
 608  0000 89            	pushw	x
 609  0001 89            	pushw	x
 610       00000002      OFST:	set	2
 613                     ; 108     unsigned short temp = DS18B20_ReadTemperature();
 615  0002 cd0000        	call	_DS18B20_ReadTemperature
 617  0005 1f01          	ldw	(OFST-1,sp),x
 618                     ; 111     if ((temp & 0xf800) == 0xf800)
 620  0007 7b01          	ld	a,(OFST-1,sp)
 621  0009 97            	ld	xl,a
 622  000a 7b02          	ld	a,(OFST+0,sp)
 623  000c 9f            	ld	a,xl
 624  000d a4f8          	and	a,#248
 625  000f 97            	ld	xl,a
 626  0010 4f            	clr	a
 627  0011 02            	rlwa	x,a
 628  0012 a3f800        	cpw	x,#63488
 629  0015 263a          	jrne	L371
 630                     ; 113         data[2] = 1;/*表示负数*/
 632  0017 1e03          	ldw	x,(OFST+1,sp)
 633  0019 a601          	ld	a,#1
 634  001b e702          	ld	(2,x),a
 635                     ; 114         temp = ~temp + 1;  //补码
 637  001d 1e01          	ldw	x,(OFST-1,sp)
 638  001f 53            	cplw	x
 639  0020 5c            	incw	x
 640  0021 1f01          	ldw	(OFST-1,sp),x
 641                     ; 115         data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
 643  0023 1e01          	ldw	x,(OFST-1,sp)
 644  0025 01            	rrwa	x,a
 645  0026 a4f0          	and	a,#240
 646  0028 01            	rrwa	x,a
 647  0029 a407          	and	a,#7
 648  002b 01            	rrwa	x,a
 649  002c 54            	srlw	x
 650  002d 54            	srlw	x
 651  002e 54            	srlw	x
 652  002f 54            	srlw	x
 653  0030 1603          	ldw	y,(OFST+1,sp)
 654  0032 01            	rrwa	x,a
 655  0033 90e701        	ld	(1,y),a
 656  0036 02            	rlwa	x,a
 657                     ; 116         data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
 659  0037 7b02          	ld	a,(OFST+0,sp)
 660  0039 a40f          	and	a,#15
 661  003b 5f            	clrw	x
 662  003c 97            	ld	xl,a
 663  003d 90ae0271      	ldw	y,#625
 664  0041 cd0000        	call	c_imul
 666  0044 90ae000a      	ldw	y,#10
 667  0048 65            	divw	x,y
 668  0049 1603          	ldw	y,(OFST+1,sp)
 669  004b 01            	rrwa	x,a
 670  004c 90f7          	ld	(y),a
 671  004e 02            	rlwa	x,a
 673  004f 2030          	jra	L571
 674  0051               L371:
 675                     ; 120         data[2] = 0;/*表示负数*/
 677  0051 1e03          	ldw	x,(OFST+1,sp)
 678  0053 6f02          	clr	(2,x)
 679                     ; 121         data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
 681  0055 1e01          	ldw	x,(OFST-1,sp)
 682  0057 01            	rrwa	x,a
 683  0058 a4f0          	and	a,#240
 684  005a 01            	rrwa	x,a
 685  005b a407          	and	a,#7
 686  005d 01            	rrwa	x,a
 687  005e 54            	srlw	x
 688  005f 54            	srlw	x
 689  0060 54            	srlw	x
 690  0061 54            	srlw	x
 691  0062 1603          	ldw	y,(OFST+1,sp)
 692  0064 01            	rrwa	x,a
 693  0065 90e701        	ld	(1,y),a
 694  0068 02            	rlwa	x,a
 695                     ; 122         data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
 697  0069 7b02          	ld	a,(OFST+0,sp)
 698  006b a40f          	and	a,#15
 699  006d 5f            	clrw	x
 700  006e 97            	ld	xl,a
 701  006f 90ae0271      	ldw	y,#625
 702  0073 cd0000        	call	c_imul
 704  0076 90ae000a      	ldw	y,#10
 705  007a 65            	divw	x,y
 706  007b 1603          	ldw	y,(OFST+1,sp)
 707  007d 01            	rrwa	x,a
 708  007e 90f7          	ld	(y),a
 709  0080 02            	rlwa	x,a
 710  0081               L571:
 711                     ; 124 }
 714  0081 5b04          	addw	sp,#4
 715  0083 81            	ret
 728                     	xdef	_DS18B20_WorkTemperature
 729                     	xdef	_DS18B20_ReadTemperature
 730                     	xdef	_DS18B20_Init
 731                     	xdef	_DS18B20_ReadByte
 732                     	xdef	_DS18B20_WriteByte
 733                     	xref	_simple_delay_us
 734                     	xref	_GPIO_ReadInputPin
 735                     	xref	_GPIO_WriteLow
 736                     	xref	_GPIO_WriteHigh
 737                     	xref	_GPIO_Init
 738                     	xref.b	c_x
 757                     	xref	c_imul
 758                     	end
