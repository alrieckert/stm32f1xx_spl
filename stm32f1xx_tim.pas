//======================================================================
unit stm32f1xx_tim;

//======================================================================
interface
uses
  stm32f1xx_rcc;
  
//======================================================================
type
  TTIM_TimeBaseInit = record
    TIM_Prescaler : word;         //  Specifies the prescaler value used to divide the TIM clock.
                                  //  This parameter can be a number between $0000 and $FFFF 
    TIM_CounterMode : word;       //  Specifies the counter mode.
                                  //  This parameter can be a value of @ref TIM_Counter_Mode 
    TIM_Period : word;            //  Specifies the period value to be loaded into the active
                                  //  Auto-Reload Register at the next update event.
                                  //  This parameter must be a number between $0000 and $FFFF.   
    TIM_ClockDivision : word;     //  Specifies the clock division.
                                  //  This parameter can be a value of @ref TIM_Clock_Division_CKD 
    TIM_RepetitionCounter : byte; //  Specifies the repetition counter value. Each time the RCR downcounter
                                  //  reaches zero, an update event is generated and counting restarts
                                  //  from the RCR value (N).
                                  //     This means in PWM mode that (N+1) corresponds to:
                                  //        - the number of PWM periods in edge-aligned mode
                                  //        - the number of half PWM period in center-aligned mode
                                  //     This parameter must be a number between $00 and $FF. 
  end;																	

//======================================================================
type
  TTIM_OCInitStructure = record
		TIM_OCMode : word;        //  Specifies the TIM mode.
															//       This parameter can be a value of @ref TIM_Output_Compare_and_PWM_modes 
		TIM_OutputState : word;   //  Specifies the TIM Output Compare state.
															//       This parameter can be a value of @ref TIM_Output_Compare_state 
		TIM_OutputNState : word;  //  Specifies the TIM complementary Output Compare state.
															//       This parameter can be a value of @ref TIM_Output_Compare_N_state
															//       @note This parameter is valid only for TIM1 and TIM8. 
		TIM_Pulse : word;         //  Specifies the pulse value to be loaded into the Capture Compare Register. 
															//       This parameter can be a number between $0000 and $FFFF 
		TIM_OCPolarity : word;    //  Specifies the output polarity.
															//       This parameter can be a value of @ref TIM_Output_Compare_Polarity 
		TIM_OCNPolarity : word;   //  Specifies the complementary output polarity.
															//       This parameter can be a value of @ref TIM_Output_Compare_N_Polarity
															//       @note This parameter is valid only for TIM1 and TIM8. 
		TIM_OCIdleState : word;   //  Specifies the TIM Output Compare pin state during Idle state.
															//      This parameter can be a value of @ref TIM_Output_Compare_Idle_State
															//       @note This parameter is valid only for TIM1 and TIM8. 
		TIM_OCNIdleState : word;  //  Specifies the TIM Output Compare pin state during Idle state.
															//       This parameter can be a value of @ref TIM_Output_Compare_N_Idle_State
	  													//       @note This parameter is valid only for TIM1 and TIM8. 
  end; 

//======================================================================
type
  TTIM_ICInit = record 
		TIM_Channel : word;      //  Specifies the TIM channel.
																		  //  This parameter can be a value of @ref TIM_Channel 
		TIM_ICPolarity : word;   //  Specifies the active edge of the input signal.
																		  //  This parameter can be a value of @ref TIM_Input_Capture_Polarity 
		TIM_ICSelection : word;  //  Specifies the input.
																		  //  This parameter can be a value of @ref TIM_Input_Capture_Selection 
		TIM_ICPrescaler : word;  //  Specifies the Input Capture Prescaler.
																		  //  This parameter can be a value of @ref TIM_Input_Capture_Prescaler 
		TIM_ICFilter : word;     //  Specifies the input capture filter.
																		  //  This parameter can be a number between $0 and $F 
  end; 

//======================================================================
type
  TTIM_BDTRInit = record
		TIM_OSSRState : word;        //  Specifies the Off-State selection used in Run mode.
																//				This parameter can be a value of @ref OSSR_Off_State_Selection_for_Run_mode_state 
		TIM_OSSIState : word;        //  Specifies the Off-State used in Idle state.
																//			This parameter can be a value of @ref OSSI_Off_State_Selection_for_Idle_mode_state 
		TIM_LOCKLevel : word;        //  Specifies the LOCK level parameters.
																	//			This parameter can be a value of @ref Lock_level  
		TIM_DeadTime : word;         //  Specifies the delay time between the switching-off and the
																//				switching-on of the outputs.
															//					This parameter can be a number between $00 and $FF  
		TIM_Break : word;            //  Specifies whether the TIM Break input is enabled or not. 
																//				This parameter can be a value of @ref Break_Input_enable_disable 
		TIM_BreakPolarity : word;    //  Specifies the TIM Break Input pin polarity.
																//				This parameter can be a value of @ref Break_Polarity 
		TIM_AutomaticOutput : word;  //  Specifies whether the TIM Automatic Output feature is enabled or not. 
																//				This parameter can be a value of @ref TIM_AOE_Bit_Set_Reset 
  end; 

//======================================================================
const
  TIM_OCMode_Timing     = $0000;
  TIM_OCMode_Active     = $0010;
  TIM_OCMode_Inactive   = $0020;
  TIM_OCMode_Toggle     = $0030;
  TIM_OCMode_PWM1       = $0060;
  TIM_OCMode_PWM2       = $0070;

  TIM_OPMode_Single     = $0008;
  TIM_OPMode_Repetitive = $0000;
 
  TIM_Channel_1         = $0000;
  TIM_Channel_2         = $0004;
  TIM_Channel_3         = $0008;
  TIM_Channel_4         = $000C;

  TIM_CKD_DIV1          = $0000;
  TIM_CKD_DIV2          = $0100;
  TIM_CKD_DIV4          = $0200;

  TIM_CounterMode_Up               	= $0000;
  TIM_CounterMode_Down  						= $0010;
  TIM_CounterMode_CenterAligned1   	= $0020;
  TIM_CounterMode_CenterAligned2   	= $0040;
  TIM_CounterMode_CenterAligned3   	= $0060;

  TIM_OCPolarity_High   						= $0000;
  TIM_OCPolarity_Low    						= $0002;
  
  TIM_OCNPolarity_High  						= $0000;
  TIM_OCNPolarity_Low   						= $0008;

  TIM_OutputState_Disable  = $0000;
  TIM_OutputState_Enable   = $0001;

  TIM_OutputNState_Disable = $0000;
  TIM_OutputNState_Enable  = $0004;

  TIM_CCx_Enable         = $0001;
  TIM_CCx_Disable        = $0000;

  TIM_CCxN_Enable        = $0004;
  TIM_CCxN_Disable       = $0000;

  TIM_Break_Enable      = $1000;
  TIM_Break_Disable     = $0000;

  TIM_BreakPolarity_Low  = $0000;
  TIM_BreakPolarity_High = $2000;

  TIM_AutomaticOutput_Enable   = $4000;
  TIM_AutomaticOutput_Disable  = $0000;

  TIM_LOCKLevel_OFF     = $0000;
  TIM_LOCKLevel_1       = $0100;
  TIM_LOCKLevel_2       = $0200;
  TIM_LOCKLevel_3       = $0300;

  TIM_OSSIState_Enable  = $0400;
  TIM_OSSIState_Disable = $0000;

  TIM_OSSRState_Enable  = $0800;
  TIM_OSSRState_Disable = $0000;

  TIM_OCIdleState_Set   = $0100;
  TIM_OCIdleState_Reset = $0000;

  TIM_OCNIdleState_Set  = $0200;
  TIM_OCNIdleState_Reset= $0000;

  TIM_ICPolarity_Rising   = $0000;
  TIM_ICPolarity_Falling  = $0002;

  TIM_ICSelection_DirectTI      = $0001; //  TIM Input 1, 2, 3 or 4 is selected to be connected to IC1, IC2, IC3 or IC4, respectively 
  TIM_ICSelection_IndirectTI    = $0002; //  TIM Input 1, 2, 3 or 4 is selected to be connected to IC2, IC1, IC4 or IC3, respectively. 
  TIM_ICSelection_TRC           = $0003; //  TIM Input 1, 2, 3 or 4 is selected to be connected to TRC. 

  TIM_ICPSC_DIV1        = $0000; //  Capture performed each time an edge is detected on the capture input. 
  TIM_ICPSC_DIV2        = $0004; //  Capture performed once every 2 events. 
  TIM_ICPSC_DIV4        = $0008; //  Capture performed once every 4 events. 
  TIM_ICPSC_DIV8        = $000C; //  Capture performed once every 8 events. 

  TIM_IT_Update         = $0001;
  TIM_IT_CC1            = $0002;
  TIM_IT_CC2            = $0004;
  TIM_IT_CC3            = $0008;
  TIM_IT_CC4            = $0010;
  TIM_IT_COM            = $0020;
  TIM_IT_Trigger        = $0040;
  TIM_IT_Break          = $0080;

  TIM_DMABase_CR1       = $0000;
  TIM_DMABase_CR2       = $0001;
  TIM_DMABase_SMCR      = $0002;
  TIM_DMABase_DIER      = $0003;
  TIM_DMABase_SR        = $0004;
  TIM_DMABase_EGR       = $0005;
  TIM_DMABase_CCMR1     = $0006;
  TIM_DMABase_CCMR2     = $0007;
  TIM_DMABase_CCER      = $0008;
  TIM_DMABase_CNT       = $0009;
  TIM_DMABase_PSC       = $000A;
  TIM_DMABase_ARR       = $000B;
  TIM_DMABase_RCR       = $000C;
  TIM_DMABase_CCR1      = $000D;
  TIM_DMABase_CCR2      = $000E;
  TIM_DMABase_CCR3      = $000F;
  TIM_DMABase_CCR4      = $0010;
  TIM_DMABase_BDTR      = $0011;
  TIM_DMABase_DCR       = $0012;

  TIM_DMABurstLength_1Byte     = $0000;
  TIM_DMABurstLength_2Bytes    = $0100;
  TIM_DMABurstLength_3Bytes    = $0200;
  TIM_DMABurstLength_4Bytes    = $0300;
  TIM_DMABurstLength_5Bytes    = $0400;
  TIM_DMABurstLength_6Bytes    = $0500;
  TIM_DMABurstLength_7Bytes    = $0600;
  TIM_DMABurstLength_8Bytes    = $0700;
  TIM_DMABurstLength_9Bytes    = $0800;
  TIM_DMABurstLength_10Bytes   = $0900;
  TIM_DMABurstLength_11Bytes   = $0A00;
  TIM_DMABurstLength_12Bytes   = $0B00;
  TIM_DMABurstLength_13Bytes   = $0C00;
  TIM_DMABurstLength_14Bytes   = $0D00;
  TIM_DMABurstLength_15Bytes   = $0E00;
  TIM_DMABurstLength_16Bytes   = $0F00;
  TIM_DMABurstLength_17Bytes   = $1000;
  TIM_DMABurstLength_18Bytes   = $1100;

  TIM_DMA_Update        = $0100;
  TIM_DMA_CC1           = $0200;
  TIM_DMA_CC2           = $0400;
  TIM_DMA_CC3           = $0800;
  TIM_DMA_CC4           = $1000;
  TIM_DMA_COM           = $2000;
  TIM_DMA_Trigger       = $4000;

  TIM_ExtTRGPSC_OFF     = $0000;
  TIM_ExtTRGPSC_DIV2    = $1000;
  TIM_ExtTRGPSC_DIV4    = $2000;
  TIM_ExtTRGPSC_DIV8    = $3000;

  TIM_TS_ITR0           = $0000;
  TIM_TS_ITR1           = $0010;
  TIM_TS_ITR2           = $0020;
  TIM_TS_ITR3           = $0030;
  TIM_TS_TI1F_ED        = $0040;
  TIM_TS_TI1FP1         = $0050;
  TIM_TS_TI2FP2         = $0060;
  TIM_TS_ETRF           = $0070;

  TIM_TIxExternalCLK1Source_TI1    = $0050;
  TIM_TIxExternalCLK1Source_TI2    = $0060;
  TIM_TIxExternalCLK1Source_TI1ED  = $0040;
   
  TIM_ExtTRGPolarity_Inverted      = $8000;
  TIM_ExtTRGPolarity_NonInverted   = $0000;

  TIM_PSCReloadMode_Update     = $0000;
  TIM_PSCReloadMode_Immediate  = $0001;

  TIM_ForcedAction_Active      = $0050;
  TIM_ForcedAction_InActive    = $0040;

  TIM_EncoderMode_TI1   = $0001;
  TIM_EncoderMode_TI2   = $0002;
  TIM_EncoderMode_TI12  = $0003;

  TIM_EventSource_Update= $0001;
  TIM_EventSource_CC1   = $0002;
  TIM_EventSource_CC2   = $0004;
  TIM_EventSource_CC3   = $0008;
  TIM_EventSource_CC4   = $0010;
  TIM_EventSource_COM   = $0020;
  TIM_EventSource_Trigger      = $0040;
  TIM_EventSource_Break = $0080;

  TIM_UpdateSource_Global      = $0000; //  Source of update is the counter overflow/underflow
                                        //                           or the setting of UG bit, or an update generation
                                        //                           through the slave mode controller. 
  TIM_UpdateSource_Regular     = $0001; //  Source of update is counter overflow/underflow. 

  TIM_OCPreload_Enable  = $0008;
  TIM_OCPreload_Disable = $0000;

  TIM_OCFast_Enable     = $0004;
  TIM_OCFast_Disable    = $0000;

  TIM_OCClear_Enable    = $0080;
  TIM_OCClear_Disable   = $0000;

  TIM_TRGOSource_Reset  = $0000;
  TIM_TRGOSource_Enable = $0010;
  TIM_TRGOSource_Update = $0020;
  TIM_TRGOSource_OC1    = $0030;
  TIM_TRGOSource_OC1Ref = $0040;
  TIM_TRGOSource_OC2Ref = $0050;
  TIM_TRGOSource_OC3Ref = $0060;
  TIM_TRGOSource_OC4Ref = $0070;

  TIM_SlaveMode_Reset   = $0004;
  TIM_SlaveMode_Gated   = $0005;
  TIM_SlaveMode_Trigger = $0006;
  TIM_SlaveMode_External1      = $0007;

  TIM_MasterSlaveMode_Enable   = $0080;
  TIM_MasterSlaveMode_Disable  = $0000;

  TIM_FLAG_Update       = $0001;
  TIM_FLAG_CC1          = $0002;
  TIM_FLAG_CC2          = $0004;
  TIM_FLAG_CC3          = $0008;
  TIM_FLAG_CC4          = $0010;
  TIM_FLAG_COM          = $0020;
  TIM_FLAG_Trigger      = $0040;
  TIM_FLAG_Break        = $0080;
  TIM_FLAG_CC1OF        = $0200;
  TIM_FLAG_CC2OF        = $0400;
  TIM_FLAG_CC3OF        = $0800;
  TIM_FLAG_CC4OF        = $1000;

  SMCR_ETR_Mask  = $00FF;
  CCMR_Offset    = $0018;
  CCER_CCE_Set   = $0001;  
	CCER_CCNE_Set  = $0004;

  TIM_SMCR_SMS    = $0007;
  TIM_SMCR_SMS_0  = $0001;
  TIM_SMCR_SMS_1  = $0002;
  TIM_SMCR_SMS_2  = $0004;

  TIM_CCER_CC1E     : word = $0001;
  TIM_CCER_CC1P     : word = $0002;
  TIM_CCER_CC1NE    : word = $0004;
  TIM_CCER_CC1NP    : word = $0008;
  TIM_CCER_CC2E     : word = $0010;
  TIM_CCER_CC2P     : word = $0020;
  TIM_CCER_CC2NE    : word = $0040;
  TIM_CCER_CC2NP    : word = $0080;
  TIM_CCER_CC3E     : word = $0100;
  TIM_CCER_CC3P     : word = $0200;
  TIM_CCER_CC3NE    : word = $0400;
  TIM_CCER_CC3NP    : word = $0800;
  TIM_CCER_CC4E     : word = $1000;
  TIM_CCER_CC4P     : word = $2000;

  TIM_CCMR1_CC1S     : word = $0003;
  TIM_CCMR1_CC1S_0   : word = $0001;
  TIM_CCMR1_CC1S_1   : word = $0002;

  TIM_CCMR1_OC1FE    : word = $0004;
  TIM_CCMR1_OC1PE    : word = $0008;

  TIM_CCMR1_OC1M     : word = $0070;
  TIM_CCMR1_OC1M_0   : word = $0010;
  TIM_CCMR1_OC1M_1   : word = $0020;
  TIM_CCMR1_OC1M_2   : word = $0040;

  TIM_CCMR1_OC1CE    : word = $0080;

  TIM_CCMR1_CC2S     : word = $0300;
  TIM_CCMR1_CC2S_0   : word = $0100;
  TIM_CCMR1_CC2S_1   : word = $0200;

  TIM_CCMR1_OC2FE    : word = $0400;
  TIM_CCMR1_OC2PE    : word = $0800;

  TIM_CCMR1_OC2M     : word = $7000;
  TIM_CCMR1_OC2M_0   : word = $1000;
  TIM_CCMR1_OC2M_1   : word = $2000;
  TIM_CCMR1_OC2M_2   : word = $4000;

  TIM_CCMR1_OC2CE    : word = $8000;

  TIM_CR1_CEN        : word = $0001;
  TIM_CR1_UDIS       : word = $0002;
  TIM_CR1_URS        : word = $0004;
  TIM_CR1_OPM        : word = $0008;
  TIM_CR1_DIR        : word = $0010;

  TIM_CR1_CMS        : word = $0060;
  TIM_CR1_CMS_0      : word = $0020;
  TIM_CR1_CMS_1      : word = $0040;

  TIM_CR1_ARPE       : word = $0080;

  TIM_CR1_CKD        : word = $0300;
  TIM_CR1_CKD_0      : word = $0100;
  TIM_CR1_CKD_1      : word = $0200;

