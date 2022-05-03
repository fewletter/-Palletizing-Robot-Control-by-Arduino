#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();
const int servo_pins[] = {0, 1, 2};
int sg90_servo_pulse_width[] = {500, 2400};
int spt5435_servo_pulse_width[] = {500, 2500};
int s3003_servo_pulse_width[] = {1520,1900};
int servo_angle_degree[] = {0, 180};
#define frequency 50

float pulse_wide;
float pulse_output;
float pulse_wide_2;
float pulse_output_2;
float pulse_wide_3;
float pulse_output_3;

void mearm_run(int i, float angle1, int servo_type_min, int servo_type_max) {
  pulse_wide = map(angle1, servo_angle_degree[0], servo_angle_degree[1], servo_type_min, servo_type_max);
  pulse_output = int(float(pulse_wide) / 1000000 * frequency * 4096);
  pwm.setPWM(i, 0, pulse_output);
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("PCA9685 test ready!");
  pwm.begin();
  pwm.setPWMFreq(frequency);
}

void loop() {
  // put your main code here, to run repeatedly:
    mearm_run(5, 0, 450, 2700);
    delay(3000);
    mearm_run(5, 180, 450, 2700);
    delay(3000);
    
    
}
