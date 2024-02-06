#include <Wire.h>
#include <rgb_lcd.h>

rgb_lcd lcd;
  // put your setup code here, to run once:
const int joystickX = A0;  // Axe X du joystick connecté à A0
const int joystickY = A1;  // Axe Y du joystick connecté à A1
const int buttonPin = 9;   // Bouton du joystick connecté à D9

int lastYPosition = 512; // Position centrale pour l'axe Y
bool lastButtonState = HIGH;
bool buttonPressed = false;

const int menuItems = 5;
int currentItem = 0;
int validation;
String menu[menuItems] = {"ShadowStrike","Option 1", "Option 2", "Option 3","Option 4"};

void setup() {
  pinMode(joystickX, INPUT);
  pinMode(joystickY, INPUT);
  pinMode(buttonPin, INPUT_PULLUP);

  lcd.begin(16, 2);
}

void loop() {
        //lcd.setRGB(255,255,255);

int yPosition = analogRead(joystickY);
  bool buttonState = digitalRead(buttonPin);
  int Maxmenu = 5;
  // Détecter le mouvement du joystick
  if (yPosition < 10 )  {
    currentItem = (currentItem - 1) % menuItems;
    displayCurrentItem();
        delay(1000);

//    lastYPosition = yPosition;
    buttonPressed = false; // Réinitialiser l'état du bouton après le déplacement
  }
 if (currentItem < 0){
  currentItem = 5;
  }
   if (currentItem > Maxmenu){
  currentItem = 0;
  }
  if  (yPosition > 1000 ) {
    currentItem = (currentItem + 1) % menuItems;
    displayCurrentItem();
    delay(1000);
//    lastYPosition = yPosition;
    buttonPressed = false; // Réinitialiser l'état du bouton après le déplacement
  }

  // Sélectionner l'option avec le bouton
  if (buttonState == LOW && lastButtonState == HIGH ) {
    lcd.setRGB(0, 255, 0); // Vert pour l'option sélectionnée
    lcd.setCursor(0,1);
    lcd.print("Validé ! ");
    delay(1000); // Afficher l'option choisie pendant un moment
    buttonPressed = true;
    validation = currentItem;
   displayCurrentItem();
  }

  lastButtonState = buttonState;
  delay(100); // Délai pour la fluidité

  
  switch (validation) {

    case 1:
      lcd.setCursor(0,1);
      lcd.setRGB(255,0,255);
      
      break;
    case 2:
      lcd.setCursor(0,1);
      lcd.setRGB(0, 255, 255);
      break;
    case 3:
      lcd.setCursor(0,1);
      lcd.setRGB(0,0,255);
      break;
      
    case 4:
      lcd.setCursor(0,1);
      lcd.setRGB(255,0,0);
      break;}
}

void displayCurrentItem() {
  lcd.clear();
  lcd.setCursor(0,0);
  //lcd.setRGB(255,0,255); // violet pour l'option en cours
  lcd.print(menu[currentItem]);
}