//======================================================================
procedure TIM_TimeBaseInit(var TIMx : TTimerRegisters; var TIM_TimeBaseInitStruct : TTIM_TimeBaseInit);
procedure TIM_PrescalerConfig(var TIMx : TTimerRegisters; Prescaler : word; TIM_PSCReloadMode : word);
procedure TIM_OC2Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
procedure TIM_OC3Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
procedure TIM_OC3PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
procedure TIM_ITConfig(var TIMx : TTimerRegisters; TIM_IT : word; NewState : TState);
procedure TIM_Cmd(var TIMx : TTimerRegisters; NewState : TState);
function TIM_GetITStatus(var TIMx : TTimerRegisters; TIM_IT : word) : boolean;
procedure TIM_ClearITPendingBit(var TIMx : TTimerRegisters; TIM_IT : word);
procedure TIM_SetCounter(var TIMx : TTimerRegisters; Counter : word);
procedure TIM_InternalClockConfig(var TIMx : TTimerRegisters);
procedure TIM_ARRPreloadConfig(var TIMx : TTimerRegisters; NewState : TState);

//======================================================================
implementation

(*//======================================================================
// Deinitializes the TIMx peripheral registers to their default reset values.
//======================================================================
procedure TIM_DeInit(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx)); 
 
  if (TIMx == TIM1)
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM1, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM1, DISABLE);  
  end;     
  else if (TIMx == TIM2)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM2, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM2, DISABLE);
  end;
  else if (TIMx == TIM3)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM3, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM3, DISABLE);
  end;
  else if (TIMx == TIM4)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM4, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM4, DISABLE);
  end; 
  else if (TIMx == TIM5)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM5, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM5, DISABLE);
  end; 
  else if (TIMx == TIM6)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM6, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM6, DISABLE);
  end; 
  else if (TIMx == TIM7)
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM7, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM7, DISABLE);
  end; 
  else if (TIMx == TIM8)
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM8, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM8, DISABLE);
  end;
  else if (TIMx == TIM9)
  begin      
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM9, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM9, DISABLE);  
   end;  
  else if (TIMx == TIM10)
  begin      
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM10, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM10, DISABLE);  
  end;  
  else if (TIMx == TIM11) 
  begin     
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM11, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM11, DISABLE);  
  end;  
  else if (TIMx == TIM12)
  begin      
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM12, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM12, DISABLE);  
  end;  
  else if (TIMx == TIM13) 
  begin       
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM13, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM13, DISABLE);  
  end;
  else if (TIMx == TIM14) 
  begin       
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM14, ENABLE);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM14, DISABLE);  
  end;        
  else if (TIMx == TIM15)
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM15, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM15, DISABLE);
  end; 
  else if (TIMx == TIM16)
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM16, ENABLE);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM16, DISABLE);
  end; 
  else
  begin
    if (TIMx == TIM17)
    begin
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM17, ENABLE);
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM17, DISABLE);
    end;  
  end;
end;
*)
//======================================================================
// Initializes the TIMx Time Base Unit peripheral according to 
//======================================================================
procedure TIM_TimeBaseInit(var TIMx : TTimerRegisters; var TIM_TimeBaseInitStruct : TTIM_TimeBaseInit);
var
  tmpcr1 : word;
begin
  tmpcr1 := TIMx.CR1;  

  if ((@TIMx = @Timer1) or (@TIMx = @Timer8) or (@TIMx = @Timer2) or (@TIMx = @Timer3) or
     (@TIMx = @Timer4) or (@TIMx = @Timer5)) then
  begin
    // Select the Counter Mode 
    tmpcr1 := tmpcr1 AND word(not(word(TIM_CR1_DIR OR TIM_CR1_CMS)));
    tmpcr1 := tmpcr1 OR dword(TIM_TimeBaseInitStruct.TIM_CounterMode);
  end;
 
  if((@TIMx <> @Timer6) and (@TIMx <> @Timer7)) then
  begin
    // Set the clock division 
    tmpcr1 := tmpcr1 and word(not(word(TIM_CR1_CKD)));
    tmpcr1 := tmpcr1 or dword(TIM_TimeBaseInitStruct.TIM_ClockDivision);
  end;

  TIMx.CR1 := tmpcr1;

  // Set the Autoreload value 
  TIMx.ARR := TIM_TimeBaseInitStruct.TIM_Period ;
 
  // Set the Prescaler value 
  TIMx.PSC := TIM_TimeBaseInitStruct.TIM_Prescaler;
    
  if ((@TIMx = @Timer1) or (@TIMx = @Timer8)) then
  begin
    // Set the Repetition Counter value 
    TIMx.RCR := TIM_TimeBaseInitStruct.TIM_RepetitionCounter;
  end;

  // Generate an update event to reload the Prescaler and the Repetition counter
  // values immediately 
  TIMx.EGR := TIM_PSCReloadMode_Immediate;           
end;
(*

//======================================================================
// Initializes the TIMx Channel1 according to the specified
//======================================================================
procedure TIM_OC1Init(TIM_TypeDef* TIMx, TIM_OCInitTypeDef* TIM_OCInitStruct)
begin
  uint16_t tmpccmrx = 0, tmpccer = 0, tmpcr2 = 0;
   
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_OC_MODE(TIM_OCInitStruct->TIM_OCMode));
  assert_param(IS_TIM_OUTPUT_STATE(TIM_OCInitStruct->TIM_OutputState));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCInitStruct->TIM_OCPolarity));   
 // Disable the Channel 1: Reset the CC1E Bit 
  TIMx->CCER &= (uint16_t)(~(uint16_t)TIM_CCER_CC1E);
  // Get the TIMx CCER register value 
  tmpccer = TIMx->CCER;
  // Get the TIMx CR2 register value 
  tmpcr2 =  TIMx->CR2;
  
  // Get the TIMx CCMR1 register value 
  tmpccmrx = TIMx->CCMR1;
    
  // Reset the Output Compare Mode Bits 
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR1_OC1M));
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR1_CC1S));

  // Select the Output Compare Mode 
  tmpccmrx |= TIM_OCInitStruct->TIM_OCMode;
  
  // Reset the Output Polarity level 
  tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC1P));
  // Set the Output Compare Polarity 
  tmpccer |= TIM_OCInitStruct->TIM_OCPolarity;
  
  // Set the Output State 
  tmpccer |= TIM_OCInitStruct->TIM_OutputState;
    
  if((TIMx == TIM1) || (TIMx == TIM8)|| (TIMx == TIM15)||
     (TIMx == TIM16)|| (TIMx == TIM17))
  begin
    assert_param(IS_TIM_OUTPUTN_STATE(TIM_OCInitStruct->TIM_OutputNState));
    assert_param(IS_TIM_OCN_POLARITY(TIM_OCInitStruct->TIM_OCNPolarity));
    assert_param(IS_TIM_OCNIDLE_STATE(TIM_OCInitStruct->TIM_OCNIdleState));
    assert_param(IS_TIM_OCIDLE_STATE(TIM_OCInitStruct->TIM_OCIdleState));
    
    // Reset the Output N Polarity level 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC1NP));
    // Set the Output N Polarity 
    tmpccer |= TIM_OCInitStruct->TIM_OCNPolarity;
    
    // Reset the Output N State 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC1NE));    
    // Set the Output N State 
    tmpccer |= TIM_OCInitStruct->TIM_OutputNState;
    
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS1));
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS1N));
    
    // Set the Output Idle state 
    tmpcr2 |= TIM_OCInitStruct->TIM_OCIdleState;
    // Set the Output N Idle state 
    tmpcr2 |= TIM_OCInitStruct->TIM_OCNIdleState;
  end;
  // Write to TIMx CR2 
  TIMx->CR2 = tmpcr2;
  
  // Write to TIMx CCMR1 
  TIMx->CCMR1 = tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx->CCR1 = TIM_OCInitStruct->TIM_Pulse; 
 
  // Write to TIMx CCER 
  TIMx->CCER = tmpccer;
end;

*)

//======================================================================
// Initializes the TIMx Channel2 according to the specified
//======================================================================
procedure TIM_OC2Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx, tmpccer, tmpcr2 : word;
begin
  tmpccmrx := 0;
	tmpccer  := 0;
	tmpcr2   := 0;

   // Disable the Channel 2: Reset the CC2E Bit 
  TIMx.CCER := TIMx.CCER AND word(NOT word(TIM_CCER_CC2E));
  
  // Get the TIMx CCER register value   
  tmpccer := TIMx.CCER;
  // Get the TIMx CR2 register value 
  tmpcr2 :=  TIMx.CR2;
  
  // Get the TIMx CCMR1 register value 
  tmpccmrx := TIMx.CCMR1;


  // Reset the Output Compare mode and Capture/Compare selection Bits 
  tmpccmrx := tmpccmrx AND word(NOT word(TIM_CCMR1_OC2M));
  tmpccmrx := tmpccmrx AND word(NOT word(TIM_CCMR1_CC2S));
  // Select the Output Compare Mode 
  tmpccmrx := tmpccmrx OR word(TIM_OCInitStruct.TIM_OCMode SHL 8);
  
  // Reset the Output Polarity level 
  tmpccer := tmpccer AND word(NOT word(TIM_CCER_CC2P));
  // Set the Output Compare Polarity 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OCPolarity shl 4);
  
  // Set the Output State 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OutputState shl 4);
    
  if ((@TIMx = @Timer1) OR (@TIMx = @Timer8)) then
  begin
{    // Reset the Output N Polarity level 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC2NP));
    // Set the Output N Polarity 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OCNPolarity << 4);
    
    // Reset the Output N State 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC2NE));    
    // Set the Output N State 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OutputNState << 4);
    
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS2));
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS2N));
    
    // Set the Output Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCIdleState << 2);
    // Set the Output N Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCNIdleState << 2);}
  end;
  
  // Write to TIMx CR2 
  TIMx.CR2 := tmpcr2;
  
  // Write to TIMx CCMR1 
  TIMx.CCMR1 := tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx.CCR2 := TIM_OCInitStruct.TIM_Pulse;
  
  // Write to TIMx CCER 
  TIMx.CCER := tmpccer;
end;

