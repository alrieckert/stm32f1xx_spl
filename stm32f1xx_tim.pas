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

// Bit definition for TIM_CR1 register
  TIM_CR1_CEN                        = $0001; //  Counter enable
  TIM_CR1_UDIS                       = $0002; //  Update disable
  TIM_CR1_URS                        = $0004; //  Update request source
  TIM_CR1_OPM                        = $0008; //  One pulse mode
  TIM_CR1_DIR                        = $0010; //  Direction

  TIM_CR1_CMS                        = $0060; //  CMS[1:0] bits (Center-aligned mode selection)
  TIM_CR1_CMS_0                      = $0020; //  Bit 0
  TIM_CR1_CMS_1                      = $0040; //  Bit 1

  TIM_CR1_ARPE                       = $0080; //  Auto-reload preload enable

  TIM_CR1_CKD                        = $0300; //  CKD[1:0] bits (clock division)
  TIM_CR1_CKD_0                      = $0100; //  Bit 0
  TIM_CR1_CKD_1                      = $0200; //  Bit 1

// Bit definition for TIM_CR2 register 
  TIM_CR2_CCPC                       = $0001; //  Capture/Compare Preloaded Control
  TIM_CR2_CCUS                       = $0004; //  Capture/Compare Control Update Selection
  TIM_CR2_CCDS                       = $0008; //  Capture/Compare DMA Selection

  TIM_CR2_MMS                        = $0070; //  MMS[2:0] bits (Master Mode Selection)
  TIM_CR2_MMS_0                      = $0010; //  Bit 0
  TIM_CR2_MMS_1                      = $0020; //  Bit 1
  TIM_CR2_MMS_2                      = $0040; //  Bit 2

  TIM_CR2_TI1S                       = $0080; //  TI1 Selection
  TIM_CR2_OIS1                       = $0100; //  Output Idle state 1 (OC1 output)
  TIM_CR2_OIS1N                      = $0200; //  Output Idle state 1 (OC1N output)
  TIM_CR2_OIS2                       = $0400; //  Output Idle state 2 (OC2 output)
  TIM_CR2_OIS2N                      = $0800; //  Output Idle state 2 (OC2N output)
  TIM_CR2_OIS3                       = $1000; //  Output Idle state 3 (OC3 output)
  TIM_CR2_OIS3N                      = $2000; //  Output Idle state 3 (OC3N output)
  TIM_CR2_OIS4                       = $4000; //  Output Idle state 4 (OC4 output)

// Bit definition for TIM_SMCR register  
  TIM_SMCR_SMS                       = $0007; //  SMS[2:0] bits (Slave mode selection)
  TIM_SMCR_SMS_0                     = $0001; //  Bit 0
  TIM_SMCR_SMS_1                     = $0002; //  Bit 1
  TIM_SMCR_SMS_2                     = $0004; //  Bit 2

  TIM_SMCR_TS                        = $0070; //  TS[2:0] bits (Trigger selection)
  TIM_SMCR_TS_0                      = $0010; //  Bit 0
  TIM_SMCR_TS_1                      = $0020; //  Bit 1
  TIM_SMCR_TS_2                      = $0040; //  Bit 2

  TIM_SMCR_MSM                       = $0080; //  Master/slave mode

  TIM_SMCR_ETF                       = $0F00; //  ETF[3:0] bits (External trigger filter)
  TIM_SMCR_ETF_0                     = $0100; //  Bit 0
  TIM_SMCR_ETF_1                     = $0200; //  Bit 1
  TIM_SMCR_ETF_2                     = $0400; //  Bit 2
  TIM_SMCR_ETF_3                     = $0800; //  Bit 3

  TIM_SMCR_ETPS                      = $3000; //  ETPS[1:0] bits (External trigger prescaler)
  TIM_SMCR_ETPS_0                    = $1000; //  Bit 0
  TIM_SMCR_ETPS_1                    = $2000; //  Bit 1

  TIM_SMCR_ECE                       = $4000; //  External clock enable
  TIM_SMCR_ETP                       = $8000; //  External trigger polarity

// Bit definition for TIM_DIER register  
  TIM_DIER_UIE                       = $0001; //  Update interrupt enable
  TIM_DIER_CC1IE                     = $0002; //  Capture/Compare 1 interrupt enable
  TIM_DIER_CC2IE                     = $0004; //  Capture/Compare 2 interrupt enable
  TIM_DIER_CC3IE                     = $0008; //  Capture/Compare 3 interrupt enable
  TIM_DIER_CC4IE                     = $0010; //  Capture/Compare 4 interrupt enable
  TIM_DIER_COMIE                     = $0020; //  COM interrupt enable
  TIM_DIER_TIE                       = $0040; //  Trigger interrupt enable
  TIM_DIER_BIE                       = $0080; //  Break interrupt enable
  TIM_DIER_UDE                       = $0100; //  Update DMA request enable
  TIM_DIER_CC1DE                     = $0200; //  Capture/Compare 1 DMA request enable
  TIM_DIER_CC2DE                     = $0400; //  Capture/Compare 2 DMA request enable
  TIM_DIER_CC3DE                     = $0800; //  Capture/Compare 3 DMA request enable
  TIM_DIER_CC4DE                     = $1000; //  Capture/Compare 4 DMA request enable
  TIM_DIER_COMDE                     = $2000; //  COM DMA request enable
  TIM_DIER_TDE                       = $4000; //  Trigger DMA request enable

// Bit definition for TIM_SR register
  TIM_SR_UIF                         = $0001; //  Update interrupt Flag
  TIM_SR_CC1IF                       = $0002; //  Capture/Compare 1 interrupt Flag
  TIM_SR_CC2IF                       = $0004; //  Capture/Compare 2 interrupt Flag
  TIM_SR_CC3IF                       = $0008; //  Capture/Compare 3 interrupt Flag
  TIM_SR_CC4IF                       = $0010; //  Capture/Compare 4 interrupt Flag
  TIM_SR_COMIF                       = $0020; //  COM interrupt Flag
  TIM_SR_TIF                         = $0040; //  Trigger interrupt Flag
  TIM_SR_BIF                         = $0080; //  Break interrupt Flag
  TIM_SR_CC1OF                       = $0200; //  Capture/Compare 1 Overcapture Flag
  TIM_SR_CC2OF                       = $0400; //  Capture/Compare 2 Overcapture Flag
  TIM_SR_CC3OF                       = $0800; //  Capture/Compare 3 Overcapture Flag
  TIM_SR_CC4OF                       = $1000; //  Capture/Compare 4 Overcapture Flag

// Bit definition for TIM_EGR register
  TIM_EGR_UG                         = $01;   //  Update Generation
  TIM_EGR_CC1G                       = $02;   //  Capture/Compare 1 Generation
  TIM_EGR_CC2G                       = $04;   //  Capture/Compare 2 Generation
  TIM_EGR_CC3G                       = $08;   //  Capture/Compare 3 Generation
  TIM_EGR_CC4G                       = $10;   //  Capture/Compare 4 Generation
  TIM_EGR_COMG                       = $20;   //  Capture/Compare Control Update Generation
  TIM_EGR_TG                         = $40;   //  Trigger Generation
  TIM_EGR_BG                         = $80;   //  Break Generation

// Bit definition for TIM_CCMR1 register  
  TIM_CCMR1_CC1S                     = $0003; //  CC1S[1:0] bits (Capture/Compare 1 Selection)
  TIM_CCMR1_CC1S_0                   = $0001; //  Bit 0
  TIM_CCMR1_CC1S_1                   = $0002; //  Bit 1

  TIM_CCMR1_OC1FE                    = $0004; //  Output Compare 1 Fast enable
  TIM_CCMR1_OC1PE                    = $0008; //  Output Compare 1 Preload enable

  TIM_CCMR1_OC1M                     = $0070; //  OC1M[2:0] bits (Output Compare 1 Mode)
  TIM_CCMR1_OC1M_0                   = $0010; //  Bit 0
  TIM_CCMR1_OC1M_1                   = $0020; //  Bit 1
  TIM_CCMR1_OC1M_2                   = $0040; //  Bit 2

  TIM_CCMR1_OC1CE                    = $0080; //  Output Compare 1Clear Enable

  TIM_CCMR1_CC2S                     = $0300; //  CC2S[1:0] bits (Capture/Compare 2 Selection)
  TIM_CCMR1_CC2S_0                   = $0100; //  Bit 0
  TIM_CCMR1_CC2S_1                   = $0200; //  Bit 1

  TIM_CCMR1_OC2FE                    = $0400; //  Output Compare 2 Fast enable
  TIM_CCMR1_OC2PE                    = $0800; //  Output Compare 2 Preload enable

  TIM_CCMR1_OC2M                     = $7000; //  OC2M[2:0] bits (Output Compare 2 Mode)
  TIM_CCMR1_OC2M_0                   = $1000; //  Bit 0
  TIM_CCMR1_OC2M_1                   = $2000; //  Bit 1
  TIM_CCMR1_OC2M_2                   = $4000; //  Bit 2

  TIM_CCMR1_OC2CE                    = $8000; //  Output Compare 2 Clear Enable

  TIM_CCMR1_IC1PSC                   = $000C; //  IC1PSC[1:0] bits (Input Capture 1 Prescaler)
  TIM_CCMR1_IC1PSC_0                 = $0004; //  Bit 0
  TIM_CCMR1_IC1PSC_1                 = $0008; //  Bit 1

  TIM_CCMR1_IC1F                     = $00F0; //  IC1F[3:0] bits (Input Capture 1 Filter)
  TIM_CCMR1_IC1F_0                   = $0010; //  Bit 0
  TIM_CCMR1_IC1F_1                   = $0020; //  Bit 1
  TIM_CCMR1_IC1F_2                   = $0040; //  Bit 2
  TIM_CCMR1_IC1F_3                   = $0080; //  Bit 3

  TIM_CCMR1_IC2PSC                   = $0C00; //  IC2PSC[1:0] bits (Input Capture 2 Prescaler)
  TIM_CCMR1_IC2PSC_0                 = $0400; //  Bit 0
  TIM_CCMR1_IC2PSC_1                 = $0800; //  Bit 1

  TIM_CCMR1_IC2F                     = $F000; //  IC2F[3:0] bits (Input Capture 2 Filter)
  TIM_CCMR1_IC2F_0                   = $1000; //  Bit 0
  TIM_CCMR1_IC2F_1                   = $2000; //  Bit 1
  TIM_CCMR1_IC2F_2                   = $4000; //  Bit 2
  TIM_CCMR1_IC2F_3                   = $8000; //  Bit 3

