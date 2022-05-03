clear 
clc
close


dtr  = pi/180 ;
r1 = 230 ; r2 = 230 ; r3 = 60 ; r4 = 27.68 ; r5 = 10.32 ;
%theta1 = 75.04*dtr ; theta2 = 7.03*dtr ; 
%(155.87,343.24)
%開矩陣
a = 70;
b = 85;
theta1 = zeros(a,b);
theta2 = zeros(a,b);
theta1(1,1) = 155.87*dtr;
theta2(1,1) = 343.24*dtr;

%試走20步 上下左右 1步5毫米
%r5
for j = 1:1:b
    %計算每個初始值,存進每個theta1,theta2的第一列
    A1 = [-r1*sin(theta1(1,j)) -r2*sin(theta2(1,j)); r1*cos(theta1(1,j)) r2*cos(theta2(1,j)) ];
    B1 = [0;5];  
    C1 = A1\B1;
    theta1(1,j+1) = theta1(1,j) + C1(1);%最後一列不用看
    theta2(1,j+1) = theta2(1,j) + C1(2);%最後一列不用看
    %r4
    for i = 1:1:a  
        %temp(i) = i;
        %location_to_degree(i,1) = r5 + 5*(i-1);%儲存r5的location
        A2 = [-r1*sin(theta1(i,j)) -r2*sin(theta2(i,j)); r1*cos(theta1(i,j)) r2*cos(theta2(i,j)) ];
        B2 = [5;0];  
        C2 = A2\B2;
        theta1(i+1,j) = theta1(i,j) + C2(1);%最後一行不用看
        theta2(i+1,j) = theta2(i,j) + C2(2);%最後一行不用看 
    end
end

c = 70;
d = 11;
theta3 = zeros(c,d);
theta4 = zeros(c,d);
%theta3 = theta1_down theta4 = theta2_down
theta3(1,1) = 155.87*dtr;
theta4(1,1) = 343.24*dtr;

for k = 1:1:d
    %計算每個初始值,存進每個theta1,theta2的第一列
    A1 = [-r1*sin(theta3(1,k)) -r2*sin(theta4(1,k)); r1*cos(theta3(1,k)) r2*cos(theta4(1,k)) ];
    B1 = [0;-5];  
    C1 = A1\B1;
    theta3(1,k+1) = theta3(1,k) + C1(1);%最後一列不用看
    theta4(1,k+1) = theta4(1,k) + C1(2);%最後一列不用看
    %r4
    for l = 1:1:c  
        %temp(i) = i;
        %location_to_degree(i,1) = r5 + 5*(i-1);%儲存r5的location
        A2 = [-r1*sin(theta3(l,k)) -r2*sin(theta4(l,k)); r1*cos(theta3(l,k)) r2*cos(theta4(l,k)) ];
        B2 = [5;0];  
        C2 = A2\B2;
        theta3(l+1,k) = theta3(l,k) + C2(1);%最後一行不用看
        theta4(l+1,k) = theta4(l,k) + C2(2);%最後一行不用看 
    end
end

r5c = zeros(a,b);
r5s = zeros(a,b);
degree1 = zeros(a,b);
degree2 = zeros(a,b);
mdegree1 = zeros(a,b);
mdegree2_180 = zeros(a,b);
mdegree2_270 = zeros(a,b);
%顯示180度為0度角 270度為0度角的差別
r5c_180 = zeros(a,b);
r5s_180 = zeros(a,b);
r5c_270 = zeros(a,b);
r5s_270 = zeros(a,b);

