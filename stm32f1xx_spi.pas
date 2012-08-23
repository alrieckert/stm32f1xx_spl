//======================================================================
unit stm32f1xx_spi;

//======================================================================
interface
uses 
  stm32f1xx_rcc;

type

  TSPI_InitTypeDef = record
    SPI_Direction : word;           //  Specifies the SPI unidirectional or bidirectional data mode.
                                    //  This parameter can be a value of @ref SPI_data_direction
    SPI_Mode : word;                //  Specifies the SPI operating mode.
                                    //   This parameter can be a value of @ref SPI_mode
    SPI_DataSize : word;            //  Specifies the SPI data size.
                                    //   This parameter can be a value of @ref SPI_data_size
    SPI_CPOL : word;                //  Specifies the serial clock steady state.
                                    //   This parameter can be a value of @ref SPI_Clock_Polarity
    SPI_CPHA : word;                //  Specifies the clock active edge for the bit capture.
                                    //   This parameter can be a value of @ref SPI_Clock_Phase
    SPI_NSS : word;                 //  Specifies whether the NSS signal is managed by
                                    //   hardware (NSS pin) or by software using the SSI bit.
                                    //   This parameter can be a value of @ref SPI_Slave_Select_management
    SPI_BaudRatePrescaler : word;   //  Specifies the Baud Rate prescaler value which will be
                                    //   used to configure the transmit and receive SCK clock.
                                    //   This parameter can be a value of @ref SPI_BaudRate_Prescaler.
                                    //   @note The communication clock is derived from the master
                                    //         clock. The slave clock does not need to be set.
    SPI_FirstBit: word;             //  Specifies whether data transfers start from MSB or LSB bit.
                                    //   This parameter can be a value of @ref SPI_MSB_LSB_transmission

    SPI_CRCPolynomial : word;       //  Specifies the polynomial used for the CRC calculation.
  end;

  TI2S_InitTypeDef = record
    I2S_Mode : word;         //  Specifies the I2S operating mode.
                             //   This parameter can be a value of @ref I2S_Mode

    I2S_Standard : word;     //  Specifies the standard used for the I2S communication.
                             //   This parameter can be a value of @ref I2S_Standard

    I2S_DataFormat : word;   //  Specifies the data format for the I2S communication.
                             //   This parameter can be a value of @ref I2S_Data_Format

    I2S_MCLKOutput : word;   //  Specifies whether the I2S MCLK output is enabled or not.
                             //   This parameter can be a value of @ref I2S_MCLK_Output

    I2S_AudioFreq : dword;   //  Specifies the frequency selected for the I2S communication.
                             //   This parameter can be a value of @ref I2S_Audio_Frequency

    I2S_CPOL : word;         //  Specifies the idle state of the I2S clock.
                             //   This parameter can be a value of @ref I2S_Clock_Polarity
  end;

