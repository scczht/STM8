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
  83  0004 4b20          	push	#32
  84  0006 ae5014        	ldw	x,#20500
  85  0009 cd0000        	call	_GPIO_Init
  87  000c 85            	popw	x
  88                     ; 22     for ( i = 0; i < 8; i++ )
  90  000d 0f01          	clr	(OFST+0,sp)
  91  000f               L33:
  92                     ; 24         DS18B20_DQ_LOW;
  94  000f 4b20          	push	#32
  95  0011 ae5014        	ldw	x,#20500
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
 111  0024 4b20          	push	#32
 112  0026 ae5014        	ldw	x,#20500
 113  0029 cd0000        	call	_GPIO_WriteHigh
 115  002c 84            	pop	a
 116  002d               L14:
 117                     ; 30         _data >>= 1;
 119  002d 0402          	srl	(OFST+1,sp)
 120                     ; 31         simple_delay_us( 80 );
 122  002f ae0050        	ldw	x,#80
 123  0032 cd0000        	call	_simple_delay_us
 125                     ; 32         DS18B20_DQ_HIGH;
 127  0035 4b20          	push	#32
 128  0037 ae5014        	ldw	x,#20500
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
 212  0007 4b20          	push	#32
 213  0009 ae5014        	ldw	x,#20500
 214  000c cd0000        	call	_GPIO_Init
 216  000f 85            	popw	x
 217                     ; 44         DS18B20_DQ_LOW;
 219  0010 4b20          	push	#32
 220  0012 ae5014        	ldw	x,#20500
 221  0015 cd0000        	call	_GPIO_WriteLow
 223  0018 84            	pop	a
 224                     ; 45         simple_delay_us(2);
 226  0019 ae0002        	ldw	x,#2
 227  001c cd0000        	call	_simple_delay_us
 229                     ; 46         _data >>= 1;
 231  001f 0402          	srl	(OFST+0,sp)
 232                     ; 47         DS18B20_DQ_HIGH;
 234  0021 4b20          	push	#32
 235  0023 ae5014        	ldw	x,#20500
 236  0026 cd0000        	call	_GPIO_WriteHigh
 238  0029 84            	pop	a
 239                     ; 48         DS18B20_IO_IN;
 241  002a 4b40          	push	#64
 242  002c 4b20          	push	#32
 243  002e ae5014        	ldw	x,#20500
 244  0031 cd0000        	call	_GPIO_Init
 246  0034 85            	popw	x
 247                     ; 49         simple_delay_us(16);
 249  0035 ae0010        	ldw	x,#16
 250  0038 cd0000        	call	_simple_delay_us
 252                     ; 50         if (DS18B20_DQ_IN == SET)
 254  003b 4b20          	push	#32
 255  003d ae5014        	ldw	x,#20500
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
 275  0057 4b20          	push	#32
 276  0059 ae5014        	ldw	x,#20500
 277  005c cd0000        	call	_GPIO_Init
 279  005f 85            	popw	x
 280                     ; 57         DS18B20_DQ_HIGH;
 282  0060 4b20          	push	#32
 283  0062 ae5014        	ldw	x,#20500
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
 354  0005 4b20          	push	#32
 355  0007 ae5014        	ldw	x,#20500
 356  000a cd0000        	call	_GPIO_Init
 358  000d 85            	popw	x
 359                     ; 67     DS18B20_DQ_HIGH;   
 361  000e 4b20          	push	#32
 362  0010 ae5014        	ldw	x,#20500
 363  0013 cd0000        	call	_GPIO_WriteHigh
 365  0016 84            	pop	a
 366                     ; 68     simple_delay_us(2);
 368  0017 ae0002        	ldw	x,#2
 369  001a cd0000        	call	_simple_delay_us
 371                     ; 69     DS18B20_DQ_LOW;   
 373  001d 4b20          	push	#32
 374  001f ae5014        	ldw	x,#20500
 375  0022 cd0000        	call	_GPIO_WriteLow
 377  0025 84            	pop	a
 378                     ; 70     simple_delay_us(400);     //复位脉冲
 380  0026 ae0190        	ldw	x,#400
 381  0029 cd0000        	call	_simple_delay_us
 383                     ; 72     DS18B20_DQ_HIGH;
 385  002c 4b20          	push	#32
 386  002e ae5014        	ldw	x,#20500
 387  0031 cd0000        	call	_GPIO_WriteHigh
 389  0034 84            	pop	a
 390                     ; 73     DS18B20_IO_IN;     
 392  0035 4b40          	push	#64
 393  0037 4b20          	push	#32
 394  0039 ae5014        	ldw	x,#20500
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
 415                     ; 75     while((DS18B20_DQ_IN == SET) || (ucounters > 10))
 417  0050 4b20          	push	#32
 418  0052 ae5014        	ldw	x,#20500
 419  0055 cd0000        	call	_GPIO_ReadInputPin
 421  0058 5b01          	addw	sp,#1
 422  005a a101          	cp	a,#1
 423  005c 27ea          	jreq	L311
 425  005e 7b01          	ld	a,(OFST+0,sp)
 426  0060 a10b          	cp	a,#11
 427  0062 24e4          	jruge	L311
 428                     ; 81     simple_delay_us(400);    
 430  0064 ae0190        	ldw	x,#400
 431  0067 cd0000        	call	_simple_delay_us
 433                     ; 82 }
 436  006a 84            	pop	a
 437  006b 81            	ret
 493                     ; 84 unsigned short DS18B20_ReadTemperature(void)
 493                     ; 85 {
 494                     .text:	section	.text,new
 495  0000               _DS18B20_ReadTemperature:
 497  0000 5204          	subw	sp,#4
 498       00000004      OFST:	set	4
 501                     ; 86     unsigned char TL = 0; /* DS18B20读出的温度寄存器值，TH存放高8位，TL存放低8位 */
 503                     ; 87     unsigned char TH = 0;
 505                     ; 91     DS18B20_Init();
 507  0002 cd0000        	call	_DS18B20_Init
 509                     ; 92     DS18B20_WriteByte(0xcc);
 511  0005 a6cc          	ld	a,#204
 512  0007 cd0000        	call	_DS18B20_WriteByte
 514                     ; 93     DS18B20_WriteByte(0x44);
 516  000a a644          	ld	a,#68
 517  000c cd0000        	call	_DS18B20_WriteByte
 519                     ; 95     DS18B20_Init();
 521  000f cd0000        	call	_DS18B20_Init
 523                     ; 96     DS18B20_WriteByte(0xcc);
 525  0012 a6cc          	ld	a,#204
 526  0014 cd0000        	call	_DS18B20_WriteByte
 528                     ; 97     DS18B20_WriteByte(0xbe);
 530  0017 a6be          	ld	a,#190
 531  0019 cd0000        	call	_DS18B20_WriteByte
 533                     ; 99     TL = DS18B20_ReadByte();   
 535  001c cd0000        	call	_DS18B20_ReadByte
 537  001f 6b01          	ld	(OFST-3,sp),a
 538                     ; 100     TH = DS18B20_ReadByte();
 540  0021 cd0000        	call	_DS18B20_ReadByte
 542  0024 6b02          	ld	(OFST-2,sp),a
 543                     ; 101     temp = (TH << 8) | TL;  
 545  0026 7b02          	ld	a,(OFST-2,sp)
 546  0028 5f            	clrw	x
 547  0029 97            	ld	xl,a
 548  002a 7b01          	ld	a,(OFST-3,sp)
 549  002c 02            	rlwa	x,a
 550  002d 1f03          	ldw	(OFST-1,sp),x
 551                     ; 102     return temp;
 553  002f 1e03          	ldw	x,(OFST-1,sp)
 556  0031 5b04          	addw	sp,#4
 557  0033 81            	ret
 603                     ; 106 void DS18B20_WorkTemperature(unsigned char *data)
 603                     ; 107 {
 604                     .text:	section	.text,new
 605  0000               _DS18B20_WorkTemperature:
 607  0000 89            	pushw	x
 608  0001 89            	pushw	x
 609       00000002      OFST:	set	2
 612                     ; 108     unsigned short temp = DS18B20_ReadTemperature();
 614  0002 cd0000        	call	_DS18B20_ReadTemperature
 616  0005 1f01          	ldw	(OFST-1,sp),x
 617                     ; 111     if ((temp & 0xf800) == 0xf800)
 619  0007 7b01          	ld	a,(OFST-1,sp)
 620  0009 97            	ld	xl,a
 621  000a 7b02          	ld	a,(OFST+0,sp)
 622  000c 9f            	ld	a,xl
 623  000d a4f8          	and	a,#248
 624  000f 97            	ld	xl,a
 625  0010 4f            	clr	a
 626  0011 02            	rlwa	x,a
 627  0012 a3f800        	cpw	x,#63488
 628  0015 263a          	jrne	L171
 629                     ; 113         data[2] = 1;/*表示负数*/
 631  0017 1e03          	ldw	x,(OFST+1,sp)
 632  0019 a601          	ld	a,#1
 633  001b e702          	ld	(2,x),a
 634                     ; 114         temp = ~temp + 1;  //补码
 636  001d 1e01          	ldw	x,(OFST-1,sp)
 637  001f 53            	cplw	x
 638  0020 5c            	incw	x
 639  0021 1f01          	ldw	(OFST-1,sp),x
 640                     ; 115         data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
 642  0023 1e01          	ldw	x,(OFST-1,sp)
 643  0025 01            	rrwa	x,a
 644  0026 a4f0          	and	a,#240
 645  0028 01            	rrwa	x,a
 646  0029 a407          	and	a,#7
 647  002b 01            	rrwa	x,a
 648  002c 54            	srlw	x
 649  002d 54            	srlw	x
 650  002e 54            	srlw	x
 651  002f 54            	srlw	x
 652  0030 1603          	ldw	y,(OFST+1,sp)
 653  0032 01            	rrwa	x,a
 654  0033 90e701        	ld	(1,y),a
 655  0036 02            	rlwa	x,a
 656                     ; 116         data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
 658  0037 7b02          	ld	a,(OFST+0,sp)
 659  0039 a40f          	and	a,#15
 660  003b 5f            	clrw	x
 661  003c 97            	ld	xl,a
 662  003d 90ae0271      	ldw	y,#625
 663  0041 cd0000        	call	c_imul
 665  0044 90ae000a      	ldw	y,#10
 666  0048 65            	divw	x,y
 667  0049 1603          	ldw	y,(OFST+1,sp)
 668  004b 01            	rrwa	x,a
 669  004c 90f7          	ld	(y),a
 670  004e 02            	rlwa	x,a
 672  004f 2030          	jra	L371
 673  0051               L171:
 674                     ; 120         data[2] = 0;/*表示负数*/
 676  0051 1e03          	ldw	x,(OFST+1,sp)
 677  0053 6f02          	clr	(2,x)
 678                     ; 121         data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
 680  0055 1e01          	ldw	x,(OFST-1,sp)
 681  0057 01            	rrwa	x,a
 682  0058 a4f0          	and	a,#240
 683  005a 01            	rrwa	x,a
 684  005b a407          	and	a,#7
 685  005d 01            	rrwa	x,a
 686  005e 54            	srlw	x
 687  005f 54            	srlw	x
 688  0060 54            	srlw	x
 689  0061 54            	srlw	x
 690  0062 1603          	ldw	y,(OFST+1,sp)
 691  0064 01            	rrwa	x,a
 692  0065 90e701        	ld	(1,y),a
 693  0068 02            	rlwa	x,a
 694                     ; 122         data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
 696  0069 7b02          	ld	a,(OFST+0,sp)
 697  006b a40f          	and	a,#15
 698  006d 5f            	clrw	x
 699  006e 97            	ld	xl,a
 700  006f 90ae0271      	ldw	y,#625
 701  0073 cd0000        	call	c_imul
 703  0076 90ae000a      	ldw	y,#10
 704  007a 65            	divw	x,y
 705  007b 1603          	ldw	y,(OFST+1,sp)
 706  007d 01            	rrwa	x,a
 707  007e 90f7          	ld	(y),a
 708  0080 02            	rlwa	x,a
 709  0081               L371:
 710                     ; 124 }
 713  0081 5b04          	addw	sp,#4
 714  0083 81            	ret
 727                     	xdef	_DS18B20_WorkTemperature
 728                     	xdef	_DS18B20_ReadTemperature
 729                     	xdef	_DS18B20_Init
 730                     	xdef	_DS18B20_ReadByte
 731                     	xdef	_DS18B20_WriteByte
 732                     	xref	_simple_delay_us
 733                     	xref	_GPIO_ReadInputPin
 734                     	xref	_GPIO_WriteLow
 735                     	xref	_GPIO_WriteHigh
 736                     	xref	_GPIO_Init
 737                     	xref.b	c_x
 756                     	xref	c_imul
 757                     	end