for i = 1:1:a
    for j = 1:1:b
        degree1(i,j) = theta1(i,j)/dtr  ;
        if degree1(i,j) > 360
            degree1(i,j) = degree1(i,j)-360;
        end
        degree2(i,j) = theta2(i,j)/dtr  ;
        
        if degree2(i,j) > 360
           degree2(i,j) = degree2(i,j) - 360;
        end

        r5c(i,j) = r1*cos(theta1(i,j)) + r2*cos(theta2(i,j));
        r5s(i,j) = r1*sin(theta1(i,j)) + r2*sin(theta2(i,j));
        location_to_degree(i,(j-1)*5+1) = r5c(i,j);
        location_to_degree(i,(j-1)*5+2) = r5s(i,j);
        location_to_degree(i,(j-1)*5+3) = degree1(i,j);
        location_to_degree(i,(j-1)*5+4) = degree2(i,j);
        %調整成伺服馬達角
        mdegree1(i,j) = degree1(i,j);
        if degree2(i,j) > 180
            mdegree2_180(i,j) = degree2(i,j) - 180 ;
        end
        mdegree2_180(i,j) = 180 - mdegree2_180(i,j);
        if degree2(i,j) > 270
            mdegree2_270(i,j) = degree2(i,j) - 270 ;
        elseif degree2(i,j) < 90
            mdegree2_270(i,j) = degree2(i,j) + 90 ;
        end
        mdegree2_270(i,j) = 180 - mdegree2_270(i,j);
        %只能由伺服馬達的角度所走的地方
        
        if degree2(i,j) > 0 && degree2(i,j) < 90
            r5c_180(i,j) = r5c_180(i,j-1);
            r5s_180(i,j) = r5s_180(i,j-1);
        else
            r5c_180(i,j) = r1*cos(theta1(i,j)) + r2*cos(theta2(i,j));
            r5s_180(i,j) = r1*sin(theta1(i,j)) + r2*sin(theta2(i,j));
        end
        
        if degree2(i,j) > 90 && degree2(i,j) < 270
            r5c_270(i,j) = r5c_270(i,j-1);
            r5s_270(i,j) = r5s_270(i,j-1);
        else
            r5c_270(i,j) = r1*cos(theta1(i,j)) + r2*cos(theta2(i,j));
            r5s_270(i,j) = r1*sin(theta1(i,j)) + r2*sin(theta2(i,j));
        end
        %99行以後不用看
    end
end 
r5c_mod = zeros(a,b);
for i = 1:1:a
    for j = 1:1:b-1
        distance_cos = abs(r5c(i,j+1) - r5c(i,j)) ; 
        if distance_cos > 1
            mdegree1(i,j+1) = 180;
            mdegree2_270(i,j+1) = 180;
            r5c_mod(i,j+1) = r5c(i,j);
        end
    end
end
r5s_mod = zeros(a,b);
for i = 1:1:a-1
    for j = 1:1:b
        distance_sin = abs(r5s(i+1,j) - r5s(i,j)) ; 
        if distance_sin > 1
            mdegree1(i+1,j) = 180;
            mdegree2_270(i+1,j) = 180;
            r5s_mod(i+1,j) = r5s(i,j);
        end
    end
end
for i = 1:1:a
    for j = 1:1:b
        matrix1(i,j) = mdegree1(i,j) + ",";
        matrix1(i,b) = mdegree1(i,b) + "}" + ",";
        
        matrix2(i,j) = mdegree2_270(i,j) + ",";
        matrix2(i,b) = mdegree2_270(i,b) + "}" + ",";
    end
end
r5c_down = zeros(c,d);
r5s_down = zeros(c,d);
degree1_down = zeros(c,d);
degree2_down = zeros(c,d);
mdegree1_down = zeros(c,d);
mdegree2_down_180 = zeros(c,d);
mdegree2_down_270 = zeros(c,d);
%顯示180度為0度角 270度為0度角的差別
r5c_down_180 = zeros(c,d);
r5s_down_180 = zeros(c,d);
r5c_down_270 = zeros(c,d);
r5s_down_270 = zeros(c,d);

