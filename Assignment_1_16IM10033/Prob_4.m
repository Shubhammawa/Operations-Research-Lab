clc;
clear all;
%%---------Decision variables------%%
% x1 --> Amount of chemical to be sent at 10 AM
% x2 --> Amount of chemical to be sent at 11 AM
% x3 --> Amount of chemical to be sent at 12 PM
% ...
% x6 --> Amount of chemical to be sent at 3 PM
% xi >=0 , for i=1,2...6

% Objective function : Minimize Z = 30x1 + 40x2 + 35x3 + 45x4 + 38x5 + 50x6

%%----------Constraints-------------%%
% 300 - x1 <= 1000
% 300 - x1 + 240 - x2 <= 1000
% 300 - x1 + 240 - x2 + 600 - x3 <= 1000
% 300 - x1 + 240 - x2 + 600 - x3 + 200 - x4 <= 1000
% 300 - x1 + 240 - x2 + 600 - x3 + 200 - x4 + 300 - x5 <= 1000
% 300 - x1 + 240 - x2 + 600 - x3 + 200 - x4 + 300 - x5 + 900 - x6 = 0  No
% chemical allowed to be kept overnight.

% x1 <= 300           The amount to be sent will be less than the total
%                     chemical present.
% x2 <= 300 - x1 + 240
% x3 <= 300 - x1 + 240 - x2 + 600
% x4 <= 300 - x1 + 240 - x2 + 600 - x3 + 200
% x5 <= 300 - x1 + 240 - x2 + 600 - x3 + 200 - x4 + 300
% Constraints simplified :
% -x1 <= 700
% -x1 - x2 <= 460
% -x1 - x2 - x3 <= -140
% -x1 - x2 - x3 - x4 <= -340
% -x1 - x2 - x3 - x4 - x5 <= -640
% -x1 -x2 - x3 - x4 - x5 - x6 = -2540
% x1 <= 300
% x1 + x2 <= 540
% x1 + x2 + x3 <= 1140
% x1 + x2 + x3 + x4 <= 1340
% x1 + x2 + x3 + x4 + x5 <= 1640
c = [30;40;35;45;38;50];
A = [-1,0,0,0,0,0;
    -1,-1,0,0,0,0;
    -1,-1,-1,0,0,0;
    -1,-1,-1,-1,0,0;
    -1,-1,-1,-1,-1,0;
    1,0,0,0,0,0;
    1,1,0,0,0,0;
    1,1,1,0,0,0;
    1,1,1,1,0,0;
    1,1,1,1,1,0];
b = [700;460;-140;-340;-640;300;540;1140;1340;1640];

A_eq = [-1,-1,-1,-1,-1,-1];
b_eq = [-2540];

lb = [0;0;0;0;0;0];

[x, fval] = linprog(c,A,b,A_eq,b_eq,lb);

fprintf('The total cost of recycling is Rs %f.\n', fval);

fprintf('The amount to be sent for recycling at 10AM is %f litres.\n',x(1));
fprintf('The amount to be sent for recycling at 11AM is %f litres.\n',x(2));
fprintf('The amount to be sent for recycling at 12PM is %f litres.\n',x(3));
fprintf('The amount to be sent for recycling at 1PM is %f litres.\n',x(4));
fprintf('The amount to be sent for recycling at 2PM is %f litres.\n',x(5));
fprintf('The amount to be sent for recycling at 3PM is %f litres.\n',x(6));