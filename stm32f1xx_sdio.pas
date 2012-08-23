//======================================================================
unit stm32f1xx_sdio;

//======================================================================
interface
uses stm32f1xx_rcc;

type
  TSDIO_InitStruct = record
    SDIO_ClockDiv       : byte;
    SDIO_ClockEdge      : dword;
    SDIO_ClockBypass    : dword;
    SDIO_ClockPowerSave : dword;
    SDIO_BusWide        : dword;
    SDIO_HardwareFlowControl : dword;
  end;

  TSDIO_CmdInitStruct = record
    SDIO_Argument : dword;
    SDIO_CmdIndex : dword;
    SDIO_Response : dword;
    SDIO_Wait     : dword;
    SDIO_CPSM     : dword;
  end;

  TSDIO_DataInitStruct = record
    SDIO_DataTimeOut    : dword;
    SDIO_DataLength     : dword;
    SDIO_DataBlockSize  : dword;
    SDIO_TransferDir    : dword;
    SDIO_TransferMode   : dword;
    SDIO_DPSM           : dword;
  end;

//======================================================================
const
  SDIO_ClockEdge_Rising             = $00000000;
  SDIO_ClockEdge_Falling            = $00002000;

  SDIO_ClockBypass_Disable          = $00000000;
  SDIO_ClockBypass_Enable           = $00000400;

  SDIO_ClockPowerSave_Disable       = $00000000;
  SDIO_ClockPowerSave_Enable        = $00000200;

  SDIO_BusWide_1b                   = $00000000;
  SDIO_BusWide_4b                   = $00000800;
  SDIO_BusWide_8b                   = $00001000;

  SDIO_HardwareFlowControl_Disable  = $00000000;
  SDIO_HardwareFlowControl_Enable   = $00004000;

  SDIO_PowerState_OFF    = $00000000;
  SDIO_PowerState_ON     = $00000003;

  SDIO_IT_CCRCFAIL       = $00000001;
  SDIO_IT_DCRCFAIL       = $00000002;
  SDIO_IT_CTIMEOUT       = $00000004;
  SDIO_IT_DTIMEOUT       = $00000008;
  SDIO_IT_TXUNDERR       = $00000010;
  SDIO_IT_RXOVERR        = $00000020;
  SDIO_IT_CMDREND        = $00000040;
  SDIO_IT_CMDSENT        = $00000080;
  SDIO_IT_DATAEND        = $00000100;
  SDIO_IT_STBITERR       = $00000200;
  SDIO_IT_DBCKEND        = $00000400;
  SDIO_IT_CMDACT         = $00000800;
  SDIO_IT_TXACT          = $00001000;
  SDIO_IT_RXACT          = $00002000;
  SDIO_IT_TXFIFOHE       = $00004000;
  SDIO_IT_RXFIFOHF       = $00008000;
  SDIO_IT_TXFIFOF        = $00010000;
  SDIO_IT_RXFIFOF        = $00020000;
  SDIO_IT_TXFIFOE        = $00040000;
  SDIO_IT_RXFIFOE        = $00080000;
  SDIO_IT_TXDAVL         = $00100000;
  SDIO_IT_RXDAVL         = $00200000;
  SDIO_IT_SDIOIT         = $00400000;
  SDIO_IT_CEATAEND       = $00800000;

  SDIO_Response_No       = $00000000;
  SDIO_Response_Short    = $00000040;
  SDIO_Response_Long     = $000000C0;

  SDIO_Wait_No           = $00000000; // SDIO No Wait, TimeOut is enabled */
  SDIO_Wait_IT           = $00000100; // SDIO Wait Interrupt Request */
  SDIO_Wait_Pend         = $00000200; // SDIO Wait End of transfer */

  SDIO_CPSM_Disable       = $00000000;
  SDIO_CPSM_Enable        = $00000400;

  SDIO_RESP1             = $00000000;
  SDIO_RESP2             = $00000004;
  SDIO_RESP3             = $00000008;
  SDIO_RESP4             = $0000000C;

  SDIO_DataBlockSize_1b  = $00000000;
  SDIO_DataBlockSize_2b  = $00000010;
  SDIO_DataBlockSize_4b  = $00000020;
  SDIO_DataBlockSize_8b  = $00000030;
  SDIO_DataBlockSize_16b = $00000040;
  SDIO_DataBlockSize_32b = $00000050;
  SDIO_DataBlockSize_64b = $00000060;
  SDIO_DataBlockSize_128b= $00000070;
  SDIO_DataBlockSize_256b= $00000080;
  SDIO_DataBlockSize_512b= $00000090;
  SDIO_DataBlockSize_1024b           = $000000A0;
  SDIO_DataBlockSize_2048b           = $000000B0;
  SDIO_DataBlockSize_4096b           = $000000C0;
  SDIO_DataBlockSize_8192b           = $000000D0;
  SDIO_DataBlockSize_16384b          = $000000E0;

  SDIO_TransferDir_ToCard= $00000000;
  SDIO_TransferDir_ToSDIO= $00000002;

  SDIO_TransferMode_Block   = $00000000;
  SDIO_TransferMode_Stream  = $00000004;

  SDIO_DPSM_Disable       = $00000000;
  SDIO_DPSM_Enable        = $00000001;

  SDIO_FLAG_CCRCFAIL     = $00000001;
  SDIO_FLAG_DCRCFAIL     = $00000002;
  SDIO_FLAG_CTIMEOUT     = $00000004;
  SDIO_FLAG_DTIMEOUT     = $00000008;
  SDIO_FLAG_TXUNDERR     = $00000010;
  SDIO_FLAG_RXOVERR      = $00000020;
  SDIO_FLAG_CMDREND      = $00000040;
  SDIO_FLAG_CMDSENT      = $00000080;
  SDIO_FLAG_DATAEND      = $00000100;
  SDIO_FLAG_STBITERR     = $00000200;
  SDIO_FLAG_DBCKEND      = $00000400;
  SDIO_FLAG_CMDACT       = $00000800;
  SDIO_FLAG_TXACT        = $00001000;
  SDIO_FLAG_RXACT        = $00002000;
  SDIO_FLAG_TXFIFOHE     = $00004000;
  SDIO_FLAG_RXFIFOHF     = $00008000;
  SDIO_FLAG_TXFIFOF      = $00010000;
  SDIO_FLAG_RXFIFOF      = $00020000;
  SDIO_FLAG_TXFIFOE      = $00040000;
  SDIO_FLAG_RXFIFOE      = $00080000;
  SDIO_FLAG_TXDAVL       = $00100000;
  SDIO_FLAG_RXDAVL       = $00200000;
  SDIO_FLAG_SDIOIT       = $00400000;
  SDIO_FLAG_CEATAEND     = $00800000;

  SDIO_ReadWaitMode_CLK  = $00000000;
  SDIO_ReadWaitMode_DATA2= $00000001;