for i = 1:1:c
    for j = 1:1:d
        degree1_down(i,j) = theta3(i,j)/dtr  ;
        if degree1_down(i,j) < 0
            degree1_down(i,j) = degree1_down(i,j)+360;
        end
        
        degree2_down(i,j) = theta4(i,j)/dtr  ;
        if degree2_down(i,j) < 0
           degree2_down(i,j) = 360 + degree2_down(i,j);
        end

        r5c_down(i,j) = r1*cos(theta3(i,j)) + r2*cos(theta4(i,j));
        r5s_down(i,j) = r1*sin(theta3(i,j)) + r2*sin(theta4(i,j));
        location_to_degree_down(i,(j-1)*5+1) = r5c_down(i,j);
        location_to_degree_down(i,(j-1)*5+2) = r5s_down(i,j);
        location_to_degree_down(i,(j-1)*5+3) = degree1_down(i,j);
        location_to_degree_down(i,(j-1)*5+4) = degree2_down(i,j);
        %調整成伺服馬達角
        mdegree1_down(i,j) = degree1_down(i,j);
        if degree2_down(i,j) > 180
            mdegree2_down_180(i,j) = degree2_down(i,j) - 180;
        else 
            mdegree2_down_180(i,j) = 0;
        end
        mdegree2_down_180(i,j) = 180 - mdegree2_down_180(i,j);
        if degree2_down(i,j) > 270
            mdegree2_down_270(i,j) = degree2_down(i,j) - 270 ;
        elseif degree2_down(i,j) < 90
            mdegree2_down_270(i,j) = degree2_down(i,j) + 90 ;
        end
        mdegree2_down_270(i,j) = 180 - mdegree2_down_270(i,j);
        
         %只能由伺服馬達的角度所走的地方
        if degree2_down(i,j) > 0 && degree2_down(i,j) < 90
            r5c_down_180(i,j) = r5c_down_180(i,j-1);
            r5s_down_180(i,j) = r5s_down_180(i,j-1);
        else
            r5c_down_180(i,j) = r1*cos(theta3(i,j)) + r2*cos(theta4(i,j));
            r5s_down_180(i,j) = r1*sin(theta3(i,j)) + r2*sin(theta4(i,j));
        end
        
        if degree2_down(i,j) > 90 && degree2_down(i,j) < 270
            r5c_down_270(i,j) = r5c_down_270(i,j-1);
            r5s_down_270(i,j) = r5s_down_270(i,j-1);
        else
            r5c_down_270(i,j) = r1*cos(theta3(i,j)) + r2*cos(theta4(i,j));
            r5s_down_270(i,j) = r1*sin(theta3(i,j)) + r2*sin(theta4(i,j));
        end
        %99行以後不用看
    end
end
for i = 1:1:c
    for j = 1:1:d
        matrix1_down(i,j) = mdegree1_down(i,d+1-j) + ",";
        matrix1_down(i,1) = "{" + mdegree1_down(i,d) + ",";
        
        matrix2_down(i,j) = mdegree2_down_270(i,d+1-j) + ",";
        matrix2_down(i,1) = "{" + mdegree2_down_270(i,d) + ",";
        
    end
end
r5ct = transpose(r5c);
r5st = transpose(r5s);
r5c_downt = transpose(r5c_down);
r5s_downt = transpose(r5s_down);
r5ct_180 = transpose(r5c_180);
r5st_180 = transpose(r5s_180);
r5c_downt_180 = transpose(r5c_down_180);
r5s_downt_180 = transpose(r5s_down_180);
r5ct_270 = transpose(r5c_270);
r5st_270 = transpose(r5s_270);
r5c_downt_270 = transpose(r5c_down_270);
r5s_downt_270 = transpose(r5s_down_270);

subplot(2,3,1);
plot(r5c,r5s,r5ct,r5st);
subplot(2,3,4);
plot(r5c_down,r5s_down,r5c_downt,r5s_downt);
subplot(2,3,2);
plot(r5c_180,r5s_180,r5ct_180,r5st_180);
subplot(2,3,5);
plot(r5c_down_180,r5s_down_180,r5c_downt_180,r5s_downt_180);
subplot(2,3,3);
plot(r5c_270,r5s_270,r5ct_270,r5st_270);
subplot(2,3,6);
plot(r5c_down_270,r5s_down_270,r5c_downt_270,r5s_downt_270);

