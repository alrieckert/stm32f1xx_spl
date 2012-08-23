//======================================================================
unit stm32f1xx_gpio;

//======================================================================
interface
uses
  stm32f1xx_rcc;
  
type
 TGPIOSpeed_TypeDef = (GPIO_Speed_10MHz = 1, GPIO_Speed_2MHz, GPIO_Speed_50MHz);

 TGPIOMode_TypeDef = byte;

 TGPIO_InitTypeDef = record
  GPIO_Pin   : word;
  GPIO_Speed : TGPIOSpeed_TypeDef;
  GPIO_Mode  : TGPIOMode_TypeDef;
 end;

 TBitAction = (Bit_RESET, Bit_SET);

const
 GPIO_Mode_AIN         = $00;
 GPIO_Mode_IN_FLOATING = $04;
 GPIO_Mode_Out_PP      = $10;
 GPIO_Mode_Out_OD      = $14;
 GPIO_Mode_AF_PP       = $18;
 GPIO_Mode_AF_OD       = $1C;
 GPIO_Mode_IPD         = $28;
 GPIO_Mode_IPU         = $48;

const
 GPIO_Pin_0                 = $0001;  { Pin 0 selected }
 GPIO_Pin_1                 = $0002;  { Pin 1 selected }
 GPIO_Pin_2                 = $0004;  { Pin 2 selected }
 GPIO_Pin_3                 = $0008;  { Pin 3 selected }
 GPIO_Pin_4                 = $0010;  { Pin 4 selected }
 GPIO_Pin_5                 = $0020;  { Pin 5 selected }
 GPIO_Pin_6                 = $0040;  { Pin 6 selected }
 GPIO_Pin_7                 = $0080;  { Pin 7 selected }
 GPIO_Pin_8                 = $0100;  { Pin 8 selected }
 GPIO_Pin_9                 = $0200;  { Pin 9 selected }
 GPIO_Pin_10                = $0400;  { Pin 10 selected }
 GPIO_Pin_11                = $0800;  { Pin 11 selected }
 GPIO_Pin_12                = $1000;  { Pin 12 selected }
 GPIO_Pin_13                = $2000;  { Pin 13 selected }
 GPIO_Pin_14                = $4000;  { Pin 14 selected }
 GPIO_Pin_15                = $8000;  { Pin 15 selected }
 GPIO_Pin_All               = $FFFF;  { All pins selected }

 GPIO_Remap_SPI1            = $00000001;  { SPI1 Alternate Function mapping }
 GPIO_Remap_I2C1            = $00000002;  { I2C1 Alternate Function mapping }
 GPIO_Remap_USART1          = $00000004;  { USART1 Alternate Function mapping }
 GPIO_Remap_USART2          = $00000008;  { USART2 Alternate Function mapping }
 GPIO_PartialRemap_USART3   = $00140010;  { USART3 Partial Alternate Function mapping }
 GPIO_FullRemap_USART3      = $00140030;  { USART3 Full Alternate Function mapping }
 GPIO_PartialRemap_TIM1     = $00160040;  { TIM1 Partial Alternate Function mapping }
 GPIO_FullRemap_TIM1        = $001600C0;  { TIM1 Full Alternate Function mapping }
 GPIO_PartialRemap1_TIM2    = $00180100;  { TIM2 Partial1 Alternate Function mapping }
 GPIO_PartialRemap2_TIM2    = $00180200;  { TIM2 Partial2 Alternate Function mapping }
 GPIO_FullRemap_TIM2        = $00180300;  { TIM2 Full Alternate Function mapping }
 GPIO_PartialRemap_TIM3     = $001A0800;  { TIM3 Partial Alternate Function mapping }
 GPIO_FullRemap_TIM3        = $001A0C00;  { TIM3 Full Alternate Function mapping }
 GPIO_Remap_TIM4            = $00001000;  { TIM4 Alternate Function mapping }
 GPIO_Remap1_CAN            = $001D4000;  { CAN Alternate Function mapping }
 GPIO_Remap2_CAN            = $001D6000;  { CAN Alternate Function mapping }
 GPIO_Remap_PD01            = $00008000;  { PD01 Alternate Function mapping }
 GPIO_Remap_SWJ_NoJTRST     = $00300100;  { Full SWJ Enabled (JTAG-DP + SW-DP; but without JTRST }
 GPIO_Remap_SWJ_JTAGDisable = $00300200;  { JTAG-DP Disabled and SW-DP Enabled }
 GPIO_Remap_SWJ_Disable     = $00300400;  { Full SWJ Disabled (JTAG-DP + SW-DP; }

 GPIO_PinSource0            = $00;
 GPIO_PinSource1            = $01;
 GPIO_PinSource2            = $02;
 GPIO_PinSource3            = $03;
 GPIO_PinSource4            = $04;
 GPIO_PinSource5            = $05;
 GPIO_PinSource6            = $06;
 GPIO_PinSource7            = $07;
 GPIO_PinSource8            = $08;
 GPIO_PinSource9            = $09;
 GPIO_PinSource10           = $0A;
 GPIO_PinSource11           = $0B;
 GPIO_PinSource12           = $0C;
 GPIO_PinSource13           = $0D;
 GPIO_PinSource14           = $0E;
 GPIO_PinSource15           = $0F;

  GPIO_PortSourceGPIOA       = $00;
  GPIO_PortSourceGPIOB       = $01;
  GPIO_PortSourceGPIOC       = $02;
  GPIO_PortSourceGPIOD       = $03;
  GPIO_PortSourceGPIOE       = $04;
  GPIO_PortSourceGPIOF       = $05;
  GPIO_PortSourceGPIOG       = $06;

procedure GPIO_DeInit(var GPIOx: TPortRegisters);
procedure GPIO_AFIODeInit;
procedure GPIO_Init(var GPIOx: TPortRegisters; const GPIO_InitStruct: TGPIO_InitTypeDef);
procedure GPIO_StructInit(var GPIO_InitStruct: TGPIO_InitTypeDef);
function GPIO_ReadInputDataBit(var GPIOx: TPortRegisters; GPIO_Pin: word): byte;
function GPIO_ReadInputData(var GPIOx: TPortRegisters): word;
function GPIO_ReadOutputDataBit(var GPIOx: TPortRegisters; GPIO_Pin: word): byte;
function GPIO_ReadOutputData(var GPIOx: TPortRegisters): word;
procedure GPIO_SetBits(var GPIOx: TPortRegisters; GPIO_Pin: word);
procedure GPIO_ResetBits(var GPIOx: TPortRegisters; GPIO_Pin: word);
procedure GPIO_WriteBit(var GPIOx: TPortRegisters; GPIO_Pin: Word; BitVal: TBitAction);
procedure GPIO_Write(var GPIOx: TPortRegisters; PortVal: word);
procedure GPIO_PinLockConfig(var GPIOx: TPortRegisters; GPIO_Pin: word);
procedure GPIO_EventOutputConfig(GPIO_PortSource, GPIO_PinSource: byte);
procedure GPIO_EventOutputCmd(NewState: TState);
procedure GPIO_PinRemapConfig(GPIO_Remap: dword; NewState: TState);
procedure GPIO_EXTILineConfig(GPIO_PortSource, GPIO_PinSource: byte);

implementation
const
 GPIO_EVCR_PORTPINCONFIG_MASK     = $FF80;
 GPIO_LSB_MASK                    = $FFFF;
 GPIO_DBGAFR_POSITION_MASK        = $000F0000;
 GPIO_DBGAFR_SWJCFG_MASK          = $F8FFFFFF;
 GPIO_DBGAFR_LOCATION_MASK        = $00200000;
 GPIO_DBGAFR_NUMBITS_MASK         = $00100000;

//======================================================================
procedure GPIO_DeInit(var GPIOx: TPortRegisters);
begin
  if @GPIOx = @PortA then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, DISABLED);
  end
  else if @GPIOx = @PortB then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, DISABLED);
  end
  else if @GPIOx = @PortC then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, DISABLED);
  end
  else if @GPIOx = @PortD then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, DISABLED);
  end
  else if @GPIOx = @PortE then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, DISABLED);
  end;
