Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public static class Programme
{
    [DllImport("user32.dll")]
    public static extern int MapVirtualKey(uint uCode, uint uMapType);
}

"@ -ReferencedAssemblies System.Windows.Forms

# 0xBF >> french canadian: é | US Keyboard: ?
#[char]([Programme]::MapVirtualKey(0xBF,2))

Add-Type -Path '.\VISE_WinKeyboardHook.dll'

$KeyboardInterceptor = new-object VISE.WinKeyboardHook.KeyboardInterceptor
function HandleKeyDown($keyId)
{
    if($keyID.KeyCode -eq "Escape"){
        $KeyboardInterceptor.StopCapturing()
        Write-Host "EXIT"
    }else{
        Write-Host "############################################"
        try{
            Write-Host "KeyChar   :" $([char]([Programme]::MapVirtualKey(("0x"+("    {0:x}" -f $keyID.KeyValue).ToUpper()),2)))
        }catch{
            Write-Host "KeyChar   : ERROR"
        }
        Write-Host "KeyCode   :" $keyID.KeyCode
        Write-Host "KeyData   :" $keyID.KeyData
        Write-Host "KeyValue  : Dec=" $keyID.KeyValue 
        Write-Host "            Hex=" ("{0:x}" -f $keyID.KeyValue).ToUpper()
        Write-Host "Modifiers :" $keyID.Modifiers
        Write-Host "Shift     :" $keyID.Shift
        Write-Host "Alt       :" $keyID.Alt
        Write-Host "Control   :" $keyID.Control
    }
}

Unregister-Event -SourceIdentifier KeyDown -ErrorAction SilentlyContinue
$keyevent = Register-ObjectEvent -InputObject $KeyboardInterceptor -EventName     KeyDown -SourceIdentifier KeyDown -Action {HandleKeyDown($event.sourceEventArgs)}

$KeyboardInterceptor.StartCapturing()