(*//======================================================================
// Initializes the TIMx Channel2 according to the specified
//======================================================================
procedure TIM_OC2Init(TIM_TypeDef* TIMx, TIM_OCInitTypeDef* TIM_OCInitStruct)
begin
  uint16_t tmpccmrx = 0, tmpccer = 0, tmpcr2 = 0;
   
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx)); 
  assert_param(IS_TIM_OC_MODE(TIM_OCInitStruct->TIM_OCMode));
  assert_param(IS_TIM_OUTPUT_STATE(TIM_OCInitStruct->TIM_OutputState));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCInitStruct->TIM_OCPolarity));   
   // Disable the Channel 2: Reset the CC2E Bit 
  TIMx->CCER &= (uint16_t)(~((uint16_t)TIM_CCER_CC2E));
  
  // Get the TIMx CCER register value   
  tmpccer = TIMx->CCER;
  // Get the TIMx CR2 register value 
  tmpcr2 =  TIMx->CR2;
  
  // Get the TIMx CCMR1 register value 
  tmpccmrx = TIMx->CCMR1;
    
  // Reset the Output Compare mode and Capture/Compare selection Bits 
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR1_OC2M));
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR1_CC2S));
  
  // Select the Output Compare Mode 
  tmpccmrx |= (uint16_t)(TIM_OCInitStruct->TIM_OCMode << 8);
  
  // Reset the Output Polarity level 
  tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC2P));
  // Set the Output Compare Polarity 
  tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OCPolarity << 4);
  
  // Set the Output State 
  tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OutputState << 4);
    
  if((TIMx == TIM1) || (TIMx == TIM8))
  begin
    assert_param(IS_TIM_OUTPUTN_STATE(TIM_OCInitStruct->TIM_OutputNState));
    assert_param(IS_TIM_OCN_POLARITY(TIM_OCInitStruct->TIM_OCNPolarity));
    assert_param(IS_TIM_OCNIDLE_STATE(TIM_OCInitStruct->TIM_OCNIdleState));
    assert_param(IS_TIM_OCIDLE_STATE(TIM_OCInitStruct->TIM_OCIdleState));
    
    // Reset the Output N Polarity level 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC2NP));
    // Set the Output N Polarity 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OCNPolarity << 4);
    
    // Reset the Output N State 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC2NE));    
    // Set the Output N State 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OutputNState << 4);
    
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS2));
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS2N));
    
    // Set the Output Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCIdleState << 2);
    // Set the Output N Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCNIdleState << 2);
  end;
  // Write to TIMx CR2 
  TIMx->CR2 = tmpcr2;
  
  // Write to TIMx CCMR1 
  TIMx->CCMR1 = tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx->CCR2 = TIM_OCInitStruct->TIM_Pulse;
  
  // Write to TIMx CCER 
  TIMx->CCER = tmpccer;
end;

*)

//======================================================================
// Initializes the TIMx Channel3 according to the specified
//======================================================================
procedure TIM_OC3Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx, tmpccer, tmpcr2 : word;
begin
  tmpccmrx := 0;
	tmpccer  := 0;
	tmpcr2   := 0;
   
  // Disable the Channel 2: Reset the CC2E Bit 
  TIMx.CCER := TIMx.CCER AND word(not(word(TIM_CCER_CC3E)));
  
  // Get the TIMx CCER register value 
  tmpccer := TIMx.CCER;
  // Get the TIMx CR2 register value 
  tmpcr2  :=  TIMx.CR2;
  
  // Get the TIMx CCMR2 register value 
  tmpccmrx := TIMx.CCMR2;
    
  // Reset the Output Compare mode and Capture/Compare selection Bits 
  tmpccmrx := tmpccmrx  AND word(not(word($0070)));
  tmpccmrx := tmpccmrx  AND word(not(word($0003)));  
  // Select the Output Compare Mode 
  tmpccmrx := tmpccmrx OR TIM_OCInitStruct.TIM_OCMode;
  
  // Reset the Output Polarity level 
  tmpccer := tmpccer AND word(not(word($0200)));
  // Set the Output Compare Polarity 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OCPolarity shl 8);
  
  // Set the Output State 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OutputState shl 8);
    
  if ((@TIMx = @Timer1) or (@TIMx = @Timer8)) then
  begin
{    // Reset the Output N Polarity level 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC3NP));
    // Set the Output N Polarity 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OCNPolarity << 8);
    // Reset the Output N State 
    tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC3NE));
    
    // Set the Output N State 
    tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OutputNState << 8);
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS3));
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS3N));
    // Set the Output Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCIdleState << 4);
    // Set the Output N Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCNIdleState << 4); }
  end;

  // Write to TIMx CR2 
  TIMx.CR2 := tmpcr2;
  
  // Write to TIMx CCMR2 
  TIMx.CCMR2 := tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx.CCR3 := TIM_OCInitStruct.TIM_Pulse;
  
  // Write to TIMx CCER 
  TIMx.CCER := tmpccer;
end;

(*

//*
  * @brief  Initializes the TIMx Channel4 according to the specified
  *   parameters in the TIM_OCInitStruct.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCInitStruct: pointer to a TIM_OCInitTypeDef structure
  *   that contains the configuration information for the specified TIM peripheral.
  * @retval None
  
procedure TIM_OC4Init(TIM_TypeDef* TIMx, TIM_OCInitTypeDef* TIM_OCInitStruct)
begin
  uint16_t tmpccmrx = 0, tmpccer = 0, tmpcr2 = 0;
   
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx)); 
  assert_param(IS_TIM_OC_MODE(TIM_OCInitStruct->TIM_OCMode));
  assert_param(IS_TIM_OUTPUT_STATE(TIM_OCInitStruct->TIM_OutputState));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCInitStruct->TIM_OCPolarity));   
  // Disable the Channel 2: Reset the CC4E Bit 
  TIMx->CCER &= (uint16_t)(~((uint16_t)TIM_CCER_CC4E));
  
  // Get the TIMx CCER register value 
  tmpccer = TIMx->CCER;
  // Get the TIMx CR2 register value 
  tmpcr2 =  TIMx->CR2;
  
  // Get the TIMx CCMR2 register value 
  tmpccmrx = TIMx->CCMR2;
    
  // Reset the Output Compare mode and Capture/Compare selection Bits 
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR2_OC4M));
  tmpccmrx &= (uint16_t)(~((uint16_t)TIM_CCMR2_CC4S));
  
  // Select the Output Compare Mode 
  tmpccmrx |= (uint16_t)(TIM_OCInitStruct->TIM_OCMode << 8);
  
  // Reset the Output Polarity level 
  tmpccer &= (uint16_t)(~((uint16_t)TIM_CCER_CC4P));
  // Set the Output Compare Polarity 
  tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OCPolarity << 12);
  
  // Set the Output State 
  tmpccer |= (uint16_t)(TIM_OCInitStruct->TIM_OutputState << 12);
    
  if((TIMx == TIM1) || (TIMx == TIM8))
  begin
    assert_param(IS_TIM_OCIDLE_STATE(TIM_OCInitStruct->TIM_OCIdleState));
    // Reset the Ouput Compare IDLE State 
    tmpcr2 &= (uint16_t)(~((uint16_t)TIM_CR2_OIS4));
    // Set the Output Idle state 
    tmpcr2 |= (uint16_t)(TIM_OCInitStruct->TIM_OCIdleState << 6);
  end;
  // Write to TIMx CR2 
  TIMx->CR2 = tmpcr2;
  
  // Write to TIMx CCMR2   
  TIMx->CCMR2 = tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx->CCR4 = TIM_OCInitStruct->TIM_Pulse;
  
  // Write to TIMx CCER 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Initializes the TIM peripheral according to the specified
  *   parameters in the TIM_ICInitStruct.
  * @param  TIMx: where x can be  1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_ICInitStruct: pointer to a TIM_ICInitTypeDef structure
  *   that contains the configuration information for the specified TIM peripheral.
  * @retval None
  
