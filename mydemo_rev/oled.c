#include "stm8s.h"
#include "STM8S105K.h"
#include "stm8s_i2c.h"
#include "stm8s_gpio.h"
#include "oled_code.h"

extern void Send_Byte(uint8_t dat);
extern void Send_String(unsigned char *str);
 
/*PB4,PB5 悬浮输入*/
static void IIC_GPIO_Init(void)
{
    PB_DDR &= 0xcf;
    PB_CR1 &= 0xcf;
    PB_CR2 &= 0xcf;
}  
 
void IICInit(void)
{
    //CLK_PCKENR1 |= 0x01;                //使能IIC外设时钟
    CLK_PeripheralClockConfig (CLK_PERIPHERAL_I2C,ENABLE);//开启IIC1时钟
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
    while(I2C_SR3 & 0x02)       //等待IIC总线空闲
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
    I2C_CR2 |= 0x01; //产生起始位
    while(!(I2C_SR1 & 0x01))       //EV5，起始信号已经发送
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
				
    I2C_DR = 0x78;      // 发送iic从器件物理地址，最低位0，写操作
    waittime = 0;
    while(!(I2C_SR1&0x02))       //地址已经被发送
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
    temp = I2C_SR1;      //清除ADDR标志位
    temp = I2C_SR3;
    waittime = 0;	
    while((I2C_SR1 & 0x80) == 0)       //等待发送寄存器为空
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
    I2C_DR = Address;                     //发送要写入24C02的空间地址
    //while((I2C_SR1 & 0x04) == 0);       //等待发送完成
    //while((I2C_SR1 & 0x80) == 0);       //等待发送寄存器为空
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
    I2C_DR = Data;                 //发送要写入的数据
    waittime = 0;
    while(!(I2C_SR1 & 0x84))       //等待发送完成
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
    temp = I2C_SR1;     //清零BTF标志位
    temp = I2C_DR;
    I2C_CR2 |= 0x02;    //发送停止信号	
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

        for(i=0;i<128;i++)                      //显示单色数据到LCD
        {
            IIC_OLED_Write_Byte(0x40, p[k]);
            k=k+1;
        
        }
    }
}

void OLED_Address(u8 page,u8 column)
{
	column=column-1;  							//我们平常所说的第1列，在LCD驱动IC里是第0列。所以在这里减去1.
	page=page-1;
	IIC_OLED_Write_Byte(0x00, 0xb0+page);   			//设置页地址。每页是8行。一个画面的64行被分成8个页。我们平常所说的第1页，在LCD驱动IC里是第0页，所以在这里减去1
	IIC_OLED_Write_Byte(0x00, ((column>>4)&0x0f)+0x10);	//设置列地址的高4位
	IIC_OLED_Write_Byte(0x00, column&0x0f);				//设置列地址的低4位
}

//全屏清屏
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
//显示16x16点阵图像、汉字、生僻字或16x16点阵的其他图标
void Display_Graphic_16x16(u8 page,u8 column,u8 *dp)
{
	u8 i,j;
	for(j=0;j<2;j++)
	{
		OLED_Address(page+j,column);
		for (i=0;i<16;i++)
		{	
			IIC_OLED_Write_Byte(0x40, *dp);		//写数据到LCD,每写完一个8位的数据后列地址自动加1
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
			IIC_OLED_Write_Byte(0x40, *dp);		//写数据到LCD,每写完一个8位的数据后列地址自动加1
			dp++;
		}
	}
}

//显示5x8的点阵的字符串，括号里的参数分别为（页,列，字符串指针）
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
				
				IIC_OLED_Write_Byte(0x40,disp_data);	//写数据到LCD,每写完1字节的数据后列地址自动加1
			}
			#if 1
			if(reverse==1)	
            {
                IIC_OLED_Write_Byte(0x40,0xff); //写入一列空白列，使得5x8的字符与字符之间有一列间隔，更美观
            }
			else
            {
                IIC_OLED_Write_Byte(0x40,0x00);  //写入一列空白列，使得5x8的字符与字符之间有一列间隔，更美观
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

//显示8x16的点阵的字符串，括号里的参数分别为（页,列，字符串指针）
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
					IIC_OLED_Write_Byte(0x40,ascii_table_8x16[j][k+8*n]);//写数据到LCD,每写完1字节的数据后列地址自动加1
				}
			}
			i++;
			column+=8;
		}
		else
		i++;
	}

}

//显示8x16的点阵的字符串，括号里的参数分别为（页,列，字符串指针）
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
            if (text[i] == 0x2e)/*点号*/
            {
                j= 10;
            }
            else if(text[i] == 0x2d) /*-号*/
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
					IIC_OLED_Write_Byte(0x40,ascii_table_16x32[j][k+16*n]);//写数据到LCD,每写完1字节的数据后列地址自动加1
				}
			}
			i++;
			column+=16;
		}
		else
		i++;
	}

}



//写入一组16x16点阵的汉字字符串（字符串表格中需含有此字）
//括号里的参数：(页，列，汉字字符串）
void Display_String_16x16(u8 page,u8 column,u8 *text)
{
    u8 i,j,k;
    u16 address; 
    
    j = 0;
    while(text[j] != '\0')
    {
        i = 0;
        address = 1;
        while(Chinese_text_16x16[i] > 0x7e)	  // >0x7f即说明不是ASCII码字符
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
        
        if(address != 1)// 显示汉字                   
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
        else              //显示空白字符            
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

//显示16x16点阵的汉字或者ASCII码8x16点阵的字符混合字符串
//括号里的参数：(页，列，字符串）
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
            temp[2] = '\0';          //汉字为两个字节
            Display_String_16x16(page,column,temp);  //显示汉字
            column += 16;
            i += 2;
        }
        else
        {
            temp[0] = text[i];    
            temp[1] = '\0';          //字母占一个字节
            Display_String_16x16(page, column, temp);  //显示字母
            column += 8;
            i++;
        }
    }
}