const
  SPI_Direction_2Lines_FullDuplex = $0000;
  SPI_Direction_2Lines_RxOnly     = $0400;
  SPI_Direction_1Line_Rx          = $8000;
  SPI_Direction_1Line_Tx          = $C000;

  SPI_Mode_Master                 = $0104;
  SPI_Mode_Slave                  = $0000;

  SPI_DataSize_16b                = $0800;
  SPI_DataSize_8b                 = $0000;

  SPI_CPOL_Low                    = $0000;
  SPI_CPOL_High                   = $0002;

  SPI_CPHA_1Edge                  = $0000;
  SPI_CPHA_2Edge                  = $0001;

  SPI_NSS_Soft                    = $0200;
  SPI_NSS_Hard                    = $0000;

  SPI_BaudRatePrescaler_2         = $0000;
  SPI_BaudRatePrescaler_4         = $0008;
  SPI_BaudRatePrescaler_8         = $0010;
  SPI_BaudRatePrescaler_16        = $0018;
  SPI_BaudRatePrescaler_32        = $0020;
  SPI_BaudRatePrescaler_64        = $0028;
  SPI_BaudRatePrescaler_128       = $0030;
  SPI_BaudRatePrescaler_256       = $0038;

  SPI_FirstBit_MSB                = $0000;
  SPI_FirstBit_LSB                = $0080;

  I2S_Mode_SlaveTx                = $0000;
  I2S_Mode_SlaveRx                = $0100;
  I2S_Mode_MasterTx               = $0200;
  I2S_Mode_MasterRx               = $0300;

  I2S_Standard_Phillips           = $0000;
  I2S_Standard_MSB                = $0010;
  I2S_Standard_LSB                = $0020;
  I2S_Standard_PCMShort           = $0030;
  I2S_Standard_PCMLong            = $00B0;

  I2S_DataFormat_16b              = $0000;
  I2S_DataFormat_16bextended      = $0001;
  I2S_DataFormat_24b              = $0003;
  I2S_DataFormat_32b              = $0005;

  I2S_MCLKOutput_Enable           = $0200;
  I2S_MCLKOutput_Disable          = $0000;

  I2S_AudioFreq_96k               = 96000;
  I2S_AudioFreq_48k               = 48000;
  I2S_AudioFreq_44k               = 44100;
  I2S_AudioFreq_32k               = 32000;
  I2S_AudioFreq_22k               = 22050;
  I2S_AudioFreq_16k               = 16000;
  I2S_AudioFreq_11k               = 11025;
  I2S_AudioFreq_8k                = 8000;
  I2S_AudioFreq_Default           = 2;

  I2S_CPOL_Low                    = $0000;
  I2S_CPOL_High                   = $0008;

  SPI_I2S_DMAReq_Tx               = $0002;
  SPI_I2S_DMAReq_Rx               = $0001;

  SPI_NSSInternalSoft_Set         = $0100;
  SPI_NSSInternalSoft_Reset       = $FEFF;

  SPI_CRC_Tx                      = $00;
  SPI_CRC_Rx                      = $01;

  SPI_Direction_Rx                = $BFFF;
  SPI_Direction_Tx                = $4000;

  SPI_I2S_IT_TXE                  = $71;
  SPI_I2S_IT_RXNE                 = $60;
  SPI_I2S_IT_ERR                  = $50;

  SPI_I2S_IT_OVR                  = $56;
  SPI_IT_MODF                     = $55;
  SPI_IT_CRCERR                   = $54;
  I2S_IT_UDR                      = $53;

  SPI_I2S_FLAG_RXNE               = $0001;
  SPI_I2S_FLAG_TXE                = $0002;
  I2S_FLAG_CHSIDE                 = $0004;
  I2S_FLAG_UDR                    = $0008;
  SPI_FLAG_CRCERR                 = $0010;
  SPI_FLAG_MODF                   = $0020;
  SPI_I2S_FLAG_OVR                = $0040;
  SPI_I2S_FLAG_BSY                = $0080;

procedure SPI_I2S_DeInit(var SPIx : TSPIRegisters);
procedure SPI_Init(var SPIx : TSPIRegisters; var SPI_InitStruct : TSPI_InitTypeDef);
procedure I2S_Init(var SPIx : TSPIRegisters; var I2S_InitStruct : TI2S_InitTypeDef);
procedure SPI_StructInit(var SPI_InitStruct : TSPI_InitTypeDef);
procedure I2S_StructInit(var I2S_InitStruct : TI2S_InitTypeDef);
procedure SPI_Cmd(var SPIx : TSPIRegisters; NewState : TState);
procedure I2S_Cmd(var SPIx : TSPIRegisters; NewState : TState);
procedure SPI_I2S_ITConfig(var SPIx : TSPIRegisters; SPI_I2S_IT : byte; NewState : TState);
procedure SPI_I2S_SendData(var SPIx : TSPIRegisters; Data : word);
function SPI_I2S_ReceiveData(var SPIx : TSPIRegisters) : word;
procedure SPI_NSSInternalSoftwareConfig(var SPIx : TSPIRegisters; SPI_NSSInternalSoft : word);
procedure SPI_SSOutputCmd(var SPIx : TSPIRegisters; NewState : TState);
procedure SPI_DataSizeConfig(var SPIx : TSPIRegisters; SPI_DataSize : word);
procedure SPI_TransmitCRC(SPIx : TSPIRegisters);
procedure SPI_CalculateCRC(var SPIx : TSPIRegisters; NewState : TState);
function SPI_GetCRC(var SPIx : TSPIRegisters; SPI_CRC : byte) : word;
function SPI_GetCRCPolynomial(var SPIx : TSPIRegisters) : word;
procedure SPI_BiDirectionalLineConfig(var SPIx : TSPIRegisters; SPI_Direction : word);
function SPI_I2S_Getword(var SPIx : TSPIRegisters; SPI_I2S_FLAG : word) : word;
procedure SPI_I2S_ClearFlag(var SPIx : TSPIRegisters; SPI_I2S_FLAG : word);
function SPI_I2S_GetITStatus(var SPIx : TSPIRegisters; SPI_I2S_IT : byte) : word;
procedure SPI_I2S_ClearITPendingBit(var SPIx : TSPIRegisters; SPI_I2S_IT : byte);

