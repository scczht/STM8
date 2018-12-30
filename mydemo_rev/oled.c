#include "stm8s.h"
#include "STM8S105K.h"
#include "stm8s_i2c.h"
#include "stm8s_gpio.h"
#include "oled_code.h"

extern void Send_Byte(uint8_t dat);
extern void Send_String(unsigned char *str);
 
/*PB4,PB5 ��������*/
static void IIC_GPIO_Init(void)
{
    PB_DDR &= 0xcf;
    PB_CR1 &= 0xcf;
    PB_CR2 &= 0xcf;
}  
 
void IICInit(void)
{
    //CLK_PCKENR1 |= 0x01;                //ʹ��IIC����ʱ��
    CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C,ENABLE);//����IIC1ʱ��
    IIC_GPIO_Init(); 

    I2C_DeInit();
    I2C_Init(200000, 0xa0,  
                  I2C_DUTYCYCLE_16_9, I2C_ACK_CURR, 
                  I2C_ADDMODE_7BIT, 8);
    I2C_Cmd(ENABLE);
}
  
void IIC_OLED_Write_Byte(unsigned char Address, unsigned char Data)
{
    unsigned char temp = 0;
    unsigned int waittime = 0;
    while(I2C_SR3 & 0x02)       //�ȴ�IIC���߿���
    {        
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {       
            Send_String("line 221\r\n");
        }
        if (waittime == 16000)
        {
            break;
        }
    }
    waittime = 0;
    I2C_CR2 |= 0x01; //������ʼλ
    while(!(I2C_SR1 & 0x01))       //EV5����ʼ�ź��Ѿ�����
    {
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {   //I2C_CR2 |= 0x01;
            Send_String("line 235\r\n");
        }

        if (waittime == 16000)
        {
            break;
        }							
    }
				
    I2C_DR = 0x78;      // ����iic�����������ַ�����λ0��д����
    waittime = 0;
    while(!(I2C_SR1&0x02))       //��ַ�Ѿ�������
    {
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {
            Send_String("line 252\r\n");
        }

        if (waittime == 16000)
        {
            break;
        }			
    }    
    temp = I2C_SR1;      //���ADDR��־λ
    temp = I2C_SR3;
    waittime = 0;	
    while((I2C_SR1 & 0x80) == 0)       //�ȴ����ͼĴ���Ϊ��
    {
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {
            Send_String("line 268\r\n");
        }

        if (waittime == 16000)
        {
            break;
        }	
    }
    I2C_DR = Address;                     //����Ҫд��24C02�Ŀռ��ַ
    //while((I2C_SR1 & 0x04) == 0);       //�ȴ��������
    //while((I2C_SR1 & 0x80) == 0);       //�ȴ����ͼĴ���Ϊ��
    waittime = 0;
    while(!(I2C_SR1 & 0x84))
    {
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {
            Send_String("line 285\r\n");
						//goto aa;
        }

        if (waittime == 16000)
        {
            break;
        }				
    }        
    I2C_DR = Data;                 //����Ҫд�������
    waittime = 0;
    while(!(I2C_SR1 & 0x84))       //�ȴ��������
    {
        waittime ++;
        if (waittime > 1600 && waittime < 1610)
        {
            Send_String("line 300\r\n");
        }

        if (waittime == 16000)
        {
            break;
        }				
    }    
    temp = I2C_SR1;     //����BTF��־λ
    temp = I2C_DR;
    I2C_CR2 |= 0x02;    //����ֹͣ�ź�	
}

void LCD_Init3(void)
{

    IIC_OLED_Write_Byte(0x00, 0xae); //--turn off oled panel

    IIC_OLED_Write_Byte(0x00,0x00); //--set low column address
    IIC_OLED_Write_Byte(0x00,0x10); //--set high column address

    IIC_OLED_Write_Byte(0x00,0x40); //--set start line address

    IIC_OLED_Write_Byte(0x00,0xb0); //--set page address

    IIC_OLED_Write_Byte(0x00,0x81); //--set contrast control register
    IIC_OLED_Write_Byte(0x00,0xff);

    IIC_OLED_Write_Byte(0x00,0xa1); //--set segment re-map 127 to 0   a0:0 to seg127
    IIC_OLED_Write_Byte(0x00,0xa6); //--set normal display

    IIC_OLED_Write_Byte(0x00,0xc9); //--set com(N-1)to com0  c0:com0 to com(N-1)

    IIC_OLED_Write_Byte(0x00,0xa8); //--set multiples ratio(1to64)
    IIC_OLED_Write_Byte(0x00,0x3f); //--1/64 duty

    IIC_OLED_Write_Byte(0x00,0xd3); //--set display offset
    IIC_OLED_Write_Byte(0x00,0x00); //--not offset

    IIC_OLED_Write_Byte(0x00,0xd5); //--set display clock divide ratio/oscillator frequency
    IIC_OLED_Write_Byte(0x00,0x80); //--set divide ratio

    IIC_OLED_Write_Byte(0x00,0xd9); //--set pre-charge period
    IIC_OLED_Write_Byte(0x00,0xf1);

    IIC_OLED_Write_Byte(0x00,0xda); //--set com pins hardware configuration
    IIC_OLED_Write_Byte(0x00,0x12);

    IIC_OLED_Write_Byte(0x00,0xdb); //--set vcomh
    IIC_OLED_Write_Byte(0x00,0x40);

    IIC_OLED_Write_Byte(0x00,0x8d); //--set chare pump enable/disable
    IIC_OLED_Write_Byte(0x00,0x14); //--set(0x10) disable
    //Write_Command3(0x10); //--set(0x10) disable
    IIC_OLED_Write_Byte(0x00,0xaf); //--turn on oled panel
}

