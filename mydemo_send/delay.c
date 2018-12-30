#include "delay.h"


void simple_delay_us(unsigned short n) 
{
    for(;n>0;n--) 
    { 
        _asm("nop"); //��STM8���棬16M����_nop_() ��ʱ�� 333ns
        _asm("nop"); 
        _asm("nop"); 
       // _asm("nop"); 
    }
}

//---- ���뼶��ʱ����----------------------- 
void simple_delay_ms(unsigned short time) 
{ 
    unsigned int i; 
    while(time--)
    {
        for(i=900;i>0;i--) 
            simple_delay_us(1);
    }
 
}

//ʹ���ڲ�16Mʱ��1һ��while��ʱ0.8us
void delay_us(unsigned int us)
{
	while(us--)
	{
		_asm("nop");
		_asm("nop");
	}
}

//ʹ���ڲ�16Mʱ��1ms
void delay_ms(unsigned int ms)
{
	int i;
	while(ms--)
	{
		for(i=0;i<1250;i++);
	}
}


void _delay_us(unsigned short i)
{
    i *= 3; 
    while(--i);
}

void _delay_ms(unsigned short i)
{
    while(i--)
    {
        _delay_us(1000);
    }
}



