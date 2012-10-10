//======================================================================
unit stm32f1xx_rcc;
//======================================================================
interface

//======================================================================
const
 HSE_Value = 8000000;
 HSI_Value = 8000000;

{ RCC }
//======================================================================
type
  TState = (Disabled = 0, Enabled = 1);

const
{ PLL entry clock source }
 RCC_PLLSource_HSI_Div2           = $00000000;
 RCC_PLLSource_HSE_Div1           = $00010000;
 RCC_PLLSource_HSE_Div2           = $00030000;

{ PLL multiplication factor }
 RCC_PLLMul_2                     = $00000000;
 RCC_PLLMul_3                     = $00040000;
 RCC_PLLMul_4                     = $00080000;
 RCC_PLLMul_5                     = $000C0000;
 RCC_PLLMul_6                     = $00100000;
 RCC_PLLMul_7                     = $00140000;
 RCC_PLLMul_8                     = $00180000;
 RCC_PLLMul_9                     = $001C0000;
 RCC_PLLMul_10                    = $00200000;
 RCC_PLLMul_11                    = $00240000;
 RCC_PLLMul_12                    = $00280000;
 RCC_PLLMul_13                    = $002C0000;
 RCC_PLLMul_14                    = $00300000;
 RCC_PLLMul_15                    = $00340000;
 RCC_PLLMul_16                    = $00380000;

{ System clock source }
 RCC_SYSCLKSource_HSI             = $00000000;
 RCC_SYSCLKSource_HSE             = $00000001;
 RCC_SYSCLKSource_PLLCLK          = $00000002;

{ AHB clock source }
 RCC_SYSCLK_Div1                  = $00000000;
 RCC_SYSCLK_Div2                  = $00000080;
 RCC_SYSCLK_Div4                  = $00000090;
 RCC_SYSCLK_Div8                  = $000000A0;
 RCC_SYSCLK_Div16                 = $000000B0;
 RCC_SYSCLK_Div64                 = $000000C0;
 RCC_SYSCLK_Div128                = $000000D0;
 RCC_SYSCLK_Div256                = $000000E0;
 RCC_SYSCLK_Div512                = $000000F0;

{ APB1/APB2 clock source }
 RCC_HCLK_Div1                    = $00000000;
 RCC_HCLK_Div2                    = $00000400;
 RCC_HCLK_Div4                    = $00000500;
 RCC_HCLK_Div8                    = $00000600;
 RCC_HCLK_Div16                   = $00000700;

{ RCC Interrupt source }
 RCC_IT_LSIRDY                    = $01;
 RCC_IT_LSERDY                    = $02;
 RCC_IT_HSIRDY                    = $04;
 RCC_IT_HSERDY                    = $08;
 RCC_IT_PLLRDY                    = $10;
 RCC_IT_CSS                       = $80;

{ USB clock source }
 RCC_USBCLKSource_PLLCLK_1Div5    = $00;
 RCC_USBCLKSource_PLLCLK_Div1     = $01;

{ ADC clock source }
 RCC_PCLK2_Div2                   = $00000000;
 RCC_PCLK2_Div4                   = $00004000;
 RCC_PCLK2_Div6                   = $00008000;
 RCC_PCLK2_Div8                   = $0000C000;

{ LSE configuration }
 RCC_LSE_OFF                      = $00;
 RCC_LSE_ON                       = $01;
 RCC_LSE_Bypass                   = $04;

{ RTC clock source }
 RCC_RTCCLKSource_LSE             = $00000100;
 RCC_RTCCLKSource_LSI             = $00000200;
 RCC_RTCCLKSource_HSE_Div128      = $00000300;

{ AHB peripheral }
 RCC_AHBPeriph_DMA1               = $00000001;
 RCC_AHBPeriph_DMA2               = $00000002;
 RCC_AHBPeriph_SRAM               = $00000004;
 RCC_AHBPeriph_FLITF              = $00000010;
 RCC_AHBPeriph_FSMC               = $00000100;
 RCC_AHBPeriph_SDIO               = $00000400;

{ APB2 peripheral }
 RCC_APB2Periph_AFIO              = $0001;
 RCC_APB2Periph_GPIOA             = $0004;
 RCC_APB2Periph_GPIOB             = $0008;
 RCC_APB2Periph_GPIOC             = $0010;
 RCC_APB2Periph_GPIOD             = $0020;
 RCC_APB2Periph_GPIOE             = $0040;
 RCC_APB2Periph_GPIOF             = $0080;
 RCC_APB2Periph_GPIOG             = $0100;

 RCC_APB2Periph_ADC1              = $0200;
 RCC_APB2Periph_ADC2              = $0400;
 RCC_APB2Periph_TIM1              = $0800;
 RCC_APB2Periph_SPI1              = $1000;
 RCC_APB2Periph_TIM8              = $2000;
 RCC_APB2Periph_USART1            = $4000;
 
 RCC_APB2Periph_TIM15             = $00010000;
 RCC_APB2Periph_TIM16             = $00020000;
 RCC_APB2Periph_TIM17             = $00040000;
 RCC_APB2Periph_TIM9              = $00080000;
 RCC_APB2Periph_TIM10             = $00100000;
 RCC_APB2Periph_TIM11             = $00200000;

 RCC_APB2Periph_ALL               = $5E7D;

