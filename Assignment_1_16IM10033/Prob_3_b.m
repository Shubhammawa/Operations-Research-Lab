clc; 
clear all;
%%-------Decision variables---------%%
%  A,B,C,D,E,F,G --> Salaries of person A,B,C... respectively. A,B,C... >=0
%% Objective function: Minimize Z = M

%%------Constraints------%%
% A >= 20000
% B >= A + 5000 => -A + B >= 5000
% C >= A + 5000 => -A + C >= 5000
% D >= A + 5000 => -A + D >= 5000
% E >= A + B    => -A -B + E >= 0
% F = E + 200   => -E + F = 200
% C + D >= 2(A + B) => -2A -2B + C + D >= 0
% G >= B        => -B + G >= 0
% G >= D        => -D + G >= 0
% G + B >= 60000
% F <= G + A    => A -F + G >= 0
% A,B,C,D,E,F,G <= M      M is the maximum salary of any of the person.
% => A - M <= 0
% B - M <= 0 .... 7 Additional constraints
c = [0,0,0,0,0,0,0,1];

A = [-1,0,0,0,0,0,0,0;     %% We put the coefficient of M to be 0 in the equations so that it does not affect the other constraints.
    1,-1,0,0,0,0,0,0;
    1,0,-1,0,0,0,0,0;
    1,0,0,-1,0,0,0,0;
    1,1,0,0,-1,0,0,0;
    2,2,-1,-1,0,0,0,0;
    0,1,0,0,0,0,-1,0;
    0,0,0,1,0,0,-1,0;
    0,-1,0,0,0,0,-1,0;
    -1,0,0,0,0,1,-1,0;
    1,0,0,0,0,0,0,-1;       %% The additional constraints
    0,1,0,0,0,0,0,-1;       %% --------------------------
    0,0,1,0,0,0,0,-1;       %% --------------------------
    0,0,0,1,0,0,0,-1;       %% --------------------------
    0,0,0,0,1,0,0,-1;       %% --------------------------
    0,0,0,0,0,1,0,-1;       %% --------------------------
    0,0,0,0,0,0,1,-1];      %% --------------------------

b = [-20000;-5000;-5000;-5000;0;0;0;0;-60000;0;0;0;0;0;0;0;0];

A_eq = [0,0,0,0,-1,1,0,0];
b_eq = [200];

lb = [0;0;0;0;0;0;0;0];

[x, fval] = linprog(c,A,b,A_eq,b_eq,lb);

fprintf('The total salary to be paid is Rs %f. \n', sum(x)-x(8));  % Subtracting the value of M from the total salary as sum(x) gives the sum A+B+C+D+E+F+G+M

for i=1:7
    fprintf('The salary of person %d is Rs %f.\n',i,x(i));
end    