procedure SDIO_DeInit;
procedure SDIO_Init(var SDIO_InitStruct : TSDIO_InitStruct);
procedure SDIO_StructInit(var SDIO_InitStruct : TSDIO_InitStruct);
procedure SDIO_ClockCmd(NewState : TState);
procedure SDIO_SetPowerState(SDIO_PowerState : dword);
function SDIO_GetPowerState : dword;
procedure SDIO_ITConfig(SDIO_IT : dword; NewState : TState);
procedure SDIO_DMACmd(NewState : TState);
procedure SDIO_SendCommand(var SDIO_CmdInitStruct : TSDIO_CmdInitStruct);
procedure SDIO_CmdStructInit(var SDIO_CmdInitStruct : TSDIO_CmdInitStruct);
function SDIO_GetCommandResponse : byte;
function SDIO_GetResponse(SDIO_RESP : dword) : dword;
procedure SDIO_DataConfig(var SDIO_DataInitStruct : TSDIO_DataInitStruct);
procedure SDIO_DataStructInit(var SDIO_DataInitStruct : TSDIO_DataInitStruct);
function SDIO_GetDataCounter : dword;
function SDIO_ReadData : dword;
procedure SDIO_WriteData(Data : dword);
function SDIO_GetFIFOCount : dword;
procedure SDIO_StartSDIOReadWait(NewState : TState);
procedure SDIO_StopSDIOReadWait(NewState : TState);
procedure SDIO_SetSDIOReadWaitMode(SDIO_ReadWaitMode : dword);
procedure SDIO_SetSDIOOperation(NewState : TState);
procedure SDIO_SendSDIOSuspendCmd(NewState : TState);
procedure SDIO_CommandCompletionCmd(NewState : TState);
procedure SDIO_CEATAITCmd(NewState : TState);
procedure SDIO_SendCEATACmd(NewState : TState);
function SDIO_GetFlagStatus(SDIO_FLAG : dword) : dword;
procedure SDIO_ClearFlag(SDIO_FLAG : dword);
function SDIO_GetITStatus(SDIO_IT : dword) : dword;
procedure SDIO_ClearITPendingBit(SDIO_IT : dword);