end;

//======================================================================
procedure GPIO_AFIODeInit;
begin
  RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, ENABLED);
  RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, DISABLED);
end;

//======================================================================
procedure GPIO_Init(var GPIOx: TPortRegisters; const GPIO_InitStruct: TGPIO_InitTypeDef);
var currentmode, currentpin, pinpos, pos, tmpreg, pinmask: dword;
begin
  {---------------------------- GPIO Mode Configuration -----------------------}
  currentmode := dword(GPIO_InitStruct.GPIO_Mode) and $0F;

  if (dword(GPIO_InitStruct.GPIO_Mode) and $10) <> $00 then
  begin
    { Output mode }
    currentmode := currentmode or dword(GPIO_InitStruct.GPIO_Speed);
  end;

  {---------------------------- GPIO CRL Configuration ------------------------}
  { Configure the eight low port pins }
  if (GPIO_InitStruct.GPIO_Pin and $00FF) <> $00 then
  begin
    tmpreg := GPIOx.CRL;

    for pinpos := 0 to 7 do
    begin
      pos := 1 shl pinpos;
      { Get the port pins position }
      currentpin := GPIO_InitStruct.GPIO_Pin and pos;

      if currentpin = pos then
      begin
        pos := pinpos shl 2;
        { Clear the corresponding low control register bits }
        pinmask := $0F shl pos;
        tmpreg := tmpreg and not(pinmask);

        { Write the mode configuration in the corresponding bits }
        tmpreg := tmpreg or (currentmode shl pos);

        { Reset the corresponding ODR bit }
        if GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPD then
          GPIOx.BRR := 1 shl pinpos;

        { Set the corresponding ODR bit }
        if GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPU then
          GPIOx.BSRR := 1 shl pinpos;
      end;
    end;
    GPIOx.CRL := tmpreg;
    tmpreg := 0;
  end;

  {---------------------------- GPIO CRH Configuration ------------------------}
  { Configure the eight high port pins }
  if GPIO_InitStruct.GPIO_Pin > $00FF then
  begin
    tmpreg := GPIOx.CRH;
    for pinpos := 0 to 7 do
    begin
      pos := 1 shl (pinpos + 8);
      { Get the port pins position }
      currentpin := GPIO_InitStruct.GPIO_Pin and pos;

      if currentpin = pos then
      begin
        pos := pinpos shl 2;
        { Clear the corresponding high control register bits }
        pinmask := $0F shl pos;
        tmpreg := tmpreg and not(pinmask);

        { Write the mode configuration in the corresponding bits }
        tmpreg := tmpreg or (currentmode shl pos);

        { Reset the corresponding ODR bit }
        if GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPD then
          GPIOx.BRR := 1 shl (pinpos + 8);

        { Set the corresponding ODR bit }
        if GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPU then
          GPIOx.BSRR := 1 shl (pinpos + 8);
      end;
    end;
    GPIOx.CRH := tmpreg;
  end;
