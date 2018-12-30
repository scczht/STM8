
#include "STM8S105K.h"


#include "stm8s.h"
#include "nrf24l01.h"
#include "delay.h"



unsigned char  TX_ADDRESS[TX_ADR_WIDTH]  = {0x34,0x43,0x10,0x10,0x01}; // Define a static TX address
unsigned char RX_ADDRESS[RX_ADR_WIDTH]  = {0x34,0x43,0x10,0x10,0x01}; // Define a static RX address
unsigned char stat;
unsigned char SPI_RW(unsigned char byte)
{   
    unsigned char  retry;
    while (SPI_GetFlagStatus(SPI_FLAG_TXE) == RESET);
    SPI_SendData(byte);
    /*!< Wait until a data is received */
    while (SPI_GetFlagStatus(SPI_FLAG_RXNE) == RESET)
    {
        //retry++;
        //if(retry>200)return 0;
    }
    /*!< Get the received data */
    byte = SPI_ReceiveData();
    return(byte);  
}
unsigned char  SPI_RW_Reg(BYTE reg, BYTE value)
{
    unsigned char status;
    
    GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                // CSN low, init SPI transaction
    status = SPI_RW(reg);      // select register
    simple_delay_us(10);
    SPI_RW(value);             // ..and write value to it..
    GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                   // CSN high again
    return(status);            // return nRF24L01 status byte
}
unsigned char SPI_Read(unsigned char reg)
{
    BYTE reg_val;
    GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);                 // CSN low, initialize SPI communication...
    //NRF24L01_CS_LOW() ;
    SPI_RW(reg);            // Select register to read from..
    simple_delay_us(10);
    reg_val = SPI_RW(0);    // ..then read registervalue
    GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);           // CSN high, terminate SPI communication
    //NRF24L01_CS_HIGH() ;
    return(reg_val);        // return register value
}
unsigned char SPI_Write_Buf(unsigned char reg, unsigned char *pBuf, unsigned char bytes)
{
    unsigned char status,byte_ctr;
           
    GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);
    status = SPI_RW(reg);        
    for(byte_ctr=0; byte_ctr<bytes; byte_ctr++) 
        SPI_RW(*pBuf++);
    GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);
    return(status);         
}