//  Bit definition for TIM_CCMR2 register  
  TIM_CCMR2_CC3S                     = $0003; //  CC3S[1:0] bits (Capture/Compare 3 Selection)
  TIM_CCMR2_CC3S_0                   = $0001; //  Bit 0
  TIM_CCMR2_CC3S_1                   = $0002; //  Bit 1

  TIM_CCMR2_OC3FE                    = $0004; //  Output Compare 3 Fast enable
  TIM_CCMR2_OC3PE                    = $0008; //  Output Compare 3 Preload enable

  TIM_CCMR2_OC3M                     = $0070; //  OC3M[2:0] bits (Output Compare 3 Mode)
  TIM_CCMR2_OC3M_0                   = $0010; //  Bit 0
  TIM_CCMR2_OC3M_1                   = $0020; //  Bit 1
  TIM_CCMR2_OC3M_2                   = $0040; //  Bit 2

  TIM_CCMR2_OC3CE                    = $0080; //  Output Compare 3 Clear Enable

  TIM_CCMR2_CC4S                     = $0300; //  CC4S[1:0] bits (Capture/Compare 4 Selection)
  TIM_CCMR2_CC4S_0                   = $0100; //  Bit 0
  TIM_CCMR2_CC4S_1                   = $0200; //  Bit 1

  TIM_CCMR2_OC4FE                    = $0400; //  Output Compare 4 Fast enable
  TIM_CCMR2_OC4PE                    = $0800; //  Output Compare 4 Preload enable

  TIM_CCMR2_OC4M                     = $7000; //  OC4M[2:0] bits (Output Compare 4 Mode)
  TIM_CCMR2_OC4M_0                   = $1000; //  Bit 0
  TIM_CCMR2_OC4M_1                   = $2000; //  Bit 1
  TIM_CCMR2_OC4M_2                   = $4000; //  Bit 2

  TIM_CCMR2_OC4CE                    = $8000; //  Output Compare 4 Clear Enable

  TIM_CCMR2_IC3PSC                   = $000C; //  IC3PSC[1:0] bits (Input Capture 3 Prescaler)
  TIM_CCMR2_IC3PSC_0                 = $0004; //  Bit 0
  TIM_CCMR2_IC3PSC_1                 = $0008; //  Bit 1

  TIM_CCMR2_IC3F                     = $00F0; //  IC3F[3:0] bits (Input Capture 3 Filter)
  TIM_CCMR2_IC3F_0                   = $0010; //  Bit 0
  TIM_CCMR2_IC3F_1                   = $0020; //  Bit 1
  TIM_CCMR2_IC3F_2                   = $0040; //  Bit 2
  TIM_CCMR2_IC3F_3                   = $0080; //  Bit 3

  TIM_CCMR2_IC4PSC                   = $0C00; //  IC4PSC[1:0] bits (Input Capture 4 Prescaler)
  TIM_CCMR2_IC4PSC_0                 = $0400; //  Bit 0
  TIM_CCMR2_IC4PSC_1                 = $0800; //  Bit 1

  TIM_CCMR2_IC4F                     = $F000; //  IC4F[3:0] bits (Input Capture 4 Filter)
  TIM_CCMR2_IC4F_0                   = $1000; //  Bit 0
  TIM_CCMR2_IC4F_1                   = $2000; //  Bit 1
  TIM_CCMR2_IC4F_2                   = $4000; //  Bit 2
  TIM_CCMR2_IC4F_3                   = $8000; //  Bit 3

// Bit definition for TIM_CCER register  
  TIM_CCER_CC1E                      = $0001; //  Capture/Compare 1 output enable
  TIM_CCER_CC1P                      = $0002; //  Capture/Compare 1 output Polarity
  TIM_CCER_CC1NE                     = $0004; //  Capture/Compare 1 Complementary output enable
  TIM_CCER_CC1NP                     = $0008; //  Capture/Compare 1 Complementary output Polarity
  TIM_CCER_CC2E                      = $0010; //  Capture/Compare 2 output enable
  TIM_CCER_CC2P                      = $0020; //  Capture/Compare 2 output Polarity
  TIM_CCER_CC2NE                     = $0040; //  Capture/Compare 2 Complementary output enable
  TIM_CCER_CC2NP                     = $0080; //  Capture/Compare 2 Complementary output Polarity
  TIM_CCER_CC3E                      = $0100; //  Capture/Compare 3 output enable
  TIM_CCER_CC3P                      = $0200; //  Capture/Compare 3 output Polarity
  TIM_CCER_CC3NE                     = $0400; //  Capture/Compare 3 Complementary output enable
  TIM_CCER_CC3NP                     = $0800; //  Capture/Compare 3 Complementary output Polarity
  TIM_CCER_CC4E                      = $1000; //  Capture/Compare 4 output enable
  TIM_CCER_CC4P                      = $2000; //  Capture/Compare 4 output Polarity
  TIM_CCER_CC4NP                     = $8000; //  Capture/Compare 4 Complementary output Polarity

//  Bit definition for TIM_CNT register 
  TIM_CNT_CNT                        = $FFFF; //  Counter Value

//  Bit definition for TIM_PSC register 
  TIM_PSC_PSC                        = $FFFF; //  Prescaler Value

//  Bit definition for TIM_ARR register 
  TIM_ARR_ARR                        = $FFFF; //  actual auto-reload Value

//  Bit definition for TIM_RCR register 
  TIM_RCR_REP                        = $FF;   // Repetition Counter Value

//  Bit definition for TIM_CCR1 register  
  TIM_CCR1_CCR1                      = $FFFF; //  Capture/Compare 1 Value

//  Bit definition for TIM_CCR2 register  
  TIM_CCR2_CCR2                      = $FFFF; //  Capture/Compare 2 Value

//  Bit definition for TIM_CCR3 register  
  TIM_CCR3_CCR3                      = $FFFF; //  Capture/Compare 3 Value

//  Bit definition for TIM_CCR4 register  
  TIM_CCR4_CCR4                      = $FFFF; //  Capture/Compare 4 Value

//  Bit definition for TIM_BDTR register  
  TIM_BDTR_DTG                       = $00FF; //  DTG[0:7] bits (Dead-Time Generator set-up)
  TIM_BDTR_DTG_0                     = $0001; //  Bit 0
  TIM_BDTR_DTG_1                     = $0002; //  Bit 1
  TIM_BDTR_DTG_2                     = $0004; //  Bit 2
  TIM_BDTR_DTG_3                     = $0008; //  Bit 3
  TIM_BDTR_DTG_4                     = $0010; //  Bit 4
  TIM_BDTR_DTG_5                     = $0020; //  Bit 5
  TIM_BDTR_DTG_6                     = $0040; //  Bit 6
  TIM_BDTR_DTG_7                     = $0080; //  Bit 7

  TIM_BDTR_LOCK                      = $0300; //  LOCK[1:0] bits (Lock Configuration)
  TIM_BDTR_LOCK_0                    = $0100; //  Bit 0
  TIM_BDTR_LOCK_1                    = $0200; //  Bit 1

  TIM_BDTR_OSSI                      = $0400; //  Off-State Selection for Idle mode
  TIM_BDTR_OSSR                      = $0800; //  Off-State Selection for Run mode
  TIM_BDTR_BKE                       = $1000; //  Break enable
  TIM_BDTR_BKP                       = $2000; //  Break Polarity
  TIM_BDTR_AOE                       = $4000; //  Automatic Output enable
  TIM_BDTR_MOE                       = $8000; //  Main Output enable

//  Bit definition for TIM_DCR register  
  TIM_DCR_DBA                        = $001F; //  DBA[4:0] bits (DMA Base Address)
  TIM_DCR_DBA_0                      = $0001; //  Bit 0
  TIM_DCR_DBA_1                      = $0002; //  Bit 1
  TIM_DCR_DBA_2                      = $0004; //  Bit 2
  TIM_DCR_DBA_3                      = $0008; //  Bit 3
  TIM_DCR_DBA_4                      = $0010; //  Bit 4

  TIM_DCR_DBL                        = $1F00; //  DBL[4:0] bits (DMA Burst Length)
  TIM_DCR_DBL_0                      = $0100; //  Bit 0
  TIM_DCR_DBL_1                      = $0200; //  Bit 1
  TIM_DCR_DBL_2                      = $0400; //  Bit 2
  TIM_DCR_DBL_3                      = $0800; //  Bit 3
  TIM_DCR_DBL_4                      = $1000; //  Bit 4

//  Bit definition for TIM_DMAR register  
  TIM_DMAR_DMAB                      = $FFFF; //  DMA register for burst accesses


//======================================================================
procedure TIM_TimeBaseInit(var TIMx : TTimerRegisters; var TIM_TimeBaseInitStruct : TTIM_TimeBaseInit);
procedure TIM_PrescalerConfig(var TIMx : TTimerRegisters; Prescaler : word; TIM_PSCReloadMode : word);

procedure TIM_ITConfig(var TIMx : TTimerRegisters; TIM_IT : word; NewState : TState);
procedure TIM_Cmd(var TIMx : TTimerRegisters; NewState : TState);
function TIM_GetITStatus(var TIMx : TTimerRegisters; TIM_IT : word) : boolean;
procedure TIM_ClearITPendingBit(var TIMx : TTimerRegisters; TIM_IT : word);
procedure TIM_SetCounter(var TIMx : TTimerRegisters; Counter : word);
procedure TIM_InternalClockConfig(var TIMx : TTimerRegisters);
procedure TIM_ARRPreloadConfig(var TIMx : TTimerRegisters; NewState : TState);

