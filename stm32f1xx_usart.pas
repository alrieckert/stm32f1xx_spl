//======================================================================
unit stm32f1xx_usart;

//======================================================================
interface
uses
  stm32f1xx_rcc;

type
 TUSART_InitTypeDef = record
  USART_BaudRate: dword;
  USART_WordLength,
  USART_StopBits,
  USART_Parity,
  USART_HardwareFlowControl,
  USART_Mode,
  USART_Clock,
  USART_CPOL,
  USART_CPHA,
  USART_LastBit: word;
 end;

const
 USART_WordLength_8b                  = $0000;
 USART_WordLength_9b                  = $1000;

 USART_StopBits_1                     = $0000;
 USART_StopBits_0_5                   = $1000;
 USART_StopBits_2                     = $2000;
 USART_StopBits_1_5                   = $3000;

 USART_Parity_No                      = $0000;
 USART_Parity_Even                    = $0400;
 USART_Parity_Odd                     = $0600;

 USART_HardwareFlowControl_None       = $0000;
 USART_HardwareFlowControl_RTS        = $0100;
 USART_HardwareFlowControl_CTS        = $0200;
 USART_HardwareFlowControl_RTS_CTS    = $0300;

 USART_Mode_Rx                        = $0004;
 USART_Mode_Tx                        = $0008;

 USART_Clock_Disable                  = $0000;
 USART_Clock_Enable                   = $0800;

 USART_CPOL_Low                       = $0000;
 USART_CPOL_High                      = $0400;

 USART_CPHA_1Edge                     = $0000;
 USART_CPHA_2Edge                     = $0200;

 USART_LastBit_Disable                = $0000;
 USART_LastBit_Enable                 = $0100;

 USART_IT_PE                          = $0028;
 USART_IT_TXE                         = $0727;
 USART_IT_TC                          = $0626;
 USART_IT_RXNE                        = $0525;
 USART_IT_IDLE                        = $0424;
 USART_IT_LBD                         = $0846;
 USART_IT_CTS                         = $096A;
 USART_IT_ERR                         = $0060;
 USART_IT_ORE                         = $0360;
 USART_IT_NE                          = $0260;
 USART_IT_FE                          = $0160;

 USART_DMAReq_Tx                      = $0080;
 USART_DMAReq_Rx                      = $0040;

 USART_WakeUp_IdleLine                = $0000;
 USART_WakeUp_AddressMark             = $0800;

 USART_LINBreakDetectLength_10b      = $0000;
 USART_LINBreakDetectLength_11b      = $0020;

 USART_IrDAMode_LowPower              = $0004;
 USART_IrDAMode_Normal                = $0000;

 USART_FLAG_CTS                       = $0200;
 USART_FLAG_LBD                       = $0100;
 USART_FLAG_TXE                       = $0080;
 USART_FLAG_TC                        = $0040;
 USART_FLAG_RXNE                      = $0020;
 USART_FLAG_IDLE                      = $0010;
 USART_FLAG_ORE                       = $0008;
 USART_FLAG_NE                        = $0004;
 USART_FLAG_FE                        = $0002;
 USART_FLAG_PE                        = $0001;

procedure USART_DeInit(var USARTx: TUSARTRegisters);
procedure USART_Init(var USARTx: TUSARTRegisters; var USART_InitStruct: TUSART_InitTypeDef);
procedure USART_StructInit(var USART_InitStruct: TUSART_InitTypeDef);
procedure USART_Cmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_ITConfig(var USARTx: TUSARTRegisters; USART_IT: word; NewState: TState);
procedure USART_DMACmd(var USARTx: TUSARTRegisters; USART_DMAReq: word; NewState: TState);
procedure USART_SetAddress(var USARTx: TUSARTRegisters; USART_Address: byte);
procedure USART_WakeUpConfig(var USARTx: TUSARTRegisters; USART_WakeUp: word);
procedure USART_ReceiverWakeUpCmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_LINBreakDetectLengthConfig(var USARTx: TUSARTRegisters; USART_LINBreakDetectLength: word);
procedure USART_LINCmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_SendData(var USARTx: TUSARTRegisters; Data: Word);
procedure USART_SendString(var USARTx: TUSARTRegisters; const  Data: String);
function USART_ReceiveData(var USARTx: TUSARTRegisters): Word;
procedure USART_SendBreak(var USARTx: TUSARTRegisters);
procedure USART_SetGuardTime(var USARTx: TUSARTRegisters; USART_GuardTime: byte);
procedure USART_SetPrescaler(var USARTx: TUSARTRegisters; USART_Prescaler: byte);
procedure USART_SmartCardCmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_SmartCardNACKCmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_HalfDuplexCmd(var USARTx: TUSARTRegisters; NewState: TState);
procedure USART_IrDAConfig(var USARTx: TUSARTRegisters; USART_IrDAMode: word);
procedure USART_IrDACmd(var USARTx: TUSARTRegisters; NewState: TState);
function USART_GetFlagStatus(var USARTx: TUSARTRegisters; USART_FLAG: word): longword;
procedure USART_ClearFlag(var USARTx: TUSARTRegisters; USART_FLAG: word);
function USART_GetITStatus(var USARTx: TUSARTRegisters; USART_IT: word): longword;
procedure USART_ClearITPendingBit(var USARTx: TUSARTRegisters; USART_IT: word);