procedure TIM_ICInit(TIM_TypeDef* TIMx, TIM_ICInitTypeDef* TIM_ICInitStruct)
begin
  // Check the parameters 
  assert_param(IS_TIM_CHANNEL(TIM_ICInitStruct->TIM_Channel));
  assert_param(IS_TIM_IC_POLARITY(TIM_ICInitStruct->TIM_ICPolarity));
  assert_param(IS_TIM_IC_SELECTION(TIM_ICInitStruct->TIM_ICSelection));
  assert_param(IS_TIM_IC_PRESCALER(TIM_ICInitStruct->TIM_ICPrescaler));
  assert_param(IS_TIM_IC_FILTER(TIM_ICInitStruct->TIM_ICFilter));
  
  if (TIM_ICInitStruct->TIM_Channel == TIM_Channel_1)
  begin
    assert_param(IS_TIM_LIST8_PERIPH(TIMx));
    // TI1 Configuration 
    TI1_Config(TIMx, TIM_ICInitStruct->TIM_ICPolarity,
               TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
  else if (TIM_ICInitStruct->TIM_Channel == TIM_Channel_2)
  begin
    assert_param(IS_TIM_LIST6_PERIPH(TIMx));
    // TI2 Configuration 
    TI2_Config(TIMx, TIM_ICInitStruct->TIM_ICPolarity,
               TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
  else if (TIM_ICInitStruct->TIM_Channel == TIM_Channel_3)
  begin
    assert_param(IS_TIM_LIST3_PERIPH(TIMx));
    // TI3 Configuration 
    TI3_Config(TIMx,  TIM_ICInitStruct->TIM_ICPolarity,
               TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC3Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
  else
  begin
    assert_param(IS_TIM_LIST3_PERIPH(TIMx));
    // TI4 Configuration 
    TI4_Config(TIMx, TIM_ICInitStruct->TIM_ICPolarity,
               TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC4Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
end;

//*
  * @brief  Configures the TIM peripheral according to the specified
  *   parameters in the TIM_ICInitStruct to measure an external PWM signal.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_ICInitStruct: pointer to a TIM_ICInitTypeDef structure
  *   that contains the configuration information for the specified TIM peripheral.
  * @retval None
  
procedure TIM_PWMIConfig(TIM_TypeDef* TIMx, TIM_ICInitTypeDef* TIM_ICInitStruct)
begin
  uint16_t icoppositepolarity = TIM_ICPolarity_Rising;
  uint16_t icoppositeselection = TIM_ICSelection_DirectTI;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  // Select the Opposite Input Polarity 
  if (TIM_ICInitStruct->TIM_ICPolarity == TIM_ICPolarity_Rising)
  begin
    icoppositepolarity = TIM_ICPolarity_Falling;
  end;
  else
  begin
    icoppositepolarity = TIM_ICPolarity_Rising;
  end;
  // Select the Opposite Input 
  if (TIM_ICInitStruct->TIM_ICSelection == TIM_ICSelection_DirectTI)
  begin
    icoppositeselection = TIM_ICSelection_IndirectTI;
  end;
  else
  begin
    icoppositeselection = TIM_ICSelection_DirectTI;
  end;
  if (TIM_ICInitStruct->TIM_Channel == TIM_Channel_1)
  begin
    // TI1 Configuration 
    TI1_Config(TIMx, TIM_ICInitStruct->TIM_ICPolarity, TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
    // TI2 Configuration 
    TI2_Config(TIMx, icoppositepolarity, icoppositeselection, TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
  else
  begin 
    // TI2 Configuration 
    TI2_Config(TIMx, TIM_ICInitStruct->TIM_ICPolarity, TIM_ICInitStruct->TIM_ICSelection,
               TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
    // TI1 Configuration 
    TI1_Config(TIMx, icoppositepolarity, icoppositeselection, TIM_ICInitStruct->TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct->TIM_ICPrescaler);
  end;
end;

//*
  * @brief  Configures the: Break feature, dead time, Lock level, the OSSI,
  *   the OSSR State and the AOE(automatic output enable).
  * @param  TIMx: where x can be  1 or 8 to select the TIM 
  * @param  TIM_BDTRInitStruct: pointer to a TIM_BDTRInitTypeDef structure that
  *   contains the BDTR Register configuration  information for the TIM peripheral.
  * @retval None
  
procedure TIM_BDTRConfig(TIM_TypeDef* TIMx, TIM_BDTRInitTypeDef *TIM_BDTRInitStruct)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST2_PERIPH(TIMx));
  assert_param(IS_TIM_OSSR_STATE(TIM_BDTRInitStruct->TIM_OSSRState));
  assert_param(IS_TIM_OSSI_STATE(TIM_BDTRInitStruct->TIM_OSSIState));
  assert_param(IS_TIM_LOCK_LEVEL(TIM_BDTRInitStruct->TIM_LOCKLevel));
  assert_param(IS_TIM_BREAK_STATE(TIM_BDTRInitStruct->TIM_Break));
  assert_param(IS_TIM_BREAK_POLARITY(TIM_BDTRInitStruct->TIM_BreakPolarity));
  assert_param(IS_TIM_AUTOMATIC_OUTPUT_STATE(TIM_BDTRInitStruct->TIM_AutomaticOutput));
  // Set the Lock level, the Break enable Bit and the Ploarity, the OSSR State,
     the OSSI State, the dead time value and the Automatic Output Enable Bit 
  TIMx->BDTR = (uint32_t)TIM_BDTRInitStruct->TIM_OSSRState | TIM_BDTRInitStruct->TIM_OSSIState |
             TIM_BDTRInitStruct->TIM_LOCKLevel | TIM_BDTRInitStruct->TIM_DeadTime |
             TIM_BDTRInitStruct->TIM_Break | TIM_BDTRInitStruct->TIM_BreakPolarity |
             TIM_BDTRInitStruct->TIM_AutomaticOutput;
end;

//*
  * @brief  Fills each TIM_TimeBaseInitStruct member with its default value.
  * @param  TIM_TimeBaseInitStruct : pointer to a TIM_TimeBaseInitTypeDef
  *   structure which will be initialized.
  * @retval None
  
procedure TIM_TimeBaseStructInit(TIM_TimeBaseInitTypeDef* TIM_TimeBaseInitStruct)
begin
  // Set the default configuration 
  TIM_TimeBaseInitStruct->TIM_Period = $FFFF;
  TIM_TimeBaseInitStruct->TIM_Prescaler = $0000;
  TIM_TimeBaseInitStruct->TIM_ClockDivision = TIM_CKD_DIV1;
  TIM_TimeBaseInitStruct->TIM_CounterMode = TIM_CounterMode_Up;
  TIM_TimeBaseInitStruct->TIM_RepetitionCounter = $0000;
end;

//*
  * @brief  Fills each TIM_OCInitStruct member with its default value.
  * @param  TIM_OCInitStruct : pointer to a TIM_OCInitTypeDef structure which will
  *   be initialized.
  * @retval None
  
procedure TIM_OCStructInit(TIM_OCInitTypeDef* TIM_OCInitStruct)
begin
  // Set the default configuration 
  TIM_OCInitStruct->TIM_OCMode = TIM_OCMode_Timing;
  TIM_OCInitStruct->TIM_OutputState = TIM_OutputState_Disable;
  TIM_OCInitStruct->TIM_OutputNState = TIM_OutputNState_Disable;
  TIM_OCInitStruct->TIM_Pulse = $0000;
  TIM_OCInitStruct->TIM_OCPolarity = TIM_OCPolarity_High;
  TIM_OCInitStruct->TIM_OCNPolarity = TIM_OCPolarity_High;
  TIM_OCInitStruct->TIM_OCIdleState = TIM_OCIdleState_Reset;
  TIM_OCInitStruct->TIM_OCNIdleState = TIM_OCNIdleState_Reset;
end;

//*
  * @brief  Fills each TIM_ICInitStruct member with its default value.
  * @param  TIM_ICInitStruct : pointer to a TIM_ICInitTypeDef structure which will
  *   be initialized.
  * @retval None
  
procedure TIM_ICStructInit(TIM_ICInitTypeDef* TIM_ICInitStruct)
begin
  // Set the default configuration 
  TIM_ICInitStruct->TIM_Channel = TIM_Channel_1;
  TIM_ICInitStruct->TIM_ICPolarity = TIM_ICPolarity_Rising;
  TIM_ICInitStruct->TIM_ICSelection = TIM_ICSelection_DirectTI;
  TIM_ICInitStruct->TIM_ICPrescaler = TIM_ICPSC_DIV1;
  TIM_ICInitStruct->TIM_ICFilter = $00;
end;

//*
  * @brief  Fills each TIM_BDTRInitStruct member with its default value.
  * @param  TIM_BDTRInitStruct: pointer to a TIM_BDTRInitTypeDef structure which
  *   will be initialized.
  * @retval None
  
procedure TIM_BDTRStructInit(TIM_BDTRInitTypeDef* TIM_BDTRInitStruct)
begin
  // Set the default configuration 
  TIM_BDTRInitStruct->TIM_OSSRState = TIM_OSSRState_Disable;
  TIM_BDTRInitStruct->TIM_OSSIState = TIM_OSSIState_Disable;
  TIM_BDTRInitStruct->TIM_LOCKLevel = TIM_LOCKLevel_OFF;
  TIM_BDTRInitStruct->TIM_DeadTime = $00;
  TIM_BDTRInitStruct->TIM_Break = TIM_Break_Disable;
  TIM_BDTRInitStruct->TIM_BreakPolarity = TIM_BreakPolarity_Low;
  TIM_BDTRInitStruct->TIM_AutomaticOutput = TIM_AutomaticOutput_Disable;
end;

*)

//======================================================================
// Enables or disables the specified TIM peripheral.
//======================================================================
procedure TIM_Cmd(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
  begin
    // Enable the TIM Counter 
    TIMx.CR1 := TIMx.CR1 OR $0001;
  end
  else
  begin
    // Disable the TIM Counter 
    TIMx.CR1 := TIMx.CR1 AND NOT word($0001);
  end;
end;

(*

//*
  * @brief  Enables or disables the TIM peripheral Main Outputs.
  * @param  TIMx: where x can be 1, 8, 15, 16 or 17 to select the TIMx peripheral.
  * @param  NewState: new state of the TIM peripheral Main Outputs.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_CtrlPWMOutputs(TIM_TypeDef* TIMx, FunctionalState NewState)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST2_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Enable the TIM Main Output 
    TIMx->BDTR |= TIM_BDTR_MOE;
  end;
  else
  begin
    // Disable the TIM Main Output 
    TIMx->BDTR &= (uint16_t)(~((uint16_t)TIM_BDTR_MOE));
  end;  
end;
*)

//======================================================================
// Enables or disables the specified TIM interrupts.
//======================================================================
procedure TIM_ITConfig(var TIMx : TTimerRegisters; TIM_IT : word; NewState : TState);
begin  
  if (NewState <> DISABLED) then
  begin
    // Enable the Interrupt sources 
    TIMx.DIER := TIMx.DIER  OR TIM_IT;
  end
  else
  begin
    // Disable the Interrupt sources 
    TIMx.DIER := TIMx.DIER  AND NOT word(TIM_IT);
  end;
end;

(*
//*
  * @brief  Configures the TIMx event to be generate by software.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_EventSource: specifies the event source.
  *   This parameter can be one or more of the following values:	   
  *     @arg TIM_EventSource_Update: Timer update Event source
  *     @arg TIM_EventSource_CC1: Timer Capture Compare 1 Event source
  *     @arg TIM_EventSource_CC2: Timer Capture Compare 2 Event source
  *     @arg TIM_EventSource_CC3: Timer Capture Compare 3 Event source
  *     @arg TIM_EventSource_CC4: Timer Capture Compare 4 Event source
  *     @arg TIM_EventSource_COM: Timer COM event source  
  *     @arg TIM_EventSource_Trigger: Timer Trigger Event source
  *     @arg TIM_EventSource_Break: Timer Break event source
  * @note 
  *   - TIM6 and TIM7 can only generate an update event. 
  *   - TIM_EventSource_COM and TIM_EventSource_Break are used only with TIM1 and TIM8.      
  * @retval None
  
procedure TIM_GenerateEvent(TIM_TypeDef* TIMx, uint16_t TIM_EventSource)
begin 
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_TIM_EVENT_SOURCE(TIM_EventSource));
  
  // Set the event sources 
  TIMx->EGR = TIM_EventSource;
end;

//*
  * @brief  Configures the TIMxs DMA interface.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 15, 16 or 17 to select 
  *   the TIM peripheral.
  * @param  TIM_DMABase: DMA Base address.
  *   This parameter can be one of the following values:
  *     @arg TIM_DMABase_CR, TIM_DMABase_CR2, TIM_DMABase_SMCR,
  *   TIM_DMABase_DIER, TIM1_DMABase_SR, TIM_DMABase_EGR,
  *   TIM_DMABase_CCMR1, TIM_DMABase_CCMR2, TIM_DMABase_CCER,
  *   TIM_DMABase_CNT, TIM_DMABase_PSC, TIM_DMABase_ARR,
  *   TIM_DMABase_RCR, TIM_DMABase_CCR1, TIM_DMABase_CCR2,
  *   TIM_DMABase_CCR3, TIM_DMABase_CCR4, TIM_DMABase_BDTR,
  *   TIM_DMABase_DCR.
  * @param  TIM_DMABurstLength: DMA Burst length.
  *   This parameter can be one value between:
  *   TIM_DMABurstLength_1Byte and TIM_DMABurstLength_18Bytes.
  * @retval None
  
procedure TIM_DMAConfig(TIM_TypeDef* TIMx, uint16_t TIM_DMABase, uint16_t TIM_DMABurstLength)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST4_PERIPH(TIMx));
  assert_param(IS_TIM_DMA_BASE(TIM_DMABase));
  assert_param(IS_TIM_DMA_LENGTH(TIM_DMABurstLength));
  // Set the DMA Base and the DMA Burst Length 
  TIMx->DCR = TIM_DMABase | TIM_DMABurstLength;
end;

//*
  * @brief  Enables or disables the TIMxs DMA Requests.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 6, 7, 8, 15, 16 or 17 
  *   to select the TIM peripheral. 
  * @param  TIM_DMASource: specifies the DMA Request sources.
  *   This parameter can be any combination of the following values:
  *     @arg TIM_DMA_Update: TIM update Interrupt source
  *     @arg TIM_DMA_CC1: TIM Capture Compare 1 DMA source
  *     @arg TIM_DMA_CC2: TIM Capture Compare 2 DMA source
  *     @arg TIM_DMA_CC3: TIM Capture Compare 3 DMA source
  *     @arg TIM_DMA_CC4: TIM Capture Compare 4 DMA source
  *     @arg TIM_DMA_COM: TIM Commutation DMA source
  *     @arg TIM_DMA_Trigger: TIM Trigger DMA source
  * @param  NewState: new state of the DMA Request sources.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_DMACmd(TIM_TypeDef* TIMx, uint16_t TIM_DMASource, FunctionalState NewState)
begin 
  // Check the parameters 
  assert_param(IS_TIM_LIST9_PERIPH(TIMx));
  assert_param(IS_TIM_DMA_SOURCE(TIM_DMASource));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
  begin
    // Enable the DMA sources 
    TIMx->DIER |= TIM_DMASource; 
  end;
  else
  begin
    // Disable the DMA sources 
    TIMx->DIER &= (uint16_t)~TIM_DMASource;
  end;
end;

//*
  * @brief  Configures the TIMx interrnal Clock
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15
  *   to select the TIM peripheral.
  * @retval None
  
*)
//======================================================================
procedure TIM_InternalClockConfig(var TIMx : TTimerRegisters);
begin
  // Disable slave mode to clock the prescaler directly with the internal clock 
  TIMx.SMCR := TIMx.SMCR AND word(NOT word(TIM_SMCR_SMS));
end;

(*//*
  * @brief  Configures the TIMx Internal Trigger as External Clock
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_ITRSource: Trigger source.
  *   This parameter can be one of the following values:
  * @param  TIM_TS_ITR0: Internal Trigger 0
  * @param  TIM_TS_ITR1: Internal Trigger 1
  * @param  TIM_TS_ITR2: Internal Trigger 2
  * @param  TIM_TS_ITR3: Internal Trigger 3
  * @retval None
  
procedure TIM_ITRxExternalClockConfig(TIM_TypeDef* TIMx, uint16_t TIM_InputTriggerSource)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_INTERNAL_TRIGGER_SELECTION(TIM_InputTriggerSource));
  // Select the Internal Trigger 
  TIM_SelectInputTrigger(TIMx, TIM_InputTriggerSource);
  // Select the External clock mode1 
  TIMx->SMCR |= TIM_SlaveMode_External1;
end;

//*
  * @brief  Configures the TIMx Trigger as External Clock
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_TIxExternalCLKSource: Trigger source.
  *   This parameter can be one of the following values:
  *     @arg TIM_TIxExternalCLK1Source_TI1ED: TI1 Edge Detector
  *     @arg TIM_TIxExternalCLK1Source_TI1: Filtered Timer Input 1
  *     @arg TIM_TIxExternalCLK1Source_TI2: Filtered Timer Input 2
  * @param  TIM_ICPolarity: specifies the TIx Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPolarity_Rising
  *     @arg TIM_ICPolarity_Falling
  * @param  ICFilter : specifies the filter value.
  *   This parameter must be a value between $0 and $F.
  * @retval None
  
procedure TIM_TIxExternalClockConfig(TIM_TypeDef* TIMx, uint16_t TIM_TIxExternalCLKSource,
                                uint16_t TIM_ICPolarity, uint16_t ICFilter)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_TIXCLK_SOURCE(TIM_TIxExternalCLKSource));
  assert_param(IS_TIM_IC_POLARITY(TIM_ICPolarity));
  assert_param(IS_TIM_IC_FILTER(ICFilter));
  // Configure the Timer Input Clock Source 
  if (TIM_TIxExternalCLKSource == TIM_TIxExternalCLK1Source_TI2)
  begin
    TI2_Config(TIMx, TIM_ICPolarity, TIM_ICSelection_DirectTI, ICFilter);
  end;
  else
  begin
    TI1_Config(TIMx, TIM_ICPolarity, TIM_ICSelection_DirectTI, ICFilter);
  end;
  // Select the Trigger source 
  TIM_SelectInputTrigger(TIMx, TIM_TIxExternalCLKSource);
  // Select the External clock mode1 
  TIMx->SMCR |= TIM_SlaveMode_External1;
end;

//*
  * @brief  Configures the External clock Mode1
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ExtTRGPrescaler: The external Trigger Prescaler.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPSC_OFF: ETRP Prescaler OFF.
  *     @arg TIM_ExtTRGPSC_DIV2: ETRP frequency divided by 2.
  *     @arg TIM_ExtTRGPSC_DIV4: ETRP frequency divided by 4.
  *     @arg TIM_ExtTRGPSC_DIV8: ETRP frequency divided by 8.
  * @param  TIM_ExtTRGPolarity: The external Trigger Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPolarity_Inverted: active low or falling edge active.
  *     @arg TIM_ExtTRGPolarity_NonInverted: active high or rising edge active.
  * @param  ExtTRGFilter: External Trigger Filter.
  *   This parameter must be a value between $00 and $0F
  * @retval None
  
procedure TIM_ETRClockMode1Config(TIM_TypeDef* TIMx, uint16_t TIM_ExtTRGPrescaler, uint16_t TIM_ExtTRGPolarity,
                             uint16_t ExtTRGFilter)
begin
  uint16_t tmpsmcr = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_EXT_PRESCALER(TIM_ExtTRGPrescaler));
  assert_param(IS_TIM_EXT_POLARITY(TIM_ExtTRGPolarity));
  assert_param(IS_TIM_EXT_FILTER(ExtTRGFilter));
  // Configure the ETR Clock source 
  TIM_ETRConfig(TIMx, TIM_ExtTRGPrescaler, TIM_ExtTRGPolarity, ExtTRGFilter);
  
  // Get the TIMx SMCR register value 
  tmpsmcr = TIMx->SMCR;
  // Reset the SMS Bits 
  tmpsmcr &= (uint16_t)(~((uint16_t)TIM_SMCR_SMS));
  // Select the External clock mode1 
  tmpsmcr |= TIM_SlaveMode_External1;
  // Select the Trigger selection : ETRF 
  tmpsmcr &= (uint16_t)(~((uint16_t)TIM_SMCR_TS));
  tmpsmcr |= TIM_TS_ETRF;
  // Write to TIMx SMCR 
  TIMx->SMCR = tmpsmcr;
end;

//*
  * @brief  Configures the External clock Mode2
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ExtTRGPrescaler: The external Trigger Prescaler.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPSC_OFF: ETRP Prescaler OFF.
  *     @arg TIM_ExtTRGPSC_DIV2: ETRP frequency divided by 2.
  *     @arg TIM_ExtTRGPSC_DIV4: ETRP frequency divided by 4.
  *     @arg TIM_ExtTRGPSC_DIV8: ETRP frequency divided by 8.
  * @param  TIM_ExtTRGPolarity: The external Trigger Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPolarity_Inverted: active low or falling edge active.
  *     @arg TIM_ExtTRGPolarity_NonInverted: active high or rising edge active.
  * @param  ExtTRGFilter: External Trigger Filter.
  *   This parameter must be a value between $00 and $0F
  * @retval None
  
procedure TIM_ETRClockMode2Config(TIM_TypeDef* TIMx, uint16_t TIM_ExtTRGPrescaler, 
                             uint16_t TIM_ExtTRGPolarity, uint16_t ExtTRGFilter)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_EXT_PRESCALER(TIM_ExtTRGPrescaler));
  assert_param(IS_TIM_EXT_POLARITY(TIM_ExtTRGPolarity));
  assert_param(IS_TIM_EXT_FILTER(ExtTRGFilter));
  // Configure the ETR Clock source 
  TIM_ETRConfig(TIMx, TIM_ExtTRGPrescaler, TIM_ExtTRGPolarity, ExtTRGFilter);
  // Enable the External clock mode2 
  TIMx->SMCR |= TIM_SMCR_ECE;
end;

//*
  * @brief  Configures the TIMx External Trigger (ETR).
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ExtTRGPrescaler: The external Trigger Prescaler.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPSC_OFF: ETRP Prescaler OFF.
  *     @arg TIM_ExtTRGPSC_DIV2: ETRP frequency divided by 2.
  *     @arg TIM_ExtTRGPSC_DIV4: ETRP frequency divided by 4.
  *     @arg TIM_ExtTRGPSC_DIV8: ETRP frequency divided by 8.
  * @param  TIM_ExtTRGPolarity: The external Trigger Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ExtTRGPolarity_Inverted: active low or falling edge active.
  *     @arg TIM_ExtTRGPolarity_NonInverted: active high or rising edge active.
  * @param  ExtTRGFilter: External Trigger Filter.
  *   This parameter must be a value between $00 and $0F
  * @retval None
  
procedure TIM_ETRConfig(TIM_TypeDef* TIMx, uint16_t TIM_ExtTRGPrescaler, uint16_t TIM_ExtTRGPolarity,
                   uint16_t ExtTRGFilter)
begin
  uint16_t tmpsmcr = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_EXT_PRESCALER(TIM_ExtTRGPrescaler));
  assert_param(IS_TIM_EXT_POLARITY(TIM_ExtTRGPolarity));
  assert_param(IS_TIM_EXT_FILTER(ExtTRGFilter));
  tmpsmcr = TIMx->SMCR;
  // Reset the ETR Bits 
  tmpsmcr &= SMCR_ETR_Mask;
  // Set the Prescaler, the Filter value and the Polarity 
  tmpsmcr |= (uint16_t)(TIM_ExtTRGPrescaler | (uint16_t)(TIM_ExtTRGPolarity | (uint16_t)(ExtTRGFilter << (uint16_t)8)));
  // Write to TIMx SMCR 
  TIMx->SMCR = tmpsmcr;