procedure TIM_SetIC1Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
procedure TIM_SetIC2Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
procedure TIM_SetIC3Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
procedure TIM_SetIC4Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);

procedure TIM_OC1Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
procedure TIM_OC2Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
procedure TIM_OC3Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
procedure TIM_OC4Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);

procedure TIM_OC1PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
procedure TIM_OC2PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
procedure TIM_OC3PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
procedure TIM_OC4PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);

procedure TIM_SetCompare1(var TIMx : TTimerRegisters; Compare1 : word);
procedure TIM_SetCompare2(var TIMx : TTimerRegisters; Compare2 : word);
procedure TIM_SetCompare3(var TIMx : TTimerRegisters; Compare3 : word);
procedure TIM_SetCompare4(var TIMx : TTimerRegisters; Compare4 : word);

procedure TIM_EncoderInterfaceConfig(var TIMx : TTimerRegisters; TIM_EncoderMode : word; TIM_IC1Polarity : word; TIM_IC2Polarity : word);
procedure TIM_SelectInputTrigger(var TIMx : TTimerRegisters; TIM_InputTriggerSource : word);
procedure TIM_ETRConfig(var TIMx : TTimerRegisters; TIM_ExtTRGPrescaler : word; TIM_ExtTRGPolarity : word; ExtTRGFilter : word);

//======================================================================
implementation

procedure TI1_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word); forward;
procedure TI2_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word); forward;
procedure TI3_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word); forward;
procedure TI4_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word); forward;

//======================================================================
// Deinitializes the TIMx peripheral registers to their default reset values.
//======================================================================
procedure TIM_DeInit(var TIMx : TTimerRegisters);
begin
  if (@TIMx = @TIM1) then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM1, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM1, DISABLED);  
  end     
  else if (@TIMx = @TIM2) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM2, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM2, DISABLED);
  end
  else if (@TIMx = @TIM3) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM3, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM3, DISABLED);
  end
  else if (@TIMx = @TIM4) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM4, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM4, DISABLED);
  end 
  else if (@TIMx = @TIM5) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM5, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM5, DISABLED);
  end 
  else if (@TIMx = @TIM6) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM6, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM6, DISABLED);
  end 
  else if (@TIMx = @TIM7) then
  begin
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM7, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM7, DISABLED);
  end 
  else if (@TIMx = @TIM8) then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM8, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM8, DISABLED);
  end
  else if (@TIMx = @TIM9) then
  begin      
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM9, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM9, DISABLED);  
  end
  else if (@TIMx = @TIM10) then
  begin      
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM10, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM10, DISABLED);  
  end  
  else if (@TIMx = @TIM11) then 
  begin     
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM11, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM11, DISABLED);  
  end  
  else if (@TIMx = @TIM12) then
  begin      
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM12, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM12, DISABLED);  
  end 
  else if (@TIMx = @TIM13) then 
  begin       
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM13, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM13, DISABLED);  
  end
  else if (@TIMx = @TIM14) then 
  begin       
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM14, ENABLED);
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_TIM14, DISABLED);  
  end        
  else if (@TIMx = @TIM15) then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM15, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM15, DISABLED);
  end 
  else if (@TIMx = @TIM16) then
  begin
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM16, ENABLED);
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM16, DISABLED);
  end 
  else
  begin
    if (@TIMx = @TIM17) then
    begin
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM17, ENABLED);
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_TIM17, DISABLED);
    end
  end
end;

//======================================================================
// Initializes the TIMx Time Base Unit peripheral according to 
// the specified parameters in the TIM_TimeBaseInitStruct
//======================================================================
procedure TIM_TimeBaseInit(var TIMx : TTimerRegisters; var TIM_TimeBaseInitStruct : TTIM_TimeBaseInit);
var
  tmpcr1 : word;
begin
  tmpcr1 := TIMx.CR1;  

  if ((@TIMx = @TIM1) or (@TIMx = @TIM8) or (@TIMx = @TIM2) or (@TIMx = @TIM3) or
     (@TIMx = @TIM4) or (@TIMx = @TIM5)) then
  begin
    // Select the Counter Mode 
    tmpcr1 := tmpcr1 AND word(not(word(TIM_CR1_DIR OR TIM_CR1_CMS)));
    tmpcr1 := tmpcr1 OR dword(TIM_TimeBaseInitStruct.TIM_CounterMode);
  end;
 
  if((@TIMx <> @TIM6) and (@TIMx <> @TIM7)) then
  begin
    // Set the clock division 
    tmpcr1 := tmpcr1 and word(not(word(TIM_CR1_CKD)));
    tmpcr1 := tmpcr1 or dword(TIM_TimeBaseInitStruct.TIM_ClockDivision);
  end;

  TIMx.CR1 := tmpcr1;

  // Set the Autoreload value 
  TIMx.ARR := TIM_TimeBaseInitStruct.TIM_Period;
 
  // Set the Prescaler value 
  TIMx.PSC := TIM_TimeBaseInitStruct.TIM_Prescaler;
    
  if ((@TIMx = @TIM1) or (@TIMx = @TIM8) or (@TIMx = @TIM15) or (@TIMx = @TIM16) or (@TIMx = @TIM17)) then
  begin
    // Set the Repetition Counter value 
    TIMx.RCR := TIM_TimeBaseInitStruct.TIM_RepetitionCounter;
  end;

  // Generate an update event to reload the Prescaler and the Repetition counter
  // values immediately 
  TIMx.EGR := TIM_PSCReloadMode_Immediate;           
end;

//======================================================================
// Initializes the TIMx Time Base Unit peripheral
//======================================================================
procedure TIM_TimeBaseInit(var TIMx : TTimerRegisters; TIM_Prescaler : word; TIM_ClockDivision : word; TIM_Period : word; TIM_RepetitionCounter : byte; TIM_CounterMode : word);
var
  tmpcr1 : word;
begin
  tmpcr1 := TIMx.CR1;  

  if ((@TIMx = @TIM1) or (@TIMx = @TIM8) or (@TIMx = @TIM2) or (@TIMx = @TIM3) or
     (@TIMx = @TIM4) or (@TIMx = @TIM5)) then
  begin
    // Select the Counter Mode 
    tmpcr1 := tmpcr1 AND word(not(word(TIM_CR1_DIR OR TIM_CR1_CMS)));
    tmpcr1 := tmpcr1 OR dword(TIM_CounterMode);
  end;
 
  if((@TIMx <> @TIM6) and (@TIMx <> @TIM7)) then
  begin
    // Set the clock division 
    tmpcr1 := tmpcr1 and word(not(word(TIM_CR1_CKD)));
    tmpcr1 := tmpcr1 or dword(TIM_ClockDivision);
  end;

  TIMx.CR1 := tmpcr1;

  // Set the Autoreload value 
  TIMx.ARR := TIM_Period;
 
  // Set the Prescaler value 
  TIMx.PSC := TIM_Prescaler;
    
  if ((@TIMx = @TIM1) or (@TIMx = @TIM8) or (@TIMx = @TIM15) or (@TIMx = @TIM16) or (@TIMx = @TIM17)) then
  begin
    // Set the Repetition Counter value 
    TIMx.RCR := TIM_RepetitionCounter;
  end;

  // Generate an update event to reload the Prescaler and the Repetition counter
  // values immediately 
  TIMx.EGR := TIM_PSCReloadMode_Immediate;           
end;

//======================================================================
// Initializes the TIMx Channel1 according to the specified
// parameters in the TIM_OCInitStruct
//======================================================================
procedure TIM_OC1Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx,
	tmpccer,
	tmpcr2  : word;
begin
  // Disable the Channel 1: Reset the CC1E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(word(TIM_CCER_CC1E));
  // Get the TIMx CCER register value
  tmpccer := TIMx.CCER;
  // Get the TIMx CR2 register value
  tmpcr2 := TIMx.CR2;
  
  // Get the TIMx CCMR1 register value
  tmpccmrx := TIMx.CCMR1;
    
  // Reset the Output Compare Mode Bits
  tmpccmrx := tmpccmrx AND NOT(word(TIM_CCMR1_OC1M));
  tmpccmrx := tmpccmrx AND NOT(word(TIM_CCMR1_CC1S));

  // Select the Output Compare Mode
  tmpccmrx := tmpccmrx OR TIM_OCInitStruct.TIM_OCMode;
  
  // Reset the Output Polarity level
  tmpccer := tmpccer AND NOT(word(TIM_CCER_CC1P));
  // Set the Output Compare Polarity
  tmpccer := tmpccer OR TIM_OCInitStruct.TIM_OCPolarity;
  
  // Set the Output State
  tmpccer := tmpccer OR TIM_OCInitStruct.TIM_OutputState;
    
  if ((@TIMx = @TIM1) OR (@TIMx = @TIM8) OR (@TIMx = @TIM15) OR
     (@TIMx = @TIM16) OR (@TIMx = @TIM17)) then
  begin
    // Reset the Output N Polarity level
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC1NP));
    // Set the Output N Polarity
    tmpccer := tmpccer OR TIM_OCInitStruct.TIM_OCNPolarity;
    
    // Reset the Output N State
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC1NE));    
    // Set the Output N State
    tmpccer := tmpccer OR TIM_OCInitStruct.TIM_OutputNState;
    
    // Reset the Output Compare and Output Compare N IDLE State
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS1));
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS1N));
    
    // Set the Output Idle state
    tmpcr2 := tmpcr2 OR TIM_OCInitStruct.TIM_OCIdleState;
    // Set the Output N Idle state
    tmpcr2 := tmpcr2 OR TIM_OCInitStruct.TIM_OCNIdleState;
  end;
  // Write to TIMx CR2
  TIMx.CR2 := tmpcr2;
  
  // Write to TIMx CCMR1
  TIMx.CCMR1 := tmpccmrx;

  // Set the Capture Compare Register value
  TIMx.CCR1 := TIM_OCInitStruct.TIM_Pulse; 
 
  // Write to TIMx CCER
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Initializes the TIMx Channel2 according to the specified
// parameters in the TIM_OCInitStruct
//======================================================================
procedure TIM_OC2Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx, 
	tmpccer, 
	tmpcr2 : word;