implementation

const
// --- CMD Register
  SDIO_CMD_CMDINDEX         = $003F;            //*!<Command Index */
  SDIO_CMD_WAITRESP         = $00C0;            //*!<WAITRESP[1:0] bits (Wait for response bits) */
  SDIO_CMD_WAITRESP_0       = $0040;            //*!< Bit 0 */
  SDIO_CMD_WAITRESP_1       = $0080;            //*!< Bit 1 */
  SDIO_CMD_WAITINT          = $0100;            //*!<CPSM Waits for Interrupt Request */
  SDIO_CMD_WAITPEND         = $0200;            //*!<CPSM Waits for ends of data transfer (CmdPend internal signal) */
  SDIO_CMD_CPSMEN           = $0400;            //*!<Command path state machine (CPSM) Enable bit */
  SDIO_CMD_SDIOSUSPEND      = $0800;            //*!<SD I/O suspend command */
  SDIO_CMD_ENCMDCOMPL       = $1000;            //*!<Enable CMD completion */
  SDIO_CMD_NIEN             = $2000;            //*!<Not Interrupt Enable */
  SDIO_CMD_CEATACMD         = $4000;            //*!<CE-ATA command */

// --- DCTRL Register
  SDIO_DCTRL_DTEN           = $0001;            //*!<Data transfer enabled bit */
  SDIO_DCTRL_DTDIR          = $0002;            //*!<Data transfer direction selection */
  SDIO_DCTRL_DTMODE         = $0004;            //*!<Data transfer mode selection */
  SDIO_DCTRL_DMAEN          = $0008;            //*!<DMA enabled bit */

  SDIO_DCTRL_DBLOCKSIZE     = $00F0;            //*!<DBLOCKSIZE[3:0] bits (Data block size) */
  SDIO_DCTRL_DBLOCKSIZE_0   = $0010;            //*!<Bit 0 */
  SDIO_DCTRL_DBLOCKSIZE_1   = $0020;            //*!<Bit 1 */
  SDIO_DCTRL_DBLOCKSIZE_2   = $0040;            //*!<Bit 2 */
  SDIO_DCTRL_DBLOCKSIZE_3   = $0080;            //*!<Bit 3 */

  SDIO_DCTRL_RWSTART        = $0100;            //*!<Read wait start */
  SDIO_DCTRL_RWSTOP         = $0200;            //*!<Read wait stop */
  SDIO_DCTRL_RWMOD          = $0400;            //*!<Read wait mode */
  SDIO_DCTRL_SDIOEN         = $0800;            //*!<SD I/O enable functions */