implementation

const
// SPI SPE mask
  CR1_SPE_Set        = $0040;
  CR1_SPE_Reset      = $FFBF;

// I2S I2SE mask
  I2SCFGR_I2SE_Set   = $0400;
  I2SCFGR_I2SE_Reset = $FBFF;

// SPI CRCNext mask
  CR1_CRCNext_Set    = $1000;

// SPI CRCEN mask
  CR1_CRCEN_Set      = $2000;
  CR1_CRCEN_Reset    = $DFFF;

// SPI SSOE mask
  CR2_SSOE_Set       = $0004;
  CR2_SSOE_Reset     = $FFFB;

// SPI registers Masks
  CR1_CLEAR_Mask     = $3040;
  I2SCFGR_CLEAR_Mask = $F040;

// SPI or I2S mode selection masks
  SPI_Mode_Select    = $F7FF;
  I2S_Mode_Select    = $0800;

//======================================================================
// Deinitializes the SPIx peripheral registers to their default
//======================================================================
procedure SPI_I2S_DeInit(var SPIx : TSPIRegisters);
begin
  case dword(@SPIx) of
    dword(@SPI1):
      begin
        // Enable SPI1 reset state
        RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, ENABLED);
        // Release SPI1 from reset state
        RCC_APB2PeriphResetCmd(RCC_APB2Periph_SPI1, DISABLED);
      end;
    dword(@SPI2):
      begin
        // Enable SPI2 reset state
        RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, ENABLED);
        // Release SPI2 from reset state
        RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI2, DISABLED);
      end;
    dword(@SPI3):
      begin
        // Enable SPI3 reset state
        //RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI3, ENABLED);
        // Release SPI3 from reset state
        //RCC_APB1PeriphResetCmd(RCC_APB1Periph_SPI3, DISABLED);
      end;
  end;
end;

//======================================================================
// Initializes the SPIx peripheral according to the specified
//======================================================================
procedure SPI_Init(var SPIx : TSPIRegisters; var SPI_InitStruct : TSPI_InitTypeDef);
begin
  // Write to SPIx CRCPOLY
  SPIx.CRCPR := SPI_InitStruct.SPI_CRCPolynomial;

  // Activate the SPI mode (Reset I2SMOD bit in I2SCFGR register)
  SPIx.I2SCFGR := SPIx.I2SCFGR AND SPI_Mode_Select;

  // Get the SPIx CR1 value
  //tmpreg := SPIx.CR1;
  // Clear BIDIMode, BIDIOE, RxONLY, SSM, SSI, LSBFirst, BR, MSTR, CPOL and CPHA bits
  //tmpreg := tmpreg AND CR1_CLEAR_Mask;
  // Configure SPIx: direction, NSS management, first transmitted bit, BaudRate prescaler
  //   master/salve mode, CPOL and CPHA
  // Set BIDImode, BIDIOE and RxONLY bits according to SPI_Direction value
  // Set SSM, SSI and MSTR bits according to SPI_Mode and SPI_NSS values
  // Set LSBFirst bit according to SPI_FirstBit value
  // Set BR bits according to SPI_BaudRatePrescaler value
  // Set CPOL bit according to SPI_CPOL value
  // Set CPHA bit according to SPI_CPHA value
  SPIx.CR1 := dword(SPI_InitStruct.SPI_Direction OR SPI_InitStruct.SPI_Mode OR
            SPI_InitStruct.SPI_DataSize OR SPI_InitStruct.SPI_CPOL OR
            SPI_InitStruct.SPI_CPHA OR SPI_InitStruct.SPI_NSS OR
            SPI_InitStruct.SPI_BaudRatePrescaler OR SPI_InitStruct.SPI_FirstBit);

  //==================== SPIx CRCPOLY Configuration ====================
  // Write to SPIx CRCPOLY
  // SPIx.CRCPR := SPI_InitStruct.SPI_CRCPolynomial;
  // SPIx.CR1 := $017F;
  // SPIx.CR2 := $0004;
