#include "stdio.h"
#include "stm8s.h"
#include "STM8S105K.h"
//#include "stm8s_i2c.h"
#include "stm8s_gpio.h"
#include "ds18b20.h"
#include "delay.h"
#include "stm8s_clk.h"
#include "oled.h"
#include "nrf24l01.h"

#define     Cycle_50us      500
#define MOTOR_GPIO_PORT  (GPIOB) /**/
#define MOTOR_GPIO_PORT_1  (GPIO_PIN_0)
#define MOTOR_GPIO_PORT_2  (GPIO_PIN_1)
#define MOTOR_GPIO_PORT_3  (GPIO_PIN_2)
#define MOTOR_GPIO_PORT_4  (GPIO_PIN_3)

unsigned char RxBuf[5]={0x01,0x03,0x05,0x07,0x09};
unsigned short tdata = 0;
/*zht git test*/
unsigned char gitTest = 30;





void Init_Uart2(void)
{
    UART2_DeInit();
    UART2_Init((u32)9600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, 
               UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);  
    UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
}

void Send_Byte(uint8_t dat)
{
    while(( UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET));
    UART2_SendData8(dat);   
}
void Send_String(unsigned char *str)
{
    while('\0'!=*str)
    {
        while(UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET);
        UART2_SendData8(*str++);
    }
}


void main(void)
{
    unsigned int i = 1;
    unsigned char temp[3];
    unsigned char dd[10];
    unsigned char cdata = 0;
    unsigned char wendu[15]={0};
    unsigned char tmp[10];
    unsigned char uStatus = 0;
		
    CLK_HSICmd(ENABLE);//启动内部高速时钟
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //内部16M时钟  
    Init_Uart2();
    Send_String("Start!!\r\n");

    IICInit();
    LCD_Init3();
    NRF24Init();
    if (1 == NRF24L01_Check())
    {
        Send_String("NO NRF !!!");
    }
    else
    {
        Send_String("NRF OK!!!");
    }
    enableInterrupts();

    Clear_Screen();
    Disp_String_8x16_16x16(1,1,"温度：");
    while (1)
    {
        //RX
        RX_Mode();
        if(nRF24L01_RxPacket(RxBuf)==1)  //返回1 表示有数据收到。
        {
            sprintf(tmp,"%d  ",(int)RxBuf[0]);
            Send_String(tmp);
            sprintf(tmp,"%d  ",(int)RxBuf[1]);
            Send_String(tmp);
            sprintf(tmp,"%d  ",(int)RxBuf[2]);
            Send_String(tmp);
            sprintf(tmp,"%u  ",(int)RxBuf[3]);
            Send_String(tmp);
            sprintf(tmp,"%d  ",(int)RxBuf[4]);
            Send_String(tmp);  
           /*解析温度*/  
            if(RxBuf[2] == 1)
            {
                sprintf(dd,"-%d.%d",(int)RxBuf[1],(int)RxBuf[0]); 
                Send_String(dd);
                Send_String("\r\n");            
            }
            else
            {
                sprintf(dd,"%d.%d",(int)RxBuf[1],(int)RxBuf[0]); 
                Send_String(dd);
                Send_String("\r\n");
            }
            Display_String_16x32(5,1,dd);           
        }
        else
        {
            Send_String("Rev NULL\r\n");
            //Display_String_16x32(5,1,"00.00");
        }
        RxBuf[0]=0;
        RxBuf[1]=0;
        RxBuf[2]=0;
        RxBuf[3]=0;
        RxBuf[4]=0;
        simple_delay_ms(1000);
        
    }

}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
    while (1)
    {
    }
}
#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
