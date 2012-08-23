//======================================================================
unit stm32f1xx_exti;

//======================================================================
interface
uses
  stm32f1xx_rcc;
  
//======================================================================
type
  TEXTIMode_TypeDef = (EXTI_Mode_Interrupt = $00, EXTI_Mode_Event = $04);
  TEXTITrigger_TypeDef = (EXTI_Trigger_Rising = $08, EXTI_Trigger_Falling = $0C, EXTI_Trigger_Rising_Falling = $10);

  TEXTI_InitTypeDef = record
    EXTI_Line : dword;                   // < Specifies the EXTI lines to be enabled or disabled.
                                         // This parameter can be any combination of @ref EXTI_Lines 
    EXTI_Mode : TEXTIMode_TypeDef;       // < Specifies the mode for the EXTI lines.
                                         // This parameter can be a value of @ref EXTIMode_TypeDef 
    EXTI_Trigger : TEXTITrigger_TypeDef; // < Specifies the trigger signal active edge for the EXTI lines.
                                         // This parameter can be a value of @ref EXTIMode_TypeDef 
    EXTI_LineCmd : TState;               // < Specifies the new state of the selected EXTI lines.
  end;

//======================================================================
const
  EXTI_Line0     = $00001;  // < External interrupt line 0
  EXTI_Line1     = $00002;  // < External interrupt line 1
  EXTI_Line2     = $00004;  // < External interrupt line 2
  EXTI_Line3     = $00008;  // < External interrupt line 3
  EXTI_Line4     = $00010;  // < External interrupt line 4
  EXTI_Line5     = $00020;  // < External interrupt line 5
  EXTI_Line6     = $00040;  // < External interrupt line 6
  EXTI_Line7     = $00080;  // < External interrupt line 7
  EXTI_Line8     = $00100;  // < External interrupt line 8
  EXTI_Line9     = $00200;  // < External interrupt line 9
  EXTI_Line10    = $00400;  // < External interrupt line 10
  EXTI_Line11    = $00800;  // < External interrupt line 11
  EXTI_Line12    = $01000;  // < External interrupt line 12
  EXTI_Line13    = $02000;  // < External interrupt line 13
  EXTI_Line14    = $04000;  // < External interrupt line 14
  EXTI_Line15    = $08000;  // < External interrupt line 15
  EXTI_Line16    = $10000;  // < External interrupt line 16 Connected to the PVD Output
  EXTI_Line17    = $20000;  // < External interrupt line 17 Connected to the RTC Alarm event
  EXTI_Line18    = $40000;  // < External interrupt line 18 Connected to the USB Device/USB OTG FS Wakeup from suspend event                                    
  EXTI_Line19    = $80000;  // < External interrupt line 19 Connected to the Ethernet Wakeup event
                                          
//======================================================================
procedure EXTI_ClearITPendingBit(EXTI_Line : dword);
function EXTI_GetITStatus(EXTI_Line : dword) : dword;
procedure EXTI_ClearFlag(EXTI_Line : dword);
function EXTI_GetFlagStatus(EXTI_Line : dword) : dword;
procedure EXTI_GenerateSWInterrupt(EXTI_Line : dword);
procedure EXTI_StructInit(var EXTI_InitStruct : TEXTI_InitTypeDef);
procedure EXTI_Init(const EXTI_InitStruct : TEXTI_InitTypeDef);
procedure EXTI_DeInit;

//======================================================================
implementation 
const
  EXTI_LineNone  = $00000;  // No interrupt selected

//======================================================================
// Deinitializes the EXTI peripheral registers to their default reset values.
//======================================================================
procedure EXTI_DeInit;
begin
  EXTI.IMR  := $00000000;
  EXTI.EMR  := $00000000;
  EXTI.RTSR := $00000000; 
  EXTI.FTSR := $00000000; 
  EXTI.PR   := $000FFFFF;
end;

//======================================================================
// Initializes the EXTI peripheral according to the specified parameters
//======================================================================
procedure EXTI_Init(const EXTI_InitStruct : TEXTI_InitTypeDef);
begin
  if (EXTI_InitStruct.EXTI_LineCmd <> DISABLED) then
  begin
    // Clear EXTI line configuration
    EXTI.IMR := EXTI.IMR AND NOT (EXTI_InitStruct.EXTI_Line);
    EXTI.EMR := EXTI.EMR AND NOT (EXTI_InitStruct.EXTI_Line);
    
    EXTI.IMR := EXTI.IMR OR EXTI_InitStruct.EXTI_Line;

    // Clear Rising Falling edge configuration
    EXTI.RTSR := EXTI.RTSR AND NOT (EXTI_InitStruct.EXTI_Line);
    EXTI.FTSR := EXTI.FTSR AND NOT (EXTI_InitStruct.EXTI_Line);
    
    // Select the trigger for the selected external interrupts
    if (EXTI_InitStruct.EXTI_Trigger = EXTI_Trigger_Rising_Falling) then
    begin
      // Rising Falling edge
      EXTI.RTSR := EXTI.RTSR OR EXTI_InitStruct.EXTI_Line;
      EXTI.FTSR := EXTI.FTSR OR EXTI_InitStruct.EXTI_Line;
    end
    else if (EXTI_InitStruct.EXTI_Trigger = EXTI_Trigger_Falling) then
    begin
      EXTI.FTSR := EXTI.FTSR OR EXTI_InitStruct.EXTI_Line;
    end
    else
    begin
      EXTI.RTSR := EXTI.RTSR OR EXTI_InitStruct.EXTI_Line;
    end;
  end
  else
  begin

  end;
end;

//======================================================================
// Fills each EXTI_InitStruct member with its reset value.
//======================================================================
procedure EXTI_StructInit(var EXTI_InitStruct : TEXTI_InitTypeDef);
begin
  EXTI_InitStruct.EXTI_Line    := EXTI_LineNone;
  EXTI_InitStruct.EXTI_Mode    := EXTI_Mode_Interrupt;
  EXTI_InitStruct.EXTI_Trigger := EXTI_Trigger_Falling;
  EXTI_InitStruct.EXTI_LineCmd := DISABLED;
end;

//======================================================================
// Generates a Software interrupt
//======================================================================
procedure EXTI_GenerateSWInterrupt(EXTI_Line : dword);
begin
  EXTI.SWIER := EXTI.SWIER or EXTI_Line;
end;

//======================================================================
// Checks whether the specified EXTI line flag is set or not
//======================================================================
function EXTI_GetFlagStatus(EXTI_Line : dword) : dword;
var
  bitstatus : dword;
begin
  bitstatus := RCC_RESET;

  if ((EXTI.PR AND EXTI_Line) <> RCC_RESET) then
    bitstatus := RCC_SET
  else
    bitstatus := RCC_RESET;

  EXTI_GetFlagStatus := bitstatus;
end;

//======================================================================
// Clears the EXTI's line pending flags.
//======================================================================
procedure EXTI_ClearFlag(EXTI_Line : dword);
begin
  EXTI.PR := EXTI_Line;
end;

//======================================================================
// Checks whether the specified EXTI line is asserted or not.
//======================================================================
function EXTI_GetITStatus(EXTI_Line : dword) : dword;
begin
  if (((EXTI.PR AND EXTI_Line) <> RCC_RESET) AND ((EXTI.IMR AND EXTI_Line) <> RCC_RESET)) then
    exit(1)
  else
    exit(0);
end;

//======================================================================
// Clears the EXTI's line pending bits.
//======================================================================
procedure EXTI_ClearITPendingBit(EXTI_Line : dword);
begin
  EXTI.PR := EXTI_Line;
end;

end.
