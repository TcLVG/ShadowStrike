#include <Wire.h>
#include <rgb_lcd.h>

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
#define MAXMENU 4
String menu[] = {"ShadowStrike","ScareWare", "SpyWare", "Trollolo","Shrek"};
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


void setup(void) {

  pinMode(JOYSTICK_Y, INPUT);
  pinMode(BUTTON, INPUT_PULLUP);
  lcd.begin(16, 2);
  lcd.createChar(0, e_aigu);

  displayItems();
  
}

void loop(void) {

  joystickMvt();
  buttonChk();

}

void joystickMvt(void){
  
  int yPosition = analogRead(JOYSTICK_Y);
  
  if(millis() - delayValue >= 250){        
    if(yPosition > 1000){
      currentItem = (currentItem+1 > MAXMENU) ? 0 : currentItem+1;
      displayItems();
    }
    else if(yPosition < 10){
      currentItem = (currentItem-1 < 0) ? MAXMENU : currentItem-1;
      displayItems();
    }
    delayValue = millis();
  }
  
}

byte buttonChk(void){
  
  bool currentState = digitalRead(BUTTON);

  if(!currentState && lastState && currentItem){
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

void menuSelection(void){
  
  switch (currentItem) {
    case 1:
      lcd.setRGB(255, 0, 255);
      break;
    case 2:
      lcd.setRGB(0, 255, 255);
      break;
    case 3:
      lcd.setRGB(0, 0, 255);
      break;
    case 4:
      lcd.setRGB(0, 75, 0);
      break;
    
  }
  
}

void displayItems(void) {

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.setRGB(255, 255, 255);
  lcd.print(menu[currentItem]);

}