{ APB1 peripheral }
 RCC_APB1Periph_TIM2              = $00000001;
 RCC_APB1Periph_TIM3              = $00000002;
 RCC_APB1Periph_TIM4              = $00000004;
 RCC_APB1Periph_TIM5              = $00000008;
 RCC_APB1Periph_TIM6              = $00000010;
 RCC_APB1Periph_TIM7              = $00000020;
 RCC_APB1Periph_TIM12             = $00000040;
 RCC_APB1Periph_TIM13             = $00000080;
 RCC_APB1Periph_TIM14             = $00000100;
 RCC_APB1Periph_WWDG              = $00000800;
 RCC_APB1Periph_SPI2              = $00004000;
 RCC_APB1Periph_USART2            = $00020000;
 RCC_APB1Periph_USART3            = $00040000;
 RCC_APB1Periph_I2C1              = $00200000;
 RCC_APB1Periph_I2C2              = $00400000;
 RCC_APB1Periph_USB               = $00800000;
 RCC_APB1Periph_CAN               = $02000000;
 RCC_APB1Periph_BKP               = $08000000;
 RCC_APB1Periph_PWR               = $10000000;
 RCC_APB1Periph_ALL               = $1AE64807;

{ Clock source to output on MCO pin }
 RCC_MCO_NoClock                  = $00;
 RCC_MCO_SYSCLK                   = $04;
 RCC_MCO_HSI                      = $05;
 RCC_MCO_HSE                      = $06;
 RCC_MCO_PLLCLK_Div2              = $07;

{ RCC Flag }
 RCC_FLAG_HSIRDY                  = $20;
 RCC_FLAG_HSERDY                  = $31;
 RCC_FLAG_PLLRDY                  = $39;
 RCC_FLAG_LSERDY                  = $41;
 RCC_FLAG_LSIRDY                  = $61;
 RCC_FLAG_PINRST                  = $7A;
 RCC_FLAG_PORRST                  = $7B;
 RCC_FLAG_SFTRST                  = $7C;
 RCC_FLAG_IWDGRST                 = $7D;
 RCC_FLAG_WWDGRST                 = $7E;
 RCC_FLAG_LPWRRST                 = $7F;

const
 RCC_RESET = 0;
 RCC_SET   = 1;

type
 TRCC_ClocksTypeDef = record
  SYSCLK_Frequency,
  HCLK_Frequency,
  PCLK1_Frequency,
  PCLK2_Frequency,
  ADCCLK_Frequency: longword;
 end;

type
 TRCCStatus = (
   RCC_HSE_OFF, 
   RCC_HSE_ON, 
   RCC_HSE_BYPASS
  );

procedure RCC_DeInit;
procedure RCC_HSEConfig(status: TRCCStatus);
function RCC_WaitForHSEStartUp: boolean;
procedure RCC_AdjustHSICalibrationValue(HSICalibrationValue: byte);
procedure RCC_HSICmd(NewState: TState);
function RCC_GetSYSCLKSource: byte;
procedure RCC_PLLConfig(RCC_PLLSource, RCC_PLLMul: longword);
procedure RCC_PLLCmd(NewState: TState);
procedure RCC_SYSCLKConfig(RCC_SYSCLKSource: longword);
procedure RCC_HCLKConfig(RCC_HCLK: longword);
procedure RCC_PCLK1Config(RCC_PCLK1: longword);
procedure RCC_PCLK2Config(RCC_PCLK2: longword);
function RCC_GetFlagStatus(RCC_FLAG: byte): boolean;

procedure RCC_ITConfig(RCC_IT: byte; NewState: TState);
procedure RCC_USBCLKConfig(RCC_USBCLKSource: longword);
procedure RCC_ADCCLKConfig(RCC_ADCCLK: longword);
procedure RCC_LSEConfig(RCC_LSE: longword);
procedure RCC_LSICmd(NewState: TState);
procedure RCC_RTCCLKConfig(RCC_RTCCLKSource: longword);
procedure RCC_RTCCLKCmd(NewState: TState);
procedure RCC_GetClocksFreq(var RCC_Clocks: TRCC_ClocksTypeDef);

