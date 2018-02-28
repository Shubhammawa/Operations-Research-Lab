clc;
clear all;
%%--------Decision Variables---------%%
% xi = The number of litres of item i produced, i = 1,2,3,4,5;  xi >= 0

%%----Objective function : Maximize profit Z = 5x1 + 7.5x2 + 10x3 + 85x4 +
%%400x5

%%------Constraints-----%%

%%  0.1x1 + 2x2 + 4x3 + 15x4 + 45x5 <= 3.7(5000) + 4.9(2500)   Fat content should be less than or equal to the available fat content
%%  x1 + 0.98x2 + 0.96x3 + 0.85x4 + 0.55x5 <= 7500  Total litres of products should be less than the available milk

c = [-5, -7.5, -10, -85, -400];
A = [0.1, 2, 4, 15, 45; 1, 1, 1, 1, 1];
b = [30750; 7500];
lb = [0; 0; 0; 0; 0];

[x, fval] = linprog(c, A, b, [], [], lb);

fprintf('Total profit is %d \n', -fval);

for i=1:5
    fprintf(' Amount of product % d is : %d litres. \n', i, x(i));
end