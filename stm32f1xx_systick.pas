//======================================================================
unit stm32f1xx_systick;

//======================================================================
interface
uses stm32f1xx_rcc;

const
 SysTick_CLKSource_HCLK_Div8  = $FFFFFFFB;
 SysTick_CLKSource_HCLK       = $00000004;

 SysTick_Counter_Disable      = $FFFFFFFE;
 SysTick_Counter_Enable       = $00000001;
 SysTick_Counter_Clear        = $00000000;

 SysTick_FLAG_COUNT           = $00000010;
 SysTick_FLAG_SKEW            = $0000001E;
 SysTick_FLAG_NOREF           = $0000001F;

procedure SysTick_CLKSourceConfig(SysTick_CLKSource: longword);
procedure SysTick_SetReload(Reload: LongWord);
procedure SysTick_CounterCmd(SysTick_Counter: Longword);
procedure SysTick_ITConfig(NewState: TState);
function SysTick_GetCounter: LongWord;
function SysTick_GetFlagStatus(SysTick_FLAG: byte): longword;
procedure delay(ms_delay : dword);
procedure delay_ms(ms_delay : dword);
procedure delay_us(us_delay : dword);

var
  SysTickDelayCounter : dword;

implementation

const
 CTRL_TICKINT_Set     = $00000002;
 CTRL_TICKINT_Reset   = $FFFFFFFD;

//======================================================================
procedure delay(ms_delay : dword);
begin
  // Enable the SysTick Counter
  SysTickDelayCounter := ms_delay;
  while SysTickDelayCounter > 0 do;
end;

//======================================================================
procedure delay_ms(ms_delay : dword);
begin
  // Enable the SysTick Counter
  SysTickDelayCounter := ms_delay;
  while SysTickDelayCounter > 0 do;
end;

//======================================================================
procedure delay_us(us_delay : dword);
begin
  // Enable the SysTick Counter
  SysTickDelayCounter := 1;
  while SysTickDelayCounter > 0 do;
end;

//======================================================================
procedure SysTick_CLKSourceConfig(SysTick_CLKSource: longword);
begin
  if SysTick_CLKSource = SysTick_CLKSource_HCLK then
    SysTick.CTRL := SysTick.Ctrl or SysTick_CLKSource_HCLK
  else
    SysTick.CTRL := SysTick.CTRL and SysTick_CLKSource_HCLK_Div8;
end;

//======================================================================
procedure SysTick_SetReload(Reload: LongWord);
begin
  SysTick.LOAD := Reload;
end;

//======================================================================
procedure SysTick_CounterCmd(SysTick_Counter: Longword);
begin
  if systick_counter = systick_counter_enable then
    systick.ctrl := systick.ctrl or systick_counter_enable
  else if systick_counter = SysTick_Counter_Disable then
    systick.ctrl := systick.ctrl and SysTick_Counter_Disable
  else
    SysTick.VAL := SysTick_Counter_Clear;
end;

//======================================================================
procedure SysTick_ITConfig(NewState: TState);
begin
  if NewState <> DISABLED then
    SysTick.CTRL := SysTick.CTRL or CTRL_TICKINT_Set
  else
    SysTick.CTRL := SysTick.CTRL and CTRL_TICKINT_Reset;
end;

//======================================================================
function SysTick_GetCounter: LongWord;
begin
  exit(SysTick.Val);
end;

//======================================================================
function SysTick_GetFlagStatus(SysTick_FLAG: byte): longword;
var tmp, statusreg: LongWord;
begin
  tmp := SysTick_FLAG shr 3;

  if tmp = 2 then
    statusreg := systick.ctrl
  else
    statusreg := systick.calib;

  if (statusreg and (1 shl SysTick_Flag)) <> 0 then
    exit(1)
  else
    exit(0);
end;

end.