procedure RCC_AHBPeriphClockCmd(RCC_AHBPeriph: longword;   NewState: TState);
procedure RCC_APB2PeriphClockCmd(RCC_APB2Periph: longword; NewState: TState);
procedure RCC_APB1PeriphClockCmd(RCC_APB1Periph: longword; NewState: TState);
procedure RCC_APB2PeriphResetCmd(RCC_APB2Periph: longword; NewState: TState);
procedure RCC_APB1PeriphResetCmd(RCC_APB1Periph: longword; NewState: TState);
procedure RCC_BackupResetCmd(NewState: TState);
procedure RCC_ClockSecuritySystemCmd(NewState: TState);
procedure RCC_MCOConfig(RCC_MCO: byte);
procedure RCC_ClearFlag;
function RCC_GetITStatus(RCC_IT: byte): longword;
procedure RCC_ClearITPendingBit(RCC_IT: byte);

implementation

const
 RCC_FLAG_Mask                 = $1F;

 RCC_CR_HSEBYP_Reset           = $FFFBFFFF;
 RCC_CR_HSEBYP_Set             = $00040000;
 RCC_CR_HSEON_Reset            = $FFFEFFFF;
 RCC_CR_HSEON_Set              = $00010000;
 RCC_CR_HSITRIM_Mask           = $FFFFFF07;

 RCC_CFGR_PLL_Mask             = $FFC0FFFF;
 RCC_CFGR_PLLMull_Mask         = $003C0000;
 RCC_CFGR_PLLSRC_Mask          = $00010000;
 RCC_CFGR_PLLXTPRE_Mask        = $00020000;
 RCC_CFGR_SWS_Mask             = $0000000C;
 RCC_CFGR_SW_Mask              = $FFFFFFFC;
 RCC_CFGR_HPRE_Reset_Mask      = $FFFFFF0F;
 RCC_CFGR_HPRE_Set_Mask        = $000000F0;
 RCC_CFGR_PPRE1_Reset_Mask     = $FFFFF8FF;
 RCC_CFGR_PPRE1_Set_Mask       = $00000700;
 RCC_CFGR_PPRE2_Reset_Mask     = $FFFFC7FF;
 RCC_CFGR_PPRE2_Set_Mask       = $00003800;
 RCC_CFGR_ADCPRE_Reset_Mask    = $FFFF3FFF;
 RCC_CFGR_ADCPRE_Set_Mask      = $0000C000;
 RCC_CFGR_USBPRE_Reset_Mask    = $FF7FFFFF;
 RCC_CFGR_USBPRE_Set_Mask      = $00800000;

 APBAHBPrescTable: array[0..15] of byte = (0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9);
 ADCPrescTable: array[0..3] of byte = (2, 4, 6, 8);

const
 HSEStartUp_Timeout = $1FFFF;

//======================================================================
// Resets the RCC clock configuration to the default reset state
//======================================================================
procedure RCC_DeInit;
begin
  // Set HSION bit
  RCC.CR := RCC.CR or 1;

  // Reset SW[1:0], HPRE[3:0], PPRE1[2:0], PPRE2[2:0], ADCPRE[1:0] and MCO[2:0] bits 
{$ifndef STM32F10X_CL}
  RCC.CFGR := RCC.CFGR and $F8FF0000;
{$else}
  RCC.CFGR := R CC.CFGR and $F0FF0000;
{$endif}

  // Reset HSEON, CSSON and PLLON bits 
  RCC.CR := RCC.CR and $FEF6FFFF;

  // Reset HSEBYP bit 
  RCC.CR := RCC.CR and $FFFBFFFF;

  // Reset PLLSRC, PLLXTPRE, PLLMUL[3:0] and USBPRE bits 
  RCC.CFGR := RCC.CFGR and $FF80FFFF;

{$ifdef STM32F10X_CL}
  // Reset PLL2ON and PLL3ON bits 
  RCC.CR := RCC.CR AND $EBFFFFFF;

  // Disable all interrupts and clear pending bits  
  RCC.CIR := $00FF0000;

  // Reset CFGR2 register 
  RCC.CFGR2 := $00000000;

  // Disable all interrupts and clear pending bits  
  RCC.CIR := $009F0000;

  // Reset CFGR2 register 
  RCC.CFGR2 := $00000000;
{$else}
  { Disable all interrupts }
  RCC.CIR := $009F0000;
{$endif}  
 end;

//======================================================================
// Configures the External High Speed oscillator (HSE)
//======================================================================
procedure RCC_HSEConfig(status: TRCCStatus);
begin
  // Reset HSEON and HSEBYP bits before configuring the HSE
  RCC.CR := RCC.CR and RCC_CR_HSEON_Reset;
  RCC.CR := RCC.CR and RCC_CR_HSEBYP_Reset;

  // Configure HSE (RCC_HSE_OFF is already covered by the code section above) 
  case status of
    RCC_HSE_ON:
      RCC.CR := RCC.CR or RCC_CR_HSEON_Set;
    RCC_HSE_BYPASS:
      RCC.CR := RCC.CR or (RCC_CR_HSEON_Set or RCC_CR_HSEBYP_Set);
  end;
