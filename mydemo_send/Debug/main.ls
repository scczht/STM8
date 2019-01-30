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
2924                     ; 25 void Init_Uart2(void)
2924                     ; 26 {
2926                     .text:	section	.text,new
2927  0000               _Init_Uart2:
2931                     ; 27     UART2_DeInit();
2933  0000 cd0000        	call	_UART2_DeInit
2935                     ; 28     UART2_Init((u32)9600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, 
2935                     ; 29                UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);  
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
2949                     ; 30     UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
2951  001a 4b01          	push	#1
2952  001c ae0205        	ldw	x,#517
2953  001f cd0000        	call	_UART2_ITConfig
2955  0022 84            	pop	a
2956                     ; 31 }
2959  0023 81            	ret
2995                     ; 33 void Send_Byte(uint8_t dat)
2995                     ; 34 {
2996                     .text:	section	.text,new
2997  0000               _Send_Byte:
2999  0000 88            	push	a
3000       00000000      OFST:	set	0
3003  0001               L5302:
3004                     ; 35     while(( UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET));
3006  0001 ae0080        	ldw	x,#128
3007  0004 cd0000        	call	_UART2_GetFlagStatus
3009  0007 4d            	tnz	a
3010  0008 27f7          	jreq	L5302
3011                     ; 36     UART2_SendData8(dat);   
3013  000a 7b01          	ld	a,(OFST+1,sp)
3014  000c cd0000        	call	_UART2_SendData8
3016                     ; 37 }
3019  000f 84            	pop	a
3020  0010 81            	ret
3057                     ; 38 void Send_String(unsigned char *str)
3057                     ; 39 {
3058                     .text:	section	.text,new
3059  0000               _Send_String:
3061  0000 89            	pushw	x
3062       00000000      OFST:	set	0
3065  0001 2017          	jra	L1602
3066  0003               L7602:
3067                     ; 42         while(UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET);
3069  0003 ae0080        	ldw	x,#128
3070  0006 cd0000        	call	_UART2_GetFlagStatus
3072  0009 4d            	tnz	a
3073  000a 27f7          	jreq	L7602
3074                     ; 43         UART2_SendData8(*str++);
3076  000c 1e01          	ldw	x,(OFST+1,sp)
3077  000e 1c0001        	addw	x,#1
3078  0011 1f01          	ldw	(OFST+1,sp),x
3079  0013 1d0001        	subw	x,#1
3080  0016 f6            	ld	a,(x)
3081  0017 cd0000        	call	_UART2_SendData8
3083  001a               L1602:
3084                     ; 40     while('\0'!=*str)
3086  001a 1e01          	ldw	x,(OFST+1,sp)
3087  001c 7d            	tnz	(x)
3088  001d 26e4          	jrne	L7602
3089                     ; 45 }
3092  001f 85            	popw	x
3093  0020 81            	ret
3096                     	switch	.const
3097  0040               L3702_wendu:
3098  0040 00            	dc.b	0
3099  0041 000000000000  	ds.b	14
3183                     ; 48 void main(void)
3183                     ; 49 {
3184                     .text:	section	.text,new
3185  0000               _main:
3187  0000 5216          	subw	sp,#22
3188       00000016      OFST:	set	22
3191                     ; 50     unsigned int i = 1;
3193  0002 ae0001        	ldw	x,#1
3194  0005 1f01          	ldw	(OFST-21,sp),x
3195                     ; 53     unsigned char cdata = 0;
3197  0007 0f03          	clr	(OFST-19,sp)
3198                     ; 54     unsigned char wendu[15]={0};
3200  0009 96            	ldw	x,sp
3201  000a 1c0004        	addw	x,#OFST-18
3202  000d 90ae0040      	ldw	y,#L3702_wendu
3203  0011 a60f          	ld	a,#15
3204  0013 cd0000        	call	c_xymvx
3206                     ; 56     unsigned char uStatus = 0;
3208                     ; 58     CLK_HSICmd(ENABLE);//启动内部高速时钟
3210  0016 a601          	ld	a,#1
3211  0018 cd0000        	call	_CLK_HSICmd
3213                     ; 59     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //内部16M时钟  
3215  001b 4f            	clr	a
3216  001c cd0000        	call	_CLK_HSIPrescalerConfig
3218                     ; 60     Init_Uart2();
3220  001f cd0000        	call	_Init_Uart2
3222                     ; 61     Send_String("Start!!\r\n");
3224  0022 ae0093        	ldw	x,#L3312
3225  0025 cd0000        	call	_Send_String
3227                     ; 63     NRF24Init();
3229  0028 cd0000        	call	_NRF24Init
3231                     ; 64     if (1 == NRF24L01_Check())
3233  002b cd0000        	call	_NRF24L01_Check
3235  002e a101          	cp	a,#1
3236  0030 2608          	jrne	L5312
3237                     ; 66         Send_String("NO NRF !!!");
3239  0032 ae0088        	ldw	x,#L7312
3240  0035 cd0000        	call	_Send_String
3243  0038 2006          	jra	L1412
3244  003a               L5312:
3245                     ; 70         Send_String("NRF OK!!!");
3247  003a ae007e        	ldw	x,#L3412
3248  003d cd0000        	call	_Send_String
3250  0040               L1412:
3251                     ; 72     GPIO_Init(GPIOE, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
3253  0040 4bf0          	push	#240
3254  0042 4b20          	push	#32
3255  0044 ae5014        	ldw	x,#20500
3256  0047 cd0000        	call	_GPIO_Init
3258  004a 85            	popw	x
3259                     ; 73     enableInterrupts();
3262  004b 9a            rim
3264  004c               L5412:
3265                     ; 77         DS18B20_WorkTemperature(temp);
3267  004c 96            	ldw	x,sp
3268  004d 1c0014        	addw	x,#OFST-2
3269  0050 cd0000        	call	_DS18B20_WorkTemperature
3271                     ; 78         RxBuf[0] = temp[0];
3273  0053 7b14          	ld	a,(OFST-2,sp)
3274  0055 b700          	ld	_RxBuf,a
3275                     ; 79         RxBuf[1] = temp[1];
3277  0057 7b15          	ld	a,(OFST-1,sp)
3278  0059 b701          	ld	_RxBuf+1,a
3279                     ; 80         RxBuf[2] = temp[2];
3281  005b 7b16          	ld	a,(OFST+0,sp)
3282  005d b702          	ld	_RxBuf+2,a
3283                     ; 82         TX_Mode();//TX
3285  005f cd0000        	call	_TX_Mode
3287                     ; 83         uStatus = nRF24L01_TxPacket(RxBuf);
3289  0062 ae0000        	ldw	x,#_RxBuf
3290  0065 cd0000        	call	_nRF24L01_TxPacket
3292  0068 6b13          	ld	(OFST-3,sp),a
3293                     ; 84         if(uStatus ==TX_OK)
3295  006a 7b13          	ld	a,(OFST-3,sp)
3296  006c a120          	cp	a,#32
3297  006e 2608          	jrne	L1512
3298                     ; 86            Send_String("Send OK!\r\n");
3300  0070 ae0073        	ldw	x,#L3512
3301  0073 cd0000        	call	_Send_String
3304  0076 2026          	jra	L5512
3305  0078               L1512:
3306                     ; 87         }else if(uStatus == MAX_TX)
3308  0078 7b13          	ld	a,(OFST-3,sp)
3309  007a a110          	cp	a,#16
3310  007c 2611          	jrne	L7512
3311                     ; 89            Send_String("Send MAX_TX Faild!\r\n");
3313  007e ae005e        	ldw	x,#L1612
3314  0081 cd0000        	call	_Send_String
3316                     ; 90             GPIO_WriteReverse(GPIOE, GPIO_PIN_5);
3318  0084 4b20          	push	#32
3319  0086 ae5014        	ldw	x,#20500
3320  0089 cd0000        	call	_GPIO_WriteReverse
3322  008c 84            	pop	a
3324  008d 200f          	jra	L5512
3325  008f               L7512:
3326                     ; 94             Send_String("Send  Faild!\r\n");
3328  008f ae004f        	ldw	x,#L5612
3329  0092 cd0000        	call	_Send_String
3331                     ; 95             GPIO_WriteReverse(GPIOE, GPIO_PIN_5);
3333  0095 4b20          	push	#32
3334  0097 ae5014        	ldw	x,#20500
3335  009a cd0000        	call	_GPIO_WriteReverse
3337  009d 84            	pop	a
3338  009e               L5512:
3339                     ; 97         simple_delay_ms(1200);
3341  009e ae04b0        	ldw	x,#1200
3342  00a1 cd0000        	call	_simple_delay_ms
3345  00a4 20a6          	jra	L5412
3380                     ; 111 void assert_failed(u8* file, u32 line)
3380                     ; 112 { 
3381                     .text:	section	.text,new
3382  0000               _assert_failed:
3386  0000               L5022:
3387  0000 20fe          	jra	L5022
3421                     	xdef	_main
3422                     	xdef	_Send_String
3423                     	xdef	_Send_Byte
3424                     	xdef	_Init_Uart2
3425                     	xdef	_tdata
3426                     	xdef	_RxBuf
3427                     	xref	_TX_Mode
3428                     	xref	_NRF24L01_Check
3429                     	xref	_nRF24L01_TxPacket
3430                     	xref	_NRF24Init
3431                     	xdef	_num_9
3432                     	xref	_simple_delay_ms
3433                     	xref	_DS18B20_WorkTemperature
3434                     	xdef	_assert_failed
3435                     	xref	_UART2_GetFlagStatus
3436                     	xref	_UART2_SendData8
3437                     	xref	_UART2_ITConfig
3438                     	xref	_UART2_Init
3439                     	xref	_UART2_DeInit
3440                     	xref	_GPIO_WriteReverse
3441                     	xref	_GPIO_Init
3442                     	xref	_CLK_HSIPrescalerConfig
3443                     	xref	_CLK_HSICmd
3444                     	switch	.const
3445  004f               L5612:
3446  004f 53656e642020  	dc.b	"Send  Faild!",13
3447  005c 0a00          	dc.b	10,0
3448  005e               L1612:
3449  005e 53656e64204d  	dc.b	"Send MAX_TX Faild!"
3450  0070 0d0a00        	dc.b	13,10,0
3451  0073               L3512:
3452  0073 53656e64204f  	dc.b	"Send OK!",13
3453  007c 0a00          	dc.b	10,0
3454  007e               L3412:
3455  007e 4e5246204f4b  	dc.b	"NRF OK!!!",0
3456  0088               L7312:
3457  0088 4e4f204e5246  	dc.b	"NO NRF !!!",0
3458  0093               L3312:
3459  0093 537461727421  	dc.b	"Start!!",13
3460  009b 0a00          	dc.b	10,0
3461                     	xref.b	c_x
3481                     	xref	c_xymvx
3482                     	end
