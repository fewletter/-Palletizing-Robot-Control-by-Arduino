int L1_IN1 = 7;int L1_IN2 = 5;int L1_ENA = 6;//左前輪
int R1_IN1 = 4;int R1_IN2 = 2;int R1_ENA = 3;//右前輪
int L2_IN1 = 12;int L2_IN2 = 13;int L2_ENA = 11;//左後輪
int R2_IN1 = 8;int R2_IN2 = 9;int R2_ENA = 10;//右後輪

void setup() {
  // put your setup code here, to run once:
  // 確認藍芽鮑率  
  Serial.begin(9600);
  pinMode(L1_IN1, OUTPUT);pinMode(L1_IN2, OUTPUT);pinMode(L1_ENA, OUTPUT);
  pinMode(R1_IN1, OUTPUT);pinMode(R1_IN2, OUTPUT);pinMode(R1_ENA, OUTPUT);
  pinMode(L2_IN1, OUTPUT);pinMode(L2_IN2, OUTPUT);pinMode(L2_ENA, OUTPUT);
  pinMode(R2_IN1, OUTPUT);pinMode(R2_IN2, OUTPUT);pinMode(R2_ENA, OUTPUT);
  
}

void L1_forward(int sp)//左前輪前進
{
  digitalWrite(L1_IN1,LOW);
  digitalWrite(L1_IN2,HIGH);
  analogWrite(L1_ENA,sp);
}
void R1_forward(int sp)//右前輪前進
{
  digitalWrite(R1_IN1,HIGH);
  digitalWrite(R1_IN2,LOW);
  analogWrite(R1_ENA,sp);
}
void L2_forward(int sp)//左後輪前進
{
  digitalWrite(L2_IN1,HIGH);
  digitalWrite(L2_IN2,LOW);
  analogWrite(L2_ENA,sp);
}
void R2_forward(int sp)//右後輪前進
{
  digitalWrite(R2_IN1,HIGH);
  digitalWrite(R2_IN2,LOW);
  analogWrite(R2_ENA,sp);
}
void allstop()
{
  digitalWrite(L1_IN1,LOW);
  digitalWrite(L1_IN2,LOW);  
  digitalWrite(R1_IN1,LOW);
  digitalWrite(R1_IN2,LOW);
  digitalWrite(L2_IN1,LOW);
  digitalWrite(L2_IN2,LOW);
  digitalWrite(R2_IN1,LOW);
  digitalWrite(R2_IN2,LOW);
}
void L1_backward(int sp)//左前輪後退
{
  digitalWrite(L1_IN1,HIGH);
  digitalWrite(L1_IN2,LOW);
  analogWrite(L1_ENA,sp);
}
void R1_backward(int sp)//右前輪後退
{
  digitalWrite(R1_IN1,LOW);
  digitalWrite(R1_IN2,HIGH);
  analogWrite(R1_ENA,sp);
}
void L2_backward(int sp)//左後輪後退
{
  digitalWrite(L2_IN1,LOW);
  digitalWrite(L2_IN2,HIGH);
  analogWrite(L2_ENA,sp);
}
void R2_backward(int sp)//右後輪後退
{
  digitalWrite(R2_IN1,LOW);
  digitalWrite(R2_IN2,HIGH);
  analogWrite(R2_ENA,sp);
}

void loop() {
  // put your main code here, to run repeatedly:
  while(Bluetooth.available()){
    char msg = Serial.read();
    Serial.println(msg);
    /*前進*/
    if(msg.equals("forward")){
      L1_forward(100);
      R1_forward(100);
      L2_forward(100);
      R2_forward(100);
      delay(1500);
      allstop();
      delay(1500);
      }
    /*後退*/
    else if (msg.equals("backward"){
      L1_backward(100);
      R1_backward(100);
      L2_backward(100);
      R2_backward(100);
      delay(1500);
      allstop();
      delay(1500);
      }
    /*順時針原地旋轉*/
    else if (msg.equals("rotateright"){
      L1_forward(200);
      R1_backward(200);
      L2_forward(200);
      R2_backward(200);
      delay(1500);
      allstop();
      delay(1500);
      }
    /*逆時針原地旋轉*/
    else if (msg.equals("rotateleft"){
      L1_backward(200);
      R1_forward(200);
      L2_backward(200);
      R2_forward(200);
      delay(1500);
      allstop();
      delay(1500);
      }
    /*左邊平移*/
    else if (msg.equals("sidewayleft"){  
      L1_backward(150);
      R1_forward(150);
      L2_forward(150);
      R2_backward(150);
      delay(1500);
      allstop();
      delay(1500);
      }
     /*右邊平移*/
    else if (msg.equals("sidewayright"){
      L1_forward(150);
      R1_backward(150);
      L2_backward(150);
      R2_forward(150);
      delay(1500);
      allstop();
      delay(1500);
      }
     /*斜向左上方*/
    else if (msg.equals("leftup"){
      R1_forward(150);
      L2_forward(150);
      delay(1500);
      allstop();
      delay(1500);
      } 
    /*斜向右上方*/
    else if (msg.equals("rightup"){
      L1_forward(150);
      R2_forward(150);
      delay(1500);
      allstop();
      delay(1500);
      }  
    /*斜向左下方*/
    else if (msg.equals("leftdown"){
      L1_backward(150);
      R2_backward(150);
      delay(1500);
      allstop();
      delay(1500);
      }  
    /*斜向右下方*/
    else if (msg.equals("rightdown"){
      R1_backward(150);
      L2_backward(150);
      delay(1500);
      allstop();
      delay(1500);
      }
  }
}
