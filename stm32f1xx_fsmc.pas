//======================================================================
unit stm32f1xx_fsmc;

//======================================================================
interface
uses stm32f1xx_rcc;

type
  TFSMC_NORSRAMTimingInitTypeDef = record
    FSMC_AddressSetupTime      : dword; // Defines the number of HCLK cycles to configure
    FSMC_AddressHoldTime       : dword; // Defines the number of HCLK cycles to configure
    FSMC_DataSetupTime         : dword; // Defines the number of HCLK cycles to configure
    FSMC_BusTurnAroundDuration : dword; // Defines the number of HCLK cycles to configure
    FSMC_CLKDivision           : dword; // Defines the period of CLK clock output signal, expressed in number of HCLK cycles.
    FSMC_DataLatency           : dword; // Defines the number of memory clock cycles to issue
    FSMC_AccessMode            : dword; // Specifies the asynchronous access mode.
  end;

  TFSMC_NORSRAMInitTypeDef = record
    FSMC_Bank               : dword; // Specifies the NOR/SRAM memory bank that will be used.
    FSMC_DataAddressMux     : dword; // Specifies whether the address and data values are
    FSMC_MemoryType         : dword; // Specifies the type of external memory attached to
    FSMC_MemoryDataWidth    : dword; // Specifies the external memory device width.
    FSMC_BurstAccessMode    : dword; // Enables or disables the burst access mode for Flash memory,
    FSMC_WaitSignalPolarity : dword; // Specifies the wait signal polarity, valid only when accessing
    FSMC_WrapMode           : dword; // Enables or disables the Wrapped burst access mode for Flash
    FSMC_WaitSignalActive   : dword; // Specifies if the wait signal is asserted by the memory one
    FSMC_WriteOperation     : dword; // Enables or disables the write operation in the selected bank by the FSMC.
    FSMC_WaitSignal         : dword; // Enables or disables the wait-state insertion via wait
    FSMC_ExtendedMode       : dword; // Enables or disables the extended mode.
    FSMC_WriteBurst         : dword; // Enables or disables the write burst operation.
    FSMC_ReadWriteTimingStruct : TFSMC_NORSRAMTimingInitTypeDef; // Timing Parameters for write and read access if the  ExtendedMode is not used
    FSMC_WriteTimingStruct     : TFSMC_NORSRAMTimingInitTypeDef; // Timing Parameters for write access if the  ExtendedMode is used
  end;

  TFSMC_NAND_PCCARDTimingInitTypeDef = record
    FSMC_SetupTime     : dword; // Defines the number of HCLK cycles to setup address before
    FSMC_WaitSetupTime : dword; // Defines the minimum number of HCLK cycles to assert the
    FSMC_HoldSetupTime : dword; // Defines the number of HCLK clock cycles to hold address
    FSMC_HiZSetupTime  : dword; // Defines the number of HCLK clock cycles during which the
  end;

  TFSMC_NANDInitTypeDef = record
    FSMC_Bank             : dword; // Specifies the NAND memory bank that will be used.
    FSMC_Waitfeature      : dword; // Enables or disables the Wait feature for the NAND Memory Bank.
    FSMC_MemoryDataWidth  : dword; // Specifies the external memory device width.
    FSMC_ECC              : dword; // Enables or disables the ECC computation.
    FSMC_ECCPageSize      : dword; // Defines the page size for the extended ECC.
    FSMC_TCLRSetupTime    : dword; // Defines the number of HCLK cycles to configure the
    FSMC_TARSetupTime     : dword; // Defines the number of HCLK cycles to configure the
    FSMC_CommonSpaceTimingStruct    : TFSMC_NAND_PCCARDTimingInitTypeDef; // FSMC Common Space Timing
    FSMC_AttributeSpaceTimingStruct : TFSMC_NAND_PCCARDTimingInitTypeDef; // FSMC Attribute Space Timing
  end;

  TFSMC_PCCARDInitTypeDef = record
    FSMC_Waitfeature    : dword; // Enables or disables the Wait feature for the Memory Bank.
    FSMC_TCLRSetupTime  : dword; // Defines the number of HCLK cycles to configure the
    FSMC_TARSetupTime   : dword; // Defines the number of HCLK cycles to configure the
    FSMC_CommonSpaceTimingStruct    : TFSMC_NAND_PCCARDTimingInitTypeDef; // FSMC Common Space Timing
    FSMC_AttributeSpaceTimingStruct : TFSMC_NAND_PCCARDTimingInitTypeDef; // FSMC Attribute Space Timing
    FSMC_IOSpaceTimingStruct        : TFSMC_NAND_PCCARDTimingInitTypeDef; // FSMC IO Space Timing
  end;