void OLED_Pic(unsigned char *p)
{
    unsigned char i,j;
    unsigned int k = 0;
    for(j=0;j<8;j++)
    {
        IIC_OLED_Write_Byte(0x00, 0x22);//--set page1
        IIC_OLED_Write_Byte(0x00, j);//--set start page
        IIC_OLED_Write_Byte(0x00, 0x07);//--set end page

        for(i=0;i<128;i++)                      //��ʾ��ɫ���ݵ�LCD
        {
            IIC_OLED_Write_Byte(0x40, p[k]);
            k=k+1;
        
        }
    }
}

void OLED_Address(u8 page,u8 column)
{
	column=column-1;  							//����ƽ����˵�ĵ�1�У���LCD����IC���ǵ�0�С������������ȥ1.
	page=page-1;
	IIC_OLED_Write_Byte(0x00, 0xb0+page);   			//����ҳ��ַ��ÿҳ��8�С�һ�������64�б��ֳ�8��ҳ������ƽ����˵�ĵ�1ҳ����LCD����IC���ǵ�0ҳ�������������ȥ1
	IIC_OLED_Write_Byte(0x00, ((column>>4)&0x0f)+0x10);	//�����е�ַ�ĸ�4λ
	IIC_OLED_Write_Byte(0x00, column&0x0f);				//�����е�ַ�ĵ�4λ
}

//ȫ������
void Clear_Screen(void)
{
	unsigned char i,j;
 	for(j=0;j<8;j++)
	{
		OLED_Address(1+j,1);
		for(i=0;i<128;i++)
		{
			IIC_OLED_Write_Byte(0x40, 0x00);
		}
	}
}
//��ʾ16x16����ͼ�񡢺��֡���Ƨ�ֻ�16x16���������ͼ��
void Display_Graphic_16x16(u8 page,u8 column,u8 *dp)
{
	u8 i,j;
	for(j=0;j<2;j++)
	{
		OLED_Address(page+j,column);
		for (i=0;i<16;i++)
		{	
			IIC_OLED_Write_Byte(0x40, *dp);		//д���ݵ�LCD,ÿд��һ��8λ�����ݺ��е�ַ�Զ���1
			dp++;
		}
	}
}

void Display_Graphic_16x32(u8 page,u8 column,const u8 *dp)
{
	u8 i,j;
	for(j=0;j<4;j++)
	{
		OLED_Address(page+j,column);
		for (i=0;i<16;i++)
		{	
			IIC_OLED_Write_Byte(0x40, *dp);		//д���ݵ�LCD,ÿд��һ��8λ�����ݺ��е�ַ�Զ���1
			dp++;
		}
	}
}

//��ʾ5x8�ĵ�����ַ�����������Ĳ����ֱ�Ϊ��ҳ,�У��ַ���ָ�룩
void Display_Dtring_5x8(u16 page,u16 column,u8 reverse,const char *text)
{
	u16 i=0,j,k,disp_data;
	while(text[i]>0x00)
	{	
		if((text[i]>=0x20)&&(text[i]<=0x7e))
		{
			j=text[i]-0x20;
			OLED_Address(page,column);
			for(k=0;k<5;k++)
			{
				if(reverse==1)
				{
					disp_data=~ascii_table_5x8[j][k];
				}
				else
				{
					disp_data=ascii_table_5x8[j][k];
				}
				
				IIC_OLED_Write_Byte(0x40,disp_data);	//д���ݵ�LCD,ÿд��1�ֽڵ����ݺ��е�ַ�Զ���1
			}
			#if 1
			if(reverse==1)	
            {
                IIC_OLED_Write_Byte(0x40,0xff); //д��һ�пհ��У�ʹ��5x8���ַ����ַ�֮����һ�м����������
            }
			else
            {
                IIC_OLED_Write_Byte(0x40,0x00);  //д��һ�пհ��У�ʹ��5x8���ַ����ַ�֮����һ�м����������
            }
			#endif
			i++;
			column+=6;
			if(column>123)
			{
				column=1;
				page++;
			}
		}
		else
		i++;
	}
}

