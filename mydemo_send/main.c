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


void LCD_Init3(void);

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

    NRF24Init();
    if (1 == NRF24L01_Check())
    {
        Send_String("NO NRF !!!");
    }
    else
    {
        Send_String("NRF OK!!!");
    }
    GPIO_Init(GPIOE, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
    enableInterrupts();

    while (1)
    {
        DS18B20_WorkTemperature(temp);
        RxBuf[0] = temp[0];
        RxBuf[1] = temp[1];
        RxBuf[2] = temp[2];
        
        TX_Mode();//TX
        uStatus = nRF24L01_TxPacket(RxBuf);
        if(uStatus ==TX_OK)
        { 
           Send_String("Send OK!\r\n");
        }else if(uStatus == MAX_TX)
        {                                           
           Send_String("Send MAX_TX Faild!\r\n");
            GPIO_WriteReverse(GPIOE, GPIO_PIN_5);
        }  
        else
        {
            Send_String("Send  Faild!\r\n");
            GPIO_WriteReverse(GPIOE, GPIO_PIN_5);
        }
        simple_delay_ms(1200);
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