// --- CLKCR Register
  SDIO_CLKCR_CLKDIV         = $00FF;            //*!<Clock divide factor */
  SDIO_CLKCR_CLKEN          = $0100;            //*!<Clock enable bit */
  SDIO_CLKCR_PWRSAV         = $0200;            //*!<Power saving configuration bit */
  SDIO_CLKCR_BYPASS         = $0400;            //*!<Clock divider bypass enable bit */

  SDIO_CLKCR_WIDBUS         = $1800;            //*!<WIDBUS[1:0] bits (Wide bus mode enable bit) */
  SDIO_CLKCR_WIDBUS_0       = $0800;            //*!<Bit 0 */
  SDIO_CLKCR_WIDBUS_1       = $1000;            //*!<Bit 1 */

  SDIO_CLKCR_NEGEDGE        = $2000;            //*!<SDIO_CK dephasing selection bit */
  SDIO_CLKCR_HWFC_EN        = $4000;            //*!<HW Flow Control enable */


  SDIO_OFFSET              =  (SDIO_BASE - PeripheralBase);

  // CLKCR Register
  CLKCR_OFFSET             = (SDIO_OFFSET + $04);
  CLKEN_BitNumber          = $08;
  CLKCR_CLKEN_BB           = (PERIPH_BB_BASE + (CLKCR_OFFSET * 32) + (CLKEN_BitNumber * 4));

  // CMD Register
  CMD_OFFSET               = (SDIO_OFFSET + $0C);
  SDIOSUSPEND_BitNumber    = $0B;
  CMD_SDIOSUSPEND_BB       = (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (SDIOSUSPEND_BitNumber * 4));

  ENCMDCOMPL_BitNumber     = $0C;
  CMD_ENCMDCOMPL_BB        = (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (ENCMDCOMPL_BitNumber * 4));

  NIEN_BitNumber           = $0D;
  CMD_NIEN_BB              = (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (NIEN_BitNumber * 4));

  ATACMD_BitNumber         = $0E;
  CMD_ATACMD_BB            = (PERIPH_BB_BASE + (CMD_OFFSET * 32) + (ATACMD_BitNumber * 4));

  // DCTRL Register
  DCTRL_OFFSET             = (SDIO_OFFSET + $2C);
  DMAEN_BitNumber          = $03;
  DCTRL_DMAEN_BB           = (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (DMAEN_BitNumber * 4));

  RWSTART_BitNumber        = $08;
  DCTRL_RWSTART_BB         = (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWSTART_BitNumber * 4));

  RWSTOP_BitNumber         = $09;
  DCTRL_RWSTOP_BB          = (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWSTOP_BitNumber * 4));

  RWMOD_BitNumber          = $0A;
  DCTRL_RWMOD_BB           = (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (RWMOD_BitNumber * 4));

  SDIOEN_BitNumber         = $0B;
  DCTRL_SDIOEN_BB          = (PERIPH_BB_BASE + (DCTRL_OFFSET * 32) + (SDIOEN_BitNumber * 4));

//======================================================================
  CLKCR_CLEAR_MASK        = $FFFF8100;
  PWR_PWRCTRL_MASK        = $FFFFFFFC;
  DCTRL_CLEAR_MASK        = $FFFFFF08;
  CMD_CLEAR_MASK          = $FFFFF800;

// SDIO RESP Registers Address
  SDIO_RESP_ADDR          = SDIO_BASE + $14;

//======================================================================
// Deinitializes the SDIO peripheral registers to their default
//======================================================================
procedure SDIO_DeInit;
begin
  SDIO.POWER  := $00000000;
  SDIO.CLKCR  := $00000000;
  SDIO.ARG    := $00000000;
  SDIO.CMD    := $00000000;
  SDIO.DTIMER := $00000000;
  SDIO.DLEN   := $00000000;
  SDIO.DCTRL  := $00000000;
  SDIO.ICR    := $00C007FF;
  SDIO.MASK   := $00000000;
end;

//======================================================================
// Fills each SDIO_InitStruct member with its default value.
//======================================================================
procedure SDIO_StructInit(var SDIO_InitStruct : TSDIO_InitStruct);
begin
  // SDIO_InitStruct members default value
  SDIO_InitStruct.SDIO_ClockDiv       := $00;
  SDIO_InitStruct.SDIO_ClockEdge      := SDIO_ClockEdge_Rising;
  SDIO_InitStruct.SDIO_ClockBypass    := SDIO_ClockBypass_Disable;
  SDIO_InitStruct.SDIO_ClockPowerSave := SDIO_ClockPowerSave_Disable;
  SDIO_InitStruct.SDIO_BusWide        := SDIO_BusWide_1b;
  SDIO_InitStruct.SDIO_HardwareFlowControl := SDIO_HardwareFlowControl_Disable;
end;

//======================================================================
// Initializes the SDIO peripheral according to the specified
// parameters in the SDIO_InitStruct.
//======================================================================
procedure SDIO_Init(var SDIO_InitStruct : TSDIO_InitStruct);
var
  tmpreg : dword;
