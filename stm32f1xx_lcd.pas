{$inline on}
//======================================================================
unit stm32f1xx_lcd;

//======================================================================
interface
uses stm32f1xx_rcc, stm32f1xx_gpio, stm32f1xx_systick, stm32f1xx_fsmc, stm32f1xx_usart, defPSPLcd;

{$PACKRECORDS 2}
type
  TLCD_TypeDef = record
    LCD_REG : word;
    tmp : array[0..65550] of word;
    LCD_RAM : word;
  end;

{$ALIGN 2}
var
 LCD : TLCD_TypeDef absolute FSMCBank1NOR1;


const
// LCD Registers
  R0           = $00;
  R1           = $01;
  R2           = $02;
  R3           = $03;
  R4           = $04;
  R5           = $05;
  R6           = $06;
  R7           = $07;
  R8           = $08;
  R9           = $09;
  R10          = $0A;
  R12          = $0C;
  R13          = $0D;
  R14          = $0E;
  R15          = $0F;
  R16          = $10;
  R17          = $11;
  R18          = $12;
  R19          = $13;
  R20          = $14;
  R21          = $15;
  R22          = $16;
  R23          = $17;
  R24          = $18;
  R25          = $19;
  R26          = $1A;
  R27          = $1B;
  R28          = $1C;
  R29          = $1D;
  R30          = $1E;
  R31          = $1F;
  R32          = $20;
  R33          = $21;
  R34          = $22;
  R36          = $24;
  R37          = $25;
  R40          = $28;
  R41          = $29;
  R43          = $2B;
  R45          = $2D;
  R48          = $30;
  R49          = $31;
  R50          = $32;
  R51          = $33;
  R52          = $34;
  R53          = $35;
  R54          = $36;
  R55          = $37;
  R56          = $38;
  R57          = $39;
  R58          = $3A;
  R59          = $3B;
  R60          = $3C;
  R61          = $3D;
  R62          = $3E;
  R63          = $3F;
  R64          = $40;
  R65          = $41;
  R66          = $42;
  R67          = $43;
  R68          = $44;
  R69          = $45;
  R70          = $46;
  R71          = $47;
  R72          = $48;
  R73          = $49;
  R74          = $4A;
  R75          = $4B;
  R76          = $4C;
  R77          = $4D;
  R78          = $4E;
  R79          = $4F;
  R80          = $50;
  R81          = $51;
  R82          = $52;
  R83          = $53;
  R96          = $60;
  R97          = $61;
  R106         = $6A;
  R118         = $76;
  R128         = $80;
  R129         = $81;
  R130         = $82;
  R131         = $83;
  R132         = $84;
  R133         = $85;
  R134         = $86;
  R135         = $87;
  R136         = $88;
  R137         = $89;
  R139         = $8B;
  R140         = $8C;
  R141         = $8D;
  R143         = $8F;
  R144         = $90;
  R145         = $91;
  R146         = $92;
  R147         = $93;
  R148         = $94;
  R149         = $95;
  R150         = $96;
  R151         = $97;
  R152         = $98;
  R153         = $99;
  R154         = $9A;
  R157         = $9D;
  R192         = $C0;
  R193         = $C1;
  R229         = $E5;

// LCD Control pins
//  CtrlPin_NCS   = GPIO_Pin_2;   // PB.02
//  CtrlPin_RS    = GPIO_Pin_7;   // PD.07
//  CtrlPin_NWR   = GPIO_Pin_15;  // PD.15

//. LCD color
  White        = $00FFFFFF;
  Black        = $00000000;
  Grey         = $F7DE;
  Blue         = $000000FF;
  Blue2        = $051F;
  Red          = $00FF0000;
  Magenta      = $F81F;
  Green        = $0000FF00;
  Cyan         = $7FFF;
  Yellow       = $FFE0;

  Line0        =  0;
  Line1        =  24;
  Line2        =  48;
  Line3        =  72;
  Line4        =  96;
  Line5        =  120;
  Line6        =  144;
  Line7        =  168;
  Line8        =  192;
  Line9        =  216;

  Horizontal   = $00;
  Vertical     = $01;

procedure STM3210E_LCD_Init;
procedure LCD_Clear(Color : dword);
procedure LCD_SetCursor(Xpos, Ypos : word);
procedure LCD_SetDisplayWindow(x, y, height, width : word);
procedure LCD_WindowModeDisable;
procedure LCD_DrawLine(Xpos, Ypos, Length, Direction : word);
procedure LCD_SetDataDirection(ADirection : word);

