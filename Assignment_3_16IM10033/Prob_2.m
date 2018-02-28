clc;
clear all;

%-----------Decision variables----------%
% xi = Number of units of product i; i = a,b,c; xi >= 0

%-------------Objective function---------%
% Maximize Expected profit Z = 1/3(-5xa + xb + xc - 7xa + 6xb + 10xc + 13xa -2xb + 6xc)
% = 1/3(xa + 5xb + 17xc)

%------------Constraints---------------%
% xa + xb + xc <= 2400

c = [-1,-5,-17];

intcon = [1:3];

A = [1,1,1];
b = [2400];

lb =[0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);
fprintf('The maximum expected value of profit is %d\n',-fval/3);

for i = 1:3
    fprintf('Number of units of type %d = %d\n',i,x(i));
end    
