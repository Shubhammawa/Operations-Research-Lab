clc;
clear all;
%---------------Decision variables-----------%
% xa,xb,xc,xd,xe,xf = 1 if item a is selected
%                     0 if not selected

%----------Objective funtion-------------%
% Maximize Z = max(Z1,Z2)
% Z1 = 60xa + 70xb + 40xc + 70xd + 16xe + 100xf
% Z2 = 60xa + 70xb + 40xc + 70xd + 16xe + 100xf - 15(6xa + 7xb + 4xc + 9xd + 3xe + 8xf - 20)
% => Z2 = -30xa -35xb - 20xc -65xd - 29xe - 20xf + 300

%----------Constaints---------------%
% 6xa + 7xb + 4xc + 9xd + 3xe + 8xf <= 20       - For Z1
% -(6xa + 7xb + 4xc + 9xd + 3xe + 8xf) <= -20   - For Z2

c1 = [-60,-70,-40,-70,-16,-100];
c2 = [30,35,20,65,29,20];

intcon = [1:6];

A1 = [6,7,4,9,3,8];
b1 = [20];

A2 = [-6,-7,-4,-9,-3,-8];
b2 = [-20];

lb = [0,0,0,0,0,0];
ub = [1,1,1,1,1,1];

[x1, fval_1] = intlinprog(c1,intcon,A1,b1,[],[],lb,ub);
[x2, fval_2] = intlinprog(c2,intcon,A2,b2,[],[],lb,ub);
fval = max(-fval_1, -fval_2 + 300);
fprintf('The maximum value possible is $ %d\n',fval);
fprintf('Selected items:\n')
if fval == -fval_1
    for i = 1:6
        if x1(i)>0
            fprintf('Item %d\n',i);
        end
    end
elseif fval == -fval_2 + 300
    for i = 1:6
        if x2(i)>0
            fprintf('Item %d\n',i);
        end
    end
end    