end;
*)

//======================================================================
// Configures the TIMx Prescaler.
//======================================================================
procedure TIM_PrescalerConfig(var TIMx : TTimerRegisters; Prescaler : word; TIM_PSCReloadMode : word);
begin
  // Set the Prescaler value 
  TIMx.PSC  := Prescaler;
  // Set or reset the UG Bit 
  TIMx.EGR := TIM_PSCReloadMode;
end;

(*
//*
  * @brief  Specifies the TIMx Counter Mode to be used.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_CounterMode: specifies the Counter Mode to be used
  *   This parameter can be one of the following values:
  *     @arg TIM_CounterMode_Up: TIM Up Counting Mode
  *     @arg TIM_CounterMode_Down: TIM Down Counting Mode
  *     @arg TIM_CounterMode_CenterAligned1: TIM Center Aligned Mode1
  *     @arg TIM_CounterMode_CenterAligned2: TIM Center Aligned Mode2
  *     @arg TIM_CounterMode_CenterAligned3: TIM Center Aligned Mode3
  * @retval None
  
procedure TIM_CounterModeConfig(TIM_TypeDef* TIMx, uint16_t TIM_CounterMode)
begin
  uint16_t tmpcr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_COUNTER_MODE(TIM_CounterMode));
  tmpcr1 = TIMx->CR1;
  // Reset the CMS and DIR Bits 
  tmpcr1 &= (uint16_t)(~((uint16_t)(TIM_CR1_DIR | TIM_CR1_CMS)));
  // Set the Counter Mode 
  tmpcr1 |= TIM_CounterMode;
  // Write to TIMx CR1 register 
  TIMx->CR1 = tmpcr1;
end;

//*
  * @brief  Selects the Input Trigger source
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_InputTriggerSource: The Input Trigger source.
  *   This parameter can be one of the following values:
  *     @arg TIM_TS_ITR0: Internal Trigger 0
  *     @arg TIM_TS_ITR1: Internal Trigger 1
  *     @arg TIM_TS_ITR2: Internal Trigger 2
  *     @arg TIM_TS_ITR3: Internal Trigger 3
  *     @arg TIM_TS_TI1F_ED: TI1 Edge Detector
  *     @arg TIM_TS_TI1FP1: Filtered Timer Input 1
  *     @arg TIM_TS_TI2FP2: Filtered Timer Input 2
  *     @arg TIM_TS_ETRF: External Trigger input
  * @retval None
  
procedure TIM_SelectInputTrigger(TIM_TypeDef* TIMx, uint16_t TIM_InputTriggerSource)
begin
  uint16_t tmpsmcr = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_TRIGGER_SELECTION(TIM_InputTriggerSource));
  // Get the TIMx SMCR register value 
  tmpsmcr = TIMx->SMCR;
  // Reset the TS Bits 
  tmpsmcr &= (uint16_t)(~((uint16_t)TIM_SMCR_TS));
  // Set the Input Trigger source 
  tmpsmcr |= TIM_InputTriggerSource;
  // Write to TIMx SMCR 
  TIMx->SMCR = tmpsmcr;
end;

//*
  * @brief  Configures the TIMx Encoder Interface.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_EncoderMode: specifies the TIMx Encoder Mode.
  *   This parameter can be one of the following values:
  *     @arg TIM_EncoderMode_TI1: Counter counts on TI1FP1 edge depending on TI2FP2 level.
  *     @arg TIM_EncoderMode_TI2: Counter counts on TI2FP2 edge depending on TI1FP1 level.
  *     @arg TIM_EncoderMode_TI12: Counter counts on both TI1FP1 and TI2FP2 edges depending
  *                                on the level of the other input.
  * @param  TIM_IC1Polarity: specifies the IC1 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_ICPolarity_Falling: IC Falling edge.
  *     @arg TIM_ICPolarity_Rising: IC Rising edge.
  * @param  TIM_IC2Polarity: specifies the IC2 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_ICPolarity_Falling: IC Falling edge.
  *     @arg TIM_ICPolarity_Rising: IC Rising edge.
  * @retval None
  
procedure TIM_EncoderInterfaceConfig(TIM_TypeDef* TIMx, uint16_t TIM_EncoderMode,
                                uint16_t TIM_IC1Polarity, uint16_t TIM_IC2Polarity)
begin
  uint16_t tmpsmcr = 0;
  uint16_t tmpccmr1 = 0;
  uint16_t tmpccer = 0;
    
  // Check the parameters 
  assert_param(IS_TIM_LIST5_PERIPH(TIMx));
  assert_param(IS_TIM_ENCODER_MODE(TIM_EncoderMode));
  assert_param(IS_TIM_IC_POLARITY(TIM_IC1Polarity));
  assert_param(IS_TIM_IC_POLARITY(TIM_IC2Polarity));

  // Get the TIMx SMCR register value 
  tmpsmcr = TIMx->SMCR;
  
  // Get the TIMx CCMR1 register value 
  tmpccmr1 = TIMx->CCMR1;
  
  // Get the TIMx CCER register value 
  tmpccer = TIMx->CCER;
  
  // Set the encoder Mode 
  tmpsmcr &= (uint16_t)(~((uint16_t)TIM_SMCR_SMS));
  tmpsmcr |= TIM_EncoderMode;
  
  // Select the Capture Compare 1 and the Capture Compare 2 as input 
  tmpccmr1 &= (uint16_t)(((uint16_t)~((uint16_t)TIM_CCMR1_CC1S)) & (uint16_t)(~((uint16_t)TIM_CCMR1_CC2S)));
  tmpccmr1 |= TIM_CCMR1_CC1S_0 | TIM_CCMR1_CC2S_0;
  
  // Set the TI1 and the TI2 Polarities 
  tmpccer &= (uint16_t)(((uint16_t)~((uint16_t)TIM_CCER_CC1P)) & ((uint16_t)~((uint16_t)TIM_CCER_CC2P)));
  tmpccer |= (uint16_t)(TIM_IC1Polarity | (uint16_t)(TIM_IC2Polarity << (uint16_t)4));
  
  // Write to TIMx SMCR 
  TIMx->SMCR = tmpsmcr;
  // Write to TIMx CCMR1 
  TIMx->CCMR1 = tmpccmr1;
  // Write to TIMx CCER 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Forces the TIMx output 1 waveform to active or inactive level.
  * @param  TIMx: where x can be  1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_ForcedAction: specifies the forced Action to be set to the output waveform.
  *   This parameter can be one of the following values:
  *     @arg TIM_ForcedAction_Active: Force active level on OC1REF
  *     @arg TIM_ForcedAction_InActive: Force inactive level on OC1REF.
  * @retval None
  
procedure TIM_ForcedOC1Config(TIM_TypeDef* TIMx, uint16_t TIM_ForcedAction)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_FORCED_ACTION(TIM_ForcedAction));
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC1M Bits 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC1M);
  // Configure The Forced output Mode 
  tmpccmr1 |= TIM_ForcedAction;
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Forces the TIMx output 2 waveform to active or inactive level.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_ForcedAction: specifies the forced Action to be set to the output waveform.
  *   This parameter can be one of the following values:
  *     @arg TIM_ForcedAction_Active: Force active level on OC2REF
  *     @arg TIM_ForcedAction_InActive: Force inactive level on OC2REF.
  * @retval None
  
procedure TIM_ForcedOC2Config(TIM_TypeDef* TIMx, uint16_t TIM_ForcedAction)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_FORCED_ACTION(TIM_ForcedAction));
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC2M Bits 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC2M);
  // Configure The Forced output Mode 
  tmpccmr1 |= (uint16_t)(TIM_ForcedAction << 8);
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Forces the TIMx output 3 waveform to active or inactive level.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ForcedAction: specifies the forced Action to be set to the output waveform.
  *   This parameter can be one of the following values:
  *     @arg TIM_ForcedAction_Active: Force active level on OC3REF
  *     @arg TIM_ForcedAction_InActive: Force inactive level on OC3REF.
  * @retval None
  
procedure TIM_ForcedOC3Config(TIM_TypeDef* TIMx, uint16_t TIM_ForcedAction)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_FORCED_ACTION(TIM_ForcedAction));
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC1M Bits 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC3M);
  // Configure The Forced output Mode 
  tmpccmr2 |= TIM_ForcedAction;
  // Write to TIMx CCMR2 register 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Forces the TIMx output 4 waveform to active or inactive level.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ForcedAction: specifies the forced Action to be set to the output waveform.
  *   This parameter can be one of the following values:
  *     @arg TIM_ForcedAction_Active: Force active level on OC4REF
  *     @arg TIM_ForcedAction_InActive: Force inactive level on OC4REF.
  * @retval None
  
procedure TIM_ForcedOC4Config(TIM_TypeDef* TIMx, uint16_t TIM_ForcedAction)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_FORCED_ACTION(TIM_ForcedAction));
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC2M Bits 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC4M);
  // Configure The Forced output Mode 
  tmpccmr2 |= (uint16_t)(TIM_ForcedAction << 8);
  // Write to TIMx CCMR2 register 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Enables or disables TIMx peripheral Preload register on ARR.
  * @param  TIMx: where x can be  1 to 17 to select the TIM peripheral.
  * @param  NewState: new state of the TIMx peripheral Preload register
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
*)
//======================================================================
procedure TIM_ARRPreloadConfig(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Set the ARR Preload Bit 
    TIMx.CR1 := TIMx.CR1 OR TIM_CR1_ARPE
  else
    // Reset the ARR Preload Bit 
    TIMx.CR1 := TIMx.CR1 AND NOT TIM_CR1_ARPE;
end;

(*
//*
  * @brief  Selects the TIM peripheral Commutation event.
  * @param  TIMx: where x can be  1, 8, 15, 16 or 17 to select the TIMx peripheral
  * @param  NewState: new state of the Commutation event.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_SelectCOM(TIM_TypeDef* TIMx, FunctionalState NewState)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST2_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Set the COM Bit 
    TIMx->CR2 |= TIM_CR2_CCUS;
  end;
  else
  begin
    // Reset the COM Bit 
    TIMx->CR2 &= (uint16_t)~((uint16_t)TIM_CR2_CCUS);
  end;
end;

//*
  * @brief  Selects the TIMx peripheral Capture Compare DMA source.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 15, 16 or 17 to select 
  *   the TIM peripheral.
  * @param  NewState: new state of the Capture Compare DMA source
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_SelectCCDMA(TIM_TypeDef* TIMx, FunctionalState NewState)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST4_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Set the CCDS Bit 
    TIMx->CR2 |= TIM_CR2_CCDS;
  end;
  else
  begin
    // Reset the CCDS Bit 
    TIMx->CR2 &= (uint16_t)~((uint16_t)TIM_CR2_CCDS);
  end;
end;

//*
  * @brief  Sets or Resets the TIM peripheral Capture Compare Preload Control bit.
  * @param  TIMx: where x can be   1, 2, 3, 4, 5, 8 or 15 
  *   to select the TIMx peripheral
  * @param  NewState: new state of the Capture Compare Preload Control bit
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_CCPreloadControl(TIM_TypeDef* TIMx, FunctionalState NewState)
begin 
  // Check the parameters 
  assert_param(IS_TIM_LIST5_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Set the CCPC Bit 
    TIMx->CR2 |= TIM_CR2_CCPC;
  end;
  else
  begin
    // Reset the CCPC Bit 
    TIMx->CR2 &= (uint16_t)~((uint16_t)TIM_CR2_CCPC);
  end;
end;

//*
  * @brief  Enables or disables the TIMx peripheral Preload register on CCR1.
  * @param  TIMx: where x can be  1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_OCPreload: new state of the TIMx peripheral Preload register
  *   This parameter can be one of the following values:
  *     @arg TIM_OCPreload_Enable
  *     @arg TIM_OCPreload_Disable
  * @retval None
  
procedure TIM_OC1PreloadConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPreload)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_OCPRELOAD_STATE(TIM_OCPreload));
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC1PE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC1PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr1 |= TIM_OCPreload;
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Enables or disables the TIMx peripheral Preload register on CCR2.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15 to select 
  *   the TIM peripheral.
  * @param  TIM_OCPreload: new state of the TIMx peripheral Preload register
  *   This parameter can be one of the following values:
  *     @arg TIM_OCPreload_Enable
  *     @arg TIM_OCPreload_Disable
  * @retval None
  
procedure TIM_OC2PreloadConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPreload)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_OCPRELOAD_STATE(TIM_OCPreload));
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC2PE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC2PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr1 |= (uint16_t)(TIM_OCPreload << 8);
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;
*)
//======================================================================
// Enables or disables the TIMx peripheral Preload register on CCR3.
//======================================================================
procedure TIM_OC3PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC3PE Bit 
  tmpccmr2 := tmpccmr2  AND word(NOT(word($0008)));
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr2 := tmpccmr2  OR TIM_OCPreload;
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;
(*
//*
  * @brief  Enables or disables the TIMx peripheral Preload register on CCR4.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCPreload: new state of the TIMx peripheral Preload register
  *   This parameter can be one of the following values:
  *     @arg TIM_OCPreload_Enable
  *     @arg TIM_OCPreload_Disable
  * @retval None
  
procedure TIM_OC4PreloadConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPreload)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCPRELOAD_STATE(TIM_OCPreload));
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC4PE Bit 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC4PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr2 |= (uint16_t)(TIM_OCPreload << 8);
  // Write to TIMx CCMR2 register 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Configures the TIMx Output Compare 1 Fast feature.
  * @param  TIMx: where x can be  1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_OCFast: new state of the Output Compare Fast Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCFast_Enable: TIM output compare fast enable
  *     @arg TIM_OCFast_Disable: TIM output compare fast disable
  * @retval None
  