begin
  tmpreg := 0;
  // Get the SDIO CLKCR value
  tmpreg := SDIO.CLKCR;

  // Clear CLKDIV, PWRSAV, BYPASS, WIDBUS, NEGEDGE, HWFC_EN bits
  tmpreg := tmpreg AND CLKCR_CLEAR_MASK;

  // Set CLKDIV bits according to SDIO_ClockDiv value
  // Set PWRSAV bit according to SDIO_ClockPowerSave value
  // Set BYPASS bit according to SDIO_ClockBypass value
  // Set WIDBUS bits according to SDIO_BusWide value
  // Set NEGEDGE bits according to SDIO_ClockEdge value
  // Set HWFC_EN bits according to SDIO_HardwareFlowControl value
  tmpreg := tmpreg OR (SDIO_InitStruct.SDIO_ClockDiv  OR SDIO_InitStruct.SDIO_ClockPowerSave OR
             SDIO_InitStruct.SDIO_ClockBypass OR SDIO_InitStruct.SDIO_BusWide OR
             SDIO_InitStruct.SDIO_ClockEdge OR SDIO_InitStruct.SDIO_HardwareFlowControl);

  // Write to SDIO CLKCR
  SDIO.CLKCR := tmpreg;
end;

//======================================================================
// Enables or disables the SDIO Clock.
//======================================================================
procedure SDIO_ClockCmd(NewState : Tstate);
begin
 if NewState = ENABLED then
    SDIO.CLKCR := SDIO.CLKCR OR SDIO_CLKCR_CLKEN
  else
    SDIO.CLKCR := SDIO.CLKCR AND NOT SDIO_CLKCR_CLKEN;
end;

//======================================================================
// Sets the power status of the controller.
//======================================================================
procedure SDIO_SetPowerState(SDIO_PowerState : dword);
begin
  SDIO.POWER := SDIO.POWER AND PWR_PWRCTRL_MASK;
  SDIO.POWER := SDIO.POWER OR SDIO_PowerState;
end;

//======================================================================
// Gets the power status of the controller.
//======================================================================
function SDIO_GetPowerState : dword;
begin
  exit(SDIO.POWER AND NOT PWR_PWRCTRL_MASK);
end;

//======================================================================
// Enables or disables the SDIO interrupts.
//======================================================================
procedure SDIO_ITConfig(SDIO_IT : dword; NewState : TState);
begin
  if NewState = ENABLED then
  begin
    SDIO.MASK := SDIO.MASK OR SDIO_IT;
  end
  else
  begin
    SDIO.MASK := SDIO.MASK AND NOT SDIO_IT;
  end;
end;

//======================================================================
// Enables or disables the SDIO DMA request.
//======================================================================
procedure SDIO_DMACmd(NewState : TState);
begin
  if NewState = ENABLED then
  begin
    SDIO.DCTRL := SDIO.DCTRL OR SDIO_DCTRL_DMAEN;
  end
  else
  begin
    SDIO.DCTRL := SDIO.DCTRL AND NOT SDIO_DCTRL_DMAEN;
  end;
end;

//======================================================================
// Fills each SDIO_CmdInitStruct member with its default value.
//======================================================================
procedure SDIO_CmdStructInit(var SDIO_CmdInitStruct : TSDIO_CmdInitStruct);
begin
  // SDIO_CmdInitStruct members default value */
  SDIO_CmdInitStruct.SDIO_Argument := $00;
  SDIO_CmdInitStruct.SDIO_CmdIndex := $00;
  SDIO_CmdInitStruct.SDIO_Response := SDIO_Response_No;
  SDIO_CmdInitStruct.SDIO_Wait     := SDIO_Wait_No;
  SDIO_CmdInitStruct.SDIO_CPSM     := SDIO_CPSM_Disable;
end;

//======================================================================
// Initializes the SDIO Command according to the specified
// parameters in the SDIO_CmdInitStruct and send the command.
//======================================================================
procedure SDIO_SendCommand(var SDIO_CmdInitStruct : TSDIO_CmdInitStruct);
var
  tmpreg : dword;
begin
  // Set the SDIO Argument value
  SDIO.ARG := SDIO_CmdInitStruct.SDIO_Argument;

  // Get the SDIO CMD value */
  tmpreg := SDIO.CMD;

  // Clear CMDINDEX, WAITRESP, WAITINT, WAITPEND, CPSMEN bits */
  tmpreg := tmpreg AND CMD_CLEAR_MASK;
  // Set CMDINDEX bits according to SDIO_CmdIndex value */
  // Set WAITRESP bits according to SDIO_Response value */
  // Set WAITINT and WAITPEND bits according to SDIO_Wait value */
  // Set CPSMEN bits according to SDIO_CPSM value */
  tmpreg := tmpreg OR SDIO_CmdInitStruct.SDIO_CmdIndex OR SDIO_CmdInitStruct.SDIO_Response
           OR SDIO_CmdInitStruct.SDIO_Wait OR SDIO_CmdInitStruct.SDIO_CPSM;

  // Write to SDIO CMD
  SDIO.CMD := tmpreg;
