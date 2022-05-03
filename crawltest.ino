#include <Servo.h>
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Servo myservo;  // 建立SERVO物件
Servo my2servo;
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);
int frequency = 50;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  myservo.attach(6);
  pwm.begin();
  pwm.setPWMFreq(frequency);
}

void loop() {
//  myservo.write(0);
//  myservo.writeMicroseconds(500);
//  delay(1000);
//  myservo.writeMicroseconds(2400);
//  delay(1000);
    //pulse_output = floor(float(1100) / 1000000.0 * frequency * 4096.0);
//    pwm.writeMicroseconds(0,1000);
//    delay(1000);
//    pwm.writeMicroseconds(0,1500);
//    delay(1000);
  myservo.write(5);
  delay(1000);
  myservo.write(40);
  delay(1000);
}