end;

//======================================================================
// Initializes the SPIx peripheral according to the specified
//======================================================================
procedure I2S_Init(var SPIx : TSPIRegisters; var I2S_InitStruct : TI2S_InitTypeDef);
var
  tmpreg, i2sdiv, i2sodd, packetlength : word;
  tmp : dword;
  RCC_Clocks : TRCC_ClocksTypeDef;
begin
  tmpreg       := 0;
  i2sdiv       := 2;
  i2sodd       := 0;
  packetlength := 1;
  tmp          := 0;

  //=============== SPIx I2SCFGR & I2SPR Configuration =================
  // Clear I2SMOD, I2SE, I2SCFG, PCMSYNC, I2SSTD, CKPOL, DATLEN and CHLEN bits
  SPIx.I2SCFGR := SPIx.I2SCFGR AND I2SCFGR_CLEAR_Mask;
  SPIx.I2SPR   := $0002;

  // Get the I2SCFGR register value
  tmpreg := SPIx.I2SCFGR;

  // If the default value has to be written, reinitialize i2sdiv and i2sodd
  if I2S_InitStruct.I2S_AudioFreq = I2S_AudioFreq_Default then
  begin
    i2sodd := 0;
    i2sdiv := 2;
  end
  // If the requested audio frequency is not the default, compute the prescaler
  else
  begin
    // Check the frame length (For the Prescaler computing)
    if I2S_InitStruct.I2S_DataFormat = I2S_DataFormat_16b then
    begin
      // Packet length is 16 bits
      packetlength := 1;
    end
    else
    begin
      // Packet length is 32 bits
      packetlength := 2;
    end;
    // Get System Clock frequency
    RCC_GetClocksFreq(&RCC_Clocks);

    // Compute the Real divider depending on the MCLK output state with a flaoting point
    if I2S_InitStruct.I2S_MCLKOutput = I2S_MCLKOutput_Enable then
    begin
      // MCLK output is enabled
      tmp := (((10 * RCC_Clocks.SYSCLK_Frequency) DIV (256 * I2S_InitStruct.I2S_AudioFreq)) + 5);
    end
    else
    begin
      // MCLK output is disabled
      tmp := (((10 * RCC_Clocks.SYSCLK_Frequency) DIV (32 * packetlength * I2S_InitStruct.I2S_AudioFreq)) + 5);
    end;

    // Remove the flaoting point
    tmp := tmp DIV 10;

    // Check the parity of the divider
    i2sodd := (tmp AND $0001);

    // Compute the i2sdiv prescaler
    i2sdiv := ((tmp - i2sodd) DIV 2);

    // Get the Mask for the Odd bit (SPI_I2SPR[8]) register
    i2sodd := (i2sodd SHL 8);
  end;

  // Test if the divider is 1 or 0
  if ((i2sdiv < 2) OR (i2sdiv > $FF)) then
  begin
    // Set the default values
    i2sdiv := 2;
    i2sodd := 0;
  end;

  // Write to SPIx I2SPR register the computed value
  SPIx.I2SPR := (i2sdiv OR i2sodd OR I2S_InitStruct.I2S_MCLKOutput);

  // Configure the I2S with the SPI_InitStruct values
  tmpreg := tmpreg OR (I2S_Mode_Select OR I2S_InitStruct.I2S_Mode OR
                  I2S_InitStruct.I2S_Standard OR I2S_InitStruct.I2S_DataFormat OR
                  I2S_InitStruct.I2S_CPOL);

  // Write to SPIx I2SCFGR
  SPIx.I2SCFGR := tmpreg;