end;

//======================================================================
// Returns command index of last command for which response
// received.
//======================================================================
function SDIO_GetCommandResponse : byte;
begin
  exit(SDIO.RESPCMD);
end;

//======================================================================
// Returns response received from the card for the last command.
//======================================================================
function SDIO_GetResponse(SDIO_RESP : dword) : dword;
begin
  exit(SDIO_RESP_ADDR + SDIO_RESP);
end;

//======================================================================
// Fills each SDIO_DataInitStruct member with its default value.
//======================================================================
procedure SDIO_DataStructInit(var SDIO_DataInitStruct : TSDIO_DataInitStruct);
begin
  // SDIO_DataInitStruct members default value */
  SDIO_DataInitStruct.SDIO_DataTimeOut := $FFFFFFFF;
  SDIO_DataInitStruct.SDIO_DataLength := $00;
  SDIO_DataInitStruct.SDIO_DataBlockSize := SDIO_DataBlockSize_1b;
  SDIO_DataInitStruct.SDIO_TransferDir := SDIO_TransferDir_ToCard;
  SDIO_DataInitStruct.SDIO_TransferMode := SDIO_TransferMode_Block;
  SDIO_DataInitStruct.SDIO_DPSM := SDIO_DPSM_Disable;
end;

//======================================================================
// Initializes the SDIO data path according to the specified
// parameters in the SDIO_DataInitStruct.
//======================================================================
procedure SDIO_DataConfig(var SDIO_DataInitStruct : TSDIO_DataInitStruct);
var
  tmpreg : dword;
begin
  // Set the SDIO Data TimeOut value
  SDIO.DTIMER := SDIO_DataInitStruct.SDIO_DataTimeOut;

  // Set the SDIO DataLength value
  SDIO.DLEN := SDIO_DataInitStruct.SDIO_DataLength;

  // Get the SDIO DCTRL value
  tmpreg := SDIO.DCTRL;

  // Clear DEN, DTMODE, DTDIR and DBCKSIZE bits
  tmpreg := tmpreg AND DCTRL_CLEAR_MASK;

  // Set DEN bit according to SDIO_DPSM value
  // Set DTMODE bit according to SDIO_TransferMode value
  // Set DTDIR bit according to SDIO_TransferDir value
  // Set DBCKSIZE bits according to SDIO_DataBlockSize value
  tmpreg := tmpreg OR SDIO_DataInitStruct.SDIO_DataBlockSize OR SDIO_DataInitStruct.SDIO_TransferDir
           OR SDIO_DataInitStruct.SDIO_TransferMode OR SDIO_DataInitStruct.SDIO_DPSM;

  // Write to SDIO DCTRL
  SDIO.DCTRL := tmpreg;
end;

//======================================================================
// Returns number of remaining data bytes to be transferred.
//======================================================================
function SDIO_GetDataCounter : dword;
begin
  exit(SDIO.DCOUNT);
end;

//======================================================================
// Read one data word from Rx FIFO.
//======================================================================
function SDIO_ReadData : dword;
begin
  exit(SDIO.FIFO);
end;

//======================================================================
// Write one data word to Tx FIFO.
//======================================================================
procedure SDIO_WriteData(Data : dword);
begin
  SDIO.FIFO := Data;
end;

//======================================================================
// Returns the number of words left to be written to or read
// from FIFO.
//======================================================================
function SDIO_GetFIFOCount : dword;
begin
  exit(SDIO.FIFOCNT);
end;

//======================================================================
// Starts the SD I/O Read Wait operation.
//======================================================================
procedure SDIO_StartSDIOReadWait(NewState : TState);
begin
  dword(pointer(DCTRL_RWSTART_BB)^) := dword(NewState);
  if NewState = ENABLED then
    SDIO.DCTRL := SDIO.DCTRL OR SDIO_DCTRL_RWSTART
  else
    SDIO.DCTRL := SDIO.DCTRL AND NOT SDIO_DCTRL_RWSTART;
end;

