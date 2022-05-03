#include <SoftwareSerial.h>
SoftwareSerial BT(12, 13); //接收腳,傳送腳
char val;


void setup() {
  Serial.begin(38400);
  Serial.print("ready");
  BT.begin(38400);
}

void loop() {
  if (Serial.available()) {
    val = Serial.read();
    BT.print(val);
  }
  if (BT.available()) {
    val = BT.read();
    Serial.print(val);
  }

}