implementation

const
{ USART RUN Mask }
 CR1_RUN_Set               = $2000;  { USART Enable Mask }
 CR1_RUN_Reset             = $DFFF;  { USART Disable Mask }

 CR2_Address_Mask          = $FFF0;  { USART address Mask }

{ USART RWU Mask }
 CR1_RWU_Set               = $0002;  { USART mute mode Enable Mask }

 USART_IT_Mask             = $001F;  { USART Interrupt Mask }

{ USART LIN Mask }
 CR2_LINE_Set              = $4000;  { USART LIN Enable Mask }
 CR2_LINE_Reset            = $BFFF;  { USART LIN Disable Mask }

 CR1_SBK_Set               = $0001;  { USART Break Character send Mask }

{ USART SC Mask }
 CR3_SCEN_Set              = $0020;  { USART SC Enable Mask }
 CR3_SCEN_Reset            = $FFDF;  { USART SC Disable Mask }

{ USART SC NACK Mask }
 CR3_NACK_Set              = $0010;  { USART SC NACK Enable Mask }
 CR3_NACK_Reset            = $FFEF;  { USART SC NACK Disable Mask }

{ USART Half-Duplex Mask }
 CR3_HDSEL_Set             = $0008;  { USART Half-Duplex Enable Mask }
 CR3_HDSEL_Reset           = $FFF7;  { USART Half-Duplex Disable Mask }

{ USART IrDA Mask }
 CR3_IRLP_Mask             = $FFFB;  { USART IrDA LowPower mode Mask }

{ USART LIN Break detection }
 CR3_LBDL_Mask             = $FFDF;  { USART LIN Break detection Mask }

{ USART WakeUp Method  }
 CR3_WAKE_Mask             = $F7FF;  { USART WakeUp Method Mask }

{ USART IrDA Mask }
 CR3_IREN_Set              = $0002;  { USART IrDA Enable Mask }
 CR3_IREN_Reset            = $FFFD;  { USART IrDA Disable Mask }

 GTPR_LSB_Mask             = $00FF;  { Guard Time Register LSB Mask }
 GTPR_MSB_Mask             = $FF00;  { Guard Time Register MSB Mask }

 CR1_CLEAR_Mask            = $E9F3;  { USART CR1 Mask }
 CR2_CLEAR_Mask            = $C0FF;  { USART CR2 Mask }
 CR3_CLEAR_Mask            = $FCFF;  { USART CR3 Mask }

//======================================================================
procedure USART_DeInit(var USARTx: TUSARTRegisters);
begin
  if @USARTx = @Usart1 then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, DISABLED);
  end
  else if @USARTx = @Usart2 then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, DISABLED);
  end
  else if @USARTx = @Usart3 then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, DISABLED);
  end;
end;

//======================================================================
procedure USART_Init(var USARTx: TUSARTRegisters; var USART_InitStruct: TUSART_InitTypeDef);
var apbclock: longword;
   RCC_ClocksStatus: TRCC_ClocksTypeDef;
