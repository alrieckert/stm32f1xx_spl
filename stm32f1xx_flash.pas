//======================================================================
unit stm32f1xx_flash;

//======================================================================
interface

const
 FLASH_Latency_0                = $00000000;  { FLASH Zero Latency cycle }
 FLASH_Latency_1                = $00000001;  { FLASH One Latency cycle }
 FLASH_Latency_2                = $00000002;  { FLASH Two Latency cycles }

 FLASH_HalfCycleAccess_Enable   = $00000008;  { FLASH Half Cycle Enable }
 FLASH_HalfCycleAccess_Disable  = $00000000;  { FLASH Half Cycle Disable }

 FLASH_PrefetchBuffer_Enable    = $00000010;  { FLASH Prefetch Buffer Enable }
 FLASH_PrefetchBuffer_Disable   = $00000000;  { FLASH Prefetch Buffer Disable }

procedure FLASH_SetLatency(FLASH_Latency: longword);
procedure FLASH_HalfCycleAccessCmd(FLASH_HalfCycleAccess: longword);
procedure FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer: longword);

implementation

const
 FLASH_ACR_LATENCY_Mask         = $00000038;
 FLASH_ACR_HLFCYA_Mask          = $FFFFFFF7;
 FLASH_ACR_PRFTBE_Mask          = $FFFFFFEF;

//======================================================================
procedure FLASH_SetLatency(FLASH_Latency: longword);
begin
	FLASH.ACR := FLASH.ACR and FLASH_ACR_LATENCY_Mask;
	FLASH.ACR := FLASH.ACR or FLASH_Latency;
end;

//======================================================================
procedure FLASH_HalfCycleAccessCmd(FLASH_HalfCycleAccess: longword);
begin
	FLASH.ACR := FLASH.ACR and FLASH_ACR_HLFCYA_Mask;
   FLASH.ACR := FLASH.ACR or FLASH_HalfCycleAccess;
end;

//======================================================================
procedure FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer: longword);
begin
	FLASH.ACR := FLASH.ACR and FLASH_ACR_PRFTBE_Mask;
	FLASH.ACR := FLASH.ACR or FLASH_PrefetchBuffer;
end;

end.
