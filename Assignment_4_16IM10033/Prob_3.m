clc;
clear all;

%----------------Decision variables---------------%
% x1j = Space taken on rent in month 1 for j number of months;  j = 1,2,3;  
% x1j >= 0
% x2j = Space taken on rent in month 2 for j number of months;  j = 1,2;
% x2j >= 0
% x31 = Space taken on rent in month 3 for 1 month;     x31 >= 0
% Note: All areas in 1000 cubic metres

%---------------------Objective function--------------%
% Minimize cost Z = 28000(x11 + x21 + x31) + 45000(x12 + x22) + 60000(x13)

%-------------------Constraints-------------------%
% x11 + x12 + x13 >= 25
% x12 + x13 + x21 + x22 >= 10
% x13 + x22 + x31 >= 20

c = [28000;45000;60000;28000;45000;28000];

intcon = [1:6];

A = [-1, -1, -1, 0, 0, 0;
    0, -1, -1, -1, -1, 0;
    0, 0, -1, 0, -1, -1];

b = [-25;-10;-20];

lb = [0;0;0;0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);
fprintf('The minimum cost is Rs %d\n',fval);
fprintf('x11 = %d\nx12 = %d\nx13 = %d\nx21 = %d\nx22 = %d\nx31 = %d',x(1),x(2),x(3),x(4),x(5),x(6));