const
  FSMC_Bank1_NORSRAM1                      = $00000000;
  FSMC_Bank1_NORSRAM2                      = $00000002;
  FSMC_Bank1_NORSRAM3                      = $00000004;
  FSMC_Bank1_NORSRAM4                      = $00000006;

  FSMC_Bank2_NAND                          = $00000010;
  FSMC_Bank3_NAND                          = $00000100;

  FSMC_Bank4_PCCARD                        = $00001000;

  FSMC_DataAddressMux_Disable              = $00000000;
  FSMC_DataAddressMux_Enable               = $00000002;

  FSMC_MemoryType_SRAM                     = $00000000;
  FSMC_MemoryType_PSRAM                    = $00000004;
  FSMC_MemoryType_NOR                      = $00000008 + $00000040;

  FSMC_MemoryDataWidth_8b                  = $00000000;
  FSMC_MemoryDataWidth_16b                 = $00000010;

  FSMC_BurstAccessMode_Disable             = $00000000;
  FSMC_BurstAccessMode_Enable              = $00000100;

  FSMC_WaitSignalPolarity_Low              = $00000000;
  FSMC_WaitSignalPolarity_High             = $00000200;

  FSMC_WrapMode_Disable                    = $00000000;
  FSMC_WrapMode_Enable                     = $00000400;

  FSMC_WaitSignalActive_BeforeWaitState    = $00000000;
  FSMC_WaitSignalActive_DuringWaitState    = $00000800;

  FSMC_WriteOperation_Disable              = $00000000;
  FSMC_WriteOperation_Enable               = $00001000;

  FSMC_WaitSignal_Disable                  = $00000000;
  FSMC_WaitSignal_Enable                   = $00002000;

  FSMC_ExtendedMode_Disable                = $00000000;
  FSMC_ExtendedMode_Enable                 = $00004000;

  FSMC_WriteBurst_Disable                  = $00000000;
  FSMC_WriteBurst_Enable                   = $00080000;

  FSMC_AccessMode_A                        = $00000000;
  FSMC_AccessMode_B                        = $10000000;
  FSMC_AccessMode_C                        = $20000000;
  FSMC_AccessMode_D                        = $30000000;

  FSMC_Waitfeature_Disable                 = $00000000;
  FSMC_Waitfeature_Enable                  = $00000002;

  FSMC_ECC_Disable                         = $00000000;
  FSMC_ECC_Enable                          = $00000040;

  FSMC_ECCPageSize_256Bytes                = $00000000;
  FSMC_ECCPageSize_512Bytes                = $00020000;
  FSMC_ECCPageSize_1024Bytes               = $00040000;
  FSMC_ECCPageSize_2048Bytes               = $00060000;
  FSMC_ECCPageSize_4096Bytes               = $00080000;
  FSMC_ECCPageSize_8192Bytes               = $000A0000;

  FSMC_IT_RisingEdge                       = $00000008;
  FSMC_IT_Level                            = $00000010;
  FSMC_IT_FallingEdge                      = $00000020;

  FSMC_FLAG_RisingEdge                     = $00000001;
  FSMC_FLAG_Level                          = $00000002;
  FSMC_FLAG_FallingEdge                    = $00000004;
  FSMC_FLAG_FEMPT                          = $00000040;

  //IS_FSMC_CLEAR_FLAG(FLAG) ((((FLAG) & (uint32_t)0xFFFFFFF8) == 0x00000000) && ((FLAG) != 0x00000000))

