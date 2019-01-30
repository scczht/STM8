   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2788                     .const:	section	.text
2789  0000               _num_9:
2790  0000 00            	dc.b	0
2791  0001 00            	dc.b	0
2792  0002 00            	dc.b	0
2793  0003 80            	dc.b	128
2794  0004 80            	dc.b	128
2795  0005 40            	dc.b	64
2796  0006 40            	dc.b	64
2797  0007 40            	dc.b	64
2798  0008 40            	dc.b	64
2799  0009 40            	dc.b	64
2800  000a 80            	dc.b	128
2801  000b 00            	dc.b	0
2802  000c 00            	dc.b	0
2803  000d 00            	dc.b	0
2804  000e 00            	dc.b	0
2805  000f 00            	dc.b	0
2806  0010 00            	dc.b	0
2807  0011 fc            	dc.b	252
2808  0012 ff            	dc.b	255
2809  0013 03            	dc.b	3
2810  0014 00            	dc.b	0
2811  0015 00            	dc.b	0
2812  0016 00            	dc.b	0
2813  0017 00            	dc.b	0
2814  0018 00            	dc.b	0
2815  0019 00            	dc.b	0
2816  001a 00            	dc.b	0
2817  001b 03            	dc.b	3
2818  001c fe            	dc.b	254
2819  001d f8            	dc.b	248
2820  001e 00            	dc.b	0
2821  001f 00            	dc.b	0
2822  0020 00            	dc.b	0
2823  0021 01            	dc.b	1
2824  0022 03            	dc.b	3
2825  0023 07            	dc.b	7
2826  0024 0c            	dc.b	12
2827  0025 08            	dc.b	8
2828  0026 08            	dc.b	8
2829  0027 08            	dc.b	8
2830  0028 08            	dc.b	8
2831  0029 04            	dc.b	4
2832  002a 06            	dc.b	6
2833  002b e1            	dc.b	225
2834  002c 7f            	dc.b	127
2835  002d 1f            	dc.b	31
2836  002e 00            	dc.b	0
2837  002f 00            	dc.b	0
2838  0030 00            	dc.b	0
2839  0031 00            	dc.b	0
2840  0032 07            	dc.b	7
2841  0033 07            	dc.b	7
2842  0034 08            	dc.b	8
2843  0035 08            	dc.b	8
2844  0036 08            	dc.b	8
2845  0037 08            	dc.b	8
2846  0038 0c            	dc.b	12
2847  0039 06            	dc.b	6
2848  003a 03            	dc.b	3
2849  003b 01            	dc.b	1
2850  003c 00            	dc.b	0
2851  003d 00            	dc.b	0
2852  003e 00            	dc.b	0
2853  003f 00            	dc.b	0
2884                     	bsct
2885  0000               _RxBuf:
2886  0000 01            	dc.b	1
2887  0001 03            	dc.b	3
2888  0002 05            	dc.b	5
2889  0003 07            	dc.b	7
2890  0004 09            	dc.b	9
2891  0005               _tdata:
2892  0005 0000          	dc.w	0
2924                     ; 28 void Init_Uart2(void)
2924                     ; 29 {
2926                     .text:	section	.text,new
2927  0000               _Init_Uart2:
2931                     ; 30     UART2_DeInit();
2933  0000 cd0000        	call	_UART2_DeInit
2935                     ; 31     UART2_Init((u32)9600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, 
2935                     ; 32                UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);  
2937  0003 4b0c          	push	#12
2938  0005 4b80          	push	#128
2939  0007 4b00          	push	#0
2940  0009 4b00          	push	#0
2941  000b 4b00          	push	#0
2942  000d ae2580        	ldw	x,#9600
2943  0010 89            	pushw	x
2944  0011 ae0000        	ldw	x,#0
2945  0014 89            	pushw	x
2946  0015 cd0000        	call	_UART2_Init
2948  0018 5b09          	addw	sp,#9
2949                     ; 33     UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
2951  001a 4b01          	push	#1
2952  001c ae0205        	ldw	x,#517
2953  001f cd0000        	call	_UART2_ITConfig
2955  0022 84            	pop	a
2956                     ; 34 }
2959  0023 81            	ret
2995                     ; 36 void Send_Byte(uint8_t dat)
2995                     ; 37 {
2996                     .text:	section	.text,new
2997  0000               _Send_Byte:
2999  0000 88            	push	a
3000       00000000      OFST:	set	0
3003  0001               L5302:
3004                     ; 38     while(( UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET));
3006  0001 ae0080        	ldw	x,#128
3007  0004 cd0000        	call	_UART2_GetFlagStatus
3009  0007 4d            	tnz	a
3010  0008 27f7          	jreq	L5302
3011                     ; 39     UART2_SendData8(dat);   
3013  000a 7b01          	ld	a,(OFST+1,sp)
3014  000c cd0000        	call	_UART2_SendData8
3016                     ; 40 }
3019  000f 84            	pop	a
3020  0010 81            	ret
3057                     ; 41 void Send_String(unsigned char *str)
3057                     ; 42 {
3058                     .text:	section	.text,new
3059  0000               _Send_String:
3061  0000 89            	pushw	x
3062       00000000      OFST:	set	0
3065  0001 2017          	jra	L1602
3066  0003               L7602:
3067                     ; 45         while(UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET);
3069  0003 ae0080        	ldw	x,#128
3070  0006 cd0000        	call	_UART2_GetFlagStatus
3072  0009 4d            	tnz	a
3073  000a 27f7          	jreq	L7602
3074                     ; 46         UART2_SendData8(*str++);
3076  000c 1e01          	ldw	x,(OFST+1,sp)
3077  000e 1c0001        	addw	x,#1
3078  0011 1f01          	ldw	(OFST+1,sp),x
3079  0013 1d0001        	subw	x,#1
3080  0016 f6            	ld	a,(x)
3081  0017 cd0000        	call	_UART2_SendData8
3083  001a               L1602:
3084                     ; 43     while('\0'!=*str)
3086  001a 1e01          	ldw	x,(OFST+1,sp)
3087  001c 7d            	tnz	(x)
3088  001d 26e4          	jrne	L7602
3089                     ; 48 }
3092  001f 85            	popw	x
3093  0020 81            	ret
3096                     	switch	.const
3097  0040               L3702_wendu:
3098  0040 00            	dc.b	0
3099  0041 000000000000  	ds.b	14
3196                     ; 51 void main(void)
3196                     ; 52 {
3197                     .text:	section	.text,new
3198  0000               _main:
3200  0000 5227          	subw	sp,#39
3201       00000027      OFST:	set	39
3204                     ; 53     unsigned int i = 1;
3206  0002 ae0001        	ldw	x,#1
3207  0005 1f01          	ldw	(OFST-38,sp),x
3208                     ; 56     unsigned char cdata = 0;
3210  0007 0f03          	clr	(OFST-36,sp)
3211                     ; 57     unsigned char wendu[15]={0};
3213  0009 96            	ldw	x,sp
3214  000a 1c0004        	addw	x,#OFST-35
3215  000d 90ae0040      	ldw	y,#L3702_wendu
3216  0011 a60f          	ld	a,#15
3217  0013 cd0000        	call	c_xymvx
3219                     ; 59     unsigned char uStatus = 0;
3221  0016 0f13          	clr	(OFST-20,sp)
3222                     ; 61     CLK_HSICmd(ENABLE);//启动内部高速时钟
3224  0018 a601          	ld	a,#1
3225  001a cd0000        	call	_CLK_HSICmd
3227                     ; 62     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //内部16M时钟  
3229  001d 4f            	clr	a
3230  001e cd0000        	call	_CLK_HSIPrescalerConfig
3232                     ; 63     Init_Uart2();
3234  0021 cd0000        	call	_Init_Uart2
3236                     ; 64     Send_String("Start!!\r\n");
3238  0024 ae0090        	ldw	x,#L7312
3239  0027 cd0000        	call	_Send_String
3241                     ; 66     IICInit();
3243  002a cd0000        	call	_IICInit
3245                     ; 67     LCD_Init3();
3247  002d cd0000        	call	_LCD_Init3
3249                     ; 68     NRF24Init();
3251  0030 cd0000        	call	_NRF24Init
3253                     ; 69     if (1 == NRF24L01_Check())
3255  0033 cd0000        	call	_NRF24L01_Check
3257  0036 a101          	cp	a,#1
3258  0038 2608          	jrne	L1412
3259                     ; 71         Send_String("NO NRF !!!");
3261  003a ae0085        	ldw	x,#L3412
3262  003d cd0000        	call	_Send_String
3265  0040 2006          	jra	L5412
3266  0042               L1412:
3267                     ; 75         Send_String("NRF OK!!!");
3269  0042 ae007b        	ldw	x,#L7412
3270  0045 cd0000        	call	_Send_String
3272  0048               L5412:
3273                     ; 77     enableInterrupts();
3276  0048 9a            rim
3278                     ; 79     Clear_Screen();
3281  0049 cd0000        	call	_Clear_Screen
3283                     ; 80     Disp_String_8x16_16x16(1,1,"温度：");
3285  004c ae0074        	ldw	x,#L1512
3286  004f 89            	pushw	x
3287  0050 ae0001        	ldw	x,#1
3288  0053 a601          	ld	a,#1
3289  0055 95            	ld	xh,a
3290  0056 cd0000        	call	_Disp_String_8x16_16x16
3292  0059 85            	popw	x
3293  005a               L3512:
3294                     ; 84         RX_Mode();
3296  005a cd0000        	call	_RX_Mode
3298                     ; 85         if(nRF24L01_RxPacket(RxBuf)==1)  //返回1 表示有数据收到。
3300  005d ae0000        	ldw	x,#_RxBuf
3301  0060 cd0000        	call	_nRF24L01_RxPacket
3303  0063 a101          	cp	a,#1
3304  0065 2703          	jreq	L41
3305  0067 cc014a        	jp	L7512
3306  006a               L41:
3307                     ; 87             sprintf(tmp,"%d  ",(int)RxBuf[0]);
3309  006a b600          	ld	a,_RxBuf
3310  006c 5f            	clrw	x
3311  006d 97            	ld	xl,a
3312  006e 89            	pushw	x
3313  006f ae006f        	ldw	x,#L1612
3314  0072 89            	pushw	x
3315  0073 96            	ldw	x,sp
3316  0074 1c0022        	addw	x,#OFST-5
3317  0077 cd0000        	call	_sprintf
3319  007a 5b04          	addw	sp,#4
3320                     ; 88             Send_String(tmp);
3322  007c 96            	ldw	x,sp
3323  007d 1c001e        	addw	x,#OFST-9
3324  0080 cd0000        	call	_Send_String
3326                     ; 89             sprintf(tmp,"%d  ",(int)RxBuf[1]);
3328  0083 b601          	ld	a,_RxBuf+1
3329  0085 5f            	clrw	x
3330  0086 97            	ld	xl,a
3331  0087 89            	pushw	x
3332  0088 ae006f        	ldw	x,#L1612
3333  008b 89            	pushw	x
3334  008c 96            	ldw	x,sp
3335  008d 1c0022        	addw	x,#OFST-5
3336  0090 cd0000        	call	_sprintf
3338  0093 5b04          	addw	sp,#4
3339                     ; 90             Send_String(tmp);
3341  0095 96            	ldw	x,sp
3342  0096 1c001e        	addw	x,#OFST-9
3343  0099 cd0000        	call	_Send_String
3345                     ; 91             sprintf(tmp,"%d  ",(int)RxBuf[2]);
3347  009c b602          	ld	a,_RxBuf+2
3348  009e 5f            	clrw	x
3349  009f 97            	ld	xl,a
3350  00a0 89            	pushw	x
3351  00a1 ae006f        	ldw	x,#L1612
3352  00a4 89            	pushw	x
3353  00a5 96            	ldw	x,sp
3354  00a6 1c0022        	addw	x,#OFST-5
3355  00a9 cd0000        	call	_sprintf
3357  00ac 5b04          	addw	sp,#4
3358                     ; 92             Send_String(tmp);
3360  00ae 96            	ldw	x,sp
3361  00af 1c001e        	addw	x,#OFST-9
3362  00b2 cd0000        	call	_Send_String
3364                     ; 93             sprintf(tmp,"%u  ",(int)RxBuf[3]);
3366  00b5 b603          	ld	a,_RxBuf+3
3367  00b7 5f            	clrw	x
3368  00b8 97            	ld	xl,a
3369  00b9 89            	pushw	x
3370  00ba ae006a        	ldw	x,#L3612
3371  00bd 89            	pushw	x
3372  00be 96            	ldw	x,sp
3373  00bf 1c0022        	addw	x,#OFST-5
3374  00c2 cd0000        	call	_sprintf
3376  00c5 5b04          	addw	sp,#4
3377                     ; 94             Send_String(tmp);
3379  00c7 96            	ldw	x,sp
3380  00c8 1c001e        	addw	x,#OFST-9
3381  00cb cd0000        	call	_Send_String
3383                     ; 95             sprintf(tmp,"%d  ",(int)RxBuf[4]);
3385  00ce b604          	ld	a,_RxBuf+4
3386  00d0 5f            	clrw	x
3387  00d1 97            	ld	xl,a
3388  00d2 89            	pushw	x
3389  00d3 ae006f        	ldw	x,#L1612
3390  00d6 89            	pushw	x
3391  00d7 96            	ldw	x,sp
3392  00d8 1c0022        	addw	x,#OFST-5
3393  00db cd0000        	call	_sprintf
3395  00de 5b04          	addw	sp,#4
3396                     ; 96             Send_String(tmp);  
3398  00e0 96            	ldw	x,sp
3399  00e1 1c001e        	addw	x,#OFST-9
3400  00e4 cd0000        	call	_Send_String
3402                     ; 98             if(RxBuf[2] == 1)
3404  00e7 b602          	ld	a,_RxBuf+2
3405  00e9 a101          	cp	a,#1
3406  00eb 2626          	jrne	L5612
3407                     ; 100                 sprintf(dd,"-%d.%d",(int)RxBuf[1],(int)RxBuf[0]); 
3409  00ed b600          	ld	a,_RxBuf
3410  00ef 5f            	clrw	x
3411  00f0 97            	ld	xl,a
3412  00f1 89            	pushw	x
3413  00f2 b601          	ld	a,_RxBuf+1
3414  00f4 5f            	clrw	x
3415  00f5 97            	ld	xl,a
3416  00f6 89            	pushw	x
3417  00f7 ae0063        	ldw	x,#L7612
3418  00fa 89            	pushw	x
3419  00fb 96            	ldw	x,sp
3420  00fc 1c001a        	addw	x,#OFST-13
3421  00ff cd0000        	call	_sprintf
3423  0102 5b06          	addw	sp,#6
3424                     ; 101                 Send_String(dd);
3426  0104 96            	ldw	x,sp
3427  0105 1c0014        	addw	x,#OFST-19
3428  0108 cd0000        	call	_Send_String
3430                     ; 102                 Send_String("\r\n");            
3432  010b ae0060        	ldw	x,#L1712
3433  010e cd0000        	call	_Send_String
3436  0111 2024          	jra	L3712
3437  0113               L5612:
3438                     ; 106                 sprintf(dd,"%d.%d",(int)RxBuf[1],(int)RxBuf[0]); 
3440  0113 b600          	ld	a,_RxBuf
3441  0115 5f            	clrw	x
3442  0116 97            	ld	xl,a
3443  0117 89            	pushw	x
3444  0118 b601          	ld	a,_RxBuf+1
3445  011a 5f            	clrw	x
3446  011b 97            	ld	xl,a
3447  011c 89            	pushw	x
3448  011d ae005a        	ldw	x,#L5712
3449  0120 89            	pushw	x
3450  0121 96            	ldw	x,sp
3451  0122 1c001a        	addw	x,#OFST-13
3452  0125 cd0000        	call	_sprintf
3454  0128 5b06          	addw	sp,#6
3455                     ; 107                 Send_String(dd);
3457  012a 96            	ldw	x,sp
3458  012b 1c0014        	addw	x,#OFST-19
3459  012e cd0000        	call	_Send_String
3461                     ; 108                 Send_String("\r\n");
3463  0131 ae0060        	ldw	x,#L1712
3464  0134 cd0000        	call	_Send_String
3466  0137               L3712:
3467                     ; 110             Display_String_16x32(5,1,dd);           
3469  0137 96            	ldw	x,sp
3470  0138 1c0014        	addw	x,#OFST-19
3471  013b 89            	pushw	x
3472  013c ae0001        	ldw	x,#1
3473  013f 89            	pushw	x
3474  0140 ae0005        	ldw	x,#5
3475  0143 cd0000        	call	_Display_String_16x32
3477  0146 5b04          	addw	sp,#4
3479  0148 2006          	jra	L7712
3480  014a               L7512:
3481                     ; 114             Send_String("Rev NULL\r\n");
3483  014a ae004f        	ldw	x,#L1022
3484  014d cd0000        	call	_Send_String
3486  0150               L7712:
3487                     ; 117         RxBuf[0]=0;
3489  0150 3f00          	clr	_RxBuf
3490                     ; 118         RxBuf[1]=0;
3492  0152 3f01          	clr	_RxBuf+1
3493                     ; 119         RxBuf[2]=0;
3495  0154 3f02          	clr	_RxBuf+2
3496                     ; 120         RxBuf[3]=0;
3498  0156 3f03          	clr	_RxBuf+3
3499                     ; 121         RxBuf[4]=0;
3501  0158 3f04          	clr	_RxBuf+4
3502                     ; 122         simple_delay_ms(1000);
3504  015a ae03e8        	ldw	x,#1000
3505  015d cd0000        	call	_simple_delay_ms
3508  0160 ac5a005a      	jpf	L3512
3543                     ; 137 void assert_failed(u8* file, u32 line)
3543                     ; 138 { 
3544                     .text:	section	.text,new
3545  0000               _assert_failed:
3549  0000               L1222:
3550  0000 20fe          	jra	L1222
3584                     	xdef	_main
3585                     	xdef	_Send_String
3586                     	xdef	_Send_Byte
3587                     	xdef	_Init_Uart2
3588                     	xdef	_tdata
3589                     	xdef	_RxBuf
3590                     	xref	_NRF24L01_Check
3591                     	xref	_nRF24L01_RxPacket
3592                     	xref	_RX_Mode
3593                     	xref	_NRF24Init
3594                     	xref	_Display_String_16x32
3595                     	xref	_Disp_String_8x16_16x16
3596                     	xref	_Clear_Screen
3597                     	xref	_LCD_Init3
3598                     	xref	_IICInit
3599                     	xdef	_num_9
3600                     	xref	_simple_delay_ms
3601                     	xdef	_assert_failed
3602                     	xref	_UART2_GetFlagStatus
3603                     	xref	_UART2_SendData8
3604                     	xref	_UART2_ITConfig
3605                     	xref	_UART2_Init
3606                     	xref	_UART2_DeInit
3607                     	xref	_CLK_HSIPrescalerConfig
3608                     	xref	_CLK_HSICmd
3609                     	xref	_sprintf
3610                     	switch	.const
3611  004f               L1022:
3612  004f 526576204e55  	dc.b	"Rev NULL",13
3613  0058 0a00          	dc.b	10,0
3614  005a               L5712:
3615  005a 25642e256400  	dc.b	"%d.%d",0
3616  0060               L1712:
3617  0060 0d0a00        	dc.b	13,10,0
3618  0063               L7612:
3619  0063 2d25642e2564  	dc.b	"-%d.%d",0
3620  006a               L3612:
3621  006a 2575202000    	dc.b	"%u  ",0
3622  006f               L1612:
3623  006f 2564202000    	dc.b	"%d  ",0
3624  0074               L1512:
3625  0074 cec2b6c8a3ba  	dc.b	206,194,182,200,163,186,0
3626  007b               L7412:
3627  007b 4e5246204f4b  	dc.b	"NRF OK!!!",0
3628  0085               L3412:
3629  0085 4e4f204e5246  	dc.b	"NO NRF !!!",0
3630  0090               L7312:
3631  0090 537461727421  	dc.b	"Start!!",13
3632  0098 0a00          	dc.b	10,0
3633                     	xref.b	c_x
3653                     	xref	c_xymvx
3654                     	end