end;

//======================================================================
// Waits for HSE start-up
//======================================================================
function RCC_WaitForHSEStartUp : boolean;
var 
  StartUpCounter: longword;
begin
  StartUpCounter := 0;

  while (RCC_GetFlagStatus(RCC_FLAG_HSERDY) = false) and (StartUpCounter < HSEStartUp_Timeout) do
    inc(StartUpCounter);

  exit(RCC_GetFlagStatus(RCC_FLAG_HSERDY));
end;

//======================================================================
// Adjusts the Internal High Speed oscillator (HSI) calibration value
//======================================================================
procedure RCC_AdjustHSICalibrationValue(HSICalibrationValue: byte);
var tmpreg: longword;
begin
  tmpreg := RCC.CR;

  { Clear HSITRIM[7:3] bits }
  tmpreg := tmpreg and RCC_CR_HSITRIM_Mask;

  { Set the HSITRIM[7:3] bits according to HSICalibrationValue value }
  tmpreg := tmpreg or (HSICalibrationValue shl 3);

  { Store the new value }
  RCC.CR := tmpreg;
end;

//======================================================================
// Enables or disables the Internal High Speed oscillator (HSI)
//======================================================================
procedure RCC_HSICmd(NewState: TState);
begin
  if newstate = Enabled then
    RCC.CR := RCC.CR or 1
  else
    RCC.CR := RCC.CR and not (1);
end;

//======================================================================
// Configures the PLL clock source and multiplication factor
//======================================================================
procedure RCC_PLLConfig(RCC_PLLSource, RCC_PLLMul: longword);
var 
  tmpreg: longword;
begin
  tmpreg := RCC.CFGR;

  { Clear PLLSRC, PLLXTPRE and PLLMUL[21:18] bits }
  tmpreg := tmpreg and RCC_CFGR_PLL_Mask;

  { Set the PLL configuration bits }
  tmpreg := tmpreg or (RCC_PLLSource or RCC_PLLMul);

  { Store the new value }
  RCC.CFGR := tmpreg;
end;

//======================================================================
// Enables or disables the PLL
//======================================================================
procedure RCC_PLLCmd(NewState: TState);
begin
  if newstate = Enabled then
    RCC.CR := RCC.CR or $01000000
  else
    RCC.CR := RCC.CR and not($01000000);
end;

{$ifdef STM32F10X_VL OR STM32F10X_CL}
/**
  * @brief  Configures the PREDIV1 division factor.
  * @note 
  *   - This function must be used only when the PLL is disabled.
  *   - This function applies only to STM32 Connectivity line and Value line 
  *     devices.
  * @param  RCC_PREDIV1_Source: specifies the PREDIV1 clock source.
  *   This parameter can be one of the following values:
  *     @arg RCC_PREDIV1_Source_HSE: HSE selected as PREDIV1 clock
  *     @arg RCC_PREDIV1_Source_PLL2: PLL2 selected as PREDIV1 clock
  * @note 
  *   For @b STM32_Value_line_devices this parameter is always RCC_PREDIV1_Source_HSE  
  * @param  RCC_PREDIV1_Div: specifies the PREDIV1 clock division factor.
  *   This parameter can be RCC_PREDIV1_Divx where x:[1,16]
  * @retval None
  */
void RCC_PREDIV1Config(uint32_t RCC_PREDIV1_Source, uint32_t RCC_PREDIV1_Div)
{
  uint32_t tmpreg = 0;
  
  /* Check the parameters */
  assert_param(IS_RCC_PREDIV1_SOURCE(RCC_PREDIV1_Source));
  assert_param(IS_RCC_PREDIV1(RCC_PREDIV1_Div));

  tmpreg = RCC->CFGR2;
  /* Clear PREDIV1[3:0] and PREDIV1SRC bits */
  tmpreg &= ~(CFGR2_PREDIV1 | CFGR2_PREDIV1SRC);
  /* Set the PREDIV1 clock source and division factor */
  tmpreg |= RCC_PREDIV1_Source | RCC_PREDIV1_Div ;
  /* Store the new value */
  RCC->CFGR2 = tmpreg;
}
#endif

#ifdef STM32F10X_CL
/**
  * @brief  Configures the PREDIV2 division factor.
  * @note 
  *   - This function must be used only when both PLL2 and PLL3 are disabled.
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  RCC_PREDIV2_Div: specifies the PREDIV2 clock division factor.
  *   This parameter can be RCC_PREDIV2_Divx where x:[1,16]
  * @retval None
  */
void RCC_PREDIV2Config(uint32_t RCC_PREDIV2_Div)
{
  uint32_t tmpreg = 0;

  /* Check the parameters */
  assert_param(IS_RCC_PREDIV2(RCC_PREDIV2_Div));

  tmpreg = RCC->CFGR2;
  /* Clear PREDIV2[3:0] bits */
  tmpreg &= ~CFGR2_PREDIV2;
  /* Set the PREDIV2 division factor */
  tmpreg |= RCC_PREDIV2_Div;
  /* Store the new value */
  RCC->CFGR2 = tmpreg;
}