procedure FSMC_NORSRAMDeInit(FSMC_Bank : dword);
procedure FSMC_NANDDeInit(FSMC_Bank : dword);
procedure FSMC_PCCARDDeInit;
procedure FSMC_NORSRAMInit(var FSMC_NORSRAMInitStruct : TFSMC_NORSRAMInitTypeDef);
procedure FSMC_NANDInit(var FSMC_NANDInitStruct : TFSMC_NANDInitTypeDef);
procedure FSMC_PCCARDInit(var FSMC_PCCARDInitStruct : TFSMC_PCCARDInitTypeDef);
procedure FSMC_NORSRAMStructInit(var FSMC_NORSRAMInitStruct : TFSMC_NORSRAMInitTypeDef);
procedure FSMC_NANDStructInit(var FSMC_NANDInitStruct : TFSMC_NANDInitTypeDef);
procedure FSMC_PCCARDStructInit(var FSMC_PCCARDInitStruct : TFSMC_PCCARDInitTypeDef);
procedure FSMC_NORSRAMCmd(FSMC_Bank : dword; NewState : TState);
procedure FSMC_NANDCmd(FSMC_Bank : dword; NewState : TState);
procedure FSMC_PCCARDCmd(NewState : TState);
procedure FSMC_NANDECCCmd(FSMC_Bank : dword; NewState : TState);
function FSMC_GetECC(FSMC_Bank : dword) : word;
procedure FSMC_ITConfig(FSMC_Bank, FSMC_IT : dword; NewState : TState);
function FSMC_GetFlagStatus(FSMC_Bank, FSMC_FLAG : dword) : dword;
procedure FSMC_ClearFlag(FSMC_Bank, FSMC_FLAG : dword);
function FSMC_GetITStatus(FSMC_Bank, FSMC_IT : dword) : word;
procedure FSMC_ClearITPendingBit(FSMC_Bank, FSMC_IT : dword);

implementation

const
  BCR_MBKEN_Set               = $00000001;
  BCR_MBKEN_Reset             = $000FFFFE;
  BCR_FACCEN_Set              = $00000040;

  PCR_PBKEN_Set               = $00000004;
  PCR_PBKEN_Reset             = $000FFFFB;
  PCR_ECCEN_Set               = $00000040;
  PCR_ECCEN_Reset             = $000FFFBF;
  PCR_MemoryType_NAND         = $00000008;


//===================================
// Deinitializes the FSMC NOR/SRAM Banks registers to their default
// reset values.
//===================================
procedure FSMC_NORSRAMDeInit(FSMC_Bank : dword);
begin
  case FSMC_Bank of
    FSMC_Bank1_NORSRAM1 :
      begin
        FSMC_Bank1.BCR1   := $000030DA;
        FSMC_Bank1.BTR1   := $0FFFFFFF;
        FSMC_Bank1E.BWTR1 := $0FFFFFFF;
      end;
    FSMC_Bank1_NORSRAM2 :
      begin
        FSMC_Bank1.BCR2   := $000030D2;
        FSMC_Bank1.BTR2   := $0FFFFFFF;
        FSMC_Bank1E.BWTR2 := $0FFFFFFF;
      end;
    FSMC_Bank1_NORSRAM3 :
      begin
        FSMC_Bank1.BCR3   := $000030D2;
        FSMC_Bank1.BTR3   := $0FFFFFFF;
        FSMC_Bank1E.BWTR3 := $0FFFFFFF;
      end;
    FSMC_Bank1_NORSRAM4 :
      begin
        FSMC_Bank1.BCR4   := $000030D2;
        FSMC_Bank1.BTR4   := $0FFFFFFF;
        FSMC_Bank1E.BWTR4 := $0FFFFFFF;
      end;
  end;
end;

//======================================================================
// Deinitializes the FSMC NAND Banks registers to their default reset values.
//======================================================================
procedure FSMC_NANDDeInit(FSMC_Bank : dword);
begin
  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    // Set the FSMC_Bank2 registers to their reset values
    FSMC_Bank2.PCR2  := $00000018;
    FSMC_Bank2.SR2   := $00000040;
    FSMC_Bank2.PMEM2 := $FCFCFCFC;
    FSMC_Bank2.PATT2 := $FCFCFCFC;
  end
  // FSMC_Bank3_NAND
  else
  begin
    // Set the FSMC_Bank3 registers to their reset values
    FSMC_Bank3.PCR3  := $00000018;
    FSMC_Bank3.SR3   := $00000040;
    FSMC_Bank3.PMEM3 := $FCFCFCFC;
    FSMC_Bank3.PATT3 := $FCFCFCFC;
  end;
end;