begin
   // Disable the Channel 2: Reset the CC2E Bit 
  TIMx.CCER := TIMx.CCER AND word(NOT word(TIM_CCER_CC2E));
  
  // Get the TIMx CCER register value   
  tmpccer := TIMx.CCER;

  // Get the TIMx CR2 register value 
  tmpcr2 := TIMx.CR2;
  
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
    
  if ((@TIMx = @TIM1) OR (@TIMx = @TIM8)) then
  begin
    // Reset the Output N Polarity level 
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC2NP));
    // Set the Output N Polarity 
    tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OCNPolarity SHL 4);
    
    // Reset the Output N State 
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC2NE));    
    // Set the Output N State 
    tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OutputNState SHL 4);
    
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS2));
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS2N));
    
    // Set the Output Idle state 
    tmpcr2 := tmpcr2 OR word(TIM_OCInitStruct.TIM_OCIdleState SHL 2);
    // Set the Output N Idle state 
    tmpcr2 := tmpcr2 OR word(TIM_OCInitStruct.TIM_OCNIdleState SHL 2);
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

//======================================================================
// Initializes the TIMx Channel3 according to the specified
// parameters in the TIM_OCInitStruct
//======================================================================
procedure TIM_OC3Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx, 
	tmpccer, 
	tmpcr2 : word;
begin
  // Disable the Channel 2: Reset the CC2E Bit 
  TIMx.CCER := TIMx.CCER AND word(not(word(TIM_CCER_CC3E)));
  
  // Get the TIMx CCER register value 
  tmpccer := TIMx.CCER;

  // Get the TIMx CR2 register value 
  tmpcr2  := TIMx.CR2;
  
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
    
  if ((@TIMx = @TIM1) or (@TIMx = @TIM8)) then
  begin
    // Reset the Output N Polarity level 
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC3NP));
    // Set the Output N Polarity 
    tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OCNPolarity SHL 8);
    // Reset the Output N State 
    tmpccer := tmpccer AND NOT(word(TIM_CCER_CC3NE));
    
    // Set the Output N State 
    tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OutputNState SHL 8);
    // Reset the Ouput Compare and Output Compare N IDLE State 
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS3));
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS3N));
    // Set the Output Idle state 
    tmpcr2 := tmpcr2 OR word(TIM_OCInitStruct.TIM_OCIdleState SHL 4);
    // Set the Output N Idle state 
    tmpcr2 := tmpcr2 OR word(TIM_OCInitStruct.TIM_OCNIdleState SHL 4); 
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

//======================================================================
// Initializes the TIMx Channel3 according to the specified
// parameters in the TIM_OCInitStruct
//======================================================================
procedure TIM_OC4Init(var TIMx : TTimerRegisters; var TIM_OCInitStruct : TTIM_OCInitStructure);
var
  tmpccmrx,
	tmpccer,
	tmpcr2 : word;
begin
  // Disable the Channel 2: Reset the CC4E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(word(TIM_CCER_CC4E));
  
  // Get the TIMx CCER register value 
  tmpccer := TIMx.CCER;
  // Get the TIMx CR2 register value 
  tmpcr2 := TIMx.CR2;
  
  // Get the TIMx CCMR2 register value 
  tmpccmrx := TIMx.CCMR2;
    
  // Reset the Output Compare mode and Capture/Compare selection Bits 
  tmpccmrx := tmpccmrx AND NOT(word(TIM_CCMR2_OC4M));
  tmpccmrx := tmpccmrx AND NOT(word(TIM_CCMR2_CC4S));
  
  // Select the Output Compare Mode 
  tmpccmrx := tmpccmrx OR word(TIM_OCInitStruct.TIM_OCMode SHL 8);
  
  // Reset the Output Polarity level 
  tmpccer := tmpccer AND NOT(word(TIM_CCER_CC4P));
  // Set the Output Compare Polarity 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OCPolarity SHL 12);
  
  // Set the Output State 
  tmpccer := tmpccer OR word(TIM_OCInitStruct.TIM_OutputState SHL 12);
    
  if ((@TIMx = @TIM1) OR (@TIMx = @TIM8)) then
  begin
    // Reset the Ouput Compare IDLE State 
    tmpcr2 := tmpcr2 AND NOT(word(TIM_CR2_OIS4));
    // Set the Output Idle state 
    tmpcr2 := tmpcr2 OR word(TIM_OCInitStruct.TIM_OCIdleState SHL 6);
  end;
  // Write to TIMx CR2 
  TIMx.CR2 := tmpcr2;
  
  // Write to TIMx CCMR2   
  TIMx.CCMR2 := tmpccmrx;

  // Set the Capture Compare Register value 
  TIMx.CCR4 := TIM_OCInitStruct.TIM_Pulse;
  
  // Write to TIMx CCER 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Initializes the TIM peripheral according to the specified