procedure TIM_OC1FastConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCFast)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_OCFAST_STATE(TIM_OCFast));
  // Get the TIMx CCMR1 register value 
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC1FE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC1FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr1 |= TIM_OCFast;
  // Write to TIMx CCMR1 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Configures the TIMx Output Compare 2 Fast feature.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5, 8, 9, 12 or 15 to select 
  *   the TIM peripheral.
  * @param  TIM_OCFast: new state of the Output Compare Fast Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCFast_Enable: TIM output compare fast enable
  *     @arg TIM_OCFast_Disable: TIM output compare fast disable
  * @retval None
  
procedure TIM_OC2FastConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCFast)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_OCFAST_STATE(TIM_OCFast));
  // Get the TIMx CCMR1 register value 
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC2FE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC2FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr1 |= (uint16_t)(TIM_OCFast << 8);
  // Write to TIMx CCMR1 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Configures the TIMx Output Compare 3 Fast feature.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCFast: new state of the Output Compare Fast Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCFast_Enable: TIM output compare fast enable
  *     @arg TIM_OCFast_Disable: TIM output compare fast disable
  * @retval None
  
procedure TIM_OC3FastConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCFast)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCFAST_STATE(TIM_OCFast));
  // Get the TIMx CCMR2 register value 
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC3FE Bit 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC3FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr2 |= TIM_OCFast;
  // Write to TIMx CCMR2 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Configures the TIMx Output Compare 4 Fast feature.
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCFast: new state of the Output Compare Fast Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCFast_Enable: TIM output compare fast enable
  *     @arg TIM_OCFast_Disable: TIM output compare fast disable
  * @retval None
  
procedure TIM_OC4FastConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCFast)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCFAST_STATE(TIM_OCFast));
  // Get the TIMx CCMR2 register value 
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC4FE Bit 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC4FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr2 |= (uint16_t)(TIM_OCFast << 8);
  // Write to TIMx CCMR2 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Clears or safeguards the OCREF1 signal on an external event
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCClear: new state of the Output Compare Clear Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCClear_Enable: TIM Output clear enable
  *     @arg TIM_OCClear_Disable: TIM Output clear disable
  * @retval None
  
procedure TIM_ClearOC1Ref(TIM_TypeDef* TIMx, uint16_t TIM_OCClear)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCCLEAR_STATE(TIM_OCClear));

  tmpccmr1 = TIMx->CCMR1;

  // Reset the OC1CE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC1CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr1 |= TIM_OCClear;
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Clears or safeguards the OCREF2 signal on an external event
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCClear: new state of the Output Compare Clear Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCClear_Enable: TIM Output clear enable
  *     @arg TIM_OCClear_Disable: TIM Output clear disable
  * @retval None
  
procedure TIM_ClearOC2Ref(TIM_TypeDef* TIMx, uint16_t TIM_OCClear)
begin
  uint16_t tmpccmr1 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCCLEAR_STATE(TIM_OCClear));
  tmpccmr1 = TIMx->CCMR1;
  // Reset the OC2CE Bit 
  tmpccmr1 &= (uint16_t)~((uint16_t)TIM_CCMR1_OC2CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr1 |= (uint16_t)(TIM_OCClear << 8);
  // Write to TIMx CCMR1 register 
  TIMx->CCMR1 = tmpccmr1;
end;

//*
  * @brief  Clears or safeguards the OCREF3 signal on an external event
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCClear: new state of the Output Compare Clear Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCClear_Enable: TIM Output clear enable
  *     @arg TIM_OCClear_Disable: TIM Output clear disable
  * @retval None
  
procedure TIM_ClearOC3Ref(TIM_TypeDef* TIMx, uint16_t TIM_OCClear)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCCLEAR_STATE(TIM_OCClear));
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC3CE Bit 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC3CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr2 |= TIM_OCClear;
  // Write to TIMx CCMR2 register 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Clears or safeguards the OCREF4 signal on an external event
  * @param  TIMx: where x can be  1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCClear: new state of the Output Compare Clear Enable Bit.
  *   This parameter can be one of the following values:
  *     @arg TIM_OCClear_Enable: TIM Output clear enable
  *     @arg TIM_OCClear_Disable: TIM Output clear disable
  * @retval None
  
procedure TIM_ClearOC4Ref(TIM_TypeDef* TIMx, uint16_t TIM_OCClear)
begin
  uint16_t tmpccmr2 = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OCCLEAR_STATE(TIM_OCClear));
  tmpccmr2 = TIMx->CCMR2;
  // Reset the OC4CE Bit 
  tmpccmr2 &= (uint16_t)~((uint16_t)TIM_CCMR2_OC4CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr2 |= (uint16_t)(TIM_OCClear << 8);
  // Write to TIMx CCMR2 register 
  TIMx->CCMR2 = tmpccmr2;
end;

//*
  * @brief  Configures the TIMx channel 1 polarity.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_OCPolarity: specifies the OC1 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCPolarity_High: Output Compare active high
  *     @arg TIM_OCPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC1PolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCPolarity));
  tmpccer = TIMx->CCER;
  // Set or Reset the CC1P Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC1P);
  tmpccer |= TIM_OCPolarity;
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx Channel 1N polarity.
  * @param  TIMx: where x can be 1, 8, 15, 16 or 17 to select the TIM peripheral.
  * @param  TIM_OCNPolarity: specifies the OC1N Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCNPolarity_High: Output Compare active high
  *     @arg TIM_OCNPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC1NPolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCNPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST2_PERIPH(TIMx));
  assert_param(IS_TIM_OCN_POLARITY(TIM_OCNPolarity));
   
  tmpccer = TIMx->CCER;
  // Set or Reset the CC1NP Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC1NP);
  tmpccer |= TIM_OCNPolarity;
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx channel 2 polarity.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_OCPolarity: specifies the OC2 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCPolarity_High: Output Compare active high
  *     @arg TIM_OCPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC2PolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCPolarity));
  tmpccer = TIMx->CCER;
  // Set or Reset the CC2P Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC2P);
  tmpccer |= (uint16_t)(TIM_OCPolarity << 4);
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx Channel 2N polarity.
  * @param  TIMx: where x can be 1 or 8 to select the TIM peripheral.
  * @param  TIM_OCNPolarity: specifies the OC2N Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCNPolarity_High: Output Compare active high
  *     @arg TIM_OCNPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC2NPolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCNPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST1_PERIPH(TIMx));
  assert_param(IS_TIM_OCN_POLARITY(TIM_OCNPolarity));
  
  tmpccer = TIMx->CCER;
  // Set or Reset the CC2NP Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC2NP);
  tmpccer |= (uint16_t)(TIM_OCNPolarity << 4);
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx channel 3 polarity.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCPolarity: specifies the OC3 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCPolarity_High: Output Compare active high
  *     @arg TIM_OCPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC3PolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCPolarity));
  tmpccer = TIMx->CCER;
  // Set or Reset the CC3P Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC3P);
  tmpccer |= (uint16_t)(TIM_OCPolarity << 8);
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx Channel 3N polarity.
  * @param  TIMx: where x can be 1 or 8 to select the TIM peripheral.
  * @param  TIM_OCNPolarity: specifies the OC3N Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCNPolarity_High: Output Compare active high
  *     @arg TIM_OCNPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC3NPolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCNPolarity)
begin
  uint16_t tmpccer = 0;
 
  // Check the parameters 
  assert_param(IS_TIM_LIST1_PERIPH(TIMx));
  assert_param(IS_TIM_OCN_POLARITY(TIM_OCNPolarity));
    
  tmpccer = TIMx->CCER;
  // Set or Reset the CC3NP Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC3NP);
  tmpccer |= (uint16_t)(TIM_OCNPolarity << 8);
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configures the TIMx channel 4 polarity.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_OCPolarity: specifies the OC4 Polarity
  *   This parmeter can be one of the following values:
  *     @arg TIM_OCPolarity_High: Output Compare active high
  *     @arg TIM_OCPolarity_Low: Output Compare active low
  * @retval None
  
procedure TIM_OC4PolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPolarity)
begin
  uint16_t tmpccer = 0;
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_OC_POLARITY(TIM_OCPolarity));
  tmpccer = TIMx->CCER;
  // Set or Reset the CC4P Bit 
  tmpccer &= (uint16_t)~((uint16_t)TIM_CCER_CC4P);
  tmpccer |= (uint16_t)(TIM_OCPolarity << 12);
  // Write to TIMx CCER register 
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Enables or disables the TIM Capture Compare Channel x.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_Channel: specifies the TIM Channel
  *   This parmeter can be one of the following values:
  *     @arg TIM_Channel_1: TIM Channel 1
  *     @arg TIM_Channel_2: TIM Channel 2
  *     @arg TIM_Channel_3: TIM Channel 3
  *     @arg TIM_Channel_4: TIM Channel 4
  * @param  TIM_CCx: specifies the TIM Channel CCxE bit new state.
  *   This parameter can be: TIM_CCx_Enable or TIM_CCx_Disable. 
  * @retval None
  
procedure TIM_CCxCmd(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_CCx)
begin
  uint16_t tmp = 0;

  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_CHANNEL(TIM_Channel));
  assert_param(IS_TIM_CCX(TIM_CCx));

  tmp = CCER_CCE_Set << TIM_Channel;

  // Reset the CCxE Bit 
  TIMx->CCER &= (uint16_t)~ tmp;

  // Set or reset the CCxE Bit  
  TIMx->CCER |=  (uint16_t)(TIM_CCx << TIM_Channel);
end;

//*
  * @brief  Enables or disables the TIM Capture Compare Channel xN.
  * @param  TIMx: where x can be 1, 8, 15, 16 or 17 to select the TIM peripheral.
  * @param  TIM_Channel: specifies the TIM Channel
  *   This parmeter can be one of the following values:
  *     @arg TIM_Channel_1: TIM Channel 1
  *     @arg TIM_Channel_2: TIM Channel 2
  *     @arg TIM_Channel_3: TIM Channel 3
  * @param  TIM_CCxN: specifies the TIM Channel CCxNE bit new state.
  *   This parameter can be: TIM_CCxN_Enable or TIM_CCxN_Disable. 
  * @retval None
  
procedure TIM_CCxNCmd(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_CCxN)
begin
  uint16_t tmp = 0;

  // Check the parameters 
  assert_param(IS_TIM_LIST2_PERIPH(TIMx));
  assert_param(IS_TIM_COMPLEMENTARY_CHANNEL(TIM_Channel));
  assert_param(IS_TIM_CCXN(TIM_CCxN));

  tmp = CCER_CCNE_Set << TIM_Channel;

  // Reset the CCxNE Bit 
  TIMx->CCER &= (uint16_t) ~tmp;

  // Set or reset the CCxNE Bit  
  TIMx->CCER |=  (uint16_t)(TIM_CCxN << TIM_Channel);
end;

//*
  * @brief  Selects the TIM Ouput Compare Mode.
  * @note   This function disables the selected channel before changing the Ouput
  *         Compare Mode.
  *         User has to enable this channel using TIM_CCxCmd and TIM_CCxNCmd functions.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_Channel: specifies the TIM Channel
  *   This parmeter can be one of the following values:
  *     @arg TIM_Channel_1: TIM Channel 1
  *     @arg TIM_Channel_2: TIM Channel 2
  *     @arg TIM_Channel_3: TIM Channel 3
  *     @arg TIM_Channel_4: TIM Channel 4
  * @param  TIM_OCMode: specifies the TIM Output Compare Mode.
  *   This paramter can be one of the following values:
  *     @arg TIM_OCMode_Timing
  *     @arg TIM_OCMode_Active
  *     @arg TIM_OCMode_Toggle
  *     @arg TIM_OCMode_PWM1
  *     @arg TIM_OCMode_PWM2
  *     @arg TIM_ForcedAction_Active
  *     @arg TIM_ForcedAction_InActive
  * @retval None
  
procedure TIM_SelectOCxM(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_OCMode)
begin
  uint32_t tmp = 0;
  uint16_t tmp1 = 0;

  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_CHANNEL(TIM_Channel));
  assert_param(IS_TIM_OCM(TIM_OCMode));

  tmp = (uint32_t) TIMx;
  tmp += CCMR_Offset;

  tmp1 = CCER_CCE_Set << (uint16_t)TIM_Channel;

  // Disable the Channel: Reset the CCxE Bit 
  TIMx->CCER &= (uint16_t) ~tmp1;

  if((TIM_Channel == TIM_Channel_1) ||(TIM_Channel == TIM_Channel_3))
  begin
    tmp += (TIM_Channel>>1);

    // Reset the OCxM bits in the CCMRx register 
    *(__IO uint32_t * ) tmp &= (uint32_t)~((uint32_t)TIM_CCMR1_OC1M);
   
    // Configure the OCxM bits in the CCMRx register 
    *(__IO uint32_t * ) tmp |= TIM_OCMode;
  end;
  else
  begin
    tmp += (uint16_t)(TIM_Channel - (uint16_t)4)>> (uint16_t)1;

    // Reset the OCxM bits in the CCMRx register 
    *(__IO uint32_t * ) tmp &= (uint32_t)~((uint32_t)TIM_CCMR1_OC2M);
    
    // Configure the OCxM bits in the CCMRx register 
    *(__IO uint32_t * ) tmp |= (uint16_t)(TIM_OCMode << 8);
  end;
end;

//*
  * @brief  Enables or Disables the TIMx Update event.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  NewState: new state of the TIMx UDIS bit
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_UpdateDisableConfig(TIM_TypeDef* TIMx, FunctionalState NewState)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Set the Update Disable Bit 
    TIMx->CR1 |= TIM_CR1_UDIS;
  end;
  else
  begin
    // Reset the Update Disable Bit 
    TIMx->CR1 &= (uint16_t)~((uint16_t)TIM_CR1_UDIS);
  end;
end;

//*
  * @brief  Configures the TIMx Update Request Interrupt source.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_UpdateSource: specifies the Update source.
  *   This parameter can be one of the following values:
  *     @arg TIM_UpdateSource_Regular: Source of update is the counter overflow/underflow
                                       or the setting of UG bit, or an update generation
                                       through the slave mode controller.
  *     @arg TIM_UpdateSource_Global: Source of update is counter overflow/underflow.
  * @retval None
  
procedure TIM_UpdateRequestConfig(TIM_TypeDef* TIMx, uint16_t TIM_UpdateSource)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_TIM_UPDATE_SOURCE(TIM_UpdateSource));
  if (TIM_UpdateSource != TIM_UpdateSource_Global)
  begin
    // Set the URS Bit 
    TIMx->CR1 |= TIM_CR1_URS;
  end;
  else
  begin
    // Reset the URS Bit 
    TIMx->CR1 &= (uint16_t)~((uint16_t)TIM_CR1_URS);
  end;