end;

//======================================================================
// Fills each SPI_InitStruct member with its default value.
//======================================================================
procedure SPI_StructInit(var SPI_InitStruct : TSPI_InitTypeDef);
begin
  //========== Reset SPI init structure parameters values ==============
  // Initialize the SPI_Direction member
  SPI_InitStruct.SPI_Direction := SPI_Direction_2Lines_FullDuplex;
  // initialize the SPI_Mode member
  SPI_InitStruct.SPI_Mode := SPI_Mode_Slave;
  // initialize the SPI_DataSize member
  SPI_InitStruct.SPI_DataSize := SPI_DataSize_8b;
  // Initialize the SPI_CPOL member
  SPI_InitStruct.SPI_CPOL := SPI_CPOL_Low;
  // Initialize the SPI_CPHA member
  SPI_InitStruct.SPI_CPHA := SPI_CPHA_1Edge;
  // Initialize the SPI_NSS member
  SPI_InitStruct.SPI_NSS := SPI_NSS_Hard;
  // Initialize the SPI_BaudRatePrescaler member
  SPI_InitStruct.SPI_BaudRatePrescaler := SPI_BaudRatePrescaler_2;
  // Initialize the SPI_FirstBit member
  SPI_InitStruct.SPI_FirstBit := SPI_FirstBit_MSB;
  // Initialize the SPI_CRCPolynomial member
  SPI_InitStruct.SPI_CRCPolynomial := 7;
end;

//======================================================================
// Fills each I2S_InitStruct member with its default value.
//======================================================================
procedure I2S_StructInit(var I2S_InitStruct : TI2S_InitTypeDef);
begin
  //=========== Reset I2S init structure parameters values =============
  // Initialize the I2S_Mode member
  I2S_InitStruct.I2S_Mode := I2S_Mode_SlaveTx;
  // Initialize the I2S_Standard member
  I2S_InitStruct.I2S_Standard := I2S_Standard_Phillips;
  // Initialize the I2S_DataFormat member
  I2S_InitStruct.I2S_DataFormat := I2S_DataFormat_16b;
  // Initialize the I2S_MCLKOutput member
  I2S_InitStruct.I2S_MCLKOutput := I2S_MCLKOutput_Disable;
  // Initialize the I2S_AudioFreq member
  I2S_InitStruct.I2S_AudioFreq := I2S_AudioFreq_Default;
  // Initialize the I2S_CPOL member
  I2S_InitStruct.I2S_CPOL := I2S_CPOL_Low;
end;