procedure LCD_WriteReg(LCD_Reg2 : word; LCD_RegValue : word);
function LCD_ReadReg(LCD_Reg2 : word) : word;
procedure LCD_WriteRAM_Prepare;
procedure LCD_WriteRAM(RGB_Code : word);
function LCD_ReadRAM : word;
procedure LCD_PowerOn;
procedure LCD_DisplayOn;
procedure LCD_DisplayOff;

procedure LCD_CtrlLinesConfig;
procedure LCD_FSMCConfig;
procedure LCD_FSMCReConfig;

procedure WriteCommand(RGB_Code : word);
procedure WriteData(RGB_Code : word);
function ReadData : word ;

//==============================================================================
implementation

//==============================================================================
const
  ScreenWidth   : word = 480;
  ScreenHeight  : word = 272;
  DISP_HOR_RESOLUTION        = 480;
  DISP_VER_RESOLUTION        = 272;
  DISP_HOR_PULSE_WIDTH  = 41;
  DISP_HOR_BACK_PORCH        = 2;
  DISP_HOR_FRONT_PORCH        = 2;
  DISP_VER_PULSE_WIDTH        = 10;
  DISP_VER_BACK_PORCH        = 2;
  DISP_VER_FRONT_PORCH        = 2;

  LEFTTORIGHT          = $00;
  RIGHTTOLEFT          = $01;
  TOPTOBOTTOM          = $02;
  BOTTOMTOTOP          = $03;

//==============================================================================
var
  TextColor : dword = $00000000;
  BackColor : dword = $00FFFFFF;

//======================================================================
procedure STM3210E_LCD_Init;
var
  HT, HPS,
  VT, VSP   : word;
