clc;
clear all;
%---------------Decision variables-----------%
% xa,xb,xc,xd,xe,xf = 1 if item a is selected
%                     0 if not selected

%----------Objective funtion-------------%
% Maximize Z = 60xa + 70xb + 40xc + 70xd + 16xe + 100xf

%----------Constaints---------------%
% 6xa + 7xb + 4xc + 9xd + 3xe + 8xf <= 20
% xd <= xa -> xd - xa <= 0

c = [-60,-70,-40,-70,-16,-100];

intcon = [1:6];

A = [6,7,4,9,3,8;
    -1,0,0,1,0,0];
b = [20;0];

lb = [0,0,0,0,0,0];
ub = [1,1,1,1,1,1];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);
fprintf('The maximum value possible is $ %d\n',-fval);
fprintf('Selected items:\n')
for i = 1:6
    if x(i)>0
        fprintf('Item %d\n',i);
    end
end    