begin
  {---------------------------- USART CR2 Configuration -----------------------}
  USARTx.CR2 := (USARTx.CR2 and CR2_CLEAR_Mask) or USART_InitStruct.USART_StopBits or USART_InitStruct.USART_Clock or USART_InitStruct.USART_CPOL or USART_InitStruct.USART_CPHA or USART_InitStruct.USART_LastBit;

  {---------------------------- USART CR1 Configuration -----------------------}
  USARTx.CR1 := (USARTx.CR1 and CR1_CLEAR_Mask) or USART_InitStruct.USART_WordLength or USART_InitStruct.USART_Parity or USART_InitStruct.USART_Mode;

  {---------------------------- USART CR3 Configuration -----------------------}
  USARTx.CR3 := (USARTx.CR3 and CR3_CLEAR_Mask) or USART_InitStruct.USART_HardwareFlowControl;

  {---------------------------- USART BRR Configuration -----------------------}
  RCC_GetClocksFreq(RCC_ClocksStatus);

  if @USARTx = @Usart1 then
    apbclock := RCC_ClocksStatus.PCLK2_Frequency
  else
    apbclock := RCC_ClocksStatus.PCLK1_Frequency;

  { Write to USART BRR }
  USARTx.BRR := apbclock div USART_InitStruct.USART_BaudRate;
end;

//======================================================================
procedure USART_StructInit(var USART_InitStruct: TUSART_InitTypeDef);
begin
  USART_InitStruct.USART_BaudRate   := $2580; { 9600 Baud }
  USART_InitStruct.USART_WordLength := USART_WordLength_8b;
  USART_InitStruct.USART_StopBits   := USART_StopBits_1;
  USART_InitStruct.USART_Parity     := USART_Parity_No ;
  USART_InitStruct.USART_Mode       := USART_Mode_Rx or USART_Mode_Tx;
  USART_InitStruct.USART_Clock      := USART_Clock_Disable;
  USART_InitStruct.USART_CPOL       := USART_CPOL_Low;
  USART_InitStruct.USART_CPHA       := USART_CPHA_1Edge;
  USART_InitStruct.USART_LastBit    := USART_LastBit_Disable;
  USART_InitStruct.USART_HardwareFlowControl := USART_HardwareFlowControl_None;
end;

//======================================================================
procedure USART_Cmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if NewState = ENABLED then
    USARTx.CR1 := USARTx.CR1 or CR1_RUN_Set
  else
    USARTx.CR1 := USARTx.CR1 and CR1_RUN_Reset;
end;

//======================================================================
procedure USART_ITConfig(var USARTx: TUSARTRegisters; USART_IT: word; NewState: TState);
var usartreg, itpos, itmask: longword;
   address: ^dword;
begin
  usartreg := (byte(USART_IT) shr $05);

  itpos := USART_IT and USART_IT_Mask; 

  itmask := dword(1 shl itpos);

  case usartreg of
    1: address := @USARTx.CR1;
    2: address := @USARTx.CR2;
  else
    address := @USARTx.CR3;
  end;

  if newstate = enabled then
    dword(address^) := dword(address^) or itmask
  else
    dword(address^) := dword(address^) and not(itmask);
    
end;