begin
  LCD_CtrlLinesConfig;
  LCD_FSMCConfig;

  delay(5);

  // Set MN (multipliers) of PLL, VCO = crystal freq * (N+1)
  // PLL freq = VCO/M with 250MHz < VCO < 800MHz
  // The max PLL freq is around 120MHz. To obtain 120MHz as the PLL freq
  WriteCommand($00E2);                     // Set PLL with OSC = 10MHz (hardware)
  // WriteData($0023);
  WriteData($001D);
  WriteData($0002);                        // Divider M = 2, PLL = 360/(M+1) = 120MHz
  WriteData($0054);                        // Validate M and N values

  WriteCommand($00E0);                     // Start PLL command
  WriteData($0001);                        // enable PLL

  Delay(1);

  WriteCommand($00E0);                     // Start PLL command again
  WriteData($0003);                        // now, use PLL output as system clock

  USART_SendString(Usart2, 'Starting the PLL' + #13 + #10);

  {HT := 0;
  while HT <> 4 do
  begin
    WriteCommand($00E4);   // Start PLL command again
    HT := ReadData;
  end;}

  USART_SendString(Usart2, 'PLL Started' + #13 + #10);

  Delay(4);
  WriteCommand($0001);                 // Soft reset
  Delay(4);

  USART_SendString(Usart2, 'Soft reset' + #13 + #10);

  // Set LSHIFT freq, i.e. the DCLK with PLL freq 120MHz set previously
  // Typical DCLK for TY430TFT480272 is 9MHz
  // Set LSHIFT freq, i.e. the DCLK with PLL freq 120MHz set previously
  // LCDC_FPR = 78642 ($0013332)
  WriteCommand($00E6);
  WriteData($0001);
  WriteData($0033);
  WriteData($0032);

  // Set panel mode
  WriteCommand($00B0);
  WriteData($0020);                        // Set 24-bit mode
  WriteData($0000);                        // Set Hsync + Vsync mode
  WriteData(hi(DISP_HOR_RESOLUTION - 1));     //Set panel size
  WriteData(lo(DISP_HOR_RESOLUTION - 1));
  WriteData(hi(DISP_VER_RESOLUTION - 1));    //Set panel size
  WriteData(lo(DISP_VER_RESOLUTION - 1));
  WriteData($0000);                        // RGB sequence

  // Set horizontal period
  HT := (DISP_HOR_RESOLUTION + DISP_HOR_PULSE_WIDTH + DISP_HOR_BACK_PORCH + DISP_HOR_FRONT_PORCH) - 1;
  HPS := (DISP_HOR_PULSE_WIDTH + DISP_HOR_BACK_PORCH) - 1;
  WriteCommand($00B4);
  WriteData(hi(HT));
  WriteData(lo(HT));
  WriteData(hi(HPS));
  WriteData(lo(HPS));
  WriteData(DISP_HOR_PULSE_WIDTH - 1);
  WriteData($0000);
  WriteData($0000);
  WriteData($0000);

  // Set vertical period
  VT := (DISP_VER_PULSE_WIDTH + DISP_VER_BACK_PORCH + DISP_VER_FRONT_PORCH + DISP_VER_RESOLUTION) - 1;
  VSP := (DISP_VER_PULSE_WIDTH + DISP_VER_BACK_PORCH) - 1;
  WriteCommand($00B6);
  WriteData(hi(VT));
  WriteData(lo(VT));
  WriteData(hi(VSP));
  WriteData(lo(VSP));
  WriteData(DISP_VER_PULSE_WIDTH - 1);
  WriteData($0000);
  WriteData($0000);

  // Set pixel format, i.e. the bpp
  //WriteCommand($003A);
  //WriteData($0055);                        // set 16bpp

  // Set pixel data interface
  WriteCommand($00F0);
  WriteData($0000);                        // 8-bit data

  // GPIO configuration
  WriteCommand($00B8);                     // Set all GPIOs to output, controlled by host
  WriteData($000F);                        // Set GPIO as output, GPIO[3:1] used as normal GPIOs
  WriteData($0001);                        // GPIO[3:0] used as normal GPIOs

  WriteCommand($00BA);
  WriteData($0000);
  Delay(1);

  WriteCommand($00BA);
  WriteData($000F);

  WriteCommand($0035);
  WriteData($0000);

  WriteCommand($0029);                     // Turn on display; show the image on display

  WriteCommand($00BE);                     // Set PWM configuration for backlight control
  WriteData($000E);                        // PWMF[7:0] = 2, PWM base freq = PLL/(256*(1+5))/256 =
                                          // 300Hz for a PLL freq = 120MHz
  WriteData($00FF);                         // Set duty cycle, from $0000 (total pull-down) to $00FF
                                          // (99% pull-up , 255/256)
  WriteData($0001);                        // PWM enabled and controlled by host (mcu)
  WriteData($00FF);
  WriteData($00FF);
  WriteData($000F);

  USART_SendString(Usart2, 'Going to reconfigure the FSMC' + #13 + #10);

  LCD_FSMCReConfig;

  USART_SendString(Usart2, 'done' + #13 + #10);

{  // Check if the LCD is SPFD5408B Controller
  if (LCD_ReadReg($00) = $5408) then
  begin
    USART_SendString(Usart1, 'LCD is SPFD5408B Controller');
    USART_SendString(Usart1, #13+#10);
// Start Initial Sequence
    delay(5);
    LCD_WriteReg(R1, $0100);   // Set SS bit
    LCD_WriteReg(R2, $0700);   // Set 1 line inversion
    LCD_WriteReg(R3, $1030);   // Set GRAM write direction and BGR=1.
    LCD_WriteReg(R4, $0000);   // Resize register

    LCD_WriteReg(R8, $0202);   // Set the back porch and front porch
    LCD_WriteReg(R9, $0000);   // Set non-display area refresh cycle ISC[3:0]
    LCD_WriteReg(R10, $0000);  // FMARK function
    LCD_WriteReg(R12, $0000);  // RGB 18-bit System interface setting
    LCD_WriteReg(R13, $0000);  // Frame marker Position
    LCD_WriteReg(R15, $0000);  // RGB interface polarity, no impact

    // Power On sequence
    LCD_WriteReg(R16, $0000);  // SAP, BT[3:0], AP, DSTB, SLP, STB
    LCD_WriteReg(R17, $0000);  // DC1[2:0], DC0[2:0], VC[2:0]
    LCD_WriteReg(R18, $0000);  // VREG1OUT voltage
    LCD_WriteReg(R19, $0000);  // VDV[4:0] for VCOM amplitude
    delay(20);                // Dis-charge capacitor power voltage (200ms)

    LCD_WriteReg(R17, $0007);  // DC1[2:0], DC0[2:0], VC[2:0]
    delay(5);                 // Delay 50 ms
    LCD_WriteReg(R16, $12B0);  // SAP, BT[3:0], AP, DSTB, SLP, STB
    delay(5);                 // Delay 50 ms
    LCD_WriteReg(R18, $01BD);  // External reference voltage= Vci
    delay(50);
    LCD_WriteReg(R19, $1400);  // VDV[4:0] for VCOM amplitude
    LCD_WriteReg(R41, $000E);  // VCM[4:0] for VCOMH
    delay(5);                 // Delay 50 ms
    LCD_WriteReg(R32, $0000);  // GRAM horizontal Address
    LCD_WriteReg(R33, $013F);  // GRAM Vertical Address

    // Adjust the Gamma Curve (SPFD5408B)
    LCD_WriteReg(R48, $0b0d);
    LCD_WriteReg(R49, $1923);
    LCD_WriteReg(R50, $1c26);
    LCD_WriteReg(R51, $261c);
    LCD_WriteReg(R52, $2419);
    LCD_WriteReg(R53, $0d0b);
    LCD_WriteReg(R54, $1006);
    LCD_WriteReg(R55, $0610);
    LCD_WriteReg(R56, $0706);
    LCD_WriteReg(R57, $0304);
    LCD_WriteReg(R58, $0e05);
    LCD_WriteReg(R59, $0e01);
    LCD_WriteReg(R60, $010e);
    LCD_WriteReg(R61, $050e);
    LCD_WriteReg(R62, $0403);
    LCD_WriteReg(R63, $0607);

    // Set GRAM area
    LCD_WriteReg(R80, $0000); // Horizontal GRAM Start Address
    LCD_WriteReg(R81, $00EF); // Horizontal GRAM End Address
    LCD_WriteReg(R82, $0000); // Vertical GRAM Start Address
    LCD_WriteReg(R83, $013F); // Vertical GRAM End Address

    LCD_WriteReg(R96,  $A700); // Gate Scan Line
    LCD_WriteReg(R97,  $0001); // NDL, VLE, REV
    LCD_WriteReg(R106, $0000); // set scrolling line

    // Partial Display Control
    LCD_WriteReg(R128, $0000);
    LCD_WriteReg(R129, $0000);
    LCD_WriteReg(R130, $0000);
    LCD_WriteReg(R131, $0000);
    LCD_WriteReg(R132, $0000);
    LCD_WriteReg(R133, $0000);

    // Panel Control
    LCD_WriteReg(R144, $0010);
    LCD_WriteReg(R146, $0000);
    LCD_WriteReg(R147, $0003);
    LCD_WriteReg(R149, $0110);
    LCD_WriteReg(R151, $0000);
    LCD_WriteReg(R152, $0000);

    // Set GRAM write direction and BGR = 1
    // I/D = 01 (Horizontal : increment, Vertical : decrement)
    // AM =1 (address is updated in vertical writing direction)
    LCD_WriteReg(R3, $1018);

    LCD_WriteReg(R7, $0112); // 262K color and display ON
    exit;
  end;

  // Start Initial Sequence
  LCD_WriteReg(R229,$8000); // Set the internal vcore voltage
  LCD_WriteReg(R0,  $0001); // Start internal OSC.
  LCD_WriteReg(R1,  $0100); // set SS and SM bit
  LCD_WriteReg(R2,  $0700); // set 1 line inversion
  LCD_WriteReg(R3,  $1030); // set GRAM write direction and BGR=1.
  LCD_WriteReg(R4,  $0000); // Resize register
  LCD_WriteReg(R8,  $0202); // set the back porch and front porch
  LCD_WriteReg(R9,  $0000); // set non-display area refresh cycle ISC[3:0]
  LCD_WriteReg(R10, $0000); // FMARK function
  LCD_WriteReg(R12, $0000); // RGB interface setting
  LCD_WriteReg(R13, $0000); // Frame marker Position
  LCD_WriteReg(R15, $0000); // RGB interface polarity

// Power On sequence
  LCD_WriteReg(R16, $0000); // SAP, BT[3:0], AP, DSTB, SLP, STB
  LCD_WriteReg(R17, $0000); // DC1[2:0], DC0[2:0], VC[2:0]
  LCD_WriteReg(R18, $0000); // VREG1OUT voltage
  LCD_WriteReg(R19, $0000); // VDV[4:0] for VCOM amplitude
  delay(20);                 // Dis-charge capacitor power voltage (200ms)
  LCD_WriteReg(R16, $17B0); // SAP, BT[3:0], AP, DSTB, SLP, STB
  LCD_WriteReg(R17, $0137); // DC1[2:0], DC0[2:0], VC[2:0]
  delay(5);                  // Delay 50 ms
  LCD_WriteReg(R18, $0139); // VREG1OUT voltage
  delay(5);                  // Delay 50 ms
  LCD_WriteReg(R19, $1d00); // VDV[4:0] for VCOM amplitude
  LCD_WriteReg(R41, $0013); // VCM[4:0] for VCOMH
  delay(5);                  // Delay 50 ms
  LCD_WriteReg(R32, $0000); // GRAM horizontal Address
  LCD_WriteReg(R33, $0000); // GRAM Vertical Address

// Adjust the Gamma Curve
  LCD_WriteReg(R48, $0006);
  LCD_WriteReg(R49, $0101);
  LCD_WriteReg(R50, $0003);
  LCD_WriteReg(R53, $0106);
  LCD_WriteReg(R54, $0b02);
  LCD_WriteReg(R55, $0302);
  LCD_WriteReg(R56, $0707);
  LCD_WriteReg(R57, $0007);
  LCD_WriteReg(R60, $0600);
  LCD_WriteReg(R61, $020b);

// Set GRAM area
  LCD_WriteReg(R80, $0000); // Horizontal GRAM Start Address
  LCD_WriteReg(R81, $00EF); // Horizontal GRAM End Address
  LCD_WriteReg(R82, $0000); // Vertical GRAM Start Address
  LCD_WriteReg(R83, $013F); // Vertical GRAM End Address

  LCD_WriteReg(R96,  $2700); // Gate Scan Line
  LCD_WriteReg(R97,  $0001); // NDL,VLE, REV
  LCD_WriteReg(R106, $0000); // set scrolling line

// Partial Display Control
  LCD_WriteReg(R128, $0000);
  LCD_WriteReg(R129, $0000);
  LCD_WriteReg(R130, $0000);
  LCD_WriteReg(R131, $0000);
  LCD_WriteReg(R132, $0000);
  LCD_WriteReg(R133, $0000);

// Panel Control
  LCD_WriteReg(R144, $0010);
  LCD_WriteReg(R146, $0000);
  LCD_WriteReg(R147, $0003);
  LCD_WriteReg(R149, $0110);
  LCD_WriteReg(R151, $0000);
  LCD_WriteReg(R152, $0000);

  // Set GRAM write direction and BGR = 1
  // I/D=01 (Horizontal : increment, Vertical : decrement)
  // AM=1 (address is updated in vertical writing direction)
  LCD_WriteReg(R3, $1018);

  LCD_WriteReg(R7, $0173); // 262K color and display ON}
end;

//======================================================================
procedure LCD_SetTextColor(Color : word);
begin
  TextColor := Color;
end;

//======================================================================
procedure LCD_SetBackColor(Color : word);
begin
  BackColor := Color;
end;

//==============================================================================
procedure LCD_SetDataDirection(ADirection : word);
begin
  case ADirection of
    LEFTTORIGHT :
      begin
        WriteCommand($36);
        WriteData($00);
      end;
    RIGHTTOLEFT :
      begin
        WriteCommand($36);
        WriteData($40);
      end;
    TOPTOBOTTOM :
      begin
        WriteCommand($36);
        WriteData($00);
      end;
    BOTTOMTOTOP :
      begin
        WriteCommand($36);
        WriteData($80);
      end;
  end;
end;

//======================================================================
procedure LCD_Clear(Color : dword);
var
  h : dword;
begin
  LCD_SetDisplayWindow(0, 0, ScreenHeight, ScreenWidth);
  LCD_WriteRAM_Prepare;

  h := ScreenWidth * ScreenHeight;
  //h := h DIV 2;

  //while (PortG.IDR and $0100) = 0 do;
  //while (PortG.IDR and $0100) <> 0 do;

  while h > 0 do
  begin
    LCD.LCD_RAM := dword(lo(hi(Color)));
    LCD.LCD_RAM := dword(hi(lo(Color)));
    LCD.LCD_RAM := dword(lo(lo(Color)));
    dec(h);
  end;
end;

//======================================================================
procedure LCD_SetCursor(Xpos, Ypos : word);
begin
  LCD_WriteReg(R32, Xpos);
  LCD_WriteReg(R33, Ypos);
end;

//======================================================================
procedure LCD_SetDisplayWindow(x, y, height, width : word);
var
  xend,
  yend : word;
begin
  xend := (x + width) - 1;
  yend := (y + height) - 1;

  WriteCommand($2A);
  WriteData(hi(x));
  WriteData(lo(x));
  WriteData(hi(xend));
  WriteData(lo(xend));

  WriteCommand($2B);
  WriteData(hi(y));
  WriteData(lo(y));
  WriteData(hi(yend));
  WriteData(lo(yend));
end;

//======================================================================
procedure LCD_WindowModeDisable;
begin
  LCD_SetDisplayWindow(239, $13F, 240, 320);
  LCD_WriteReg(R3, $1018);
end;

//======================================================================
procedure LCD_DrawLine(Xpos, Ypos, Length, Direction : word);
var
  i : dword;
begin
  i := 0;

  LCD_SetCursor(Xpos, Ypos);

  if (Direction = Horizontal) then
  begin
    LCD_WriteRAM_Prepare(); // Prepare to write GRAM
    for i := 0 to Length - 1 do
    begin
      LCD_WriteRAM(TextColor);
    end
  end
  else
  begin
    for i := 0 to Length - 1 do
    begin
      LCD_WriteRAM_Prepare; // Prepare to write GRAM
      LCD_WriteRAM(TextColor);
      inc(Xpos);
      LCD_SetCursor(Xpos, Ypos);
    end;
  end;
end;

//======================================================================
procedure LCD_WriteReg(LCD_Reg2 : word; LCD_RegValue : word);
begin
  // Write 16-bit Index, then Write Reg
  LCD.LCD_Reg := dword(LCD_Reg2);
  // Write 16-bit Reg
  LCD.LCD_RAM := dword(LCD_RegValue);
end;

//======================================================================
function LCD_ReadReg(LCD_Reg2 : word) : word;
begin
  // Write 16-bit Index (then Read Reg)
  LCD.LCD_Reg := dword(LCD_Reg2);
  // Read 16-bit Reg
  exit(LCD.LCD_RAM);
end;

//======================================================================
procedure LCD_WriteRAM_Prepare;
begin
  LCD.LCD_REG := dword($002C);
end;

//======================================================================
procedure LCD_WriteRAM(RGB_Code : word);
begin
  // Write 16-bit GRAM Reg
  LCD.LCD_RAM := dword(RGB_Code);
end;

//======================================================================
procedure WriteCommand(RGB_Code : word);
begin
  // Write 16-bit GRAM Reg
  LCD.LCD_REG := dword(RGB_Code);
end;

//======================================================================
procedure WriteData(RGB_Code : word);
begin
  // Write 16-bit GRAM Reg
  LCD.LCD_RAM := dword(RGB_Code);
end;

//======================================================================
function ReadData : word;
begin
  exit(LCD.LCD_RAM);
end;

//======================================================================
function LCD_ReadRAM : word;
begin
  // Write 16-bit Index (then Read Reg)
  LCD.LCD_REG := dword(R34); // Select GRAM Reg
  // Read 16-bit Reg
  exit(LCD.LCD_RAM);
end;

//======================================================================
procedure LCD_PowerOn;
begin
// Power On sequence
  LCD_WriteReg(R16, $0000); // SAP, BT[3:0], AP, DSTB, SLP, STB
  LCD_WriteReg(R17, $0000); // DC1[2:0], DC0[2:0], VC[2:0]
  LCD_WriteReg(R18, $0000); // VREG1OUT voltage
  LCD_WriteReg(R19, $0000); // VDV[4:0] for VCOM amplitude
  delay(20);               // Dis-charge capacitor power voltage (200ms)
  LCD_WriteReg(R16, $17B0); // SAP, BT[3:0], AP, DSTB, SLP, STB
  LCD_WriteReg(R17, $0137); // DC1[2:0], DC0[2:0], VC[2:0]
  delay(5);                // Delay 50 ms
  LCD_WriteReg(R18, $0139); // VREG1OUT voltage
  delay(5);                // Delay 50 ms
  LCD_WriteReg(R19, $1d00); // VDV[4:0] for VCOM amplitude
  LCD_WriteReg(R41, $0013); // VCM[4:0] for VCOMH
  delay(5);                // Delay 50 ms
  LCD_WriteReg(R7, $0173);  // 262K color and display ON
end;

//======================================================================
procedure LCD_DisplayOn;
begin
  // Display On
  LCD_WriteReg(R7, $0173); // 262K color and display ON
end;

//======================================================================
procedure LCD_DisplayOff;
begin
  // Display Off
  LCD_WriteReg(R7, $000);
end;

//======================================================================
procedure LCD_CtrlLinesConfig;
var
  GPIO_InitStructure : TGPIO_InitTypeDef;
begin
  GPIO_StructInit(GPIO_InitStructure);

  // Enable FSMC, GPIOD, GPIOE, GPIOF, GPIOG and AFIO clocks
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_FSMC, ENABLED);

  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD OR RCC_APB2Periph_GPIOE OR
                         {RCC_APB2Periph_GPIOF OR RCC_APB2Periph_GPIOG OR}
                         RCC_APB2Periph_AFIO, ENABLED);

  // Set PD.00(D2), PD.01(D3), PD.04(NOE), PD.05(NWE), PD.08(D13), PD.09(D14),
  //   PD.10(D15), PD.14(D0), PD.15(D1) as alternate
  //   function push pull
  GPIO_InitStructure.GPIO_Pin := GPIO_Pin_0 OR GPIO_Pin_1 OR GPIO_Pin_4 OR GPIO_Pin_5 OR
                                 GPIO_Pin_7 OR GPIO_Pin_11 OR
                                 GPIO_Pin_8 OR GPIO_Pin_9 OR GPIO_Pin_10 OR GPIO_Pin_14 OR
                                GPIO_Pin_15;
  GPIO_InitStructure.GPIO_Speed := GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode := GPIO_Mode_AF_PP;
  GPIO_Init(PortD, GPIO_InitStructure);

  // Set PE.07(D4), PE.08(D5), PE.09(D6), PE.10(D7), PE.11(D8), PE.12(D9), PE.13(D10),
  //   PE.14(D11), PE.15(D12) as alternate function push pull
  GPIO_InitStructure.GPIO_Pin := GPIO_Pin_7 OR GPIO_Pin_8 OR GPIO_Pin_9 OR GPIO_Pin_10 OR
                                GPIO_Pin_11 OR GPIO_Pin_12 OR GPIO_Pin_13 OR GPIO_Pin_14 OR
                                GPIO_Pin_15;
  GPIO_Init(PortE, GPIO_InitStructure);

  // Set PF.00(A0 (RS)) as alternate function push pull
  //GPIO_InitStructure.GPIO_Pin := GPIO_Pin_0;
  //GPIO_Init(PortF, GPIO_InitStructure);

  // Set PG.12(NE4 (LCD/CS)) as alternate function push pull - CE3(LCD /CS)
  //GPIO_InitStructure.GPIO_Pin := GPIO_Pin_12;
  //GPIO_Init(PortG, GPIO_InitStructure);

  // Set PD.3 as output for LCD reset
  GPIO_InitStructure.GPIO_Speed := GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode := GPIO_Mode_Out_PP;
  GPIO_InitStructure.GPIO_Pin := GPIO_Pin_3;
  GPIO_Init(PortD, GPIO_InitStructure);

  GPIO_SetBits(PortD, GPIO_Pin_3);

  // Set PF.10 as input
  //GPIO_InitStructure.GPIO_Speed := GPIO_Speed_50MHz;
  //GPIO_InitStructure.GPIO_Mode := GPIO_Mode_IN_FLOATING;
  //GPIO_InitStructure.GPIO_Pin := GPIO_Pin_10;
  //GPIO_Init(PortF, GPIO_InitStructure);

  // Set PF.8 as input
  //GPIO_InitStructure.GPIO_Speed := GPIO_Speed_50MHz;
  //GPIO_InitStructure.GPIO_Mode := GPIO_Mode_IN_FLOATING;
  //GPIO_InitStructure.GPIO_Pin := GPIO_Pin_8;
  //GPIO_Init(PortG, GPIO_InitStructure);
end;

//======================================================================
procedure LCD_FSMCConfig;
var
  FSMC_NORSRAMInitStructure : TFSMC_NORSRAMInitTypeDef;
begin
  // FSMC_Bank1_NORSRAM1 configured as follows:
  //      - Data/Address MUX = Disable
  //      - Memory Type = SRAM
  //      - Data Width = 16bit
  //      - Write Operation = Enable
  //      - Extended Mode = Disable
  //      - Asynchronous Wait = Disable
  FSMC_NORSRAMInitStructure.FSMC_Bank               := FSMC_Bank1_NORSRAM1;
  FSMC_NORSRAMInitStructure.FSMC_DataAddressMux     := FSMC_DataAddressMux_Disable;
  FSMC_NORSRAMInitStructure.FSMC_MemoryType         := FSMC_MemoryType_PSRAM;
  FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth    := FSMC_MemoryDataWidth_16b;
  FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode    := FSMC_BurstAccessMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity := FSMC_WaitSignalPolarity_Low;
  FSMC_NORSRAMInitStructure.FSMC_WrapMode           := FSMC_WrapMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive   := FSMC_WaitSignalActive_BeforeWaitState;
  FSMC_NORSRAMInitStructure.FSMC_WriteOperation     := FSMC_WriteOperation_Enable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignal         := FSMC_WaitSignal_Disable;
  FSMC_NORSRAMInitStructure.FSMC_ExtendedMode       := FSMC_ExtendedMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WriteBurst         := FSMC_WriteBurst_Disable;

  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AddressSetupTime      := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AddressHoldTime       := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_DataSetupTime         := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_BusTurnAroundDuration := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_CLKDivision           := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_DataLatency           := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AccessMode            := FSMC_AccessMode_B;

  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AddressSetupTime      := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AddressHoldTime       := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_DataSetupTime         := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_BusTurnAroundDuration := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_CLKDivision           := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_DataLatency           := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AccessMode            := FSMC_AccessMode_B;

  FSMC_NORSRAMInit(FSMC_NORSRAMInitStructure);

  // Enable FSMC_Bank1_NORSRAM1
  FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLED);
end;

//======================================================================
procedure LCD_FSMCReConfig;
var
  FSMC_NORSRAMInitStructure : TFSMC_NORSRAMInitTypeDef;
begin
  // FSMC_Bank1_NORSRAM1 configured as follows:
  //      - Data/Address MUX = Disable
  //      - Memory Type = SRAM
  //      - Data Width = 16bit
  //      - Write Operation = Enable
  //      - Extended Mode = Disable
  //      - Asynchronous Wait = Disable
  FSMC_NORSRAMInitStructure.FSMC_Bank               := FSMC_Bank1_NORSRAM1;
  FSMC_NORSRAMInitStructure.FSMC_DataAddressMux     := FSMC_DataAddressMux_Disable;
  FSMC_NORSRAMInitStructure.FSMC_MemoryType         := FSMC_MemoryType_PSRAM;
  FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth    := FSMC_MemoryDataWidth_16b;
  FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode    := FSMC_BurstAccessMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity := FSMC_WaitSignalPolarity_Low;
  FSMC_NORSRAMInitStructure.FSMC_WrapMode           := FSMC_WrapMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive   := FSMC_WaitSignalActive_BeforeWaitState;
  FSMC_NORSRAMInitStructure.FSMC_WriteOperation     := FSMC_WriteOperation_Enable;
  FSMC_NORSRAMInitStructure.FSMC_WaitSignal         := FSMC_WaitSignal_Disable;
  FSMC_NORSRAMInitStructure.FSMC_ExtendedMode       := FSMC_ExtendedMode_Disable;
  FSMC_NORSRAMInitStructure.FSMC_WriteBurst         := FSMC_WriteBurst_Disable;

  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AddressSetupTime      := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AddressHoldTime       := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_DataSetupTime         := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_BusTurnAroundDuration := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_CLKDivision           := 1;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_DataLatency           := 0;
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct.FSMC_AccessMode            := FSMC_AccessMode_B;

  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AddressSetupTime      := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AddressHoldTime       := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_DataSetupTime         := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_BusTurnAroundDuration := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_CLKDivision           := 1;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_DataLatency           := 0;
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct.FSMC_AccessMode            := FSMC_AccessMode_B;

  FSMC_NORSRAMInit(FSMC_NORSRAMInitStructure);

  // Enable FSMC_Bank1_NORSRAM1
  FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLED);
end;
end.