void NRF24_GPIOInit(void)
{
    //����ģ���IO�ڳ�ʼ�� 
    //MISO ��ȡ����  �������룬û���ⲿ�ж�
    GPIO_Init(NRF24L01_CE_PORT, (GPIO_Pin_TypeDef)(NRF24L01_CE_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//ce 
    GPIO_Init(NRF24L01_CS_PORT, (GPIO_Pin_TypeDef)(NRF24L01_CS_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//cs
    GPIO_Init(NRF24L01_SCK_PORT, (GPIO_Pin_TypeDef)(NRF24L01_SCK_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//sck
    GPIO_Init(NRF24L01_MOSI_PORT, (GPIO_Pin_TypeDef)(NRF24L01_MOSI_PIN ), GPIO_MODE_OUT_PP_HIGH_FAST);//MOSI
    GPIO_Init(NRF24L01_MISO_PORT, (GPIO_Pin_TypeDef)(NRF24L01_MISO_PIN), GPIO_MODE_IN_FL_NO_IT);//MISO
    GPIO_Init(NRF24L01_IRQ_PORT, (GPIO_Pin_TypeDef)(NRF24L01_IRQ_PIN ), GPIO_MODE_IN_FL_NO_IT); //IRQ
    simple_delay_us(125);
    GPIO_WriteHigh(NRF24L01_CE_PORT, NRF24L01_CE_PIN);
    GPIO_WriteHigh(NRF24L01_CS_PORT, NRF24L01_CS_PIN);
    GPIO_WriteLow(NRF24L01_SCK_PORT, NRF24L01_SCK_PIN);
    simple_delay_us(125);
}
void NRF24Init(void)
{
    NRF24_GPIOInit();
    SPI_DeInit();
    /* Initialize SPI in Slave mode  */
    SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_2, SPI_MODE_MASTER, SPI_CLOCKPOLARITY_LOW,
                    SPI_CLOCKPHASE_1EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX, SPI_NSS_SOFT,(uint8_t)0x07);  
    /* Enable the SPI*/
    SPI_Cmd(ENABLE);
    simple_delay_us(125);
    //RX_Mode();
} 
void RX_Mode(void)
{
    GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
    SPI_Write_Buf(WRITE_REG + TX_ADDR, TX_ADDRESS, TX_ADR_WIDTH);    // Writes TX_Address to nRF24L01
    SPI_Write_Buf(WRITE_REG + RX_ADDR_P0, TX_ADDRESS, RX_ADR_WIDTH); // Use the same address on the RX device as the TX device
    
    SPI_RW_Reg(WRITE_REG + EN_AA, 0x01);      //Ƶ��0�Զ�   ACKӦ������  
    SPI_RW_Reg(WRITE_REG + EN_RXADDR, 0x01);  //������յ�ַֻ��Ƶ��0�� 
    SPI_RW_Reg(WRITE_REG + RF_CH, 40);        //   �����ŵ�����Ϊ2.4GHZ���շ�����һ��
    //SPI_RW_Reg(WRITE_REG + SETUP_RETR, 0x1a);
    SPI_RW_Reg(WRITE_REG + RX_PW_P0, 5); //���ý������ݳ��ȣ���������Ϊ32�ֽ�
    SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x07); // ���÷�������Ϊ1MHZ�����书��Ϊ���ֵ0dB 
    /*���÷�������250kbps��λ5��λ3���ʹ�� λ5λ3=00:1Mbps 01:2Mbps 10:250kbps 11:��ʹ��*/
    //SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x27); // ���÷�������Ϊ250�����书��Ϊ���ֵ0dB  ���ͺŲ�֧��
    
    SPI_RW_Reg(WRITE_REG + CONFIG2, 0x0f);    //power up  1: PRX
    //CE = 1; 
    GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
    simple_delay_us(100);
}



unsigned char SPI_Read_Buf(BYTE reg, BYTE *pBuf, BYTE bytes)
{
    unsigned char status,byte_ctr;
    
    GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);// Set CSN low, init SPI tranaction
    status = SPI_RW(reg);               // Select register to write to and read status byte
    //printf("\n\r %d \n\r",status);
    for(byte_ctr=0;byte_ctr<bytes;byte_ctr++)
        pBuf[byte_ctr] = SPI_RW(0);     
    
    GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);

    return(status);                    // return nRF24L01 status byte
}

/**************************************************/
//�ϵ���NRF24L01�Ƿ���λ
//д5������Ȼ���ٶ��������бȽϣ���ͬʱ����ֵ:0����ʾ��λ;���򷵻�1����ʾ����λ 
unsigned char NRF24L01_Check(void)
{
    unsigned char buf[5]={0xa5,0xa5,0xa5,0xa5,0xa5};
    unsigned char i;       
    SPI_Write_Buf(WRITE_REG+TX_ADDR,buf,5);   //д��5���ֽڵĵ�ַ.   
    SPI_Read_Buf(TX_ADDR,buf,5);              //����д��ĵ�ַ    
    for(i=0;i<5;i++)
      if(buf[i]!=0xa5)
          break;                     
    if(i!=5)
      return 1;                               //NRF24L01����λ 
    return 0;                                 //NRF24L01��λ
    
#if 0    
    unsigned char buf1[5]={0xff,0xff,0xff,0xff,0xff};
    unsigned char i; 
    //SPI_Write_Buf(WRITE_REG+RF_SETUP,buf1,5);//д��5���ֽڵĵ�ַ.
    SPI_Read_Buf(RF_SETUP,buf1,5); 


    SPI_Read_Buf(TX_ADDR,buf1,5); 
    if(0x34==buf1[0]&&0x01==buf1[4])
        return 0;
    else
        return 1;
#endif    
}       
/*************************************************************/

/*************************************************************/
//  �������ݰ�
/**************************************************************/
unsigned char nRF24L01_RxPacket(unsigned char* rx_buf)
{
    unsigned char revale=0;
    //unsigned char buf[1]={0xaa};
    //RX_Mode();
    //SPI_Write_Buf(WRITE_REG+STATUS,buf,1);
    stat=SPI_Read(STATUS);  // read register STATUS's value
    SPI_RW_Reg(WRITE_REG+STATUS,stat);
    if(stat&0x40)               // if receive data ready (RX_DR) interrupt
    { 
        SPI_Read_Buf(RD_RX_PLOAD,rx_buf,5);// read receive payload from RX_FIFO buffer      
        SPI_RW_Reg(FLUSH_RX,0xff);//���RX FIFO�Ĵ��� 
        revale =1;//we have receive data    
    }
    return revale;
}

//�ú�����ʼ��NRF24L01��TXģʽ
//����TX��ַ,дTX���ݿ��,����RX�Զ�Ӧ��ĵ�ַ,���TX��������,ѡ��RFƵ��,�����ʺ�LNA HCURR
//PWR_UP,CRCʹ��
//��CE��ߺ�,������RXģʽ,�����Խ���������		   
//CEΪ�ߴ���10us,����������.	 
void TX_Mode(void)
{														 
	GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);    
  	SPI_Write_Buf(WRITE_REG+TX_ADDR,(u8*)TX_ADDRESS,TX_ADR_WIDTH);//дTX�ڵ��ַ 
  	SPI_Write_Buf(WRITE_REG+RX_ADDR_P0,(u8*)RX_ADDRESS,RX_ADR_WIDTH); //����TX�ڵ��ַ,��ҪΪ��ʹ��ACK	  

  	SPI_RW_Reg(WRITE_REG+EN_AA,0x01);     //ʹ��ͨ��0���Զ�Ӧ��    
  	SPI_RW_Reg(WRITE_REG+EN_RXADDR,0x01); //ʹ��ͨ��0�Ľ��յ�ַ  
  	SPI_RW_Reg(WRITE_REG+SETUP_RETR,0x1a);//�����Զ��ط����ʱ��:500us + 86us;����Զ��ط�����:10��
  	SPI_RW_Reg(WRITE_REG+RF_CH,40);       //����RFͨ��Ϊ40
    SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x07); // ���÷�������Ϊ1MHZ�����书��Ϊ���ֵ0dB 
    /*���÷�������250kbps��λ5��λ3���ʹ�� λ5λ3=00:1Mbps 01:2Mbps 10:250kbps 11:��ʹ��*/
    //SPI_RW_Reg(WRITE_REG + RF_SETUP, 0x27); // ���÷�������Ϊ250�����书��Ϊ���ֵ0dB  ���ͺŲ�֧��

    SPI_RW_Reg(WRITE_REG+CONFIG2,0x0e);    //���û�������ģʽ�Ĳ���;PWR_UP,EN_CRC,16BIT_CRC,����ģʽ,���������ж�
	GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);//CEΪ��,10us����������
	simple_delay_us(10);
}


