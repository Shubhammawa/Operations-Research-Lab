clc;
clear all;

%--------------Decision variables---------------%
% xij = 1 if sequence i to j is selected
%       0 if not selected
% i = 1,2,3,4;  j = 1,2,3,4;    i!=j

%--------------Objective function-------------%
% Minimize time Z = 4x12 + 7x13 + 3x14 + 4x21 + 6x23 + 3x24 + 7x31 + 6x32 +
% 7x34 + 3x41 + 3x42 + 7x43

%-------------Constraints----------------%
% x12 + x13 + x14 = 1
% x21 + x23 + x24 = 1
% x31 + x32 + x34 = 1
% x41 + x42 + x43 = 1

% x21 + x31 + x41 = 1
% x12 + x32 + x42 = 1
% x13 + x23 + x43 = 1
% x14 + x24 + x34 = 1

% x12 + x21 <= 1
% x13 + x31 <= 1
% x14 + x41 <= 1

% x23 + x32 <= 1
% x24 + x42 <= 1

% x34 + x43 <= 1

c = [4, 7, 3, 4, 6, 3, 7, 6, 7, 3, 3, 7];

intcon = [1:12];

A = [1,0,0,1,0,0,0,0,0,0,0,0;
    0,1,0,0,0,0,1,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,1,0,0;
    0,0,0,0,1,0,0,1,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,1,0,0,1];
    

b = [1;1;1;1;1;1];

A_eq = [1,1,1,0,0,0,0,0,0,0,0,0;
        0,0,0,1,1,1,0,0,0,0,0,0;
        0,0,0,0,0,0,1,1,1,0,0,0;
        0,0,0,0,0,0,0,0,0,1,1,1;
        0,0,0,1,0,0,1,0,0,1,0,0;
        1,0,0,0,0,0,0,1,0,0,1,0;
        0,1,0,0,1,0,0,0,0,0,0,1;
        0,0,1,0,0,1,0,0,1,0,0,0];

b_eq = [1;1;1;1;1;1;1;1];

lb = [0;0;0;0;0;0;0;0;0;0;0;0];
ub = [1;1;1;1;1;1;1;1;1;1;1;1];

[x, fval] = intlinprog(c,intcon,A,b,A_eq,b_eq,lb,ub);
%fprintf('The minimum setup time is %d\n',fval);

for i = 1:12
    fprintf('Route %d selection : %d\n',i,x(i));
end  
max = 0;
cost = 0;
for i = 1:12
    if x(i) == 1
        cost = cost + c(i);
        if c(i)> max
            max = c(i);
        end
    end
end 
cost = cost - max;
fprintf('The minimum time required is %d\n',cost);          