end;

//*
  * @brief  Enables or disables the TIMxs Hall sensor interface.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  NewState: new state of the TIMx Hall sensor interface.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  
procedure TIM_SelectHallSensor(TIM_TypeDef* TIMx, FunctionalState NewState)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
  begin
    // Set the TI1S Bit 
    TIMx->CR2 |= TIM_CR2_TI1S;
  end;
  else
  begin
    // Reset the TI1S Bit 
    TIMx->CR2 &= (uint16_t)~((uint16_t)TIM_CR2_TI1S);
  end;
end;

//*
  * @brief  Selects the TIMxs One Pulse Mode.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_OPMode: specifies the OPM Mode to be used.
  *   This parameter can be one of the following values:
  *     @arg TIM_OPMode_Single
  *     @arg TIM_OPMode_Repetitive
  * @retval None
  
procedure TIM_SelectOnePulseMode(TIM_TypeDef* TIMx, uint16_t TIM_OPMode)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_TIM_OPM_MODE(TIM_OPMode));
  // Reset the OPM Bit 
  TIMx->CR1 &= (uint16_t)~((uint16_t)TIM_CR1_OPM);
  // Configure the OPM Mode 
  TIMx->CR1 |= TIM_OPMode;
end;

//*
  * @brief  Selects the TIMx Trigger Output Mode.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 6, 7, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_TRGOSource: specifies the Trigger Output source.
  *   This paramter can be one of the following values:
  *
  *  - For all TIMx
  *     @arg TIM_TRGOSource_Reset:  The UG bit in the TIM_EGR register is used as the trigger output (TRGO).
  *     @arg TIM_TRGOSource_Enable: The Counter Enable CEN is used as the trigger output (TRGO).
  *     @arg TIM_TRGOSource_Update: The update event is selected as the trigger output (TRGO).
  *
  *  - For all TIMx except TIM6 and TIM7
  *     @arg TIM_TRGOSource_OC1: The trigger output sends a positive pulse when the CC1IF flag
  *                              is to be set, as soon as a capture or compare match occurs (TRGO).
  *     @arg TIM_TRGOSource_OC1Ref: OC1REF signal is used as the trigger output (TRGO).
  *     @arg TIM_TRGOSource_OC2Ref: OC2REF signal is used as the trigger output (TRGO).
  *     @arg TIM_TRGOSource_OC3Ref: OC3REF signal is used as the trigger output (TRGO).
  *     @arg TIM_TRGOSource_OC4Ref: OC4REF signal is used as the trigger output (TRGO).
  *
  * @retval None
  
procedure TIM_SelectOutputTrigger(TIM_TypeDef* TIMx, uint16_t TIM_TRGOSource)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST7_PERIPH(TIMx));
  assert_param(IS_TIM_TRGO_SOURCE(TIM_TRGOSource));
  // Reset the MMS Bits 
  TIMx->CR2 &= (uint16_t)~((uint16_t)TIM_CR2_MMS);
  // Select the TRGO source 
  TIMx->CR2 |=  TIM_TRGOSource;
end;

//*
  * @brief  Selects the TIMx Slave Mode.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_SlaveMode: specifies the Timer Slave Mode.
  *   This paramter can be one of the following values:
  *     @arg TIM_SlaveMode_Reset: Rising edge of the selected trigger signal (TRGI) re-initializes
  *                               the counter and triggers an update of the registers.
  *     @arg TIM_SlaveMode_Gated:     The counter clock is enabled when the trigger signal (TRGI) is high.
  *     @arg TIM_SlaveMode_Trigger:   The counter starts at a rising edge of the trigger TRGI.
  *     @arg TIM_SlaveMode_External1: Rising edges of the selected trigger (TRGI) clock the counter.
  * @retval None
  
procedure TIM_SelectSlaveMode(TIM_TypeDef* TIMx, uint16_t TIM_SlaveMode)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_SLAVE_MODE(TIM_SlaveMode));
 // Reset the SMS Bits 
  TIMx->SMCR &= (uint16_t)~((uint16_t)TIM_SMCR_SMS);
  // Select the Slave Mode 
  TIMx->SMCR |= TIM_SlaveMode;
end;

//*
  * @brief  Sets or Resets the TIMx Master/Slave Mode.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_MasterSlaveMode: specifies the Timer Master Slave Mode.
  *   This paramter can be one of the following values:
  *     @arg TIM_MasterSlaveMode_Enable: synchronization between the current timer
  *                                      and its slaves (through TRGO).
  *     @arg TIM_MasterSlaveMode_Disable: No action
  * @retval None
  
procedure TIM_SelectMasterSlaveMode(TIM_TypeDef* TIMx, uint16_t TIM_MasterSlaveMode)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_MSM_STATE(TIM_MasterSlaveMode));
  // Reset the MSM Bit 
  TIMx->SMCR &= (uint16_t)~((uint16_t)TIM_SMCR_MSM);
  
  // Set or Reset the MSM Bit 
  TIMx->SMCR |= TIM_MasterSlaveMode;
end;


*)
//======================================================================
// Sets the TIMx Counter Register value
//======================================================================
procedure TIM_SetCounter(var TIMx : TTimerRegisters; Counter : word);
begin
  // Set the Counter Register value 
  TIMx.CNT := Counter;
end;

(*
//*
  * @brief  Sets the TIMx Autoreload Register value
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  Autoreload: specifies the Autoreload register new value.
  * @retval None
  
procedure TIM_SetAutoreload(TIM_TypeDef* TIMx, uint16_t Autoreload)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  // Set the Autoreload Register value 
  TIMx->ARR = Autoreload;
end;

//*
  * @brief  Sets the TIMx Capture Compare1 Register value
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  Compare1: specifies the Capture Compare1 register new value.
  * @retval None
  
procedure TIM_SetCompare1(TIM_TypeDef* TIMx, uint16_t Compare1)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  // Set the Capture Compare1 Register value 
  TIMx->CCR1 = Compare1;
end;

//*
  * @brief  Sets the TIMx Capture Compare2 Register value
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  Compare2: specifies the Capture Compare2 register new value.
  * @retval None
  
procedure TIM_SetCompare2(TIM_TypeDef* TIMx, uint16_t Compare2)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  // Set the Capture Compare2 Register value 
  TIMx->CCR2 = Compare2;
end;

//*
  * @brief  Sets the TIMx Capture Compare3 Register value
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  Compare3: specifies the Capture Compare3 register new value.
  * @retval None
  
procedure TIM_SetCompare3(TIM_TypeDef* TIMx, uint16_t Compare3)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  // Set the Capture Compare3 Register value 
  TIMx->CCR3 = Compare3;
end;

//*
  * @brief  Sets the TIMx Capture Compare4 Register value
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  Compare4: specifies the Capture Compare4 register new value.
  * @retval None
  
procedure TIM_SetCompare4(TIM_TypeDef* TIMx, uint16_t Compare4)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  // Set the Capture Compare4 Register value 
  TIMx->CCR4 = Compare4;
end;

//*
  * @brief  Sets the TIMx Input Capture 1 prescaler.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_ICPSC: specifies the Input Capture1 prescaler new value.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPSC_DIV1: no prescaler
  *     @arg TIM_ICPSC_DIV2: capture is done once every 2 events
  *     @arg TIM_ICPSC_DIV4: capture is done once every 4 events
  *     @arg TIM_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  
procedure TIM_SetIC1Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_IC_PRESCALER(TIM_ICPSC));
  // Reset the IC1PSC Bits 
  TIMx->CCMR1 &= (uint16_t)~((uint16_t)TIM_CCMR1_IC1PSC);
  // Set the IC1PSC value 
  TIMx->CCMR1 |= TIM_ICPSC;
end;

//*
  * @brief  Sets the TIMx Input Capture 2 prescaler.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_ICPSC: specifies the Input Capture2 prescaler new value.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPSC_DIV1: no prescaler
  *     @arg TIM_ICPSC_DIV2: capture is done once every 2 events
  *     @arg TIM_ICPSC_DIV4: capture is done once every 4 events
  *     @arg TIM_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  
procedure TIM_SetIC2Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  assert_param(IS_TIM_IC_PRESCALER(TIM_ICPSC));
  // Reset the IC2PSC Bits 
  TIMx->CCMR1 &= (uint16_t)~((uint16_t)TIM_CCMR1_IC2PSC);
  // Set the IC2PSC value 
  TIMx->CCMR1 |= (uint16_t)(TIM_ICPSC << 8);
end;

//*
  * @brief  Sets the TIMx Input Capture 3 prescaler.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ICPSC: specifies the Input Capture3 prescaler new value.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPSC_DIV1: no prescaler
  *     @arg TIM_ICPSC_DIV2: capture is done once every 2 events
  *     @arg TIM_ICPSC_DIV4: capture is done once every 4 events
  *     @arg TIM_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  
procedure TIM_SetIC3Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_IC_PRESCALER(TIM_ICPSC));
  // Reset the IC3PSC Bits 
  TIMx->CCMR2 &= (uint16_t)~((uint16_t)TIM_CCMR2_IC3PSC);
  // Set the IC3PSC value 
  TIMx->CCMR2 |= TIM_ICPSC;
end;

//*
  * @brief  Sets the TIMx Input Capture 4 prescaler.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ICPSC: specifies the Input Capture4 prescaler new value.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPSC_DIV1: no prescaler
  *     @arg TIM_ICPSC_DIV2: capture is done once every 2 events
  *     @arg TIM_ICPSC_DIV4: capture is done once every 4 events
  *     @arg TIM_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  
procedure TIM_SetIC4Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC)
begin  
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  assert_param(IS_TIM_IC_PRESCALER(TIM_ICPSC));
  // Reset the IC4PSC Bits 
  TIMx->CCMR2 &= (uint16_t)~((uint16_t)TIM_CCMR2_IC4PSC);
  // Set the IC4PSC value 
  TIMx->CCMR2 |= (uint16_t)(TIM_ICPSC << 8);
end;

//*
  * @brief  Sets the TIMx Clock Division value.
  * @param  TIMx: where x can be  1 to 17 except 6 and 7 to select 
  *   the TIM peripheral.
  * @param  TIM_CKD: specifies the clock division value.
  *   This parameter can be one of the following value:
  *     @arg TIM_CKD_DIV1: TDTS = Tck_tim
  *     @arg TIM_CKD_DIV2: TDTS = 2*Tck_tim
  *     @arg TIM_CKD_DIV4: TDTS = 4*Tck_tim
  * @retval None
  
procedure TIM_SetClockDivision(TIM_TypeDef* TIMx, uint16_t TIM_CKD)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  assert_param(IS_TIM_CKD_DIV(TIM_CKD));
  // Reset the CKD Bits 
  TIMx->CR1 &= (uint16_t)~((uint16_t)TIM_CR1_CKD);
  // Set the CKD value 
  TIMx->CR1 |= TIM_CKD;
end;

//*
  * @brief  Gets the TIMx Input Capture 1 value.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @retval Capture Compare 1 Register value.
  
uint16_t TIM_GetCapture1(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST8_PERIPH(TIMx));
  // Get the Capture 1 Register value 
  return TIMx->CCR1;
end;

//*
  * @brief  Gets the TIMx Input Capture 2 value.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @retval Capture Compare 2 Register value.
  
uint16_t TIM_GetCapture2(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST6_PERIPH(TIMx));
  // Get the Capture 2 Register value 
  return TIMx->CCR2;
end;

//*
  * @brief  Gets the TIMx Input Capture 3 value.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @retval Capture Compare 3 Register value.
  
uint16_t TIM_GetCapture3(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx)); 
  // Get the Capture 3 Register value 
  return TIMx->CCR3;
end;

//*
  * @brief  Gets the TIMx Input Capture 4 value.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @retval Capture Compare 4 Register value.
  
uint16_t TIM_GetCapture4(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_LIST3_PERIPH(TIMx));
  // Get the Capture 4 Register value 
  return TIMx->CCR4;
end;

//*
  * @brief  Gets the TIMx Counter value.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @retval Counter Register value.
  
uint16_t TIM_GetCounter(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  // Get the Counter Register value 
  return TIMx->CNT;
end;

//*
  * @brief  Gets the TIMx Prescaler value.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @retval Prescaler Register value.
  
uint16_t TIM_GetPrescaler(TIM_TypeDef* TIMx)
begin
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  // Get the Prescaler Register value 
  return TIMx->PSC;
end;

//*
  * @brief  Checks whether the specified TIM flag is set or not.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_FLAG: specifies the flag to check.
  *   This parameter can be one of the following values:
  *     @arg TIM_FLAG_Update: TIM update Flag
  *     @arg TIM_FLAG_CC1: TIM Capture Compare 1 Flag
  *     @arg TIM_FLAG_CC2: TIM Capture Compare 2 Flag
  *     @arg TIM_FLAG_CC3: TIM Capture Compare 3 Flag
  *     @arg TIM_FLAG_CC4: TIM Capture Compare 4 Flag
  *     @arg TIM_FLAG_COM: TIM Commutation Flag
  *     @arg TIM_FLAG_Trigger: TIM Trigger Flag
  *     @arg TIM_FLAG_Break: TIM Break Flag
  *     @arg TIM_FLAG_CC1OF: TIM Capture Compare 1 overcapture Flag
  *     @arg TIM_FLAG_CC2OF: TIM Capture Compare 2 overcapture Flag
  *     @arg TIM_FLAG_CC3OF: TIM Capture Compare 3 overcapture Flag
  *     @arg TIM_FLAG_CC4OF: TIM Capture Compare 4 overcapture Flag
  * @note
  *   - TIM6 and TIM7 can have only one update flag. 
  *   - TIM9, TIM12 and TIM15 can have only TIM_FLAG_Update, TIM_FLAG_CC1,
  *      TIM_FLAG_CC2 or TIM_FLAG_Trigger. 
  *   - TIM10, TIM11, TIM13, TIM14, TIM16 and TIM17 can have TIM_FLAG_Update or TIM_FLAG_CC1.   
  *   - TIM_FLAG_Break is used only with TIM1, TIM8 and TIM15. 
  *   - TIM_FLAG_COM is used only with TIM1, TIM8, TIM15, TIM16 and TIM17.    
  * @retval The new state of TIM_FLAG (SET or RESET).
  
FlagStatus TIM_GetFlagStatus(TIM_TypeDef* TIMx, uint16_t TIM_FLAG)
begin 
  ITStatus bitstatus = RESET;  
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_TIM_GET_FLAG(TIM_FLAG));
  
  if ((TIMx->SR & TIM_FLAG) != (uint16_t)RESET)
  begin
    bitstatus = SET;
  end;
  else
  begin
    bitstatus = RESET;
  end;
  return bitstatus;