/**
  * @brief  Configures the PLL2 multiplication factor.
  * @note
  *   - This function must be used only when the PLL2 is disabled.
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  RCC_PLL2Mul: specifies the PLL2 multiplication factor.
  *   This parameter can be RCC_PLL2Mul_x where x:{[8,14], 16, 20}
  * @retval None
  */
void RCC_PLL2Config(uint32_t RCC_PLL2Mul)
{
  uint32_t tmpreg = 0;

  /* Check the parameters */
  assert_param(IS_RCC_PLL2_MUL(RCC_PLL2Mul));

  tmpreg = RCC->CFGR2;
  /* Clear PLL2Mul[3:0] bits */
  tmpreg &= ~CFGR2_PLL2MUL;
  /* Set the PLL2 configuration bits */
  tmpreg |= RCC_PLL2Mul;
  /* Store the new value */
  RCC->CFGR2 = tmpreg;
}


/**
  * @brief  Enables or disables the PLL2.
  * @note 
  *   - The PLL2 can not be disabled if it is used indirectly as system clock
  *     (i.e. it is used as PLL clock entry that is used as System clock).
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  NewState: new state of the PLL2. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_PLL2Cmd(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));

  *(__IO uint32_t *) CR_PLL2ON_BB = (uint32_t)NewState;
}


/**
  * @brief  Configures the PLL3 multiplication factor.
  * @note 
  *   - This function must be used only when the PLL3 is disabled.
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  RCC_PLL3Mul: specifies the PLL3 multiplication factor.
  *   This parameter can be RCC_PLL3Mul_x where x:{[8,14], 16, 20}
  * @retval None
  */
void RCC_PLL3Config(uint32_t RCC_PLL3Mul)
{
  uint32_t tmpreg = 0;

  /* Check the parameters */
  assert_param(IS_RCC_PLL3_MUL(RCC_PLL3Mul));

  tmpreg = RCC->CFGR2;
  /* Clear PLL3Mul[3:0] bits */
  tmpreg &= ~CFGR2_PLL3MUL;
  /* Set the PLL3 configuration bits */
  tmpreg |= RCC_PLL3Mul;
  /* Store the new value */
  RCC->CFGR2 = tmpreg;
}


/**
  * @brief  Enables or disables the PLL3.
  * @note   This function applies only to STM32 Connectivity line devices.
  * @param  NewState: new state of the PLL3. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_PLL3Cmd(FunctionalState NewState)
{
  /* Check the parameters */

  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) CR_PLL3ON_BB = (uint32_t)NewState;
}
{$endif}

//======================================================================
// Configures the system clock (SYSCLK)
//======================================================================
procedure RCC_SYSCLKConfig(RCC_SYSCLKSource: longword);
var 
  tmpreg: longword;
begin
  tmpreg := RCC.CFGR;

  { Clear SW[1:0] bits }
  tmpreg := tmpreg and RCC_CFGR_SW_Mask;

  { Set SW[1:0] bits according to RCC_SYSCLKSource value }
  tmpreg := tmpreg or RCC_SYSCLKSource;

  { Store the new value }
  RCC.CFGR := tmpreg;
end;

//======================================================================
// Returns the clock source used as system clock
//======================================================================
function RCC_GetSYSCLKSource: byte;
begin
  exit(RCC.CFGR and RCC_CFGR_SWS_Mask);
end;

//======================================================================
// Configures the AHB clock (HCLK)
//======================================================================
procedure RCC_HCLKConfig(RCC_HCLK: longword);
var tmpreg: longword;
begin
  tmpreg := RCC.CFGR;

  { Clear HPRE[7:4] bits }
  tmpreg := tmpreg and RCC_CFGR_HPRE_Reset_Mask;

  { Set HPRE[7:4] bits according to RCC_HCLK value }
  tmpreg := tmpreg or RCC_HCLK;

  { Store the new value }
  RCC.CFGR := tmpreg;
end;

//======================================================================
// Configures the Low Speed APB clock (PCLK1)
//======================================================================
procedure RCC_PCLK1Config(RCC_PCLK1: longword);
var tmpreg: longword;
begin
  tmpreg := RCC.CFGR;

  { Clear PPRE1[10:8] bits }
  tmpreg := tmpreg and RCC_CFGR_PPRE1_Reset_Mask;

  { Set PPRE1[10:8] bits according to RCC_PCLK1 value }
  tmpreg := tmpreg or RCC_PCLK1;

  { Store the new value }
  RCC.CFGR := tmpreg;
end;