end;

//======================================================================
procedure GPIO_StructInit(var GPIO_InitStruct: TGPIO_InitTypeDef);
begin
  GPIO_InitStruct.GPIO_Pin   := GPIO_Pin_All;
  GPIO_InitStruct.GPIO_Speed := GPIO_Speed_2MHz;
  GPIO_InitStruct.GPIO_Mode  := GPIO_Mode_IN_FLOATING;
end;

//======================================================================
function GPIO_ReadInputDataBit(var GPIOx: TPortRegisters; GPIO_Pin: word): byte;
begin
  if (GPIOx.IDR and GPIO_Pin) <> 0 then
    exit(1)
  else
    exit(0);
end;

//======================================================================
function GPIO_ReadInputData(var GPIOx: TPortRegisters): word;
begin
  exit(GPIOx.IDR);
end;

//======================================================================
function GPIO_ReadOutputDataBit(var GPIOx: TPortRegisters; GPIO_Pin: word): byte;
begin
  if (GPIOx.ODR and GPIO_Pin) <> 0 then
    exit(1)
  else
    exit(0);
end;

//======================================================================
function GPIO_ReadOutputData(var GPIOx: TPortRegisters): word;
begin
  exit(GPIOx.ODR);
end;

//======================================================================
procedure GPIO_SetBits(var GPIOx: TPortRegisters; GPIO_Pin: word);
begin
  GPIOx.BSRR := GPIO_Pin;
end;

//======================================================================
procedure GPIO_ResetBits(var GPIOx: TPortRegisters; GPIO_Pin: word);
begin
  GPIOx.BRR := GPIO_Pin;
end;

