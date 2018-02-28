clc;
clear all;

%-------Decision variables---------%
% xi = 0     if item is not picked
%      1     if item is picked
% i = 1,2,3,4,5,6,7

%--------Objective function-----------%
% Maximise value Z = 250x1 + 300x2 + 500x3 + 700x4 + 750x5 + 900x6 + 950x7

%----------Constraints----------%
% 0.55x1 + .6x2 + .7x3 + .75x4 + .85x5 + .9x6 + .95x7 <= 3.6

c = [-250; -300; -500; -700; -750; -900; -950];

intcon = [1:7];

A = [.55, .6, .7, .75, .85, .9, .95];

b = [3.6];

lb = [0;0;0;0;0;0;0];
ub = [1;1;1;1;1;1;1];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);

fprintf('The maximum value is %d\n',-fval);

for i = 1:7
    if (x(i)==1)
        fprintf('Item %d selected\n',i);
    
    
    elseif (x(i)==0)
            fprintf('Item %d not selected\n',i);
    end
   
  
end