//======================================================================
// Stops the SD I/O Read Wait operation.
//======================================================================
procedure SDIO_StopSDIOReadWait(NewState : TState);
begin
  dword(pointer(DCTRL_RWSTOP_BB)^) := dword(NewState);
  if NewState = ENABLED then
    SDIO.DCTRL := SDIO.DCTRL OR SDIO_DCTRL_RWSTOP
  else
    SDIO.DCTRL := SDIO.DCTRL AND NOT SDIO_DCTRL_RWSTOP;
end;

//======================================================================
// Sets one of the two options of inserting read wait interval.
//======================================================================
procedure SDIO_SetSDIOReadWaitMode(SDIO_ReadWaitMode : dword);
begin
  dword(pointer(DCTRL_RWMOD_BB)^) := dword(SDIO_ReadWaitMode);
  if SDIO_ReadWaitMode = 1 then
    SDIO.DCTRL := SDIO.DCTRL OR SDIO_DCTRL_RWMOD
  else
    SDIO.DCTRL := SDIO.DCTRL AND NOT SDIO_DCTRL_RWMOD;
end;

//======================================================================
// Enables or disables the SD I/O Mode Operation.
//======================================================================
procedure SDIO_SetSDIOOperation(NewState : TState);
begin
  dword(pointer(DCTRL_SDIOEN_BB)^) := dword(NewState);
  if NewState = Enabled then
    SDIO.DCTRL := SDIO.DCTRL OR SDIO_DCTRL_SDIOEN
  else
    SDIO.DCTRL := SDIO.DCTRL AND NOT SDIO_DCTRL_SDIOEN;
end;

//======================================================================
// Enables or disables the SD I/O Mode suspend command sending.
//======================================================================
procedure SDIO_SendSDIOSuspendCmd(NewState : TState);
begin
  dword(pointer(CMD_SDIOSUSPEND_BB)^) := dword(NewState);
  if NewState = Enabled then
    SDIO.CMD := SDIO.CMD OR SDIO_CMD_SDIOSUSPEND
  else
    SDIO.CMD := SDIO.CMD AND NOT SDIO_CMD_SDIOSUSPEND;
end;

//======================================================================
// Enables or disables the command completion signal.
//======================================================================
procedure SDIO_CommandCompletionCmd(NewState : TState);
begin
  dword(pointer(CMD_ENCMDCOMPL_BB)^) := dword(NewState);
  if NewState = Enabled then
    SDIO.CMD := SDIO.CMD OR SDIO_CMD_ENCMDCOMPL
  else
    SDIO.CMD := SDIO.CMD AND NOT SDIO_CMD_ENCMDCOMPL;
end;

//======================================================================
// Enables or disables the CE-ATA interrupt.
//======================================================================
procedure SDIO_CEATAITCmd(NewState : TState);
begin
  dword(pointer(CMD_NIEN_BB)^) := dword((NOT(dword(NewState)) AND $01));
end;

//======================================================================
// Sends CE-ATA command (CMD61).
//======================================================================
procedure SDIO_SendCEATACmd(NewState : TState);
begin
  //dword(pointer(CMD_ATACMD_BB)^) := dword(NewState);
  //if NewState = Enabled then
  //  SDIO.CMD := SDIO.CMD OR SDIO_CMD_ATACMD
  //else
   // SDIO.CMD := SDIO.CMD AND NOT SDIO_CMD_ATACMD;
end;

//======================================================================
// Checks whether the specified SDIO flag is set or not.
//======================================================================
function SDIO_GetFlagStatus(SDIO_FLAG : dword) : dword;
begin
  if ((SDIO.STA AND SDIO_FLAG) <> 0) then
  begin
    exit(1);
  end
  else
  begin
    exit(0);
  end;
end;

//======================================================================
// Clears the SDIO's pending flags.
//======================================================================
procedure SDIO_ClearFlag(SDIO_FLAG : dword);
begin
  SDIO.ICR := SDIO_FLAG;
end;

//======================================================================
// Checks whether the specified SDIO interrupt has occurred or not.
//======================================================================
function SDIO_GetITStatus(SDIO_IT : dword) : dword;
begin
  if ((SDIO.STA AND SDIO_IT) <> 0) then
  begin
    exit(1);
  end
  else
  begin
    exit(0);
  end;
end;

//======================================================================
// Clears the SDIO's interrupt pending bits.
//======================================================================
procedure SDIO_ClearITPendingBit(SDIO_IT : dword);
begin
  SDIO.ICR := SDIO_IT;
end;

end.