//��ָ��λ��дָ�����ȵ�����
//reg:�Ĵ���(λ��)
//*pBuf:����ָ��
//len:���ݳ���
//����ֵ,�˴ζ�����״̬�Ĵ���ֵ
u8 NRF24L01_Write_Buf(u8 reg, u8 *pBuf, u8 len)
{
	u8 status,u8_ctr;	    
 	GPIO_WriteLow(NRF24L01_CS_PORT,NRF24L01_CS_PIN);          //ʹ��SPI����
  	status = SPI_RW(reg);//���ͼĴ���ֵ(λ��),����ȡ״ֵ̬
  	for(u8_ctr=0; u8_ctr<len; u8_ctr++)
        SPI_RW(*pBuf++); //д������  
  	GPIO_WriteHigh(NRF24L01_CS_PORT,NRF24L01_CS_PIN);       //�ر�SPI����
  	return status;          //���ض�����״ֵ̬
}	

//����NRF24L01����һ������
//txbuf:�����������׵�ַ
//����ֵ:�������״��
u8 nRF24L01_TxPacket(u8 *txbuf)
{
	unsigned char sta;
  
	GPIO_WriteLow(NRF24L01_CE_PORT,NRF24L01_CE_PIN);
  	NRF24L01_Write_Buf(WR_TX_PLOAD,txbuf,TX_PLOAD_WIDTH);//д���ݵ�TX BUF  
 	GPIO_WriteHigh(NRF24L01_CE_PORT,NRF24L01_CE_PIN);//��������	   
	//while(NRF24L01_IRQ!=0);//�ȴ��������
	while(GPIO_ReadInputPin( GPIOD, GPIO_PIN_4) != 0);//�ȴ��������
	sta=SPI_Read(STATUS);  //��ȡ״̬�Ĵ�����ֵ	   
	SPI_RW_Reg(WRITE_REG+STATUS,sta); //���TX_DS��MAX_RT�жϱ�־
	if(sta&MAX_TX)//�ﵽ����ط�����
	{
		SPI_RW_Reg(FLUSH_TX,0xff);//���TX FIFO�Ĵ��� 
		return MAX_TX; 
	}
	if(sta&TX_OK)//�������
	{
		return TX_OK;
	}
	return 0xff;//����ԭ����ʧ��
}
























