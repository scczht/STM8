//#include "stm8s.h"
//#include "STM8S105K.h"
//#include "stm8s_i2c.h"
#include "stm8s_gpio.h"
#include "delay.h"

#define TES_SENSOR_PIN             GPIOE, GPIO_PIN_5        /*PD0: �¶ȴ����������ܽ� */  
#define DS18B20_IO_OUT  GPIO_Init(TES_SENSOR_PIN, GPIO_MODE_OUT_PP_HIGH_FAST) /*����stm8�ϵ�DQ����Ϊ���ģʽ*/
#define DS18B20_IO_IN   GPIO_Init(TES_SENSOR_PIN, GPIO_MODE_IN_PU_NO_IT)/*����stm8�ϵ�DQ����Ϊ����ģʽ*/
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

/* ��ʼ��DS18B20��IO�� DQ ͬʱ���DS�Ĵ���: 1->������  0->���� */  	 
u8 DS18B20_Init(void)
{
    unsigned char ucounters = 0;
    DS18B20_IO_OUT;   
    DS18B20_DQ_HIGH;   
    simple_delay_us(2);
    DS18B20_DQ_LOW;   
    simple_delay_us(400);     //��λ����

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
    unsigned char TL = 0; /* DS18B20�������¶ȼĴ���ֵ��TH��Ÿ�8λ��TL��ŵ�8λ */
    unsigned char TH = 0;
    unsigned short temp;  /* �¶�ֵ */
    unsigned char byte;  //����һ��byte8λ   
    
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

/*Ϊ�˱��ں���������ʾ���ú��������ţ��������ݣ�С�����ݷֿ�����*/
void DS18B20_WorkTemperature(unsigned char *data)
{
    unsigned short temp = DS18B20_ReadTemperature();

    /*�ж�����*/
    if ((temp & 0xf800) == 0xf800)
    {
        data[2] = 1;/*��ʾ����*/
        temp = ~temp + 1;  //����
        data[1] = (temp & 0x07F0) >> 4; /*�����������*/
        data[0] = (temp & 0x000F)*625/10; /*���С��,������λС��*/
    }
    else
    {
        data[2] = 0;/*��ʾ����*/
        data[1] = (temp & 0x07F0) >> 4; /*�����������*/
        data[0] = (temp & 0x000F)*625/10; /*���С��,������λС��*/
    }
}