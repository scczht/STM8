   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2788                     	bsct
2789  0000               _TX_ADDRESS:
2790  0000 34            	dc.b	52
2791  0001 43            	dc.b	67
2792  0002 10            	dc.b	16
2793  0003 10            	dc.b	16
2794  0004 01            	dc.b	1
2795  0005               _RX_ADDRESS:
2796  0005 34            	dc.b	52
2797  0006 43            	dc.b	67
2798  0007 10            	dc.b	16
2799  0008 10            	dc.b	16
2800  0009 01            	dc.b	1
2843                     ; 14 unsigned char SPI_RW(unsigned char byte)
2843                     ; 15 {   
2845                     .text:	section	.text,new
2846  0000               _SPI_RW:
2848  0000 88            	push	a
2849       00000000      OFST:	set	0
2852  0001               L1102:
2853                     ; 17     while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);
2855  0001 a602          	ld	a,#2
2856  0003 cd0000        	call	_SPI_GetFlagStatus
2858  0006 4d            	tnz	a
2859  0007 27f8          	jreq	L1102
2860                     ; 18     SPI_SendData(byte);
2862  0009 7b01          	ld	a,(OFST+1,sp)
2863  000b cd0000        	call	_SPI_SendData
2866  000e               L7102:
2867                     ; 20     while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET)
2869  000e a601          	ld	a,#1
2870  0010 cd0000        	call	_SPI_GetFlagStatus
2872  0013 4d            	tnz	a
2873  0014 27f8          	jreq	L7102
2874                     ; 26     byte = SPI_ReceiveData();
2876  0016 cd0000        	call	_SPI_ReceiveData
2878  0019 6b01          	ld	(OFST+1,sp),a
2879                     ; 27     return(byte);  
2881  001b 7b01          	ld	a,(OFST+1,sp)
2884  001d 5b01          	addw	sp,#1
2885  001f 81            	ret
2941                     ; 29 unsigned char  SPI_RW_Reg(BYTE reg, BYTE value)
2941                     ; 30 {
2942                     .text:	section	.text,new
2943  0000               _SPI_RW_Reg:
2945  0000 89            	pushw	x
2946  0001 88            	push	a
2947       00000001      OFST:	set	1
2950                     ; 33     GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                // CSN low, init SPI transaction
2952  0002 4b08          	push	#8
2953  0004 ae500f        	ldw	x,#20495
2954  0007 cd0000        	call	_GPIO_WriteLow
2956  000a 84            	pop	a
2957                     ; 34     status = SPI_RW(reg);      // select register
2959  000b 7b02          	ld	a,(OFST+1,sp)
2960  000d cd0000        	call	_SPI_RW
2962  0010 6b01          	ld	(OFST+0,sp),a
2963                     ; 35     simple_delay_us(10);
2965  0012 ae000a        	ldw	x,#10
2966  0015 cd0000        	call	_simple_delay_us
2968                     ; 36     SPI_RW(value);             // ..and write value to it..
2970  0018 7b03          	ld	a,(OFST+2,sp)
2971  001a cd0000        	call	_SPI_RW
2973                     ; 37     GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                   // CSN high again
2975  001d 4b08          	push	#8
2976  001f ae500f        	ldw	x,#20495
2977  0022 cd0000        	call	_GPIO_WriteHigh
2979  0025 84            	pop	a
2980                     ; 38     return(status);            // return nRF24L01 status byte
2982  0026 7b01          	ld	a,(OFST+0,sp)
2985  0028 5b03          	addw	sp,#3
2986  002a 81            	ret
3033                     ; 40 unsigned char SPI_Read(unsigned char reg)
3033                     ; 41 {
3034                     .text:	section	.text,new
3035  0000               _SPI_Read:
3037  0000 88            	push	a
3038  0001 88            	push	a
3039       00000001      OFST:	set	1
3042                     ; 43     GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                 // CSN low, initialize SPI communication...
3044  0002 4b08          	push	#8
3045  0004 ae500f        	ldw	x,#20495
3046  0007 cd0000        	call	_GPIO_WriteLow
3048  000a 84            	pop	a
3049                     ; 45     SPI_RW(reg);            // Select register to read from..
3051  000b 7b02          	ld	a,(OFST+1,sp)
3052  000d cd0000        	call	_SPI_RW
3054                     ; 46     simple_delay_us(10);
3056  0010 ae000a        	ldw	x,#10
3057  0013 cd0000        	call	_simple_delay_us
3059                     ; 47     reg_val = SPI_RW(0);    // ..then read registervalue
3061  0016 4f            	clr	a
3062  0017 cd0000        	call	_SPI_RW
3064  001a 6b01          	ld	(OFST+0,sp),a
3065                     ; 48     GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);           // CSN high, terminate SPI communication
3067  001c 4b08          	push	#8
3068  001e ae500f        	ldw	x,#20495
3069  0021 cd0000        	call	_GPIO_WriteHigh
3071  0024 84            	pop	a
3072                     ; 50     return(reg_val);        // return register value
3074  0025 7b01          	ld	a,(OFST+0,sp)
3077  0027 85            	popw	x
3078  0028 81            	ret
3152                     ; 52 unsigned char SPI_Write_Buf(unsigned char reg, unsigned char *pBuf, unsigned char bytes)
3152                     ; 53 {
3153                     .text:	section	.text,new
3154  0000               _SPI_Write_Buf:
3156  0000 88            	push	a
3157  0001 89            	pushw	x
3158       00000002      OFST:	set	2
3161                     ; 56     GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);
3163  0002 4b08          	push	#8
3164  0004 ae500f        	ldw	x,#20495
3165  0007 cd0000        	call	_GPIO_WriteLow
3167  000a 84            	pop	a
3168                     ; 57     status = SPI_RW(reg);        
3170  000b 7b03          	ld	a,(OFST+1,sp)
3171  000d cd0000        	call	_SPI_RW
3173  0010 6b01          	ld	(OFST-1,sp),a
3174                     ; 58     for(byte_ctr=0; byte_ctr<bytes; byte_ctr++) 
3176  0012 0f02          	clr	(OFST+0,sp)
3178  0014 2010          	jra	L5312
3179  0016               L1312:
3180                     ; 59         SPI_RW(*pBuf++);
3182  0016 1e06          	ldw	x,(OFST+4,sp)
3183  0018 1c0001        	addw	x,#1
3184  001b 1f06          	ldw	(OFST+4,sp),x
3185  001d 1d0001        	subw	x,#1
3186  0020 f6            	ld	a,(x)
3187  0021 cd0000        	call	_SPI_RW
3189                     ; 58     for(byte_ctr=0; byte_ctr<bytes; byte_ctr++) 
3191  0024 0c02          	inc	(OFST+0,sp)
3192  0026               L5312:
3195  0026 7b02          	ld	a,(OFST+0,sp)
3196  0028 1108          	cp	a,(OFST+6,sp)
3197  002a 25ea          	jrult	L1312
3198                     ; 60     GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);
3200  002c 4b08          	push	#8
3201  002e ae500f        	ldw	x,#20495
3202  0031 cd0000        	call	_GPIO_WriteHigh
3204  0034 84            	pop	a
3205                     ; 61     return(status);         
3207  0035 7b01          	ld	a,(OFST-1,sp)
3210  0037 5b03          	addw	sp,#3
3211  0039 81            	ret
3238                     ; 64 void NRF24_GPIOInit(void)
3238                     ; 65 {
3239                     .text:	section	.text,new
3240  0000               _NRF24_GPIOInit:
3244                     ; 68     GPIO_Init(NRF24L01_CE_PORT, (GPIO_Pin_TypeDef)(NRF24L01_CE_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//ce 
3246  0000 4bf0          	push	#240
3247  0002 4b04          	push	#4
3248  0004 ae500f        	ldw	x,#20495
3249  0007 cd0000        	call	_GPIO_Init
3251  000a 85            	popw	x
3252                     ; 69     GPIO_Init(NRF24L01_CS_PORT, (GPIO_Pin_TypeDef)(NRF24L01_CS_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//cs
3254  000b 4bf0          	push	#240
3255  000d 4b08          	push	#8
3256  000f ae500f        	ldw	x,#20495
3257  0012 cd0000        	call	_GPIO_Init
3259  0015 85            	popw	x
3260                     ; 70     GPIO_Init(NRF24L01_SCK_PORT, (GPIO_Pin_TypeDef)(NRF24L01_SCK_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//sck
3262  0016 4bf0          	push	#240
3263  0018 4b20          	push	#32
3264  001a ae500a        	ldw	x,#20490
3265  001d cd0000        	call	_GPIO_Init
3267  0020 85            	popw	x
3268                     ; 71     GPIO_Init(NRF24L01_MOSI_PORT, (GPIO_Pin_TypeDef)(NRF24L01_MOSI_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//MOSI
3270  0021 4bf0          	push	#240
3271  0023 4b40          	push	#64
3272  0025 ae500a        	ldw	x,#20490
3273  0028 cd0000        	call	_GPIO_Init
3275  002b 85            	popw	x
3276                     ; 72     GPIO_Init(NRF24L01_MISO_PORT, (GPIO_Pin_TypeDef)(NRF24L01_MISO_PIN), GPIO_MODE_IN_FL_NO_IT);//MISO
3278  002c 4b00          	push	#0
3279  002e 4b80          	push	#128
3280  0030 ae500a        	ldw	x,#20490
3281  0033 cd0000        	call	_GPIO_Init
3283  0036 85            	popw	x
3284                     ; 73     GPIO_Init(NRF24L01_IRQ_PORT, (GPIO_Pin_TypeDef)(NRF24L01_IRQ_PIN ), GPIO_MODE_IN_FL_NO_IT); //IRQ
3286  0037 4b00          	push	#0
3287  0039 4b10          	push	#16
3288  003b ae500f        	ldw	x,#20495
3289  003e cd0000        	call	_GPIO_Init
3291  0041 85            	popw	x
3292                     ; 74     simple_delay_us(125);
3294  0042 ae007d        	ldw	x,#125
3295  0045 cd0000        	call	_simple_delay_us
3297                     ; 75     GPIO_WriteHigh(NRF24L01_CE_PORT, NRF24L01_CE_PIN);
3299  0048 4b04          	push	#4
3300  004a ae500f        	ldw	x,#20495
3301  004d cd0000        	call	_GPIO_WriteHigh
3303  0050 84            	pop	a
3304                     ; 76     GPIO_WriteHigh(NRF24L01_CS_PORT, NRF24L01_CS_PIN);
3306  0051 4b08          	push	#8
3307  0053 ae500f        	ldw	x,#20495
3308  0056 cd0000        	call	_GPIO_WriteHigh
3310  0059 84            	pop	a
3311                     ; 77     GPIO_WriteLow(NRF24L01_SCK_PORT, NRF24L01_SCK_PIN);
3313  005a 4b20          	push	#32
3314  005c ae500a        	ldw	x,#20490
3315  005f cd0000        	call	_GPIO_WriteLow
3317  0062 84            	pop	a
3318                     ; 78     simple_delay_us(125);
3320  0063 ae007d        	ldw	x,#125
3321  0066 cd0000        	call	_simple_delay_us
3323                     ; 79 }
3326  0069 81            	ret
3354                     ; 80 void NRF24Init(void)
3354                     ; 81 {
3355                     .text:	section	.text,new
3356  0000               _NRF24Init:
3360                     ; 82     NRF24_GPIOInit();
3362  0000 cd0000        	call	_NRF24_GPIOInit
3364                     ; 83     SPI_DeInit();
3366  0003 cd0000        	call	_SPI_DeInit
3368                     ; 85     SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_2, SPI_MODE_MASTER, SPI_CLOCKPOLARITY_LOW,
3368                     ; 86                     SPI_CLOCKPHASE_1EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX, SPI_NSS_SOFT,(uint8_t)0x07);  
3370  0006 4b07          	push	#7
3371  0008 4b02          	push	#2
3372  000a 4b00          	push	#0
3373  000c 4b00          	push	#0
3374  000e 4b00          	push	#0
3375  0010 4b04          	push	#4
3376  0012 5f            	clrw	x
3377  0013 4f            	clr	a
3378  0014 95            	ld	xh,a
3379  0015 cd0000        	call	_SPI_Init
3381  0018 5b06          	addw	sp,#6
3382                     ; 88     SPI_Cmd(ENABLE);
3384  001a a601          	ld	a,#1
3385  001c cd0000        	call	_SPI_Cmd
3387                     ; 89     simple_delay_us(125);
3389  001f ae007d        	ldw	x,#125
3390  0022 cd0000        	call	_simple_delay_us
3392                     ; 91 } 
3395  0025 81            	ret
3424                     ; 92 void RX_Mode(void)
3424                     ; 93 {  
3425                     .text:	section	.text,new
3426  0000               _RX_Mode:
3430                     ; 94     GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
3432  0000 4b04          	push	#4
3433  0002 ae500f        	ldw	x,#20495
3434  0005 cd0000        	call	_GPIO_WriteLow
3436  0008 84            	pop	a
3437                     ; 95     SPI_Write_Buf(WRITE_REG + TX_ADDR, TX_ADDRESS, TX_ADR_WIDTH);    // Writes TX_Address to nRF24L01
3439  0009 4b05          	push	#5
3440  000b ae0000        	ldw	x,#_TX_ADDRESS
3441  000e 89            	pushw	x
3442  000f a630          	ld	a,#48
3443  0011 cd0000        	call	_SPI_Write_Buf
3445  0014 5b03          	addw	sp,#3
3446                     ; 96     SPI_Write_Buf(WRITE_REG + RX_ADDR_P0, TX_ADDRESS, RX_ADR_WIDTH); // Use the same address on the RX device as the TX device
3448  0016 4b05          	push	#5
3449  0018 ae0000        	ldw	x,#_TX_ADDRESS
3450  001b 89            	pushw	x
3451  001c a62a          	ld	a,#42
3452  001e cd0000        	call	_SPI_Write_Buf
3454  0021 5b03          	addw	sp,#3
3455                     ; 98     SPI_RW_Reg(WRITE_REG + EN_AA, 0x01);      //频道0自动   ACK应答允许  
3457  0023 ae0001        	ldw	x,#1
3458  0026 a621          	ld	a,#33
3459  0028 95            	ld	xh,a
3460  0029 cd0000        	call	_SPI_RW_Reg
3462                     ; 99     SPI_RW_Reg(WRITE_REG + EN_RXADDR, 0x01);  //允许接收地址只有频道0， 
3464  002c ae0001        	ldw	x,#1
3465  002f a622          	ld	a,#34
3466  0031 95            	ld	xh,a
3467  0032 cd0000        	call	_SPI_RW_Reg
3469                     ; 100     SPI_RW_Reg(WRITE_REG + RF_CH, 40);        //   设置信道工作为2.4GHZ，收发必须一致
3471  0035 ae0028        	ldw	x,#40
3472  0038 a625          	ld	a,#37
3473  003a 95            	ld	xh,a
3474  003b cd0000        	call	_SPI_RW_Reg
3476                     ; 102     SPI_RW_Reg(WRITE_REG + RX_PW_P0, 5); //设置接收数据长度，本次设置为32字节
3478  003e ae0005        	ldw	x,#5
3479  0041 a631          	ld	a,#49
3480  0043 95            	ld	xh,a
3481  0044 cd0000        	call	_SPI_RW_Reg
3483                     ; 103     SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x07); // 设置发射速率为1MHZ，发射功率为最大值0dB 
3485  0047 ae0007        	ldw	x,#7
3486  004a a626          	ld	a,#38
3487  004c 95            	ld	xh,a
3488  004d cd0000        	call	_SPI_RW_Reg
3490                     ; 106     SPI_RW_Reg(WRITE_REG + CONFIG2, 0x0f);    //power up  1: PRX
3492  0050 ae000f        	ldw	x,#15
3493  0053 a620          	ld	a,#32
3494  0055 95            	ld	xh,a
3495  0056 cd0000        	call	_SPI_RW_Reg
3497                     ; 108     GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
3499  0059 4b04          	push	#4
3500  005b ae500f        	ldw	x,#20495
3501  005e cd0000        	call	_GPIO_WriteHigh
3503  0061 84            	pop	a
3504                     ; 109     simple_delay_us(100);
3506  0062 ae0064        	ldw	x,#100
3507  0065 cd0000        	call	_simple_delay_us
3509                     ; 110 }
3512  0068 81            	ret
3586                     ; 114 unsigned char SPI_Read_Buf(BYTE reg, BYTE *pBuf, BYTE bytes)
3586                     ; 115 {
3587                     .text:	section	.text,new
3588  0000               _SPI_Read_Buf:
3590  0000 88            	push	a
3591  0001 89            	pushw	x
3592       00000002      OFST:	set	2
3595                     ; 118     GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);// Set CSN low, init SPI tranaction
3597  0002 4b08          	push	#8
3598  0004 ae500f        	ldw	x,#20495
3599  0007 cd0000        	call	_GPIO_WriteLow
3601  000a 84            	pop	a
3602                     ; 119     status = SPI_RW(reg);               // Select register to write to and read status byte
3604  000b 7b03          	ld	a,(OFST+1,sp)
3605  000d cd0000        	call	_SPI_RW
3607  0010 6b01          	ld	(OFST-1,sp),a
3608                     ; 121     for(byte_ctr=0;byte_ctr<bytes;byte_ctr++)
3610  0012 0f02          	clr	(OFST+0,sp)
3612  0014 2014          	jra	L3322
3613  0016               L7222:
3614                     ; 122         pBuf[byte_ctr] = SPI_RW(0);     
3616  0016 7b06          	ld	a,(OFST+4,sp)
3617  0018 97            	ld	xl,a
3618  0019 7b07          	ld	a,(OFST+5,sp)
3619  001b 1b02          	add	a,(OFST+0,sp)
3620  001d 2401          	jrnc	L42
3621  001f 5c            	incw	x
3622  0020               L42:
3623  0020 02            	rlwa	x,a
3624  0021 89            	pushw	x
3625  0022 4f            	clr	a
3626  0023 cd0000        	call	_SPI_RW
3628  0026 85            	popw	x
3629  0027 f7            	ld	(x),a
3630                     ; 121     for(byte_ctr=0;byte_ctr<bytes;byte_ctr++)
3632  0028 0c02          	inc	(OFST+0,sp)
3633  002a               L3322:
3636  002a 7b02          	ld	a,(OFST+0,sp)
3637  002c 1108          	cp	a,(OFST+6,sp)
3638  002e 25e6          	jrult	L7222
3639                     ; 124     GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);
3641  0030 4b08          	push	#8
3642  0032 ae500f        	ldw	x,#20495
3643  0035 cd0000        	call	_GPIO_WriteHigh
3645  0038 84            	pop	a
3646                     ; 126     return(status);                    // return nRF24L01 status byte
3648  0039 7b01          	ld	a,(OFST-1,sp)
3651  003b 5b03          	addw	sp,#3
3652  003d 81            	ret
3655                     .const:	section	.text
3656  0000               L7322_buf:
3657  0000 a5            	dc.b	165
3658  0001 a5            	dc.b	165
3659  0002 a5            	dc.b	165
3660  0003 a5            	dc.b	165
3661  0004 a5            	dc.b	165
3705                     ; 132 unsigned char NRF24L01_Check(void)
3705                     ; 133 {
3706                     .text:	section	.text,new
3707  0000               _NRF24L01_Check:
3709  0000 5206          	subw	sp,#6
3710       00000006      OFST:	set	6
3713                     ; 134     unsigned char buf[5]={0xa5,0xa5,0xa5,0xa5,0xa5};
3715  0002 96            	ldw	x,sp
3716  0003 1c0001        	addw	x,#OFST-5
3717  0006 90ae0000      	ldw	y,#L7322_buf
3718  000a a605          	ld	a,#5
3719  000c cd0000        	call	c_xymvx
3721                     ; 136     SPI_Write_Buf(WRITE_REG+TX_ADDR,buf,5);   //写入5个字节的地址.   
3723  000f 4b05          	push	#5
3724  0011 96            	ldw	x,sp
3725  0012 1c0002        	addw	x,#OFST-4
3726  0015 89            	pushw	x
3727  0016 a630          	ld	a,#48
3728  0018 cd0000        	call	_SPI_Write_Buf
3730  001b 5b03          	addw	sp,#3
3731                     ; 137     SPI_Read_Buf(TX_ADDR,buf,5);              //读出写入的地址    
3733  001d 4b05          	push	#5
3734  001f 96            	ldw	x,sp
3735  0020 1c0002        	addw	x,#OFST-4
3736  0023 89            	pushw	x
3737  0024 a610          	ld	a,#16
3738  0026 cd0000        	call	_SPI_Read_Buf
3740  0029 5b03          	addw	sp,#3
3741                     ; 138     for(i=0;i<5;i++)
3743  002b 0f06          	clr	(OFST+0,sp)
3744  002d               L3622:
3745                     ; 139       if(buf[i]!=0xa5)
3747  002d 96            	ldw	x,sp
3748  002e 1c0001        	addw	x,#OFST-5
3749  0031 9f            	ld	a,xl
3750  0032 5e            	swapw	x
3751  0033 1b06          	add	a,(OFST+0,sp)
3752  0035 2401          	jrnc	L03
3753  0037 5c            	incw	x
3754  0038               L03:
3755  0038 02            	rlwa	x,a
3756  0039 f6            	ld	a,(x)
3757  003a a1a5          	cp	a,#165
3758  003c 2608          	jrne	L7622
3759                     ; 140           break;                     
3761                     ; 138     for(i=0;i<5;i++)
3763  003e 0c06          	inc	(OFST+0,sp)
3766  0040 7b06          	ld	a,(OFST+0,sp)
3767  0042 a105          	cp	a,#5
3768  0044 25e7          	jrult	L3622
3769  0046               L7622:
3770                     ; 141     if(i!=5)
3772  0046 7b06          	ld	a,(OFST+0,sp)
3773  0048 a105          	cp	a,#5
3774  004a 2704          	jreq	L3722
3775                     ; 142       return 1;                               //NRF24L01不在位 
3777  004c a601          	ld	a,#1
3779  004e 2001          	jra	L23
3780  0050               L3722:
3781                     ; 143     return 0;                                 //NRF24L01在位
3783  0050 4f            	clr	a
3785  0051               L23:
3787  0051 5b06          	addw	sp,#6
3788  0053 81            	ret
3836                     ; 164 unsigned char nRF24L01_RxPacket(unsigned char* rx_buf)
3836                     ; 165 {
3837                     .text:	section	.text,new
3838  0000               _nRF24L01_RxPacket:
3840  0000 89            	pushw	x
3841  0001 88            	push	a
3842       00000001      OFST:	set	1
3845                     ; 166     unsigned char revale=0;
3847  0002 0f01          	clr	(OFST+0,sp)
3848                     ; 170     stat=SPI_Read(STATUS);  // read register STATUS's value
3850  0004 a607          	ld	a,#7
3851  0006 cd0000        	call	_SPI_Read
3853  0009 b700          	ld	_stat,a
3854                     ; 171     SPI_RW_Reg(WRITE_REG+STATUS,stat);
3856  000b b600          	ld	a,_stat
3857  000d 97            	ld	xl,a
3858  000e a627          	ld	a,#39
3859  0010 95            	ld	xh,a
3860  0011 cd0000        	call	_SPI_RW_Reg
3862                     ; 172     if(stat&0x40)               // if receive data ready (RX_DR) interrupt
3864  0014 b600          	ld	a,_stat
3865  0016 a540          	bcp	a,#64
3866  0018 2719          	jreq	L7132
3867                     ; 174         SPI_Read_Buf(RD_RX_PLOAD,rx_buf,5);// read receive payload from RX_FIFO buffer      
3869  001a 4b05          	push	#5
3870  001c 1e03          	ldw	x,(OFST+2,sp)
3871  001e 89            	pushw	x
3872  001f a661          	ld	a,#97
3873  0021 cd0000        	call	_SPI_Read_Buf
3875  0024 5b03          	addw	sp,#3
3876                     ; 175         SPI_RW_Reg(FLUSH_RX,0xff);//清除RX FIFO寄存器 
3878  0026 ae00ff        	ldw	x,#255
3879  0029 a6e2          	ld	a,#226
3880  002b 95            	ld	xh,a
3881  002c cd0000        	call	_SPI_RW_Reg
3883                     ; 176         revale =1;//we have receive data    
3885  002f a601          	ld	a,#1
3886  0031 6b01          	ld	(OFST+0,sp),a
3887  0033               L7132:
3888                     ; 178     return revale;
3890  0033 7b01          	ld	a,(OFST+0,sp)
3893  0035 5b03          	addw	sp,#3
3894  0037 81            	ret
3924                     ; 186 void TX_Mode(void)
3924                     ; 187 {														 
3925                     .text:	section	.text,new
3926  0000               _TX_Mode:
3930                     ; 188 	GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);    
3932  0000 4b04          	push	#4
3933  0002 ae500f        	ldw	x,#20495
3934  0005 cd0000        	call	_GPIO_WriteLow
3936  0008 84            	pop	a
3937                     ; 189   	SPI_Write_Buf(WRITE_REG+TX_ADDR,(u8*)TX_ADDRESS,TX_ADR_WIDTH);//写TX节点地址 
3939  0009 4b05          	push	#5
3940  000b ae0000        	ldw	x,#_TX_ADDRESS
3941  000e 89            	pushw	x
3942  000f a630          	ld	a,#48
3943  0011 cd0000        	call	_SPI_Write_Buf
3945  0014 5b03          	addw	sp,#3
3946                     ; 190   	SPI_Write_Buf(WRITE_REG+RX_ADDR_P0,(u8*)RX_ADDRESS,RX_ADR_WIDTH); //设置TX节点地址,主要为了使能ACK	  
3948  0016 4b05          	push	#5
3949  0018 ae0005        	ldw	x,#_RX_ADDRESS
3950  001b 89            	pushw	x
3951  001c a62a          	ld	a,#42
3952  001e cd0000        	call	_SPI_Write_Buf
3954  0021 5b03          	addw	sp,#3
3955                     ; 192   	SPI_RW_Reg(WRITE_REG+EN_AA,0x01);     //使能通道0的自动应答    
3957  0023 ae0001        	ldw	x,#1
3958  0026 a621          	ld	a,#33
3959  0028 95            	ld	xh,a
3960  0029 cd0000        	call	_SPI_RW_Reg
3962                     ; 193   	SPI_RW_Reg(WRITE_REG+EN_RXADDR,0x01); //使能通道0的接收地址  
3964  002c ae0001        	ldw	x,#1
3965  002f a622          	ld	a,#34
3966  0031 95            	ld	xh,a
3967  0032 cd0000        	call	_SPI_RW_Reg
3969                     ; 194   	SPI_RW_Reg(WRITE_REG+SETUP_RETR,0x1a);//设置自动重发间隔时间:500us + 86us;最大自动重发次数:10次
3971  0035 ae001a        	ldw	x,#26
3972  0038 a624          	ld	a,#36
3973  003a 95            	ld	xh,a
3974  003b cd0000        	call	_SPI_RW_Reg
3976                     ; 195   	SPI_RW_Reg(WRITE_REG+RF_CH,40);       //设置RF通道为40
3978  003e ae0028        	ldw	x,#40
3979  0041 a625          	ld	a,#37
3980  0043 95            	ld	xh,a
3981  0044 cd0000        	call	_SPI_RW_Reg
3983                     ; 196     SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x07); // 设置发射速率为1MHZ，发射功率为最大值0dB 
3985  0047 ae0007        	ldw	x,#7
3986  004a a626          	ld	a,#38
3987  004c 95            	ld	xh,a
3988  004d cd0000        	call	_SPI_RW_Reg
3990                     ; 200     SPI_RW_Reg(WRITE_REG+CONFIG2,0x0e);    //配置基本工作模式的参数;PWR_UP,EN_CRC,16BIT_CRC,接收模式,开启所有中断
3992  0050 ae000e        	ldw	x,#14
3993  0053 a620          	ld	a,#32
3994  0055 95            	ld	xh,a
3995  0056 cd0000        	call	_SPI_RW_Reg
3997                     ; 201 	GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);//CE为高,10us后启动发送
3999  0059 4b04          	push	#4
4000  005b ae500f        	ldw	x,#20495
4001  005e cd0000        	call	_GPIO_WriteHigh
4003  0061 84            	pop	a
4004                     ; 202 	simple_delay_us(10);
4006  0062 ae000a        	ldw	x,#10
4007  0065 cd0000        	call	_simple_delay_us
4009                     ; 203 }
4012  0068 81            	ret
4086                     ; 211 u8 NRF24L01_Write_Buf(u8 reg, u8 *pBuf, u8 len)
4086                     ; 212 {
4087                     .text:	section	.text,new
4088  0000               _NRF24L01_Write_Buf:
4090  0000 88            	push	a
4091  0001 89            	pushw	x
4092       00000002      OFST:	set	2
4095                     ; 214  	GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);          //使能SPI传输
4097  0002 4b08          	push	#8
4098  0004 ae500f        	ldw	x,#20495
4099  0007 cd0000        	call	_GPIO_WriteLow
4101  000a 84            	pop	a
4102                     ; 215   	status = SPI_RW(reg);//发送寄存器值(位置),并读取状态值
4104  000b 7b03          	ld	a,(OFST+1,sp)
4105  000d cd0000        	call	_SPI_RW
4107  0010 6b01          	ld	(OFST-1,sp),a
4108                     ; 216   	for(u8_ctr=0; u8_ctr<len; u8_ctr++)
4110  0012 0f02          	clr	(OFST+0,sp)
4112  0014 2010          	jra	L3732
4113  0016               L7632:
4114                     ; 217         SPI_RW(*pBuf++); //写入数据  
4116  0016 1e06          	ldw	x,(OFST+4,sp)
4117  0018 1c0001        	addw	x,#1
4118  001b 1f06          	ldw	(OFST+4,sp),x
4119  001d 1d0001        	subw	x,#1
4120  0020 f6            	ld	a,(x)
4121  0021 cd0000        	call	_SPI_RW
4123                     ; 216   	for(u8_ctr=0; u8_ctr<len; u8_ctr++)
4125  0024 0c02          	inc	(OFST+0,sp)
4126  0026               L3732:
4129  0026 7b02          	ld	a,(OFST+0,sp)
4130  0028 1108          	cp	a,(OFST+6,sp)
4131  002a 25ea          	jrult	L7632
4132                     ; 218   	GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);       //关闭SPI传输
4134  002c 4b08          	push	#8
4135  002e ae500f        	ldw	x,#20495
4136  0031 cd0000        	call	_GPIO_WriteHigh
4138  0034 84            	pop	a
4139                     ; 219   	return status;          //返回读到的状态值
4141  0035 7b01          	ld	a,(OFST-1,sp)
4144  0037 5b03          	addw	sp,#3
4145  0039 81            	ret
4195                     ; 225 u8 nRF24L01_TxPacket(u8 *txbuf)
4195                     ; 226 {
4196                     .text:	section	.text,new
4197  0000               _nRF24L01_TxPacket:
4199  0000 89            	pushw	x
4200  0001 88            	push	a
4201       00000001      OFST:	set	1
4204                     ; 229 	GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
4206  0002 4b04          	push	#4
4207  0004 ae500f        	ldw	x,#20495
4208  0007 cd0000        	call	_GPIO_WriteLow
4210  000a 84            	pop	a
4211                     ; 230   	NRF24L01_Write_Buf(WR_TX_PLOAD,txbuf,TX_PLOAD_WIDTH);//写数据到TX BUF  
4213  000b 4b05          	push	#5
4214  000d 1e03          	ldw	x,(OFST+2,sp)
4215  000f 89            	pushw	x
4216  0010 a6a0          	ld	a,#160
4217  0012 cd0000        	call	_NRF24L01_Write_Buf
4219  0015 5b03          	addw	sp,#3
4220                     ; 231  	GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);//启动发送	   
4222  0017 4b04          	push	#4
4223  0019 ae500f        	ldw	x,#20495
4224  001c cd0000        	call	_GPIO_WriteHigh
4226  001f 84            	pop	a
4228  0020               L3242:
4229                     ; 233 	while(GPIO_ReadInputPin( GPIOD, GPIO_PIN_4) != 0);//等待发送完成
4231  0020 4b10          	push	#16
4232  0022 ae500f        	ldw	x,#20495
4233  0025 cd0000        	call	_GPIO_ReadInputPin
4235  0028 5b01          	addw	sp,#1
4236  002a 4d            	tnz	a
4237  002b 26f3          	jrne	L3242
4238                     ; 234 	sta=SPI_Read(STATUS);  //读取状态寄存器的值	   
4240  002d a607          	ld	a,#7
4241  002f cd0000        	call	_SPI_Read
4243  0032 6b01          	ld	(OFST+0,sp),a
4244                     ; 235 	SPI_RW_Reg(WRITE_REG+STATUS,sta); //清除TX_DS或MAX_RT中断标志
4246  0034 7b01          	ld	a,(OFST+0,sp)
4247  0036 97            	ld	xl,a
4248  0037 a627          	ld	a,#39
4249  0039 95            	ld	xh,a
4250  003a cd0000        	call	_SPI_RW_Reg
4252                     ; 236 	if(sta&MAX_TX)//达到最大重发次数
4254  003d 7b01          	ld	a,(OFST+0,sp)
4255  003f a510          	bcp	a,#16
4256  0041 270d          	jreq	L7242
4257                     ; 238 		SPI_RW_Reg(FLUSH_TX,0xff);//清除TX FIFO寄存器 
4259  0043 ae00ff        	ldw	x,#255
4260  0046 a6e1          	ld	a,#225
4261  0048 95            	ld	xh,a
4262  0049 cd0000        	call	_SPI_RW_Reg
4264                     ; 239 		return MAX_TX; 
4266  004c a610          	ld	a,#16
4268  004e 2008          	jra	L44
4269  0050               L7242:
4270                     ; 241 	if(sta&TX_OK)//发送完成
4272  0050 7b01          	ld	a,(OFST+0,sp)
4273  0052 a520          	bcp	a,#32
4274  0054 2705          	jreq	L1342
4275                     ; 243 		return TX_OK;
4277  0056 a620          	ld	a,#32
4279  0058               L44:
4281  0058 5b03          	addw	sp,#3
4282  005a 81            	ret
4283  005b               L1342:
4284                     ; 245 	return 0xff;//其他原因发送失败
4286  005b a6ff          	ld	a,#255
4288  005d 20f9          	jra	L44
4332                     	xdef	_NRF24L01_Write_Buf
4333                     	xdef	_NRF24_GPIOInit
4334                     	switch	.ubsct
4335  0000               _stat:
4336  0000 00            	ds.b	1
4337                     	xdef	_stat
4338                     	xdef	_RX_ADDRESS
4339                     	xdef	_TX_ADDRESS
4340                     	xref	_simple_delay_us
4341                     	xdef	_TX_Mode
4342                     	xdef	_NRF24L01_Check
4343                     	xdef	_nRF24L01_TxPacket
4344                     	xdef	_nRF24L01_RxPacket
4345                     	xdef	_RX_Mode
4346                     	xdef	_NRF24Init
4347                     	xdef	_SPI_Read_Buf
4348                     	xdef	_SPI_Write_Buf
4349                     	xdef	_SPI_RW_Reg
4350                     	xdef	_SPI_Read
4351                     	xdef	_SPI_RW
4352                     	xref	_SPI_GetFlagStatus
4353                     	xref	_SPI_ReceiveData
4354                     	xref	_SPI_SendData
4355                     	xref	_SPI_Cmd
4356                     	xref	_SPI_Init
4357                     	xref	_SPI_DeInit
4358                     	xref	_GPIO_ReadInputPin
4359                     	xref	_GPIO_WriteLow
4360                     	xref	_GPIO_WriteHigh
4361                     	xref	_GPIO_Init
4362                     	xref.b	c_x
4382                     	xref	c_xymvx
4383                     	end