//======================================================================
// Enables or disables the specified SPI peripheral.
//======================================================================
procedure SPI_Cmd(var SPIx : TSPIRegisters; NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    // Enable the selected SPI peripheral
    SPIx.CR1 := SPIx.CR1 OR CR1_SPE_Set;
  end
  else
  begin
    // Disable the selected SPI peripheral
    SPIx.CR1 := SPIx.CR1 AND CR1_SPE_Reset;
  end;
end;

//======================================================================
// Enables or disables the specified SPI peripheral (in I2S mode).
//======================================================================
procedure I2S_Cmd(var SPIx : TSPIRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
  begin
    // Enable the selected SPI peripheral (in I2S mode)
    SPIx.I2SCFGR := SPIx.I2SCFGR OR I2SCFGR_I2SE_Set OR 4;
  end
  else
  begin
    // Disable the selected SPI peripheral (in I2S mode)
    SPIx.I2SCFGR := SPIx.I2SCFGR AND I2SCFGR_I2SE_Reset;
  end;
end;

//======================================================================
// Enables or disables the specified SPI/I2S interrupts.
//======================================================================
procedure SPI_I2S_ITConfig(var SPIx : TSPIRegisters; SPI_I2S_IT : byte; NewState : TState);
var
  itpos, itmask : word;
begin
  itpos  := 0;
  itmask := 0;

  // Get the SPI/I2S IT index
  itpos := SPI_I2S_IT SHR 4;

  // Set the IT mask
  itmask := (1 SHL itpos);

  if (NewState <> DISABLED) then
  begin
    // Enable the selected SPI/I2S interrupt
    SPIx.CR2 := SPIx.CR2 OR itmask;
  end
  else
  begin
    // Disable the selected SPI/I2S interrupt
    SPIx.CR2 := SPIx.CR2 AND NOT itmask;
  end;
end;

{//======================================================================
// Enables or disables the SPIx/I2Sx DMA interface.
//======================================================================
procedure SPI_I2S_DMACmd(SPI_TypeDef* SPIx,   SPI_I2S_DMAReq, FunctionalState NewState)
begin
  // Check the parameters
  assert_param(IS_SPI_ALL_PERIPH(SPIx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  assert_param(IS_SPI_I2S_DMAREQ(SPI_I2S_DMAReq));
  if (NewState != DISABLE)
  begin
    // Enable the selected SPI/I2S DMA requests
    SPIx.CR2 OR= SPI_I2S_DMAReq;
  end
  else
  begin
    // Disable the selected SPI/I2S DMA requests
    SPIx.CR2 &= (uint16_t)~SPI_I2S_DMAReq;
  end
end

//*
  * @brief  Transmits a Data through the SPIx/I2Sx peripheral.
  * @param SPIx: where x can be :
  *   1, 2 or 3 in SPI mode
  *   2 or 3 in I2S mode
  * @param Data : Data to be transmitted..
  * @retval : None

}
//======================================================================
procedure SPI_I2S_SendData(var SPIx : TSPIRegisters; Data : word);
begin
  // Write in the DR register the data to be sent
  SPIx.DR := word(Data);
end;

//======================================================================
// Returns the most recent received data by the SPIx/I2Sx peripheral.
//======================================================================
function SPI_I2S_ReceiveData(var SPIx : TSPIRegisters) : word;
begin
  // Return the data in the DR register
  exit(SPIx.DR);
end;

//======================================================================
// Configures internally by software the NSS pin for the selected
//======================================================================
procedure SPI_NSSInternalSoftwareConfig(var SPIx : TSPIRegisters; SPI_NSSInternalSoft : word);
begin
  if (SPI_NSSInternalSoft <> SPI_NSSInternalSoft_Reset) then
  begin
    // Set NSS pin internally by software
    SPIx.CR1 := SPIx.CR1 OR SPI_NSSInternalSoft_Set;
  end
  else
  begin
    // Reset NSS pin internally by software
    SPIx.CR1 := SPIx.CR1 AND SPI_NSSInternalSoft_Reset;
  end;
end;

//======================================================================
// Enables or disables the SS output for the selected SPI.
//======================================================================
procedure SPI_SSOutputCmd(var SPIx : TSPIRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
  begin
    // Enable the selected SPI SS output
    SPIx.CR2 := SPIx.CR2 OR CR2_SSOE_Set;
  end
  else
  begin
    // Disable the selected SPI SS output
    SPIx.CR2 := SPIx.CR2 AND CR2_SSOE_Reset;
  end;
end;

//======================================================================
// Configures the data size for the selected SPI.
//======================================================================
procedure SPI_DataSizeConfig(var SPIx : TSPIRegisters; SPI_DataSize : word);
begin
  // Clear DFF bit
  SPIx.CR1 := SPIx.CR1 AND NOT SPI_DataSize_16b;
  // Set new DFF bit value
  SPIx.CR1 := SPIx.CR1 OR SPI_DataSize;
end;

//======================================================================
// Transmit the SPIx CRC value.
//======================================================================
procedure SPI_TransmitCRC(SPIx : TSPIRegisters);
begin
  // Enable the selected SPI CRC transmission
  SPIx.CR1 := SPIx.CR1 OR CR1_CRCNext_Set;
end;

//======================================================================
// Enables or disables the CRC value calculation of the
//======================================================================
procedure SPI_CalculateCRC(var SPIx : TSPIRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
  begin
    // Enable the selected SPI CRC calculation
    SPIx.CR1 := SPIx.CR1 OR CR1_CRCEN_Set;
  end
  else
  begin
    // Disable the selected SPI CRC calculation
    SPIx.CR1 := SPIx.CR1 AND CR1_CRCEN_Reset;
  end;
end;

//======================================================================
// Returns the transmit or the receive CRC register value for
// the specified SPI.
//======================================================================
function SPI_GetCRC(var SPIx : TSPIRegisters; SPI_CRC : byte) : word;
var
  crcreg : word;
begin
  crcreg := 0;

  if (SPI_CRC <> SPI_CRC_Rx) then
  begin
    // Get the Tx CRC register
    crcreg := SPIx.TXCRCR;
  end
  else
  begin
    // Get the Rx CRC register
    crcreg := SPIx.RXCRCR;
  end;
  // Return the selected CRC register
  SPI_GetCRC := crcreg;
end;

//======================================================================
// Returns the CRC Polynomial register value for the specified SPI.
//======================================================================
function SPI_GetCRCPolynomial(var SPIx : TSPIRegisters) : word;
begin
  // Return the CRC polynomial register
  exit(SPIx.CRCPR);
end;

//======================================================================
// Selects the data transfer direction in bi-directional mode
// for the specified SPI.
//======================================================================
procedure SPI_BiDirectionalLineConfig(var SPIx : TSPIRegisters; SPI_Direction : word);
begin
  if (SPI_Direction = SPI_Direction_Tx) then
  begin
    // Set the Tx only mode
    SPIx.CR1 := SPIx.CR1 OR SPI_Direction_Tx;
  end
  else
  begin
    // Set the Rx only mode
    SPIx.CR1 := SPIx.CR1 AND SPI_Direction_Rx;
  end;
end;

//======================================================================
// Checks whether the specified SPI/I2S flag is set or not.
//======================================================================
function SPI_I2S_Getword(var SPIx : TSPIRegisters; SPI_I2S_FLAG : word) : word;
begin
  // Check the status of the specified SPI/I2S flag
  if ((SPIx.SR AND SPI_I2S_FLAG) > 0) then
    // SPI_I2S_FLAG is set
		SPI_I2S_Getword := 1
  else
    // SPI_I2S_FLAG is reset
		SPI_I2S_Getword := 0;
end;

//======================================================================
// Clears the SPIx CRC Error (CRCERR) flag.
//======================================================================
procedure SPI_I2S_ClearFlag(var SPIx : TSPIRegisters; SPI_I2S_FLAG : word);
begin
  // Clear the selected SPI CRC Error (CRCERR) flag
  SPIx.SR := NOT SPI_I2S_FLAG;
end;

//======================================================================
// Checks whether the specified SPI/I2S interrupt has occurred or not.
//======================================================================
function SPI_I2S_GetITStatus(var SPIx : TSPIRegisters; SPI_I2S_IT : byte) : word;
var
  bitstatus : word;
  itpos, itmask, enablestatus : word;
begin
  bitstatus    := 0;
  itpos        := 0;
  itmask       := 0;
  enablestatus := 0;

  // Get the SPI/I2S IT index
  itpos := ($01 SHL (SPI_I2S_IT AND $0F));
  // Get the SPI/I2S IT mask
  itmask := SPI_I2S_IT SHR 4;
  // Set the IT mask
  itmask := ($01 SHL itmask);
  // Get the SPI_I2S_IT enable bit status
  enablestatus := (SPIx.CR2 AND itmask) ;
  // Check the status of the specified SPI/I2S interrupt
  if (((SPIx.SR AND itpos) <> 0) AND (enablestatus > 0)) then
  begin
    // SPI_I2S_IT is set
    bitstatus := 1;
  end
  else
  begin
    // SPI_I2S_IT is reset
    bitstatus := 0;
  end;
  // Return the SPI_I2S_IT status
  exit(bitstatus);
end;

//======================================================================
// Clears the SPIx CRC Error (CRCERR) interrupt pending bit.
//======================================================================
procedure SPI_I2S_ClearITPendingBit(var SPIx : TSPIRegisters; SPI_I2S_IT : byte);
var
  itpos : word;
begin
  itpos := 0;

  // Get the SPI IT index
  itpos := ($01 SHL (SPI_I2S_IT AND $0F));
  // Clear the selected SPI CRC Error (CRCERR) interrupt pending bit
  SPIx.SR := NOT itpos;
end;

end.
