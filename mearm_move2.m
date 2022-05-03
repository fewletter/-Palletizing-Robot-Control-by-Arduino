clear 
clc
close


dtr  = pi/180 ;
r1 = 230 ; r2 = 230 ; r3 = 60 ; r4 = 250.38 ; r5 = 287.63 ;
%theta1 = 75.04*dtr ; theta2 = 7.03*dtr ; 
%速度 合併過後
dr5 = 2; dr4 = 2;

theta1 = zeros(1,21);
theta2 = zeros(1,21);
theta1(1) = 75.04*dtr;
theta2(1) = 7.03*dtr;

A1 = [-2*r1*sin(theta1(1)) -r2*sin(theta2(1)); 2*r1*cos(theta1(1))  r2*cos(theta2(1)) ];
B = [2;0]; 
C1 = A1\B;
D1 = [C1(1)/dtr;C1(2)/dtr];

theta1(2) = theta1(1) + C1(1);
theta2(2) = theta2(1) + C1(2);

r5c = r1*cos(theta1(2)) + r1*cos(theta2(2));

A2 = [-2*r1*sin(theta1(2)) -r2*sin(theta2(2)); 2*r1*cos(theta1(2))  r2*cos(theta2(2)) ];
 
C2 = A2\B;
D2 = [C2(1)/dtr;C2(2)/dtr];