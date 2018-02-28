clc;
clear all;

%---------Decision variables------------%
% xij = 2 if 2 pieces of product i are selected in vehicle j
%       1 if 1 piece of product i is selected in vehicle j
%       0 if it is not selected
% i = 1,2...7;  j = 1,2,3

%-------Objective Function----------%
% Maximize Z = x11 + x21 + x31 + ..... + x73

%-----------Constraints--------------%

% Each vehicle volume constraints
% .55x11 + .6x21 + .7x31 + .75x41 + .85x51 + .9x61 + .95x71 <= 3.6
% .55x12 + .6x22 + .....                         ..+ .95x72 <= 3.6
% .55x13 + .6x23 + .....                         ..+ .95x73 <= 3.6

% Constraint on number of items of each type
% x11 + x12 + x13 <= 2
% x21 + x22 + x23 <= 2
% ...
% ...
% x71 + x72 + x73 <= 2

c = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];

intcon = [1:21];

A = [.55, .6, .7, .75, .85, .9, .95,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,.55, .6, .7, .75, .85, .9, .95,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,.55, .6, .7, .75, .85, .9, .95;
    1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0;
    0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0;
    0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0;
    0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0;
    0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1];

b = [3.6; 3.6; 3.6; 2; 2; 2; 2; 2; 2; 2];

lb = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

ub = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);

fprintf('Vehicle 1\n');
for i = 1:7
    if x(i) > 0
        fprintf('Product %d is selected %d times.\n',i,x(i));
    end
end
fprintf('\n');
fprintf('Vehicle 2\n');
for i = 8:14
    if x(i) > 0
        fprintf('Product %d is selected %d times.\n',i-7,x(i));
    end
end
fprintf('\n');
fprintf('Vehicle 3\n');
for i = 15:21
    if x(i) > 0
        fprintf('Product %d is selected %d times.\n',i-14,x(i));
    end
end