//======================================================================
// Configures the High Speed APB clock (PCLK2)
//======================================================================
procedure RCC_PCLK2Config(RCC_PCLK2: longword);
var tmpreg: longword;
begin
  tmpreg := RCC.CFGR;

  { Clear PPRE2[13:11] bits }
  tmpreg := tmpreg and RCC_CFGR_PPRE2_Reset_Mask;

  { Set PPRE2[13:11] bits according to RCC_PCLK2 value }
  tmpreg := tmpreg or (RCC_PCLK2 shl 3);

  { Store the new value }
  RCC.CFGR := tmpreg;
end;

//======================================================================
// Enables or disables the specified RCC interrupts
//======================================================================
procedure RCC_ITConfig(RCC_IT: byte; NewState: TState);
begin
  if newstate = enabled then
    pbyte($40021009)^ := pbyte($40021009)^ or RCC_IT
  else
    pbyte($40021009)^ := pbyte($40021009)^ and not(RCC_IT);
end;

{$ifdef STM32F10X_CL}
//======================================================================
// Configures the USB clock (USBCLK).
//======================================================================
procedure RCC_USBCLKConfig(RCC_USBCLKSource : longword);
begin
//  *(__IO uint32_t *) CFGR_USBPRE_BB = RCC_USBCLKSource;
end;

{$else}
//======================================================================
// Configures the USB OTG FS clock (OTGFSCLK).
//======================================================================
procedure RCC_OTGFSCLKConfig(RCC_OTGFSCLKSource : longword);
begin
//  *(__IO uint32_t *) CFGR_OTGFSPRE_BB = RCC_OTGFSCLKSource;
end;
{$endif}

//======================================================================
function RCC_GetFlagStatus(RCC_FLAG: byte): boolean;
var 
  tmp, 
	statusreg: longword;
begin
  { Get the RCC register index }
  tmp := (RCC_FLAG shr 5);

  if tmp = 1 then
    statusreg := rcc.cr
  else if tmp = 2 then
    statusreg := rcc.bdcr
  else
    statusreg := rcc.csr;

  tmp := RCC_FLAG and RCC_FLAG_Mask;

  if (statusreg and (1 shl tmp)) <> 0 then
    exit(true)
  else
    exit(false);
end;

//======================================================================
procedure RCC_USBCLKConfig(RCC_USBCLKSource: longword);
begin
  if RCC_USBCLKSource = RCC_USBCLKSource_PLLCLK_1Div5 then
    RCC.CFGR := RCC.CFGR and RCC_CFGR_USBPRE_Reset_Mask
  else
    RCC.CFGR := RCC.CFGR or RCC_CFGR_USBPRE_Set_Mask;
end;

//======================================================================
// Configures the ADC clock (ADCCLK)
//======================================================================
procedure RCC_ADCCLKConfig(RCC_ADCCLK: longword);
begin
  RCC.CFGR := (RCC.CFGR and RCC_CFGR_ADCPRE_Reset_Mask) or RCC_ADCCLK;
end;

{$ifdef STM32F10X_CL}
/**
  * @brief  Configures the I2S2 clock source(I2S2CLK).
  * @note
  *   - This function must be called before enabling I2S2 APB clock.
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  RCC_I2S2CLKSource: specifies the I2S2 clock source.
  *   This parameter can be one of the following values:
  *     @arg RCC_I2S2CLKSource_SYSCLK: system clock selected as I2S2 clock entry
  *     @arg RCC_I2S2CLKSource_PLL3_VCO: PLL3 VCO clock selected as I2S2 clock entry
  * @retval None
  */
void RCC_I2S2CLKConfig(uint32_t RCC_I2S2CLKSource)
{
  /* Check the parameters */
  assert_param(IS_RCC_I2S2CLK_SOURCE(RCC_I2S2CLKSource));

  *(__IO uint32_t *) CFGR2_I2S2SRC_BB = RCC_I2S2CLKSource;
}

/**
  * @brief  Configures the I2S3 clock source(I2S2CLK).
  * @note
  *   - This function must be called before enabling I2S3 APB clock.
  *   - This function applies only to STM32 Connectivity line devices.
  * @param  RCC_I2S3CLKSource: specifies the I2S3 clock source.
  *   This parameter can be one of the following values:
  *     @arg RCC_I2S3CLKSource_SYSCLK: system clock selected as I2S3 clock entry
  *     @arg RCC_I2S3CLKSource_PLL3_VCO: PLL3 VCO clock selected as I2S3 clock entry
  * @retval None
  */
void RCC_I2S3CLKConfig(uint32_t RCC_I2S3CLKSource)
{
  /* Check the parameters */
  assert_param(IS_RCC_I2S3CLK_SOURCE(RCC_I2S3CLKSource));

  *(__IO uint32_t *) CFGR2_I2S3SRC_BB = RCC_I2S3CLKSource;
}
{$endif}

