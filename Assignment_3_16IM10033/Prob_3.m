clc;
clear all;

%------------Decision variables-------------%
% xi = Number of people starting work on day i of the week
% xi>= 0;   i = 1,2,3,4,5,6,7

%------------Objective function------------%
% Minimize Z = x1 + x2 + x3 + x4 + x5 + x6 + x7

%------------Constraints---------------%
% x1 + x4 + x5 + x6 + x7 >= 17
% x1 + x2 + x5 + x6 + x7 >= 13
% x1 + x2 + x3 + x6 + x7 >= 15
% x1 + x2 + x3 + x4 + x7 >= 19
% x1 + x2 + x3 + x4 + x5 >= 14
% x2 + x3 + x4 + x5 + x6 >= 16
% x3 + x4 + x5 + x6 + x7 >= 11

c = [1,1,1,1,1,1,1];
intcon = [1:7];

A = [-1,0,0,-1,-1,-1,-1;
    -1,-1,0,0,-1,-1,-1;
    -1,-1,-1,0,0,-1,-1;
    -1,-1,-1,-1,0,0,-1;
    -1,-1,-1,-1,-1,0,0;
    0,-1,-1,-1,-1,-1,0;
    0,0,-1,-1,-1,-1,-1];
b = [-17;-13;-15;-19;-14;-16;-11];

lb = [0;0;0;0;0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);
fprintf('The minimum number of employees needed to be hired = %d\n',fval);