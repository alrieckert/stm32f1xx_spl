//======================================================================
unit stm32f1xx_nvic;

//======================================================================
interface
uses stm32f1xx_rcc;

//======================================================================
const
  NVIC_VectTab_RAM             = $20000000;
  NVIC_VectTab_FLASH           = $08000000;

  NVIC_LP_SEVONPEND            = $10;
  NVIC_LP_SLEEPDEEP            = $04;
  NVIC_LP_SLEEPONEXIT          = $02;

  NVIC_PriorityGroup_0         = $700;
  NVIC_PriorityGroup_1         = $600;
  NVIC_PriorityGroup_2         = $500;
  NVIC_PriorityGroup_3         = $400;
  NVIC_PriorityGroup_4         = $300;

  SystemHandler_NMI            = $00001F;     // NMI Handler */
  SystemHandler_HardFault      = $000000;     // Hard Fault Handler */
  SystemHandler_MemoryManage   = $043430;     // Memory Manage Handler */
  SystemHandler_BusFault       = $547931;     // Bus Fault Handler */
  SystemHandler_UsageFault     = $24C232;     // Usage Fault Handler */
  SystemHandler_SVCall         = $01FF40;     // SVCall Handler */
  SystemHandler_DebugMonitor   = $0A0080;     // Debug Monitor Handler */
  SystemHandler_PSV            = $02829C;     // PSV Handler */
  SystemHandler_SysTick        = $02C39A;     // SysTick Handler */

  __NVIC_PRIO_BITS             = 4;

//======================================================================
type
  TNVIC_InitTypeDef = record
		NVIC_IRQChannel : integer;
		NVIC_IRQChannelPreemptionPriority,
		NVIC_IRQChannelSubPriority: byte;
		NVIC_IRQChannelCmd: TState;
 end;

//======================================================================
procedure NVIC_EnableIRQ(IRQn : integer);
procedure NVIC_DisableIRQ(IRQn : word);
procedure NVIC_SetPriority(IRQn : integer; priority : dword);

procedure NVIC_PriorityGroupConfig(PriorityGroup: longword);
procedure NVIC_Init(const NVIC_InitStruct: TNVIC_InitTypeDef);
procedure NVIC_SetVectorTable(NVIC_VectTab, Offset: Longword);
procedure NVIC_SystemLPConfig(LowPowerMode: byte; NewState: TState);

//======================================================================
implementation
const
  AIRCR_VECTKEY_MASK    = $05FA0000;

//======================================================================
procedure NVIC_PriorityGroupConfig(PriorityGroup: longword);
begin
  SCB.AIRCR := AIRCR_VECTKEY_MASK OR PriorityGroup;
end;

//======================================================================
procedure NVIC_Init(const NVIC_InitStruct: TNVIC_InitTypeDef);
var tmppriority, tmppre, tmpsub: longword;
begin
  tmppriority := $00;
  tmppre := $00;
  tmpsub := $0F;

  if NVIC_InitStruct.NVIC_IRQChannelCmd <> DISABLED then
  begin
    { Compute the Corresponding IRQ Priority --------------------------------}
    tmppriority := ($700 - (SCB.AIRCR and $700)) shr $08;
    tmppre := (4 - tmppriority);
    tmpsub := tmpsub shr tmppriority;

    tmppriority := NVIC_InitStruct.NVIC_IRQChannelPreemptionPriority shl tmppre;
    tmppriority := tmppriority or (NVIC_InitStruct.NVIC_IRQChannelSubPriority and tmpsub);
    tmppriority := tmppriority shl $04;

    NVIC.IP[NVIC_InitStruct.NVIC_IRQChannel] := tmppriority;

    { Enable the Selected IRQ Channels --------------------------------------}
    NVIC.ISER[NVIC_InitStruct.NVIC_IRQChannel shr $05] := dword(1 shl (NVIC_InitStruct.NVIC_IRQChannel and $1F));
  end
  else
    NVIC.ICER[NVIC_InitStruct.NVIC_IRQChannel shr $05] := 1 shl (NVIC_InitStruct.NVIC_IRQChannel and $1F);
end;

//======================================================================
procedure NVIC_SetPriority(IRQn : integer; priority : dword);
begin
  if (IRQn < 0) then 
    SCB.SHP[(word(IRQn) AND $0F) - 4] := ((priority SHL (8 - __NVIC_PRIO_BITS)) AND $FF)   // set Priority for Cortex-M3 System Interrupts
  else
    NVIC.IP[word(IRQn)] := ((priority SHL (8 - __NVIC_PRIO_BITS)) AND $FF);                // set Priority for device specific Interrupts
end;

//======================================================================
procedure NVIC_EnableIRQ(IRQn : integer);
begin
  NVIC.ISER[IRQn shr $05] := dword(1 shl (IRQn and $1F));
end;

//======================================================================
procedure NVIC_DisableIRQ(IRQn : word); inline;
begin
  NVIC.ICER[dword(IRQn) shr $05] := dword(1 shl (IRQn AND $1F));
end;

//======================================================================
procedure NVIC_SetVectorTable(NVIC_VectTab, Offset: Longword);
begin
  SCB.VTOR := NVIC_VectTab OR (offset AND $1FFFFF80);
end;

//======================================================================
procedure NVIC_SystemLPConfig(LowPowerMode: byte; NewState: TState);
begin
  case NewState of
    Disabled:
      SCB.SCR := SCB.SCR or LowPowerMode;
    Enabled:
      SCB.SCR := SCB.SCR and not(LowPowerMode);
  end;
end;

end.