//======================================================================
// Configures the External Low Speed oscillator (LSE)
//======================================================================
procedure RCC_LSEConfig(RCC_LSE: longword);
begin
  RCC.BDCR := RCC_LSE_OFF;
  RCC.BDCR := RCC_LSE_OFF;

  case RCC_LSE of
    RCC_LSE_ON:
      RCC.BDCR := RCC_LSE_ON;
    RCC_LSE_Bypass:
      RCC.BDCR := RCC_LSE_ON or RCC_LSE_Bypass;
  end;
end;

//======================================================================
// Enables or disables the Internal Low Speed oscillator (LSI)
//======================================================================
procedure RCC_LSICmd(NewState: TState);
begin
  if NewState = Enabled then
    RCC.CSR := RCC.CSR or 1
  else
    RCC.CSR := RCC.CSR and not(1);
end;

//======================================================================
// Configures the RTC clock (RTCCLK)
//======================================================================
procedure RCC_RTCCLKConfig(RCC_RTCCLKSource: longword);
begin
  RCC.BDCR := RCC.BDCR or RCC_RTCCLKSource;
end;

//======================================================================
// Enables or disables the RTC clock
//======================================================================
procedure RCC_RTCCLKCmd(NewState: TState);
begin
  if NewState = Enabled then
    RCC.BDCR := RCC.BDCR or $8000
  else
    RCC.BDCR := RCC.BDCR and not($8000);
end;

//======================================================================
// Returns the frequencies of different on chip clocks
//======================================================================
procedure RCC_GetClocksFreq(var RCC_Clocks: TRCC_ClocksTypeDef);
var 
  tmp, 
	pllmull, 
	pllsource, 
	presc: longword;
begin
  { Get SYSCLK source }
  tmp := RCC.CFGR and RCC_CFGR_SWS_Mask;

  case tmp of
    $00: // HSI used as system clock 
      RCC_Clocks.SYSCLK_Frequency := HSI_Value;
    $04: // HSE used as system clock 
      RCC_Clocks.SYSCLK_Frequency := HSE_Value;
    $08: // PLL used as system clock 
      begin
        // Get PLL clock source and multiplication factor
        pllmull := RCC.CFGR and RCC_CFGR_PLLMull_Mask;
        pllsource := RCC.CFGR and RCC_CFGR_PLLSRC_Mask;