//======================================================================
procedure GPIO_WriteBit(var GPIOx: TPortRegisters; GPIO_Pin: Word; BitVal: TBitAction);
begin
  if BitVal <> Bit_RESET then
    GPIOx.BSRR := GPIO_Pin
  else
    GPIOx.BRR := GPIO_Pin;
end;

//======================================================================
procedure GPIO_Write(var GPIOx: TPortRegisters; PortVal: word);
begin
  GPIOx.ODR := PortVal;
end;

//======================================================================
procedure GPIO_PinLockConfig(var GPIOx: TPortRegisters; GPIO_Pin: word);
var tmp: dword;
begin
  tmp := $00010000;

  tmp := tmp or GPIO_Pin;
  { Set LCKK bit }
  GPIOx.LCKR := tmp;
  { Reset LCKK bit }
  GPIOx.LCKR := GPIO_Pin;
  { Set LCKK bit }
  GPIOx.LCKR := tmp;
  { Read LCKK bit}
  tmp := GPIOx.LCKR;
  { Read LCKK bit}
  tmp := GPIOx.LCKR;
end;

//======================================================================
procedure GPIO_EventOutputConfig(GPIO_PortSource, GPIO_PinSource: byte);
var tmpreg: dword;
begin
  tmpreg := AFIO.EVCR;
  { Clear the PORT[6:4] and PIN[3:0] bits }
  tmpreg := tmpreg and GPIO_EVCR_PORTPINCONFIG_MASK;
  tmpreg := tmpreg or (GPIO_PortSource shl 4);
  tmpreg := tmpreg or GPIO_PinSource;

  AFIO.EVCR := tmpreg;
end;

//======================================================================
procedure GPIO_EventOutputCmd(NewState: TState);
begin
  if NewState = Enabled then
    AFIO.EVCR := AFIO.EVCR or $80
  else
    AFIO.EVCR := AFIO.EVCR or not(dword($80));
end;

//======================================================================
procedure GPIO_PinRemapConfig(GPIO_Remap: dword; NewState: TState);
var tmp, tmp1, tmpreg, tmpmask: dword;
begin
  tmpreg := AFIO.MAPR;
  tmp1 := 0;

  tmpmask := (GPIO_Remap and GPIO_DBGAFR_POSITION_MASK) shr $10;
  tmp := GPIO_Remap and GPIO_LSB_MASK;

  if (GPIO_Remap and (GPIO_DBGAFR_LOCATION_MASK OR GPIO_DBGAFR_NUMBITS_MASK)) = (GPIO_DBGAFR_LOCATION_MASK OR GPIO_DBGAFR_NUMBITS_MASK) then
  begin
    tmpreg := tmpreg and GPIO_DBGAFR_SWJCFG_MASK;
    AFIO.MAPR := AFIO.MAPR AND GPIO_DBGAFR_SWJCFG_MASK;
  end
  else if (GPIO_Remap and GPIO_DBGAFR_NUMBITS_MASK) = GPIO_DBGAFR_NUMBITS_MASK then
  begin
    tmp1 := 3 shl tmpmask;
    tmpreg := tmpreg and not(tmp1);
    tmpreg := tmpreg OR NOT GPIO_DBGAFR_SWJCFG_MASK;
  end
  else
  begin
    tmpreg := tmpreg and not(tmp SHL ((GPIO_Remap SHR $15) * $10));
    tmpreg := tmpreg OR NOT GPIO_DBGAFR_SWJCFG_MASK;
  end;  

  if NewState = enabled then
  begin
    tmpreg := tmpreg OR (tmp SHL ((GPIO_Remap SHR $15) * $10));
  end;
  
  AFIO.MAPR := tmpreg;
end;

//======================================================================
procedure GPIO_EXTILineConfig(GPIO_PortSource, GPIO_PinSource: byte);
var tmp: dword;
begin
  tmp := dword($0F) shl ($04 * (GPIO_PinSource AND byte($03)));

  AFIO.EXTICR[GPIO_PinSource shr $02] := AFIO.EXTICR[GPIO_PinSource shr $02] AND NOT(tmp);
  AFIO.EXTICR[GPIO_PinSource shr $02] := AFIO.EXTICR[GPIO_PinSource shr $02] OR (dword(GPIO_PortSource) SHL ($04 * (GPIO_PinSource and byte($03))));
end;
end.
