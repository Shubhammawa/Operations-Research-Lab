clc;
clear all;

%--------------Decison variables--------------------%
% xij = Quantity shipped from plant i to demand point j
% i = 1,2,3;    j = 1,2,3,4;    xij >= 0

%----------------Objective function---------------%
% Minimize cost Z = 300x11 + 200x12 + 700x13 + .... + 500x34

%-----------------Constraints--------------------%
% x11 + x12 + x13 + x14 <= 5000
% x21 + x22 + x23 + x24 <= 6000
% x31 + x32 + x33 + x34 <= 2500

% x11 + x21 + x31 >= 6000
% x12 + x22 + x32 >= 4000
% x13 + x23 + x33 >= 2000
% x14 + x24 + x34 >= 1500

% x11 >= .6(x11 + x12 + x13 + x14)

c = [300;200;700;600;700;500;200;300;200;500;400;500];

intcon = 1:12;

A = [1,1,1,1,0,0,0,0,0,0,0,0;
    0,0,0,0,1,1,1,1,0,0,0,0;
    0,0,0,0,0,0,0,0,1,1,1,1;
    -1,0,0,0,-1,0,0,0,-1,0,0,0;
    0,-1,0,0,0,-1,0,0,0,-1,0,0;
    0,0,-1,0,0,0,-1,0,0,0,-1,0;
    0,0,0,-1,0,0,0,-1,0,0,0,-1;
    -.4,.6,.6,.6,0,0,0,0,0,0,0,0];

b = [5000;6000;2500;-6000;-4000;-2000;-1500;0];

lb = [0;0;0;0;0;0;0;0;0;0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);
fprintf('The minimum cost is %d\n',fval);

for i = 0:2
    for j = 1:4
        fprintf('x%d%d = %d\n',i+1,j,x(4*i + j));
    end
end    

% Since the solution does not change, sending atleast 60% of the production
% of plant 1 to D1 doesn't affect the cost.