//======================================================================
procedure USART_DMACmd(var USARTx: TUSARTRegisters; USART_DMAReq: word; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR3 := USARTx.CR3 or USART_DMAReq
  else
    USARTx.CR3 := USARTx.CR3 and not(USART_DMAReq);
end;

//======================================================================
procedure USART_SetAddress(var USARTx: TUSARTRegisters; USART_Address: byte);
begin
  USARTx.CR2 := USARTx.CR2 and CR2_Address_Mask;
  USARTx.CR2 := USARTx.CR2 or USART_Address;
end;

//======================================================================
procedure USART_WakeUpConfig(var USARTx: TUSARTRegisters; USART_WakeUp: word);
begin
  USARTx.CR1 := USARTx.CR1 and CR3_WAKE_Mask;
  USARTx.CR1 := USARTx.CR1 or USART_WakeUp;
end;

//======================================================================
procedure USART_ReceiverWakeUpCmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR1 := USARTx.CR1 or CR1_RWU_Set
  else
    USARTx.cr1 := USARTx.cr1 and not(CR1_RWU_Set);
end;

//======================================================================
procedure USART_LINBreakDetectLengthConfig(var USARTx: TUSARTRegisters; USART_LINBreakDetectLength: word);
begin
  USARTx.CR2 := USARTx.CR2 and CR3_LBDL_Mask;
  USARTx.CR2 := USARTx.CR2 or USART_LINBreakDetectLength;
end;

//======================================================================
procedure USART_LINCmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR2 := USARTx.CR2 or CR2_LINE_Set
  else
    USARTx.CR2 := USARTx.CR2 and CR2_LINE_Reset;
end;

//======================================================================
procedure USART_SendData(var USARTx: TUSARTRegisters; Data: Word);
begin
  USARTx.DR := byte(Data and $1FF);
  while (USARTx.SR AND (1 shl 7)) = 0 do;
end;

//======================================================================
procedure USART_SendString(var USARTx: TUSARTRegisters; const data: string);
var
  i : word;
begin
  for i := 1 to length(Data) do
  begin
    USARTx.DR := ord(Data[i]) and $1FF;
    while (USARTx.SR AND (1 shl 7)) = 0 do;
  end;
end;

//======================================================================
function USART_ReceiveData(var USARTx: TUSARTRegisters): Word;
begin
  USART_ReceiveData := (USARTx.DR and $1FF);
end;

//======================================================================
procedure USART_SendBreak(var USARTx: TUSARTRegisters);
begin
  USARTx.CR1 := USARTx.CR1 or CR1_SBK_Set;
end;

//======================================================================
procedure USART_SetGuardTime(var USARTx: TUSARTRegisters; USART_GuardTime: byte);
begin
  USARTx.GTPR := USARTx.GTPR and GTPR_LSB_Mask;
  USARTx.GTPR := USARTx.GTPR or (USART_GuardTime shl 8);
end;

//======================================================================
procedure USART_SetPrescaler(var USARTx: TUSARTRegisters; USART_Prescaler: byte);
begin
  USARTx.GTPR := USARTx.GTPR and GTPR_MSB_Mask;
  USARTx.GTPR := USARTx.GTPR or USART_Prescaler;
end;

//======================================================================
procedure USART_SmartCardCmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR3 := USARTx.CR3 or CR3_SCEN_Set
  else
    USARTx.CR3 := USARTx.CR3 and CR3_SCEN_Reset;
end;

//======================================================================
procedure USART_SmartCardNACKCmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR3 := USARTx.CR3 or CR3_NACK_Set
  else
    USARTx.CR3 := USARTx.CR3 and CR3_NACK_Reset;
end;

//======================================================================
procedure USART_HalfDuplexCmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR3 := USARTx.CR3 or CR3_HDSEL_Set
  else
    USARTx.CR3 := USARTx.CR3 and CR3_HDSEL_Reset;
end;

//======================================================================
procedure USART_IrDAConfig(var USARTx: TUSARTRegisters; USART_IrDAMode: word);
begin
  USARTx.CR3 := USARTx.CR3 and CR3_IRLP_Mask;
  USARTx.CR3 := USARTx.CR3 or USART_IrDAMode;
end;

//======================================================================
procedure USART_IrDACmd(var USARTx: TUSARTRegisters; NewState: TState);
begin
  if newstate = enabled then
    USARTx.CR3 := USARTx.CR3 or CR3_IREN_Set
  else
    USARTx.CR3 := USARTx.CR3 and CR3_IREN_Reset;
end;

//======================================================================
function USART_GetFlagStatus(var USARTx: TUSARTRegisters; USART_FLAG: word): dword;
begin
  USART_GetFlagStatus := (USARTx.SR AND USART_FLAG);
end;

//======================================================================
procedure USART_ClearFlag(var USARTx: TUSARTRegisters; USART_FLAG: word);
begin
  USARTx.SR := USARTx.SR AND NOT (1 shl 5);
end;

//======================================================================
function USART_GetITStatus(var USARTx: TUSARTRegisters; USART_IT: word): longword;
var bitpos, itmask, usartreg: longword;
begin
  usartreg := (byte(USART_IT) shr 5);

  itmask := USART_IT and USART_IT_Mask;

  itmask := dword(1) shl itmask;

  if usartreg = 1 then
    itmask := itmask and USARTx.CR1
  else if usartreg = 2 then
    itmask := itmask and usartx.CR2
  else
    itmask := itmask and usartx.CR3;

  bitpos := USART_IT shr 8;

  bitpos := dword(1) shl bitpos;
  bitpos := bitpos and USARTx.SR;

  if (itmask <> 0)  and (bitpos <> 0) then
    USART_GetITStatus := 1
  else
    USART_GetITStatus  := 0;
end;

//======================================================================
procedure USART_ClearITPendingBit(var USARTx: TUSARTRegisters; USART_IT: word);
var bitpos, itmask: longword;
begin
  bitpos := USART_IT shr 8;

  itmask := word(1) shl word(bitpos);
  USARTx.SR := USARTx.SR and not(itmask);
end;

end.