//��ʾ8x16�ĵ�����ַ�����������Ĳ����ֱ�Ϊ��ҳ,�У��ַ���ָ�룩
void Display_String_8x16(u16 page,u16 column,u8 *text)
{
	u16 i=0,j,k,n;
	if(column>123)
	{
		column=1;
		page+=2;
	}
	while(text[i]>0x00)
	{	
		if((text[i]>=0x20)&&(text[i]<=0x7e))
		{
			j=text[i]-0x20;
			for(n=0;n<2;n++)
			{			
				OLED_Address(page+n,column);
				for(k=0;k<8;k++)
				{		
					IIC_OLED_Write_Byte(0x40,ascii_table_8x16[j][k+8*n]);//д���ݵ�LCD,ÿд��1�ֽڵ����ݺ��е�ַ�Զ���1
				}
			}
			i++;
			column+=8;
		}
		else
		i++;
	}

}

//��ʾ8x16�ĵ�����ַ�����������Ĳ����ֱ�Ϊ��ҳ,�У��ַ���ָ�룩
void Display_String_16x32(u16 page,u16 column,u8 *text)
{
	u16 i=0,j,k,n;
	if(column>123)
	{
		column=1;
		page+=2;
	}
	while(text[i]>0x00)
	{	
		if((text[i]>=0x20)&&(text[i]<=0x7e))
		{
            if (text[i] == 0x2e)/*���*/
            {
                j= 10;
            }
            else if(text[i] == 0x2d) /*-��*/
            {
                j= 11;
            }
            else
            {
                j=text[i]-0x30;
            }
            
			for(n=0;n<4;n++)
			{			
				OLED_Address(page+n,column);
				for(k=0;k<16;k++)
				{		
					IIC_OLED_Write_Byte(0x40,ascii_table_16x32[j][k+16*n]);//д���ݵ�LCD,ÿд��1�ֽڵ����ݺ��е�ַ�Զ���1
				}
			}
			i++;
			column+=16;
		}
		else
		i++;
	}

}



//д��һ��16x16����ĺ����ַ������ַ���������躬�д��֣�
//������Ĳ�����(ҳ���У������ַ�����
void Display_String_16x16(u8 page,u8 column,u8 *text)
{
    u8 i,j,k;
    u16 address; 
    
    j = 0;
    while(text[j] != '\0')
    {
        i = 0;
        address = 1;
        while(Chinese_text_16x16[i] > 0x7e)	  // >0x7f��˵������ASCII���ַ�
        {
            if(Chinese_text_16x16[i] == text[j])
            {
                if(Chinese_text_16x16[i + 1] == text[j + 1])
                {
                    address = i * 16;
                    break;
                }
            }
            i += 2;            
        }
        
        if(column > 113)
        {
            column = 0;
            page += 2;
        }
        
        if(address != 1)// ��ʾ����                   
        {            
            for(k=0;k<2;k++)
            {
                OLED_Address(page+k,column);
	            for(i = 0; i < 16; i++)               
	            {
	                IIC_OLED_Write_Byte(0x40,Chinese_code_16x16[address]);   
	                address++;
	            }
            }
            j += 2;        
        }
        else              //��ʾ�հ��ַ�            
        {
            for(k=0;k<2;k++)
            {
                OLED_Address(page+k,column);
                for(i = 0; i < 16; i++)               
                {
                    IIC_OLED_Write_Byte(0x40,0x00);   
                }
            }
            j++;
        }
        column+=16;
    }
}

//��ʾ16x16����ĺ��ֻ���ASCII��8x16������ַ�����ַ���
//������Ĳ�����(ҳ���У��ַ�����
void Disp_String_8x16_16x16(u8 page,u8 column,const u8 *text)
{
    u8 temp[3];
    u8 i = 0;    
    
    while(text[i] != '\0')
    {
        if(text[i] > 0x7e)
        {
            temp[0] = text[i];
            temp[1] = text[i + 1];
            temp[2] = '\0';          //����Ϊ�����ֽ�
            Display_String_16x16(page,column,temp);  //��ʾ����
            column += 16;
            i += 2;
        }
        else
        {
            temp[0] = text[i];    
            temp[1] = '\0';          //��ĸռһ���ֽ�
            Display_String_16x16(page, column, temp);  //��ʾ��ĸ
            column += 8;
            i++;
        }
    }
}