end;

//*
  * @brief  Clears the TIMx's pending flags.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_FLAG: specifies the flag bit to clear.
  *   This parameter can be any combination of the following values:
  *     @arg TIM_FLAG_Update: TIM update Flag
  *     @arg TIM_FLAG_CC1: TIM Capture Compare 1 Flag
  *     @arg TIM_FLAG_CC2: TIM Capture Compare 2 Flag
  *     @arg TIM_FLAG_CC3: TIM Capture Compare 3 Flag
  *     @arg TIM_FLAG_CC4: TIM Capture Compare 4 Flag
  *     @arg TIM_FLAG_COM: TIM Commutation Flag
  *     @arg TIM_FLAG_Trigger: TIM Trigger Flag
  *     @arg TIM_FLAG_Break: TIM Break Flag
  *     @arg TIM_FLAG_CC1OF: TIM Capture Compare 1 overcapture Flag
  *     @arg TIM_FLAG_CC2OF: TIM Capture Compare 2 overcapture Flag
  *     @arg TIM_FLAG_CC3OF: TIM Capture Compare 3 overcapture Flag
  *     @arg TIM_FLAG_CC4OF: TIM Capture Compare 4 overcapture Flag
  * @note
  *   - TIM6 and TIM7 can have only one update flag. 
  *   - TIM9, TIM12 and TIM15 can have only TIM_FLAG_Update, TIM_FLAG_CC1,
  *      TIM_FLAG_CC2 or TIM_FLAG_Trigger. 
  *   - TIM10, TIM11, TIM13, TIM14, TIM16 and TIM17 can have TIM_FLAG_Update or TIM_FLAG_CC1.   
  *   - TIM_FLAG_Break is used only with TIM1, TIM8 and TIM15. 
  *   - TIM_FLAG_COM is used only with TIM1, TIM8, TIM15, TIM16 and TIM17.   
  * @retval None
  
procedure TIM_ClearFlag(TIM_TypeDef* TIMx, uint16_t TIM_FLAG)
begin  
  // Check the parameters 
  assert_param(IS_TIM_ALL_PERIPH(TIMx));
  assert_param(IS_TIM_CLEAR_FLAG(TIM_FLAG));
   
  // Clear the flags 
  TIMx->SR = (uint16_t)~TIM_FLAG;
end;

//*
  * @brief  Checks whether the TIM interrupt has occurred or not.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_IT: specifies the TIM interrupt source to check.
  *   This parameter can be one of the following values:
  *     @arg TIM_IT_Update: TIM update Interrupt source
  *     @arg TIM_IT_CC1: TIM Capture Compare 1 Interrupt source
  *     @arg TIM_IT_CC2: TIM Capture Compare 2 Interrupt source
  *     @arg TIM_IT_CC3: TIM Capture Compare 3 Interrupt source
  *     @arg TIM_IT_CC4: TIM Capture Compare 4 Interrupt source
  *     @arg TIM_IT_COM: TIM Commutation Interrupt source
  *     @arg TIM_IT_Trigger: TIM Trigger Interrupt source
  *     @arg TIM_IT_Break: TIM Break Interrupt source
  * @note
  *   - TIM6 and TIM7 can generate only an update interrupt.
  *   - TIM9, TIM12 and TIM15 can have only TIM_IT_Update, TIM_IT_CC1,
  *      TIM_IT_CC2 or TIM_IT_Trigger. 
  *   - TIM10, TIM11, TIM13, TIM14, TIM16 and TIM17 can have TIM_IT_Update or TIM_IT_CC1.   
  *   - TIM_IT_Break is used only with TIM1, TIM8 and TIM15. 
  *   - TIM_IT_COM is used only with TIM1, TIM8, TIM15, TIM16 and TIM17.  
  * @retval The new state of the TIM_IT(SET or RESET).

*)
//======================================================================
function TIM_GetITStatus(var TIMx : TTimerRegisters; TIM_IT : word) : boolean;
var
  itstatus, itenable : word;
begin
  itstatus := TIMx.SR AND TIM_IT;
  itenable := TIMx.DIER AND TIM_IT;

  if ((itstatus > 0) AND (itenable > 0)) then
	  exit(TRUE)
  else
	  exit(FALSE);		
end;


(*
//*
  * @brief  Clears the TIMx's interrupt pending bits.
  * @param  TIMx: where x can be 1 to 17 to select the TIM peripheral.
  * @param  TIM_IT: specifies the pending bit to clear.
  *   This parameter can be any combination of the following values:
  *     @arg TIM_IT_Update: TIM1 update Interrupt source
  *     @arg TIM_IT_CC1: TIM Capture Compare 1 Interrupt source
  *     @arg TIM_IT_CC2: TIM Capture Compare 2 Interrupt source
  *     @arg TIM_IT_CC3: TIM Capture Compare 3 Interrupt source
  *     @arg TIM_IT_CC4: TIM Capture Compare 4 Interrupt source
  *     @arg TIM_IT_COM: TIM Commutation Interrupt source
  *     @arg TIM_IT_Trigger: TIM Trigger Interrupt source
  *     @arg TIM_IT_Break: TIM Break Interrupt source
  * @note
  *   - TIM6 and TIM7 can generate only an update interrupt.
  *   - TIM9, TIM12 and TIM15 can have only TIM_IT_Update, TIM_IT_CC1,
  *      TIM_IT_CC2 or TIM_IT_Trigger. 
  *   - TIM10, TIM11, TIM13, TIM14, TIM16 and TIM17 can have TIM_IT_Update or TIM_IT_CC1.   
  *   - TIM_IT_Break is used only with TIM1, TIM8 and TIM15. 
  *   - TIM_IT_COM is used only with TIM1, TIM8, TIM15, TIM16 and TIM17.    
  * @retval None
*)
//======================================================================  
procedure TIM_ClearITPendingBit(var TIMx : TTimerRegisters; TIM_IT : word);
begin
  // Clear the IT pending Bit 
  TIMx.SR := word(not(TIM_IT));
end;


(*
//*
  * @brief  Configure the TI1 as Input.
  * @param  TIMx: where x can be 1 to 17 except 6 and 7 to select the TIM peripheral.
  * @param  TIM_ICPolarity : The Input Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPolarity_Rising
  *     @arg TIM_ICPolarity_Falling
  * @param  TIM_ICSelection: specifies the input to be used.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICSelection_DirectTI: TIM Input 1 is selected to be connected to IC1.
  *     @arg TIM_ICSelection_IndirectTI: TIM Input 1 is selected to be connected to IC2.
  *     @arg TIM_ICSelection_TRC: TIM Input 1 is selected to be connected to TRC.
  * @param  TIM_ICFilter: Specifies the Input Capture Filter.
  *   This parameter must be a value between $00 and $0F.
  * @retval None
  
static procedure TI1_Config(TIM_TypeDef* TIMx, uint16_t TIM_ICPolarity, uint16_t TIM_ICSelection,
                       uint16_t TIM_ICFilter)
begin
  uint16_t tmpccmr1 = 0, tmpccer = 0;
  // Disable the Channel 1: Reset the CC1E Bit 
  TIMx->CCER &= (uint16_t)~((uint16_t)TIM_CCER_CC1E);
  tmpccmr1 = TIMx->CCMR1;
  tmpccer = TIMx->CCER;
  // Select the Input and set the filter 
  tmpccmr1 &= (uint16_t)(((uint16_t)~((uint16_t)TIM_CCMR1_CC1S)) & ((uint16_t)~((uint16_t)TIM_CCMR1_IC1F)));
  tmpccmr1 |= (uint16_t)(TIM_ICSelection | (uint16_t)(TIM_ICFilter << (uint16_t)4));
  // Select the Polarity and set the CC1E Bit 
  tmpccer &= (uint16_t)~((uint16_t)(TIM_CCER_CC1P));
  tmpccer |= (uint16_t)(TIM_ICPolarity | (uint16_t)TIM_CCER_CC1E);
  // Write to TIMx CCMR1 and CCER registers 
  TIMx->CCMR1 = tmpccmr1;
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configure the TI2 as Input.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5, 8, 9, 12 or 15 to select the TIM peripheral.
  * @param  TIM_ICPolarity : The Input Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPolarity_Rising
  *     @arg TIM_ICPolarity_Falling
  * @param  TIM_ICSelection: specifies the input to be used.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICSelection_DirectTI: TIM Input 2 is selected to be connected to IC2.
  *     @arg TIM_ICSelection_IndirectTI: TIM Input 2 is selected to be connected to IC1.
  *     @arg TIM_ICSelection_TRC: TIM Input 2 is selected to be connected to TRC.
  * @param  TIM_ICFilter: Specifies the Input Capture Filter.
  *   This parameter must be a value between $00 and $0F.
  * @retval None
  
static procedure TI2_Config(TIM_TypeDef* TIMx, uint16_t TIM_ICPolarity, uint16_t TIM_ICSelection,
                       uint16_t TIM_ICFilter)
begin
  uint16_t tmpccmr1 = 0, tmpccer = 0, tmp = 0;
  // Disable the Channel 2: Reset the CC2E Bit 
  TIMx->CCER &= (uint16_t)~((uint16_t)TIM_CCER_CC2E);
  tmpccmr1 = TIMx->CCMR1;
  tmpccer = TIMx->CCER;
  tmp = (uint16_t)(TIM_ICPolarity << 4);
  // Select the Input and set the filter 
  tmpccmr1 &= (uint16_t)(((uint16_t)~((uint16_t)TIM_CCMR1_CC2S)) & ((uint16_t)~((uint16_t)TIM_CCMR1_IC2F)));
  tmpccmr1 |= (uint16_t)(TIM_ICFilter << 12);
  tmpccmr1 |= (uint16_t)(TIM_ICSelection << 8);
  // Select the Polarity and set the CC2E Bit 
   tmpccer &= (uint16_t)~((uint16_t)(TIM_CCER_CC2P));
  tmpccer |=  (uint16_t)(tmp | (uint16_t)TIM_CCER_CC2E);
  // Write to TIMx CCMR1 and CCER registers 
  TIMx->CCMR1 = tmpccmr1 ;
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configure the TI3 as Input.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ICPolarity : The Input Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPolarity_Rising
  *     @arg TIM_ICPolarity_Falling
  * @param  TIM_ICSelection: specifies the input to be used.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICSelection_DirectTI: TIM Input 3 is selected to be connected to IC3.
  *     @arg TIM_ICSelection_IndirectTI: TIM Input 3 is selected to be connected to IC4.
  *     @arg TIM_ICSelection_TRC: TIM Input 3 is selected to be connected to TRC.
  * @param  TIM_ICFilter: Specifies the Input Capture Filter.
  *   This parameter must be a value between $00 and $0F.
  * @retval None
  
static procedure TI3_Config(TIM_TypeDef* TIMx, uint16_t TIM_ICPolarity, uint16_t TIM_ICSelection,
                       uint16_t TIM_ICFilter)
begin
  uint16_t tmpccmr2 = 0, tmpccer = 0, tmp = 0;
  // Disable the Channel 3: Reset the CC3E Bit 
  TIMx->CCER &= (uint16_t)~((uint16_t)TIM_CCER_CC3E);
  tmpccmr2 = TIMx->CCMR2;
  tmpccer = TIMx->CCER;
  tmp = (uint16_t)(TIM_ICPolarity << 8);
  // Select the Input and set the filter 
  tmpccmr2 &= (uint16_t)(((uint16_t)~((uint16_t)TIM_CCMR2_CC3S)) & ((uint16_t)~((uint16_t)TIM_CCMR2_IC3F)));
  tmpccmr2 |= (uint16_t)(TIM_ICSelection | (uint16_t)(TIM_ICFilter << (uint16_t)4));
  // Select the Polarity and set the CC3E Bit 
  tmpccer &= (uint16_t)~((uint16_t)(TIM_CCER_CC3P));
  tmpccer |= (uint16_t)(tmp | (uint16_t)TIM_CCER_CC3E);
  // Write to TIMx CCMR2 and CCER registers 
  TIMx->CCMR2 = tmpccmr2;
  TIMx->CCER = tmpccer;
end;

//*
  * @brief  Configure the TI1 as Input.
  * @param  TIMx: where x can be 1, 2, 3, 4, 5 or 8 to select the TIM peripheral.
  * @param  TIM_ICPolarity : The Input Polarity.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICPolarity_Rising
  *     @arg TIM_ICPolarity_Falling
  * @param  TIM_ICSelection: specifies the input to be used.
  *   This parameter can be one of the following values:
  *     @arg TIM_ICSelection_DirectTI: TIM Input 4 is selected to be connected to IC4.
  *     @arg TIM_ICSelection_IndirectTI: TIM Input 4 is selected to be connected to IC3.
  *     @arg TIM_ICSelection_TRC: TIM Input 4 is selected to be connected to TRC.
  * @param  TIM_ICFilter: Specifies the Input Capture Filter.
  *   This parameter must be a value between $00 and $0F.
  * @retval None
  
static procedure TI4_Config(TIM_TypeDef* TIMx, uint16_t TIM_ICPolarity, uint16_t TIM_ICSelection,
                       uint16_t TIM_ICFilter)
begin
  uint16_t tmpccmr2 = 0, tmpccer = 0, tmp = 0;

   // Disable the Channel 4: Reset the CC4E Bit 
  TIMx->CCER &= (uint16_t)~((uint16_t)TIM_CCER_CC4E);
  tmpccmr2 = TIMx->CCMR2;
  tmpccer = TIMx->CCER;
  tmp = (uint16_t)(TIM_ICPolarity << 12);
  // Select the Input and set the filter 
  tmpccmr2 &= (uint16_t)((uint16_t)(~(uint16_t)TIM_CCMR2_CC4S) & ((uint16_t)~((uint16_t)TIM_CCMR2_IC4F)));
  tmpccmr2 |= (uint16_t)(TIM_ICSelection << 8);
  tmpccmr2 |= (uint16_t)(TIM_ICFilter << 12);

  // Select the Polarity and set the CC4E Bit 
  tmpccer &= (uint16_t)~((uint16_t)(TIM_CCER_CC4P));
  tmpccer |= (uint16_t)(tmp | (uint16_t)TIM_CCER_CC4E);
  // Write to TIMx CCMR2 and CCER registers 
  TIMx->CCMR2 = tmpccmr2;
  TIMx->CCER = tmpccer;
end;

//*
  * @end;
  

//*
  * @end;
  

//*
  * @end;
  

//****************** (C) COPYRIGHT 2010 STMicroelectronics *****END OF FILE*** *)

end.
