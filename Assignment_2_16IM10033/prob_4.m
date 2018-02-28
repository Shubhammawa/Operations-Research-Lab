clc;
clear all;

%---------Decision variables-----------%
% xi = 1 if ith lifeguard selected
%      0 if not selected
% i = a,b,...,g

%----------Objective function-----------%
% Minimize cost Z = 300xa + 180xb + 210xc + 380xd + 200xe + 220xf + 900xg

%----------Constraints------------------%
% xa + xb >= 1                  Atleast one is there between 1-2PM and 2-3
% xa >= 1                       3-4
% xa + xc + xd >= 1             4-5
% xc + xd + xf >= 1             5-6
% xc + xd + xe + xf >= 1        6-7
% xd + xe + xf >= 1             7-8
% xd + xe + xg >= 1             8-9

c = [300,180,210,380,200,220,900];

intcon = [1:7];

A = [-1,-1,0,0,0,0,0;
    -1,0,0,0,0,0,0;
    -1,0,-1,-1,0,0,0;
    0,0,-1,-1,0,-1,0;
    0,0,-1,-1,-1,-1,0;
    0,0,0,-1,-1,-1,0;
    0,0,0,-1,-1,0,-1];
b = [-1;-1;-1;-1;-1;-1;-1];

lb = [0;0;0;0;0;0;0];
ub = [1;1;1;1;1;1;1];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);
fprintf('The least cost is Rs %d\n',fval);
fprintf('Selected lifguards:\n');
for i = 1:7
    if x(i)==1
        fprintf('%d\n',i);
    end
end    