// parameters in the TIM_ICInitStruct
//======================================================================
procedure TIM_ICInit(var TIMx : TTimerRegisters; var TIM_ICInitStruct : TTIM_ICInit);
begin
  if (TIM_ICInitStruct.TIM_Channel = TIM_Channel_1) then
  begin
    // TI1 Configuration 
    TI1_Config(TIMx, TIM_ICInitStruct.TIM_ICPolarity,
               TIM_ICInitStruct.TIM_ICSelection,
               TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end
  else if (TIM_ICInitStruct.TIM_Channel = TIM_Channel_2) then
  begin
    // TI2 Configuration 
    TI2_Config(TIMx, TIM_ICInitStruct.TIM_ICPolarity,
               TIM_ICInitStruct.TIM_ICSelection,
               TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end
  else if (TIM_ICInitStruct.TIM_Channel = TIM_Channel_3) then
  begin
    // TI3 Configuration 
    TI3_Config(TIMx,  TIM_ICInitStruct.TIM_ICPolarity,
               TIM_ICInitStruct.TIM_ICSelection,
               TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC3Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end
  else
  begin
    // TI4 Configuration 
    TI4_Config(TIMx, TIM_ICInitStruct.TIM_ICPolarity,
               TIM_ICInitStruct.TIM_ICSelection,
               TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC4Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end;
end;

//======================================================================
// Configures the TIM peripheral according to the specified
// parameters in the TIM_ICInitStruct to measure an external PWM signal
//======================================================================
procedure TIM_PWMIConfig(var TIMx : TTimerRegisters; var TIM_ICInitStruct : TTIM_ICInit);
var
  icoppositepolarity, 
	icoppositeselection : word;
begin
  icoppositepolarity  := TIM_ICPolarity_Rising;
  icoppositeselection := TIM_ICSelection_DirectTI;

  // Select the Opposite Input Polarity 
  if (TIM_ICInitStruct.TIM_ICPolarity = TIM_ICPolarity_Rising) then
    icoppositepolarity := TIM_ICPolarity_Falling
  else
    icoppositepolarity := TIM_ICPolarity_Rising;

  // Select the Opposite Input 
  if (TIM_ICInitStruct.TIM_ICSelection = TIM_ICSelection_DirectTI) then
    icoppositeselection := TIM_ICSelection_IndirectTI
  else
    icoppositeselection := TIM_ICSelection_DirectTI;

  if (TIM_ICInitStruct.TIM_Channel = TIM_Channel_1) then
  begin
    // TI1 Configuration 
    TI1_Config(TIMx, TIM_ICInitStruct.TIM_ICPolarity, TIM_ICInitStruct.TIM_ICSelection, TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
    // TI2 Configuration 
    TI2_Config(TIMx, icoppositepolarity, icoppositeselection, TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end
  else
  begin 
    // TI2 Configuration 
    TI2_Config(TIMx, TIM_ICInitStruct.TIM_ICPolarity, TIM_ICInitStruct.TIM_ICSelection, TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC2Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
    // TI1 Configuration 
    TI1_Config(TIMx, icoppositepolarity, icoppositeselection, TIM_ICInitStruct.TIM_ICFilter);
    // Set the Input Capture Prescaler value 
    TIM_SetIC1Prescaler(TIMx, TIM_ICInitStruct.TIM_ICPrescaler);
  end;
end;

//======================================================================
// Configures the: Break feature, dead time, Lock level, the OSSI,
// the OSSR State and the AOE(automatic output enable)
//======================================================================
procedure TIM_BDTRConfig(var TIMx : TTimerRegisters; var TIM_BDTRInitStruct : TTIM_BDTRInit);
begin
  // Set the Lock level, the Break enable Bit and the Ploarity, the OSSR State,
  // the OSSI State, the dead time value and the Automatic Output Enable Bit 
  TIMx.BDTR := longword(TIM_BDTRInitStruct.TIM_OSSRState OR TIM_BDTRInitStruct.TIM_OSSIState OR 
	           TIM_BDTRInitStruct.TIM_LOCKLevel OR TIM_BDTRInitStruct.TIM_DeadTime OR
             TIM_BDTRInitStruct.TIM_Break OR TIM_BDTRInitStruct.TIM_BreakPolarity OR
             TIM_BDTRInitStruct.TIM_AutomaticOutput);
end;

//======================================================================
// Fills each TIM_TimeBaseInitStruct member with its default value
//======================================================================
procedure TIM_TimeBaseStructInit(var TIM_TimeBaseInitStruct : TTIM_TimeBaseInit);
begin
  // Set the default configuration 
  TIM_TimeBaseInitStruct.TIM_Period := $FFFF;
  TIM_TimeBaseInitStruct.TIM_Prescaler := $0000;
  TIM_TimeBaseInitStruct.TIM_ClockDivision := TIM_CKD_DIV1;
  TIM_TimeBaseInitStruct.TIM_CounterMode := TIM_CounterMode_Up;
  TIM_TimeBaseInitStruct.TIM_RepetitionCounter := $0000;
end;

//======================================================================
// Fills each TIM_OCInitStruct member with its default value
//======================================================================
procedure TIM_OCStructInit(var TIM_OCInitStruct : TTIM_OCInitStructure);
begin
  // Set the default configuration 
  TIM_OCInitStruct.TIM_OCMode := TIM_OCMode_Timing;
  TIM_OCInitStruct.TIM_OutputState := TIM_OutputState_Disable;
  TIM_OCInitStruct.TIM_OutputNState := TIM_OutputNState_Disable;
  TIM_OCInitStruct.TIM_Pulse := $0000;
  TIM_OCInitStruct.TIM_OCPolarity := TIM_OCPolarity_High;
  TIM_OCInitStruct.TIM_OCNPolarity := TIM_OCPolarity_High;
  TIM_OCInitStruct.TIM_OCIdleState := TIM_OCIdleState_Reset;
  TIM_OCInitStruct.TIM_OCNIdleState := TIM_OCNIdleState_Reset;
end;

//======================================================================
// Fills each TIM_ICInitStruct member with its default value.
//======================================================================
procedure TIM_ICStructInit(var TIM_ICInitStruct : TTIM_ICInit);
begin
  // Set the default configuration 
  TIM_ICInitStruct.TIM_Channel := TIM_Channel_1;
  TIM_ICInitStruct.TIM_ICPolarity := TIM_ICPolarity_Rising;
  TIM_ICInitStruct.TIM_ICSelection := TIM_ICSelection_DirectTI;
  TIM_ICInitStruct.TIM_ICPrescaler := TIM_ICPSC_DIV1;
  TIM_ICInitStruct.TIM_ICFilter := $00;
end;

//======================================================================
// Fills each TIM_BDTRInitStruct member with its default value.
//======================================================================
procedure TIM_BDTRStructInit(var TIM_BDTRInitStruct : TTIM_BDTRInit);
begin
  // Set the default configuration 
  TIM_BDTRInitStruct.TIM_OSSRState := TIM_OSSRState_Disable;
  TIM_BDTRInitStruct.TIM_OSSIState := TIM_OSSIState_Disable;
  TIM_BDTRInitStruct.TIM_LOCKLevel := TIM_LOCKLevel_OFF;
  TIM_BDTRInitStruct.TIM_DeadTime := $00;
  TIM_BDTRInitStruct.TIM_Break := TIM_Break_Disable;
  TIM_BDTRInitStruct.TIM_BreakPolarity := TIM_BreakPolarity_Low;
  TIM_BDTRInitStruct.TIM_AutomaticOutput := TIM_AutomaticOutput_Disable;
end;

//======================================================================
// Enables or disables the specified TIM peripheral.
//======================================================================
procedure TIM_Cmd(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Enable the TIM Counter 
    TIMx.CR1 := TIMx.CR1 OR $0001
  else
    // Disable the TIM Counter 
    TIMx.CR1 := TIMx.CR1 AND NOT word($0001);
end;

//======================================================================
// Enables or disables the TIM peripheral Main Outputs.
//======================================================================
procedure TIM_CtrlPWMOutputs(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Enable the TIM Main Output 
    TIMx.BDTR := TIMx.BDTR OR TIM_BDTR_MOE
  else
    // Disable the TIM Main Output 
    TIMx.BDTR := TIMx.BDTR AND NOT(word(TIM_BDTR_MOE));
end;

//======================================================================
// Enables or disables the specified TIM interrupts
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

//======================================================================
// Configures the TIMx event to be generate by software
//======================================================================
procedure TIM_GenerateEvent(var TIMx : TTimerRegisters; TIM_EventSource : word);
begin 
  // Set the event sources 
  TIMx.EGR := TIM_EventSource;
end;

//======================================================================
// Configures the TIMx's DMA interface
//======================================================================
procedure TIM_DMAConfig(var TIMx : TTimerRegisters; TIM_DMABase : word; TIM_DMABurstLength : word);
begin
  // Set the DMA Base and the DMA Burst Length 
  TIMx.DCR := (TIM_DMABase OR TIM_DMABurstLength);
end;

//======================================================================
// Enables or disables the TIMx's DMA Requests.
//======================================================================
procedure TIM_DMACmd(var TIMx : TTimerRegisters; TIM_DMASource : word; NewState : TState);
begin 
  if (NewState <> DISABLED) then
    // Enable the DMA sources 
    TIMx.DIER := TIMx.DIER OR TIM_DMASource 
  else
    // Disable the DMA sources 
    TIMx.DIER := TIMx.DIER AND NOT(word(TIM_DMASource));
end;

//======================================================================
// Configures the TIMx interrnal Clock
//======================================================================
procedure TIM_InternalClockConfig(var TIMx : TTimerRegisters);
begin
  // Disable slave mode to clock the prescaler directly with the internal clock 
  TIMx.SMCR := TIMx.SMCR AND word(NOT word(TIM_SMCR_SMS));
end;

//======================================================================
// Configures the TIMx Internal Trigger as External Clock
//======================================================================
procedure TIM_ITRxExternalClockConfig(var TIMx : TTimerRegisters; TIM_InputTriggerSource : word);
begin
  // Select the Internal Trigger 
  TIM_SelectInputTrigger(TIMx, TIM_InputTriggerSource);
  // Select the External clock mode1 
  TIMx.SMCR := TIMx.SMCR OR TIM_SlaveMode_External1;
end;

//======================================================================
// Configures the TIMx Trigger as External Clock
//======================================================================
procedure TIM_TIxExternalClockConfig(var TIMx : TTimerRegisters; TIM_TIxExternalCLKSource : word; TIM_ICPolarity : word; ICFilter : word);
begin
  // Configure the Timer Input Clock Source 
  if (TIM_TIxExternalCLKSource = TIM_TIxExternalCLK1Source_TI2) then
    TI2_Config(TIMx, TIM_ICPolarity, TIM_ICSelection_DirectTI, ICFilter)
  else
    TI1_Config(TIMx, TIM_ICPolarity, TIM_ICSelection_DirectTI, ICFilter);

  // Select the Trigger source 
  TIM_SelectInputTrigger(TIMx, TIM_TIxExternalCLKSource);
	
  // Select the External clock mode1 
  TIMx.SMCR := TIMx.SMCR OR TIM_SlaveMode_External1;
end;

//======================================================================
// Configures the External clock Mode1
//======================================================================
procedure TIM_ETRClockMode1Config(var TIMx : TTimerRegisters; TIM_ExtTRGPrescaler : word; TIM_ExtTRGPolarity : word; ExtTRGFilter : word);
var
  tmpsmcr : word;
begin
  // Configure the ETR Clock source 
  TIM_ETRConfig(TIMx, TIM_ExtTRGPrescaler, TIM_ExtTRGPolarity, ExtTRGFilter);
  
  // Get the TIMx SMCR register value 
  tmpsmcr := TIMx.SMCR;
  // Reset the SMS Bits 
  tmpsmcr := tmpsmcr AND NOT(word(TIM_SMCR_SMS));
  // Select the External clock mode1 
  tmpsmcr := tmpsmcr OR TIM_SlaveMode_External1;
  // Select the Trigger selection : ETRF 
  tmpsmcr := tmpsmcr AND NOT(word(TIM_SMCR_TS));
  tmpsmcr := tmpsmcr OR TIM_TS_ETRF;

  // Write to TIMx SMCR 
  TIMx.SMCR := tmpsmcr;
end;

//======================================================================
// Configures the External clock Mode2
//======================================================================
procedure TIM_ETRClockMode2Config(var TIMx : TTimerRegisters; TIM_ExtTRGPrescaler : word; TIM_ExtTRGPolarity : word; ExtTRGFilter : word);
begin
  // Configure the ETR Clock source 
  TIM_ETRConfig(TIMx, TIM_ExtTRGPrescaler, TIM_ExtTRGPolarity, ExtTRGFilter);
  // Enable the External clock mode2 
  TIMx.SMCR := TIMx.SMCR OR TIM_SMCR_ECE;
end;

//======================================================================
// Configures the TIMx External Trigger (ETR)
//======================================================================
procedure TIM_ETRConfig(var TIMx : TTimerRegisters; TIM_ExtTRGPrescaler : word; TIM_ExtTRGPolarity : word; ExtTRGFilter : word);
var
  tmpsmcr : word;
begin
  tmpsmcr := TIMx.SMCR;
  // Reset the ETR Bits 
  tmpsmcr := tmpsmcr AND SMCR_ETR_Mask;
  // Set the Prescaler, the Filter value and the Polarity 
  tmpsmcr := tmpsmcr OR word(TIM_ExtTRGPrescaler OR word(TIM_ExtTRGPolarity OR word(ExtTRGFilter SHL 8)));
  // Write to TIMx SMCR 
  TIMx.SMCR := tmpsmcr;
end;

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

//======================================================================
// Specifies the TIMx Counter Mode to be used.
//======================================================================
procedure TIM_CounterModeConfig(var TIMx : TTimerRegisters; TIM_CounterMode : word);
var
  tmpcr1 : word;
begin
  tmpcr1 := TIMx.CR1;
  // Reset the CMS and DIR Bits 
  tmpcr1 := tmpcr1 AND NOT(TIM_CR1_DIR OR TIM_CR1_CMS);
  // Set the Counter Mode 
  tmpcr1 := tmpcr1 OR TIM_CounterMode;
  // Write to TIMx CR1 register 
  TIMx.CR1 := tmpcr1;
end;

//======================================================================
// Selects the Input Trigger source
//======================================================================
procedure TIM_SelectInputTrigger(var TIMx : TTimerRegisters; TIM_InputTriggerSource : word);
var
  tmpsmcr : word;
begin
  // Get the TIMx SMCR register value 
  tmpsmcr := TIMx.SMCR;
  // Reset the TS Bits 
  tmpsmcr := tmpsmcr  AND NOT(word(TIM_SMCR_TS));
  // Set the Input Trigger source 
  tmpsmcr := tmpsmcr OR TIM_InputTriggerSource;
  // Write to TIMx SMCR 
  TIMx.SMCR := tmpsmcr;
end;

//======================================================================
// Configures the TIMx Encoder Interface
//======================================================================
procedure TIM_EncoderInterfaceConfig(var TIMx : TTimerRegisters; TIM_EncoderMode : word; TIM_IC1Polarity : word; TIM_IC2Polarity : word);
var
  tmpsmcr,
  tmpccmr1, 
  tmpccer : word;
begin
  // Get the TIMx SMCR register value 
  tmpsmcr := TIMx.SMCR;
  
  // Get the TIMx CCMR1 register value 
  tmpccmr1 := TIMx.CCMR1;
  
  // Get the TIMx CCER register value 
  tmpccer := TIMx.CCER;
  
  // Set the encoder Mode 
  tmpsmcr := tmpsmcr AND NOT(word(TIM_SMCR_SMS));
  tmpsmcr := tmpsmcr OR TIM_EncoderMode;
  
  // Select the Capture Compare 1 and the Capture Compare 2 as input 
  tmpccmr1 := tmpccmr1 AND (NOT(word(TIM_CCMR1_CC1S)) AND NOT(word(TIM_CCMR1_CC2S)));
  tmpccmr1 := tmpccmr1 OR TIM_CCMR1_CC1S_0 OR TIM_CCMR1_CC2S_0;
  
  // Set the TI1 and the TI2 Polarities 
  tmpccer := tmpccer AND word(NOT(word(TIM_CCER_CC1P)) AND NOT(word(TIM_CCER_CC2P)));   
  tmpccer := tmpccer OR (TIM_IC1Polarity OR word(TIM_IC2Polarity SHL 4));
  
  // Write to TIMx SMCR 
  TIMx.SMCR := tmpsmcr;
  // Write to TIMx CCMR1 
  TIMx.CCMR1 := tmpccmr1;
  // Write to TIMx CCER 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Forces the TIMx output 1 waveform to active or inactive level.
//======================================================================
procedure TIM_ForcedOC1Config(var TIMx : TTimerRegisters; TIM_ForcedAction : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC1M Bits 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC1M);
  // Configure The Forced output Mode 
  tmpccmr1 := tmpccmr1 OR TIM_ForcedAction;
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Forces the TIMx output 2 waveform to active or inactive level
//======================================================================
procedure TIM_ForcedOC2Config(var TIMx : TTimerRegisters; TIM_ForcedAction : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC2M Bits 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC2M);
  // Configure The Forced output Mode 
  tmpccmr1 := tmpccmr1 OR (TIM_ForcedAction SHL 8);
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Forces the TIMx output 3 waveform to active or inactive level
//======================================================================
procedure TIM_ForcedOC3Config(var TIMx : TTimerRegisters; TIM_ForcedAction : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC1M Bits 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC3M);
  // Configure The Forced output Mode 
  tmpccmr2 := tmpccmr2 OR TIM_ForcedAction;
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Forces the TIMx output 4 waveform to active or inactive level
//======================================================================
procedure TIM_ForcedOC4Config(var TIMx : TTimerRegisters; TIM_ForcedAction : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC2M Bits 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC4M);
  // Configure The Forced output Mode 
  tmpccmr2 := (TIM_ForcedAction SHL 8);
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Enables or disables TIMx peripheral Preload register on ARR
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

//======================================================================
// Selects the TIM peripheral Commutation event
//======================================================================
procedure TIM_SelectCOM(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Set the COM Bit 
    TIMx.CR2 := TIMx.CR2 OR TIM_CR2_CCUS
  else
    // Reset the COM Bit 
    TIMx.CR2 := TIMx.CR2 AND NOT(TIM_CR2_CCUS);
end;

//======================================================================
// Selects the TIMx peripheral Capture Compare DMA source
//======================================================================
procedure TIM_SelectCCDMA(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Set the CCDS Bit 
    TIMx.CR2 := TIMx.CR2 OR TIM_CR2_CCDS
  else
    // Reset the CCDS Bit 
    TIMx.CR2 := TIMx.CR2 AND NOT(TIM_CR2_CCDS);
end;

//======================================================================
// Sets or Resets the TIM peripheral Capture Compare Preload Control bit
//======================================================================
procedure TIM_CCPreloadControl(var TIMx : TTimerRegisters; NewState : TState);
begin 
  if (NewState <> DISABLED) then
    // Set the CCPC Bit 
    TIMx.CR2 := TIMx.CR2 OR TIM_CR2_CCPC
  else
    // Reset the CCPC Bit 
    TIMx.CR2 := TIMx.CR2 AND NOT(TIM_CR2_CCPC);
end;

//======================================================================
// Enables or disables the TIMx peripheral Preload register on CCR1
//======================================================================
procedure TIM_OC1PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC1PE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC1PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr1 := tmpccmr1 OR TIM_OCPreload;
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Enables or disables the TIMx peripheral Preload register on CCR2
//======================================================================
procedure TIM_OC2PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC2PE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC2PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr1 := tmpccmr1 OR (TIM_OCPreload SHL 8);
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Enables or disables the TIMx peripheral Preload register on CCR3
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

//======================================================================
// Enables or disables the TIMx peripheral Preload register on CCR4
//======================================================================
procedure TIM_OC4PreloadConfig(var TIMx : TTimerRegisters; TIM_OCPreload : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC4PE Bit 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC4PE);
  // Enable or Disable the Output Compare Preload feature 
  tmpccmr2 := tmpccmr2 OR (TIM_OCPreload SHL 8);
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Configures the TIMx Output Compare 1 Fast feature
//======================================================================
procedure TIM_OC1FastConfig(var TIMx : TTimerRegisters; TIM_OCFast : word);
var
	tmpccmr1 : word;
begin
  // Get the TIMx CCMR1 register value 
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC1FE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC1FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr1 := tmpccmr1 OR TIM_OCFast;
  // Write to TIMx CCMR1 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Configures the TIMx Output Compare 2 Fast feature
//======================================================================
procedure TIM_OC2FastConfig(var TIMx : TTimerRegisters; TIM_OCFast : word);
var
  tmpccmr1 : word;
begin
  // Get the TIMx CCMR1 register value 
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC2FE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC2FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr1 := tmpccmr1 OR (TIM_OCFast SHL 8);
  // Write to TIMx CCMR1 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Configures the TIMx Output Compare 3 Fast feature
//======================================================================
procedure TIM_OC3FastConfig(var TIMx : TTimerRegisters; TIM_OCFast : word);
var
  tmpccmr2 : word;
begin
  // Get the TIMx CCMR2 register value 
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC3FE Bit 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC3FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr2 := tmpccmr2  OR TIM_OCFast;
  // Write to TIMx CCMR2 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Configures the TIMx Output Compare 4 Fast feature
//======================================================================
procedure TIM_OC4FastConfig(var TIMx : TTimerRegisters; TIM_OCFast : word);
var
  tmpccmr2 : word;
begin
  // Get the TIMx CCMR2 register value 
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC4FE Bit 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC4FE);
  // Enable or Disable the Output Compare Fast Bit 
  tmpccmr2 := tmpccmr2 OR (TIM_OCFast SHL 8);
  // Write to TIMx CCMR2 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Clears or safeguards the OCREF1 signal on an external event
//======================================================================
procedure TIM_ClearOC1Ref(var TIMx : TTimerRegisters; TIM_OCClear : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;

  // Reset the OC1CE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC1CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr1 := tmpccmr1 OR TIM_OCClear;
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Clears or safeguards the OCREF2 signal on an external event
//======================================================================
procedure TIM_ClearOC2Ref(var TIMx : TTimerRegisters; TIM_OCClear : word);
var
  tmpccmr1 : word;
begin
  tmpccmr1 := TIMx.CCMR1;
  // Reset the OC2CE Bit 
  tmpccmr1 := tmpccmr1 AND NOT(TIM_CCMR1_OC2CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr1 := tmpccmr1 OR (TIM_OCClear SHL 8);
  // Write to TIMx CCMR1 register 
  TIMx.CCMR1 := tmpccmr1;
end;

//======================================================================
// Clears or safeguards the OCREF3 signal on an external event
//======================================================================
procedure TIM_ClearOC3Ref(var TIMx : TTimerRegisters; TIM_OCClear : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC3CE Bit 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC3CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr2 := tmpccmr2 OR TIM_OCClear;
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Clears or safeguards the OCREF4 signal on an external event
//======================================================================
procedure TIM_ClearOC4Ref(var TIMx : TTimerRegisters; TIM_OCClear : word);
var
  tmpccmr2 : word;
begin
  tmpccmr2 := TIMx.CCMR2;
  // Reset the OC4CE Bit 
  tmpccmr2 := tmpccmr2 AND NOT(TIM_CCMR2_OC4CE);
  // Enable or Disable the Output Compare Clear Bit 
  tmpccmr2 := tmpccmr2 OR (TIM_OCClear SHL 8);
  // Write to TIMx CCMR2 register 
  TIMx.CCMR2 := tmpccmr2;
end;

//======================================================================
// Configures the TIMx channel 1 polarity
//======================================================================
procedure TIM_OC1PolarityConfig(var TIMx : TTimerRegisters; TIM_OCPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC1P Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC1P);
  tmpccer := tmpccer OR TIM_OCPolarity;
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx Channel 1N polarity
//======================================================================
procedure TIM_OC1NPolarityConfig(var TIMx : TTimerRegisters; TIM_OCNPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC1NP Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC1NP);
  tmpccer := tmpccer OR TIM_OCNPolarity;
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx channel 2 polarity
//======================================================================
procedure TIM_OC2PolarityConfig(var TIMx : TTimerRegisters; TIM_OCPolarity : word);
var
	tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC2P Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC2P);
  tmpccer := tmpccer OR (TIM_OCPolarity SHL 4);
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx Channel 2N polarity
//======================================================================
procedure TIM_OC2NPolarityConfig(var TIMx : TTimerRegisters; TIM_OCNPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC2NP Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC2NP);
  tmpccer := tmpccer OR (TIM_OCNPolarity SHL 4);
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx channel 3 polarity
//======================================================================
procedure TIM_OC3PolarityConfig(var TIMx : TTimerRegisters; TIM_OCPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC3P Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC3P);
  tmpccer := tmpccer OR (TIM_OCPolarity SHL 8);
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx Channel 3N polarity
//======================================================================
procedure TIM_OC3NPolarityConfig(var TIMx : TTimerRegisters; TIM_OCNPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC3NP Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC3NP);
  tmpccer := tmpccer OR (TIM_OCNPolarity SHL 8);
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Configures the TIMx channel 4 polarity
//======================================================================
procedure TIM_OC4PolarityConfig(var TIMx : TTimerRegisters; TIM_OCPolarity : word);
var
  tmpccer : word;
begin
  tmpccer := TIMx.CCER;
  // Set or Reset the CC4P Bit 
  tmpccer := tmpccer AND NOT(TIM_CCER_CC4P);
  tmpccer := tmpccer OR (TIM_OCPolarity SHL 12);
  // Write to TIMx CCER register 
  TIMx.CCER := tmpccer;
end;

//======================================================================
// Enables or disables the TIM Capture Compare Channel x
//======================================================================
procedure TIM_CCxCmd(var TIMx : TTimerRegisters; TIM_Channel : word; TIM_CCx : word);
var
  tmp : word;
begin
  tmp := CCER_CCE_Set SHL TIM_Channel;

  // Reset the CCxE Bit 
  TIMx.CCER := TIMx.CCER AND NOT(tmp);

  // Set or reset the CCxE Bit  
  TIMx.CCER := TIMx.CCER OR (TIM_CCx SHL TIM_Channel);
end;

//======================================================================
// Enables or disables the TIM Capture Compare Channel xN
//======================================================================
procedure TIM_CCxNCmd(var TIMx : TTimerRegisters; TIM_Channel : word; TIM_CCxN : word);
var
  tmp : word;
begin
  tmp := CCER_CCNE_Set SHL TIM_Channel;

  // Reset the CCxNE Bit 
  TIMx.CCER := TIMx.CCER AND NOT(tmp);

  // Set or reset the CCxNE Bit  
  TIMx.CCER := TIMx.CCER OR (TIM_CCxN SHL TIM_Channel);
end;

//======================================================================
// Selects the TIM Ouput Compare Mode
//======================================================================
procedure TIM_SelectOCxM(var TIMx : TTimerRegisters; TIM_Channel : word; TIM_OCMode : word);
var
  tmp : pointer;
  tmp1 : word;
begin
  tmp := @TIMx;
  tmp := tmp + CCMR_Offset;

  tmp1 := CCER_CCE_Set SHL TIM_Channel;

  // Disable the Channel: Reset the CCxE Bit 
  TIMx.CCER := TIMx.CCER AND NOT(tmp1);

  if ((TIM_Channel = TIM_Channel_1) OR (TIM_Channel = TIM_Channel_3)) then
  begin
    tmp := tmp + (TIM_Channel SHR 1);

    // Reset the OCxM bits in the CCMRx register 
    dword(tmp^) := dword(tmp^) AND NOT(TIM_CCMR1_OC1M);
   
    // Configure the OCxM bits in the CCMRx register 
    dword(tmp^) := dword(tmp^) OR TIM_OCMode;
  end
  else
  begin
    tmp := tmp + (TIM_Channel - 4) SHR 1;

    // Reset the OCxM bits in the CCMRx register 
    dword(tmp^) := dword(tmp^) AND NOT(TIM_CCMR1_OC2M);
    
    // Configure the OCxM bits in the CCMRx register 
    dword(tmp^) := dword(tmp^) OR (TIM_OCMode SHL 8);
  end;
end;

//======================================================================
// Enables or Disables the TIMx Update event
//======================================================================
procedure TIM_UpdateDisableConfig(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Set the Update Disable Bit 
    TIMx.CR1 := TIMx.CR1 OR TIM_CR1_UDIS
  else
    // Reset the Update Disable Bit 
    TIMx.CR1 := TIMx.CR1 AND NOT(TIM_CR1_UDIS);
end;

//======================================================================
// Configures the TIMx Update Request Interrupt source
//======================================================================
procedure TIM_UpdateRequestConfig(var TIMx : TTimerRegisters; TIM_UpdateSource : word);
begin
  if (TIM_UpdateSource <> TIM_UpdateSource_Global) then
    // Set the URS Bit 
    TIMx.CR1 := TIMx.CR1 OR TIM_CR1_URS
  else
    // Reset the URS Bit 
    TIMx.CR1 := TIMx.CR1 AND NOT(TIM_CR1_URS);
end;

//======================================================================
// Enables or disables the TIMx's Hall sensor interface
//======================================================================
procedure TIM_SelectHallSensor(var TIMx : TTimerRegisters; NewState : TState);
begin
  if (NewState <> DISABLED) then
    // Set the TI1S Bit 
    TIMx.CR2 := TIMx.CR2 OR TIM_CR2_TI1S
  else
    // Reset the TI1S Bit 
    TIMx.CR2 := TIMx.CR2 AND NOT(TIM_CR2_TI1S);
end;

//======================================================================
// Selects the TIMx's One Pulse Mode
//======================================================================
procedure TIM_SelectOnePulseMode(var TIMx : TTimerRegisters; TIM_OPMode : word);
begin
  // Reset the OPM Bit 
  TIMx.CR1 := TIMx.CR1 AND NOT(TIM_CR1_OPM);
  // Configure the OPM Mode 
  TIMx.CR1 := TIMx.CR1 OR TIM_OPMode;
end;

//======================================================================
// Selects the TIMx Trigger Output Mode
//======================================================================
procedure TIM_SelectOutputTrigger(var TIMx : TTimerRegisters; TIM_TRGOSource : word);
begin
  // Reset the MMS Bits 
  TIMx.CR2 := TIMx.CR2 AND NOT(TIM_CR2_MMS);
  // Select the TRGO source 
  TIMx.CR2 := TIMx.CR2 OR TIM_TRGOSource;
end;

//======================================================================
// Selects the TIMx Slave Mode
//======================================================================
procedure TIM_SelectSlaveMode(var TIMx : TTimerRegisters; TIM_SlaveMode : word);
begin
  // Reset the SMS Bits 
  TIMx.SMCR := TIMx.SMCR AND NOT(TIM_SMCR_SMS);
  // Select the Slave Mode 
  TIMx.SMCR := TIMx.SMCR OR TIM_SlaveMode;
end;

//======================================================================
// Sets or Resets the TIMx Master/Slave Mode
//======================================================================
procedure TIM_SelectMasterSlaveMode(var TIMx : TTimerRegisters; TIM_MasterSlaveMode : word);
begin
  // Reset the MSM Bit 
  TIMx.SMCR := TIMx.SMCR AND NOT(TIM_SMCR_MSM);
  // Set or Reset the MSM Bit 
  TIMx.SMCR := TIMx.SMCR OR TIM_MasterSlaveMode;
end;

//======================================================================
// Sets the TIMx Counter Register value
//======================================================================
procedure TIM_SetCounter(var TIMx : TTimerRegisters; Counter : word);
begin
  // Set the Counter Register value 
  TIMx.CNT := Counter;
end;

//======================================================================
// Sets the TIMx Autoreload Register value
//======================================================================
procedure TIM_SetAutoreload(var TIMx : TTimerRegisters; Autoreload : word);
begin
  // Set the Autoreload Register value 
  TIMx.ARR := Autoreload;
end;

//======================================================================
// Sets the TIMx Capture Compare1 Register value
//======================================================================
procedure TIM_SetCompare1(var TIMx : TTimerRegisters; Compare1 : word);
begin
  // Set the Capture Compare1 Register value 
  TIMx.CCR1 := Compare1;
end;

//======================================================================
// Sets the TIMx Capture Compare2 Register value
//======================================================================
procedure TIM_SetCompare2(var TIMx : TTimerRegisters; Compare2 : word);
begin
  // Set the Capture Compare2 Register value 
  TIMx.CCR2 := Compare2;
end;

//======================================================================
// Sets the TIMx Capture Compare3 Register value
//======================================================================
procedure TIM_SetCompare3(var TIMx : TTimerRegisters; Compare3 : word);
begin
  // Set the Capture Compare3 Register value 
  TIMx.CCR3 := Compare3;
end;

//======================================================================
// Sets the TIMx Capture Compare4 Register value
//======================================================================
procedure TIM_SetCompare4(var TIMx : TTimerRegisters; Compare4 : word);
begin
  // Set the Capture Compare4 Register value 
  TIMx.CCR4 := Compare4;
end;

//======================================================================
// Sets the TIMx Input Capture 1 prescaler.
//======================================================================
procedure TIM_SetIC1Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
begin
  // Reset the IC1PSC Bits 
  TIMx.CCMR1 := TIMx.CCMR1 AND NOT(TIM_CCMR1_IC1PSC);
  // Set the IC1PSC value 
  TIMx.CCMR1 := TIMx.CCMR1 OR TIM_ICPSC;
end;

//======================================================================
// Sets the TIMx Input Capture 2 prescaler.
//======================================================================
procedure TIM_SetIC2Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
begin
  // Reset the IC2PSC Bits 
  TIMx.CCMR1 := TIMx.CCMR1 AND NOT(TIM_CCMR1_IC2PSC);
  // Set the IC2PSC value 
  TIMx.CCMR1 := TIMx.CCMR1 OR (TIM_ICPSC SHL 8);
end;

//======================================================================
// Sets the TIMx Input Capture 3 prescaler.
//======================================================================
procedure TIM_SetIC3Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
begin
  // Reset the IC3PSC Bits 
  TIMx.CCMR2 := TIMx.CCMR2 AND NOT(TIM_CCMR2_IC3PSC);
  // Set the IC3PSC value 
  TIMx.CCMR2 := TIMx.CCMR2 OR TIM_ICPSC;
end;

//======================================================================
// Sets the TIMx Input Capture 4 prescaler.
//======================================================================
procedure TIM_SetIC4Prescaler(var TIMx : TTimerRegisters; TIM_ICPSC : word);
begin  
  // Reset the IC4PSC Bits 
  TIMx.CCMR2 := TIMx.CCMR2 AND NOT(TIM_CCMR2_IC4PSC);
  // Set the IC4PSC value 
  TIMx.CCMR2 := TIMx.CCMR2 OR (TIM_ICPSC SHL 8);
end;

//======================================================================
// Sets the TIMx Clock Division value.
//======================================================================
procedure TIM_SetClockDivision(var TIMx : TTimerRegisters; TIM_CKD : word);
begin
  // Reset the CKD Bits 
  TIMx.CR1 := TIMx.CR1 AND NOT(TIM_CR1_CKD);
  // Set the CKD value 
  TIMx.CR1 := TIMx.CR1 OR TIM_CKD;
end;

//======================================================================
// Gets the TIMx Input Capture 1 value.
//======================================================================
function TIM_GetCapture1(var TIMx : TTimerRegisters) : word;
begin
  // Get the Capture 1 Register value 
  result := TIMx.CCR1;
end;

//======================================================================
// Gets the TIMx Input Capture 2 value.
//======================================================================
function TIM_GetCapture2(var TIMx : TTimerRegisters) : word;
begin
  // Get the Capture 2 Register value 
  result := TIMx.CCR2;
end;

//======================================================================
// Gets the TIMx Input Capture 3 value
//======================================================================
function TIM_GetCapture3(var TIMx : TTimerRegisters) : word;
begin
  // Get the Capture 3 Register value 
  result := TIMx.CCR3;
end;

//======================================================================
// Gets the TIMx Input Capture 4 value.
//======================================================================
function TIM_GetCapture4(var TIMx : TTimerRegisters) : word;
begin
  // Get the Capture 4 Register value 
  result := TIMx.CCR4;
end;

//======================================================================
// Gets the TIMx Counter value.
//======================================================================
function TIM_GetCounter(var TIMx : TTimerRegisters) : word;
begin
  // Get the Counter Register value 
  result := TIMx.CNT;
end;

//======================================================================
// Gets the TIMx Prescaler value.
//======================================================================
function TIM_GetPrescaler(var TIMx : TTimerRegisters) : word;
begin
  // Get the Prescaler Register value 
  result := TIMx.PSC;
end;

//======================================================================
// Checks whether the specified TIM flag is set or not.
//======================================================================
function TIM_GetFlagStatus(var TIMx : TTimerRegisters; TIM_FLAG : word) : boolean;
begin 
  if ((TIMx.SR AND TIM_FLAG) <> 0) then
    exit(TRUE)
  else
    exit(FALSE)
end;

//======================================================================
// Clears the TIMx's pending flags.
//======================================================================
procedure TIM_ClearFlag(var TIMx : TTimerRegisters;  TIM_FLAG : word);
begin  
  // Clear the flags 
  TIMx.SR := NOT(TIM_FLAG);
end;

//======================================================================
// Checks whether the TIM interrupt has occurred or not.
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

//======================================================================
// Clears the TIMx's interrupt pending bits.
//======================================================================  
procedure TIM_ClearITPendingBit(var TIMx : TTimerRegisters; TIM_IT : word);
begin
  // Clear the IT pending Bit 
  TIMx.SR := word(not(TIM_IT));
end;

//======================================================================  
// Configure the TI1 as Input
//======================================================================  
procedure TI1_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word);
var
  tmpccmr1,
	tmpccer : word;
begin
  // Disable the Channel 1: Reset the CC1E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(word(TIM_CCER_CC1E));
  tmpccmr1 := TIMx.CCMR1;
  tmpccer := TIMx.CCER;
	
  // Select the Input and set the filter 
  tmpccmr1 := tmpccmr1 AND word((NOT(word(TIM_CCMR1_CC1S)) AND (NOT(word(TIM_CCMR1_IC1F)))));
  tmpccmr1 := tmpccmr1 OR word(TIM_ICSelection OR (word(TIM_ICFilter shl 4)));
  
  if ((@TIMx = @TIM1) OR (@TIMx = @TIM8) OR (@TIMx = @TIM2) OR (@TIMx = @TIM3) OR
     (@TIMx = @TIM4) OR (@TIMx = @TIM5)) then
  begin
    // Select the Polarity and set the CC1E Bit 
    tmpccer := tmpccer AND NOT(word((TIM_CCER_CC1P)));
    tmpccer := tmpccer OR word(TIM_ICPolarity OR word(TIM_CCER_CC1E));
  end
  else
  begin
    // Select the Polarity and set the CC1E Bit 
    tmpccer := tmpccer AND NOT(word((TIM_CCER_CC1P OR TIM_CCER_CC1NP)));
    tmpccer := tmpccer OR (TIM_ICPolarity OR TIM_CCER_CC1E);
  end;

  // Write to TIMx CCMR1 and CCER registers 
  TIMx.CCMR1 := tmpccmr1;
  TIMx.CCER := tmpccer;
end;

//======================================================================  
// Configure the TI2 as Input
//======================================================================  
procedure TI2_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word);
var
  tmpccmr1,
	tmpccer,
	tmp : word;
begin
  // Disable the Channel 2: Reset the CC2E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(word(TIM_CCER_CC2E));
  tmpccmr1 := TIMx.CCMR1;
  tmpccer := TIMx.CCER;
	
  tmp := word(TIM_ICPolarity shl 4);

  // Select the Input and set the filter 
  tmpccmr1 := tmpccmr1 AND word((NOT(word(TIM_CCMR1_CC2S))) AND (NOT(word(TIM_CCMR1_IC2F))));
  tmpccmr1 := tmpccmr1 OR word(TIM_ICFilter shl 12);
  tmpccmr1 := tmpccmr1 OR word(TIM_ICSelection shl 8);
  
  if((@TIMx = @TIM1) OR (@TIMx = @TIM8) OR (@TIMx = @TIM2) OR (@TIMx = @TIM3) OR
     (@TIMx = @TIM4) OR(@TIMx = @TIM5)) then
  begin
    // Select the Polarity and set the CC2E Bit 
    tmpccer := tmpccer AND NOT(TIM_CCER_CC2P);
    tmpccer := tmpccer OR word(tmp OR TIM_CCER_CC2E);
  end
  else
  begin
    // Select the Polarity and set the CC2E Bit 
    tmpccer := tmpccer AND NOT(TIM_CCER_CC2P OR TIM_CCER_CC2NP);
    tmpccer := tmpccer OR (TIM_ICPolarity OR TIM_CCER_CC2E);
  end;
  
  // Write to TIMx CCMR1 and CCER registers 
  TIMx.CCMR1 := tmpccmr1;
  TIMx.CCER := tmpccer;
end;

//======================================================================  
// Configure the TI3 as Input
//======================================================================  
procedure TI3_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word);
var
  tmpccmr2,
	tmpccer,
	tmp : word;
begin
  // Disable the Channel 3: Reset the CC3E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(TIM_CCER_CC3E);
  tmpccmr2 := TIMx.CCMR2;
  tmpccer := TIMx.CCER;
  tmp := (TIM_ICPolarity shl 8);
  // Select the Input and set the filter 
  tmpccmr2 := tmpccmr2 AND (NOT(TIM_CCMR2_CC3S) AND NOT(TIM_CCMR2_IC3F));
  tmpccmr2 := tmpccmr2 OR (TIM_ICSelection OR (TIM_ICFilter SHL 4));
    
  if((@TIMx = @TIM1) OR (@TIMx = @TIM8) OR (@TIMx = @TIM2) OR (@TIMx = @TIM3) OR
     (@TIMx = @TIM4) OR(@TIMx = @TIM5)) then
  begin
    // Select the Polarity and set the CC3E Bit 
    tmpccer := tmpccer AND NOT(TIM_CCER_CC3P);
    tmpccer := tmpccer OR (tmp OR TIM_CCER_CC3E);
  end
  else
  begin
    // Select the Polarity and set the CC3E Bit 
    tmpccer := tmpccer AND NOT (TIM_CCER_CC3P OR TIM_CCER_CC3NP);
    tmpccer := tmpccer OR (TIM_ICPolarity OR TIM_CCER_CC3E);
  end;
  
  // Write to TIMx CCMR2 and CCER registers 
  TIMx.CCMR2 := tmpccmr2;
  TIMx.CCER := tmpccer;
end;

//======================================================================  
// Configure the TI4 as Input
//======================================================================  
procedure TI4_Config(var TIMx : TTimerRegisters; TIM_ICPolarity : word; TIM_ICSelection : word; TIM_ICFilter : word);
var
	tmp,
	tmpccer,
  tmpccmr2 : word;
begin
   // Disable the Channel 4: Reset the CC4E Bit 
  TIMx.CCER := TIMx.CCER AND NOT(TIM_CCER_CC4E);
  tmpccmr2 := TIMx.CCMR2;
  tmpccer := TIMx.CCER;
  tmp := (TIM_ICPolarity SHL 12);
	
  // Select the Input and set the filter 
  tmpccmr2 := tmpccmr2 AND (NOT(TIM_CCMR2_CC4S) AND NOT(TIM_CCMR2_IC4F));
  tmpccmr2 := tmpccmr2 OR (TIM_ICSelection shl 8);
  tmpccmr2 := tmpccmr2 OR (TIM_ICFilter shl 12);
		
  if((@TIMx = @TIM1) OR (@TIMx = @TIM8) OR (@TIMx = @TIM2) OR (@TIMx = @TIM3) OR
     (@TIMx = @TIM4) OR (@TIMx = @TIM5)) then
  begin
    // Select the Polarity and set the CC4E Bit 
    tmpccer := tmpccer AND NOT(TIM_CCER_CC4P);
    tmpccer := tmpccer OR (tmp OR TIM_CCER_CC4E);
  end
  else
  begin
    // Select the Polarity and set the CC4E Bit 
    tmpccer := tmpccer AND NOT (TIM_CCER_CC3P OR TIM_CCER_CC4NP);
    tmpccer := tmpccer OR (TIM_ICPolarity OR TIM_CCER_CC4E);
  end;
  // Write to TIMx CCMR2 and CCER registers 
  TIMx.CCMR2 := tmpccmr2;
  TIMx.CCER := tmpccer;
end;

end.