//======================================================================
// Deinitializes the FSMC PCCARD Bank registers to their default reset values.
//======================================================================
procedure FSMC_PCCARDDeInit;
begin
  // Set the FSMC_Bank4 registers to their reset values
  FSMC_Bank4.PCR4  := $00000018;
  FSMC_Bank4.SR4   := $00000000;
  FSMC_Bank4.PMEM4 := $FCFCFCFC;
  FSMC_Bank4.PATT4 := $FCFCFCFC;
  FSMC_Bank4.PIO4  := $FCFCFCFC;
end;

//======================================================================
// Initializes the FSMC NOR/SRAM Banks according to the specified
// parameters in the FSMC_NORSRAMInitStruct.
//======================================================================
procedure FSMC_NORSRAMInit(var FSMC_NORSRAMInitStruct : TFSMC_NORSRAMInitTypeDef);
var
  BCRvalue,
  BTRvalue,
  BWTRvalue : dword;
begin
  BCRvalue := dword(FSMC_NORSRAMInitStruct.FSMC_DataAddressMux OR
                    FSMC_NORSRAMInitStruct.FSMC_MemoryType OR
                    FSMC_NORSRAMInitStruct.FSMC_MemoryDataWidth OR
                    FSMC_NORSRAMInitStruct.FSMC_BurstAccessMode OR
                    FSMC_NORSRAMInitStruct.FSMC_WaitSignalPolarity OR
                    FSMC_NORSRAMInitStruct.FSMC_WrapMode OR
                    FSMC_NORSRAMInitStruct.FSMC_WaitSignalActive OR
                    FSMC_NORSRAMInitStruct.FSMC_WriteOperation OR
                    FSMC_NORSRAMInitStruct.FSMC_WaitSignal OR
                    FSMC_NORSRAMInitStruct.FSMC_ExtendedMode OR
                    FSMC_NORSRAMInitStruct.FSMC_WriteBurst);

  BTRvalue := dword(dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AddressSetupTime) OR
                  dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AddressHoldTime SHL 4) OR
                  dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_DataSetupTime SHL 8) OR
                  dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_BusTurnAroundDuration SHL 16) OR
                  dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_CLKDivision SHL 20) OR
                  dword(FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_DataLatency SHL 24) OR
                    FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AccessMode);


  if (FSMC_NORSRAMInitStruct.FSMC_ExtendedMode = FSMC_ExtendedMode_Enable) then
  begin
    BWTRvalue := dword(FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AddressSetupTime OR
                      (FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AddressHoldTime SHL 4 )OR
                      (FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_DataSetupTime SHL 8) OR
                      (FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_CLKDivision SHL 20) OR
                      (FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_DataLatency SHL 24) OR
                       FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AccessMode);
  end
  else
  begin
    BWTRvalue := $0FFFFFFF;
  end;

  case FSMC_NORSRAMInitStruct.FSMC_Bank of
    FSMC_Bank1_NORSRAM1 :
      begin
        FSMC_Bank1.BCR1   := BCRvalue;
        FSMC_Bank1.BTR1   := BTRvalue;
        FSMC_Bank1E.BWTR1 := BWTRvalue;
      end;
    FSMC_Bank1_NORSRAM2 :
      begin
        FSMC_Bank1.BCR2   := BCRvalue;
        FSMC_Bank1.BTR2   := BTRvalue;
        FSMC_Bank1E.BWTR2 := BWTRvalue;
      end;
    FSMC_Bank1_NORSRAM3 :
      begin
        FSMC_Bank1.BCR3   := BCRvalue;
        FSMC_Bank1.BTR3   := BTRvalue;
        FSMC_Bank1E.BWTR3 := BWTRvalue;
      end;
    FSMC_Bank1_NORSRAM4 :
      begin
        FSMC_Bank1.BCR4   := BCRvalue;
        FSMC_Bank1.BTR4   := BTRvalue;
        FSMC_Bank1E.BWTR4 := BWTRvalue;
      end;
  end;
end;

//======================================================================
// Initializes the FSMC NAND Banks according to the specified
// parameters in the FSMC_NANDInitStruct.
//======================================================================
procedure FSMC_NANDInit(var FSMC_NANDInitStruct : TFSMC_NANDInitTypeDef);
var
  tmppcr,
  tmppmem,
  tmppatt  : dword;
