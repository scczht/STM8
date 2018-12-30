//#include "stm8s.h"
//#include "STM8S105K.h"
//#include "stm8s_i2c.h"
#include "stm8s_gpio.h"
#include "delay.h"

#define TES_SENSOR_PIN             GPIOE, GPIO_PIN_5        /*PD0: 温度传感器采样管脚 */  
#define DS18B20_IO_OUT  GPIO_Init(TES_SENSOR_PIN, GPIO_MODE_OUT_PP_HIGH_FAST) /*设置stm8上的DQ引脚为输出模式*/
#define DS18B20_IO_IN   GPIO_Init(TES_SENSOR_PIN, GPIO_MODE_IN_PU_NO_IT)/*设置stm8上的DQ引脚为输入模式*/
#define DS18B20_DQ_HIGH   GPIO_WriteHigh(TES_SENSOR_PIN)
#define DS18B20_DQ_LOW    GPIO_WriteLow(TES_SENSOR_PIN)
#define DS18B20_DQ_IN GPIO_ReadInputPin(TES_SENSOR_PIN)

extern void Send_Byte(uint8_t dat);
extern void Send_String(unsigned char *str);

void DS18B20_WriteByte( unsigned char _data )
{
    unsigned char i = 0;

    DS18B20_IO_OUT;
    for ( i = 0; i < 8; i++ )
    {
        DS18B20_DQ_LOW;
        simple_delay_us( 2 );
        if ( _data & 0x01 )
        {
            DS18B20_DQ_HIGH;
        }
        _data >>= 1;
        simple_delay_us( 80 );
        DS18B20_DQ_HIGH;
    }
}

unsigned char DS18B20_ReadByte( void )
{
    unsigned char i = 0;
    unsigned char _data = 0;
    
    for ( i = 0; i < 8; i++ )
    {
        DS18B20_IO_OUT;
        DS18B20_DQ_LOW;
        simple_delay_us(2);
        _data >>= 1;
        DS18B20_DQ_HIGH;
        DS18B20_IO_IN;
        simple_delay_us(16);
        if (DS18B20_DQ_IN == SET)
        {
            _data |= 0x80;
        }

        simple_delay_us( 60 );
        DS18B20_IO_OUT;
        DS18B20_DQ_HIGH;
	}
    return _data;
}

/* 初始化DS18B20的IO口 DQ 同时检测DS的存在: 1->不存在  0->存在 */  	 
u8 DS18B20_Init(void)
{
    unsigned char ucounters = 0;
    DS18B20_IO_OUT;   
    DS18B20_DQ_HIGH;   
    simple_delay_us(2);
    DS18B20_DQ_LOW;   
    simple_delay_us(400);     //复位脉冲

    DS18B20_DQ_HIGH;
    DS18B20_IO_IN;     
    simple_delay_us(60);     
    while((DS18B20_DQ_IN == SET) || (ucounters > 10))
    {
        //Send_Byte(1); 
        ucounters ++;
        simple_delay_us(10);
    }
    simple_delay_us(400);    
}

unsigned short DS18B20_ReadTemperature(void)
{
    unsigned char TL = 0; /* DS18B20读出的温度寄存器值，TH存放高8位，TL存放低8位 */
    unsigned char TH = 0;
    unsigned short temp;  /* 温度值 */
    unsigned char byte;  //定义一个byte8位   
    
    DS18B20_Init();
    DS18B20_WriteByte(0xcc);
    DS18B20_WriteByte(0x44);

    DS18B20_Init();
    DS18B20_WriteByte(0xcc);
    DS18B20_WriteByte(0xbe);

    TL = DS18B20_ReadByte();   
    TH = DS18B20_ReadByte();
    temp = (TH << 8) | TL;  
    return temp;
}

/*为了便于后续各种显示，该函数将符号，整数数据，小数数据分开保存*/
void DS18B20_WorkTemperature(unsigned char *data)
{
    unsigned short temp = DS18B20_ReadTemperature();

    /*判断正负*/
    if ((temp & 0xf800) == 0xf800)
    {
        data[2] = 1;/*表示负数*/
        temp = ~temp + 1;  //补码
        data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
        data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
    }
    else
    {
        data[2] = 0;/*表示负数*/
        data[1] = (temp & 0x07F0) >> 4; /*存放整数部分*/
        data[0] = (temp & 0x000F)*625/10; /*存放小数,保留两位小数*/
    }
}