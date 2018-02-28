clc;
clear all;

%%-------------Decision Variables--------------%%
% x12 = Amount supplied from node 1 to 2
% x13 = Amount supplied from node 1 to 3
% x24 = Amount supplied from node 2 to 4
% x32 = Amount supplied from node 3 to 2
% x36 = Amount supplied from node 3 to 6
% x43 = Amount supplied from node 4 to 3
% x46 = Amount supplied from node 4 to 6
% x52 = Amount supplied from node 5 to 2
% x54 = Amount supplied from node 5 to 4
% All decison variables non-negative

%------------Objective function----------%
% Minimize cost Z = x12 + 4x13 + x24 + 3x32 + x36 + x43 + x46 + x52 + 3x54

%------------Constraints-------------%

%------------Supply Constraints------%
% x12 + x13 <= 10
% x52 + x54 <= 15

%-----------Demand Constraints------%
% x13 + x43 - x32 - x36 >= 11
% x24 + x54 - x43 - x46 >= 10
% x36 + x46 >= 4

% x12 + x32 + x52 = x24     Node 2 is just for routing and has no storage.

c = [1;4;1;3;1;1;1;1;3];

intcon = [1:9];

A = [1,1,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,1,1;
    0,-1,0,1,1,-1,0,0,0;
    0,0,-1,0,0,1,1,0,-1;
    0,0,0,0,-1,0,-1,0,0];

b = [10;15;-11;-10;-4];

A_eq = [1,0,-1,1,0,0,0,1,0];

b_eq = [0];

lb = [0,0,0,0,0,0,0,0,0];

[x, fval] = intlinprog(c,intcon,A,b,A_eq,b_eq,lb);
fprintf('The minimum cost is Rs %d\n',fval);

for i = 1:9
    fprintf('Value of variable %d is %d\n',i,x(i));
end    