begin
  tmppcr   := $00000000;
  tmppmem  := $00000000;
  tmppatt  := $00000000;

  // Set the tmppcr value according to FSMC_NANDInitStruct parameters
  tmppcr := FSMC_NANDInitStruct.FSMC_Waitfeature OR
            PCR_MemoryType_NAND OR
            FSMC_NANDInitStruct.FSMC_MemoryDataWidth OR
            FSMC_NANDInitStruct.FSMC_ECC OR
            FSMC_NANDInitStruct.FSMC_ECCPageSize OR
            (FSMC_NANDInitStruct.FSMC_TCLRSetupTime SHL 9 )OR
            (FSMC_NANDInitStruct.FSMC_TARSetupTime SHL 13);

  // Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters
  tmppmem := FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_SetupTime OR
            (FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_WaitSetupTime SHL 8) OR
            (FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HoldSetupTime SHL 16)OR
            (FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HiZSetupTime SHL 24);

  // Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters
  tmppatt := FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_SetupTime OR
            (FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_WaitSetupTime SHL 8) OR
            (FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HoldSetupTime SHL 16)OR
            (FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HiZSetupTime SHL 24);

  if (FSMC_NANDInitStruct.FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    // FSMC_Bank2_NAND registers configuration
    FSMC_Bank2.PCR2  := tmppcr;
    FSMC_Bank2.PMEM2 := tmppmem;
    FSMC_Bank2.PATT2 := tmppatt;
  end
  else
  begin
    // FSMC_Bank3_NAND registers configuration
    FSMC_Bank3.PCR3  := tmppcr;
    FSMC_Bank3.PMEM3 := tmppmem;
    FSMC_Bank3.PATT3 := tmppatt;
  end;
end;

//======================================================================
// Initializes the FSMC PCCARD Bank according to the specified
// parameters in the FSMC_PCCARDInitStruct.
//======================================================================
procedure FSMC_PCCARDInit(var FSMC_PCCARDInitStruct : TFSMC_PCCARDInitTypeDef);
begin
  // Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters
  FSMC_Bank4.PCR4 := FSMC_PCCARDInitStruct.FSMC_Waitfeature OR
                     FSMC_MemoryDataWidth_16b OR
                     (FSMC_PCCARDInitStruct.FSMC_TCLRSetupTime SHL 9) OR
                     (FSMC_PCCARDInitStruct.FSMC_TARSetupTime SHL 13);

  // Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters
  FSMC_Bank4.PMEM4 := FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_SetupTime OR
                      (FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_WaitSetupTime SHL 8) OR
                      (FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HoldSetupTime SHL 16)OR
                      (FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HiZSetupTime SHL 24);

  // Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters
  FSMC_Bank4.PATT4 := FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_SetupTime OR
                      (FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_WaitSetupTime SHL 8) OR
                      (FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HoldSetupTime SHL 16)OR
                      (FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HiZSetupTime SHL 24);

  // Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters
  FSMC_Bank4.PIO4 := FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_SetupTime OR
                     (FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_WaitSetupTime SHL 8) OR
                     (FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_HoldSetupTime SHL 16)OR
                     (FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_HiZSetupTime SHL 24);
end;

//======================================================================
// Fills each FSMC_NORSRAMInitStruct member with its default value.
//======================================================================
procedure FSMC_NORSRAMStructInit(var FSMC_NORSRAMInitStruct : TFSMC_NORSRAMInitTypeDef);
begin
  // Reset NOR/SRAM Init structure parameters values
  FSMC_NORSRAMInitStruct.FSMC_Bank := FSMC_Bank1_NORSRAM1;
  FSMC_NORSRAMInitStruct.FSMC_DataAddressMux := FSMC_DataAddressMux_Enable;
  FSMC_NORSRAMInitStruct.FSMC_MemoryType := FSMC_MemoryType_SRAM;
  FSMC_NORSRAMInitStruct.FSMC_MemoryDataWidth := FSMC_MemoryDataWidth_8b;
  FSMC_NORSRAMInitStruct.FSMC_BurstAccessMode := FSMC_BurstAccessMode_Disable;
  FSMC_NORSRAMInitStruct.FSMC_WaitSignalPolarity := FSMC_WaitSignalPolarity_Low;
  FSMC_NORSRAMInitStruct.FSMC_WrapMode := FSMC_WrapMode_Disable;
  FSMC_NORSRAMInitStruct.FSMC_WaitSignalActive := FSMC_WaitSignalActive_BeforeWaitState;
  FSMC_NORSRAMInitStruct.FSMC_WriteOperation := FSMC_WriteOperation_Enable;
  FSMC_NORSRAMInitStruct.FSMC_WaitSignal := FSMC_WaitSignal_Enable;
  FSMC_NORSRAMInitStruct.FSMC_ExtendedMode := FSMC_ExtendedMode_Disable;
  FSMC_NORSRAMInitStruct.FSMC_WriteBurst := FSMC_WriteBurst_Disable;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AddressSetupTime := $F;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AddressHoldTime := $F;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_DataSetupTime := $FF;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_BusTurnAroundDuration := $F;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_CLKDivision := $F;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_DataLatency := $F;
  FSMC_NORSRAMInitStruct.FSMC_ReadWriteTimingStruct.FSMC_AccessMode := FSMC_AccessMode_A;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AddressSetupTime := $F;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AddressHoldTime := $F;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_DataSetupTime := $FF;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_BusTurnAroundDuration := $F;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_CLKDivision := $F;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_DataLatency := $F;
  FSMC_NORSRAMInitStruct.FSMC_WriteTimingStruct.FSMC_AccessMode := FSMC_AccessMode_A;
end;

//======================================================================
// Fills each FSMC_NANDInitStruct member with its default value.
//======================================================================
procedure FSMC_NANDStructInit(var FSMC_NANDInitStruct : TFSMC_NANDInitTypeDef);
begin
  // Reset NAND Init structure parameters values
  FSMC_NANDInitStruct.FSMC_Bank := FSMC_Bank2_NAND;
  FSMC_NANDInitStruct.FSMC_Waitfeature := FSMC_Waitfeature_Disable;
  FSMC_NANDInitStruct.FSMC_MemoryDataWidth := FSMC_MemoryDataWidth_8b;
  FSMC_NANDInitStruct.FSMC_ECC := FSMC_ECC_Disable;
  FSMC_NANDInitStruct.FSMC_ECCPageSize := FSMC_ECCPageSize_256Bytes;
  FSMC_NANDInitStruct.FSMC_TCLRSetupTime := $0;
  FSMC_NANDInitStruct.FSMC_TARSetupTime := $0;
  FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_SetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_WaitSetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HoldSetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HiZSetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_SetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_WaitSetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HoldSetupTime := $FC;
  FSMC_NANDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HiZSetupTime := $FC;
end;

//======================================================================
// Fills each FSMC_PCCARDInitStruct member with its default value.
//======================================================================
procedure FSMC_PCCARDStructInit(var FSMC_PCCARDInitStruct : TFSMC_PCCARDInitTypeDef);
begin
  // Reset PCCARD Init structure parameters values
  FSMC_PCCARDInitStruct.FSMC_Waitfeature := FSMC_Waitfeature_Disable;
  FSMC_PCCARDInitStruct.FSMC_TCLRSetupTime := $0;
  FSMC_PCCARDInitStruct.FSMC_TARSetupTime := $0;
  FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_SetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_WaitSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HoldSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_CommonSpaceTimingStruct.FSMC_HiZSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_SetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_WaitSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HoldSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_AttributeSpaceTimingStruct.FSMC_HiZSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_SetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_WaitSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_HoldSetupTime := $FC;
  FSMC_PCCARDInitStruct.FSMC_IOSpaceTimingStruct.FSMC_HiZSetupTime := $FC;
end
;
//======================================================================
// Enables or disables the specified NOR/SRAM Memory Bank.
//======================================================================
procedure FSMC_NORSRAMCmd(FSMC_Bank : dword; NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    case FSMC_Bank of
      FSMC_Bank1_NORSRAM1 : FSMC_Bank1.BCR1 := FSMC_Bank1.BCR1 OR BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM2 : FSMC_Bank1.BCR2 := FSMC_Bank1.BCR2 OR BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM3 : FSMC_Bank1.BCR3 := FSMC_Bank1.BCR3 OR BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM4 : FSMC_Bank1.BCR4 := FSMC_Bank1.BCR4 OR BCR_MBKEN_Set;
    end;
  end
  else
  begin
    case FSMC_Bank of
      FSMC_Bank1_NORSRAM1 : FSMC_Bank1.BCR1 := FSMC_Bank1.BCR1 AND NOT BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM2 : FSMC_Bank1.BCR2 := FSMC_Bank1.BCR2 AND NOT BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM3 : FSMC_Bank1.BCR3 := FSMC_Bank1.BCR3 AND NOT BCR_MBKEN_Set;
      FSMC_Bank1_NORSRAM4 : FSMC_Bank1.BCR4 := FSMC_Bank1.BCR4 AND NOT BCR_MBKEN_Set;
    end;
  end;
end;

//======================================================================
// Enables or disables the specified NAND Memory Bank.
//======================================================================
procedure FSMC_NANDCmd(FSMC_Bank : dword; NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    // Enable the selected NAND Bank by setting the PBKEN bit in the PCRx register
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.PCR2 := FSMC_Bank2.PCR2 OR PCR_PBKEN_Set;
    end
    else
    begin
      FSMC_Bank3.PCR3 := FSMC_Bank3.PCR3 OR PCR_PBKEN_Set;
    end;
  end
  else
  begin
    // Disable the selected NAND Bank by clearing the PBKEN bit in the PCRx register
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.PCR2 := FSMC_Bank2.PCR2 AND PCR_PBKEN_Reset;
    end
    else
    begin
      FSMC_Bank3.PCR3 := FSMC_Bank3.PCR3 AND PCR_PBKEN_Reset;
    end;
  end;
end;

//======================================================================
// Enables or disables the PCCARD Memory Bank.
//======================================================================
procedure FSMC_PCCARDCmd(NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    // Enable the PCCARD Bank by setting the PBKEN bit in the PCR4 register
    FSMC_Bank4.PCR4 := FSMC_Bank4.PCR4 OR PCR_PBKEN_Set;
  end
  else
  begin
    // Disable the PCCARD Bank by clearing the PBKEN bit in the PCR4 register
    FSMC_Bank4.PCR4 := FSMC_Bank4.PCR4 AND PCR_PBKEN_Reset;
  end;
end;

//======================================================================
// Enables or disables the FSMC NAND ECC feature.
//======================================================================
procedure FSMC_NANDECCCmd(FSMC_Bank : dword; NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    // Enable the selected NAND Bank ECC function by setting the ECCEN bit in the PCRx register
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.PCR2 := FSMC_Bank2.PCR2 OR PCR_ECCEN_Set;
    end
    else
    begin
      FSMC_Bank3.PCR3 := FSMC_Bank3.PCR3 OR PCR_ECCEN_Set;
    end;
  end
  else
  begin
    // Disable the selected NAND Bank ECC function by clearing the ECCEN bit in the PCRx register
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.PCR2 := FSMC_Bank2.PCR2 AND PCR_ECCEN_Reset;
    end
    else
    begin
      FSMC_Bank3.PCR3 := FSMC_Bank3.PCR3 AND PCR_ECCEN_Reset;
    end;
  end;
end;

//======================================================================
// Returns the error correction code register value.
//======================================================================
function FSMC_GetECC(FSMC_Bank : dword) : word;
var
  eccval : dword;
begin
  eccval := $00000000;

  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    // Get the ECCR2 register value
    eccval := FSMC_Bank2.ECCR2;
  end
  else
  begin
    // Get the ECCR3 register value
    eccval := FSMC_Bank3.ECCR3;
  end;
  // Return the error correction code value
  exit(eccval);
end;

//======================================================================
// Enables or disables the specified FSMC interrupts.
//======================================================================
procedure FSMC_ITConfig(FSMC_Bank, FSMC_IT : dword; NewState : TState);
begin
  if (NewState = ENABLED) then
  begin
    // Enable the selected FSMC_Bank2 interrupts
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.SR2 := FSMC_Bank2.SR2 OR FSMC_IT;
    end
    // Enable the selected FSMC_Bank3 interrupts
    else if (FSMC_Bank = FSMC_Bank3_NAND) then
    begin
      FSMC_Bank3.SR3 := FSMC_Bank3.SR3 OR FSMC_IT;
    end
    // Enable the selected FSMC_Bank4 interrupts
    else
    begin
      FSMC_Bank4.SR4 := FSMC_Bank4.SR4 OR FSMC_IT;
    end
  end
  else
  begin
    // Disable the selected FSMC_Bank2 interrupts
    if (FSMC_Bank = FSMC_Bank2_NAND) then
    begin
      FSMC_Bank2.SR2 := FSMC_Bank2.SR2 AND NOT FSMC_IT;
    end
    // Disable the selected FSMC_Bank3 interrupts
    else if (FSMC_Bank = FSMC_Bank3_NAND) then
    begin
      FSMC_Bank3.SR3 := FSMC_Bank3.SR3 AND NOT FSMC_IT;
    end
    // Disable the selected FSMC_Bank4 interrupts
    else
    begin
      FSMC_Bank4.SR4 := FSMC_Bank4.SR4 AND NOT FSMC_IT;
    end;
  end;
end;

//======================================================================
// Checks whether the specified FSMC flag is set or not.
//======================================================================
function FSMC_GetFlagStatus(FSMC_Bank, FSMC_FLAG : dword) : dword;
var
  bitstatus : word;
  tmpsr     : dword;
begin
  bitstatus := 0;
  tmpsr     := $00000000;

  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    tmpsr := FSMC_Bank2.SR2;
  end
  else if (FSMC_Bank = FSMC_Bank3_NAND) then
  begin
    tmpsr := FSMC_Bank3.SR3;
  end
  // FSMC_Bank4_PCCARD
  else
  begin
    tmpsr := FSMC_Bank4.SR4;
  end;

  // Get the flag status
  if ((tmpsr AND FSMC_FLAG) <> 0) then
  begin
    bitstatus := 1;
  end
  else
  begin
    bitstatus := 0;
  end;
  // Return the flag status
  exit(bitstatus);
end;

//======================================================================
// Clears the FSMC's pending flags.
//======================================================================
procedure FSMC_ClearFlag(FSMC_Bank, FSMC_FLAG : dword);
begin
  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    FSMC_Bank2.SR2 := FSMC_Bank2.SR2 AND NOT FSMC_FLAG;
  end
  else if (FSMC_Bank = FSMC_Bank3_NAND) then
  begin
    FSMC_Bank3.SR3 := FSMC_Bank3.SR3 AND NOT FSMC_FLAG;
  end
  // FSMC_Bank4_PCCARD
  else
  begin
    FSMC_Bank4.SR4 := FSMC_Bank4.SR4 AND NOT FSMC_FLAG;
  end;
end;

//======================================================================
// Checks whether the specified FSMC interrupt has occurred or not.
//======================================================================
function FSMC_GetITStatus(FSMC_Bank, FSMC_IT : dword) : word;
var
  bitstatus : word;
  tmpsr,
  itstatus,
  itenable : dword;
begin
  bitstatus := 0;
  tmpsr     := $0;
  itstatus  := $0;
  itenable  := $0;

  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    tmpsr := FSMC_Bank2.SR2;
  end
  else if (FSMC_Bank = FSMC_Bank3_NAND) then
  begin
    tmpsr := FSMC_Bank3.SR3;
  end
  // FSMC_Bank4_PCCARD
  else
  begin
    tmpsr := FSMC_Bank4.SR4;
  end;

  itstatus := tmpsr AND FSMC_IT;

  itenable := tmpsr AND (FSMC_IT SHR 3);
  if ((itstatus <> 0)  AND (itenable <> 0)) then
  begin
    bitstatus := 1;
  end
  else
  begin
    bitstatus := 0;
  end;
  exit(bitstatus);
end;

//======================================================================
// Clears the FSMC's interrupt pending bits.
//======================================================================
procedure FSMC_ClearITPendingBit(FSMC_Bank, FSMC_IT : dword);
begin
  if (FSMC_Bank = FSMC_Bank2_NAND) then
  begin
    FSMC_Bank2.SR2 := FSMC_Bank2.SR2 AND NOT (FSMC_IT SHR 3);
  end
  else if(FSMC_Bank = FSMC_Bank3_NAND) then
  begin
    FSMC_Bank3.SR3 := FSMC_Bank3.SR3 AND NOT (FSMC_IT SHR 3);
  end
  // FSMC_Bank4_PCCARD
  else
  begin
    FSMC_Bank4.SR4 := FSMC_Bank4.SR4 AND NOT (FSMC_IT SHR 3);
  end
end;

end.