{$ifndef STM32F10X_CL}
				pllmull := ( pllmull shr 18) + 2;
				
				if (pllsource = 0) then
				begin
					// HSI oscillator clock divided by 2 selected as PLL clock entry 
					RCC_Clocks.SYSCLK_Frequency := (HSI_VALUE shr 1) * pllmull;
				end
				else
				begin
  {$ifdef STM32F10X_LD_VL OR STM32F10X_MD_VL OR STM32F10X_HD_VL}
				 prediv1factor := (RCC.CFGR2 AND CFGR2_PREDIV1) + 1;
				 // HSE oscillator clock selected as PREDIV1 clock entry 
				 RCC_Clocks.SYSCLK_Frequency := (HSE_VALUE / prediv1factor) * pllmull; 
  {$else}
				 // HSE selected as PLL clock entry 
				 if ((RCC.CFGR AND RCC_CFGR_PLLXTPRE_Mask) <> RCC_RESET) then
					begin 
						// HSE oscillator clock divided by 2 
						RCC_Clocks.SYSCLK_Frequency := (HSE_VALUE SHR 1) * pllmull;
					end
					else
					begin
						RCC_Clocks.SYSCLK_Frequency := HSE_VALUE * pllmull;
					end;
  {$endif}
				end;
{$else}
				pllmull := pllmull SHR 18;
				
				if (pllmull <> $0D) then
				begin
					 pllmull := pllmull + 2;
				end
				else
				begin 
					// PLL multiplication factor = PLL input clock * 6.5 
					pllmull := 13 / 2; 
				end;
							
				if (pllsource = 0) then
				begin
					// HSI oscillator clock divided by 2 selected as PLL clock entry 
					RCC_Clocks.SYSCLK_Frequency := (HSI_VALUE shr 1) * pllmull;
				end
				else
				begin
					// PREDIV1 selected as PLL clock entry 
					
					// Get PREDIV1 clock source and division factor 
					prediv1source := RCC.CFGR2 AND CFGR2_PREDIV1SRC;
					prediv1factor := (RCC.CFGR2 AND CFGR2_PREDIV1) + 1;
					
					if (prediv1source = 0) then
					begin
						// HSE oscillator clock selected as PREDIV1 clock entry 
						RCC_Clocks.SYSCLK_Frequency := (HSE_VALUE / prediv1factor) * pllmull;          
					end
					else
					begin
						// PLL2 clock selected as PREDIV1 clock entry 
						
						// Get PREDIV2 division factor and PLL2 multiplication factor 
						prediv2factor := ((RCC.CFGR2 AND CFGR2_PREDIV2) SHR 4) + 1;
						pll2mull := ((RCC.CFGR2 AND CFGR2_PLL2MUL) SHR 8 ) + 2; 
						RCC_Clocks.SYSCLK_Frequency := (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
					end;
				end;
	{$endif}
  	    end
			else
				RCC_Clocks.SYSCLK_Frequency := HSI_Value;
		  end;

  // Compute HCLK, PCLK1, PCLK2 and ADCCLK clocks frequencies
  // Get HCLK prescaler 
  tmp := RCC.CFGR and RCC_CFGR_HPRE_Set_Mask;
  tmp := tmp shr 4;
  presc := APBAHBPrescTable[tmp];

  // HCLK clock frequency 
  RCC_Clocks.HCLK_Frequency := RCC_Clocks.SYSCLK_Frequency shr presc;

  // Get PCLK1 prescaler 
  tmp := RCC.CFGR and RCC_CFGR_PPRE1_Set_Mask;
  tmp := tmp shr 8;
  presc := APBAHBPrescTable[tmp];

  // PCLK1 clock frequency 
  RCC_Clocks.PCLK1_Frequency := RCC_Clocks.HCLK_Frequency shr presc;

  // Get PCLK2 prescaler 
  tmp := RCC.CFGR and RCC_CFGR_PPRE2_Set_Mask;
  tmp := tmp shr 11;
  presc := APBAHBPrescTable[tmp];

  // PCLK2 clock frequency 
  RCC_Clocks.PCLK2_Frequency := RCC_Clocks.HCLK_Frequency shr presc;

  // Get ADCCLK prescaler 
  tmp := RCC.CFGR and RCC_CFGR_ADCPRE_Set_Mask;
  tmp := tmp shr 14;
  presc := ADCPrescTable[tmp];

  // ADCCLK clock frequency 
  RCC_Clocks.ADCCLK_Frequency := RCC_Clocks.PCLK2_Frequency div presc;
end;

//======================================================================
procedure RCC_AHBPeriphClockCmd(RCC_AHBPeriph: longword; NewState: TState);
begin
  if newstate = enabled then
    RCC.AHBENR := RCC.AHBENR or RCC_AHBPeriph
  else
    RCC.AHBENR := RCC.AHBENR and not(RCC_AHBPeriph);
end;

//======================================================================
procedure RCC_APB2PeriphClockCmd(RCC_APB2Periph: longword; NewState: TState);
begin
  if newstate = enabled then
    RCC.APB2ENR := RCC.APB2ENR or RCC_APB2Periph
  else
    RCC.APB2ENR := RCC.APB2ENR and not(RCC_APB2Periph);
end;

//======================================================================
procedure RCC_APB1PeriphClockCmd(RCC_APB1Periph: longword; NewState: TState);
begin
  if newstate = enabled then
    RCC.APB1ENR := RCC.APB1ENR or RCC_APB1Periph
  else
    RCC.APB1ENR := RCC.APB1ENR and not(RCC_APB1Periph);
end;

//======================================================================
procedure RCC_APB2PeriphResetCmd(RCC_APB2Periph: longword; NewState: TState);
begin
  if newstate = enabled then
    RCC.APB2RSTR := RCC.APB2RSTR or RCC_APB2Periph
  else
    RCC.APB2RSTR := RCC.APB2RSTR and not(RCC_APB2Periph);
end;

//======================================================================
procedure RCC_APB1PeriphResetCmd(RCC_APB1Periph: longword; NewState: TState);
begin
  if newstate = enabled then
    RCC.APB1RSTR := RCC.APB1RSTR or RCC_APB1Periph
  else
    RCC.APB1RSTR := RCC.APB1RSTR and not(RCC_APB1Periph);
end;

//======================================================================
procedure RCC_BackupResetCmd(NewState: TState);
begin
  if newstate = enabled then
    RCC.BDCR := RCC.BDCR or $400
  else
    RCC.BDCR := RCC.BDCR and not($400);
end;

//======================================================================
procedure RCC_ClockSecuritySystemCmd(NewState: TState);
begin
  if newstate = enabled then
    RCC.CR := RCC.CR or $80000
  else
    RCC.CR := RCC.CR and not($80000);
end;

//======================================================================
procedure RCC_MCOConfig(RCC_MCO: byte);
begin
  pbyte($40021007)^ := RCC_MCO;
end;

//======================================================================
procedure RCC_ClearFlag;
begin
  RCC.CSR := RCC.CSR or $01000000;
end;

//======================================================================
function RCC_GetITStatus(RCC_IT: byte): longword;
begin
  if (RCC.CIR and RCC_IT) <> RCC_RESET then
    exit(RCC_SET)
  else
    exit(RCC_RESET);
end;

//======================================================================
procedure RCC_ClearITPendingBit(RCC_IT: byte);
begin
  pbyte($4002100A)^ := RCC_IT;
end;

end.
