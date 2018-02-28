clc;
clear all;
%--------------Decision variables---------%
% xij - Number of units of type i in segment j
% i = A,B,C,D,E;    j = F(Front),M(Middle),B,(Back)
% xij >= 0

%-----------Objective function------------%
% Maximize value Z = 50000(xAF + xAM + xAB) + 60000(xBF + xBM + xBB) +
% 90000(xCF + xCM + xCB) + 40000(xDF + xDM + xDB) + 30000(xEF + xEM + xEB)

%-----------Constraints-----------------%
% Volume constraints
% 25xAF + 15xBF + 13xCF + 20xDF + 16xEF <= 200
% 25xAM + 15xBM + 13xCM + 20xDM + 16xEM <= 500
% 25xAB + 15xBB + 13xCB + 20xDB + 16xEB <= 300

% Weight constraints
% 500xAF + 1500xBF + 2100xCF + 600xDF + 400xEF <= 8000
% 500xAM + 1500xBM + 2100xCM + 600xDM + 400xEM <= 20000
% 500xAB + 1500xBB + 2100xCB + 600xDB + 400xEB <= 6000

% Balance constraints
% 500xAM + 1500xBM + 2100xCM + 600xDM + 400xEM >= 500xAF + 1500xBF +
% 2100xCF + 600xDF + 400xEF + 500xAB + 1500xBB + 2100xCB + 600xDB + 400xEB
 
% 500xAM + 1500xBM + 2100xCM + 600xDM + 400xEM <= 2(500xAF + 1500xBF +
% 2100xCF + 600xDF + 400xEF + 500xAB + 1500xBB + 2100xCB + 600xDB + 400xEB)

% Constraints on total no items available
% xAF + xAM + xAB <= 12
% xBF + xBM + xBB <= 8
% xCF + xCM + xCB <= 22
% xDF + xDM + xDB <= 15
% xEF + xEM + xEB <= 11

c = [-50000,-60000,-90000,-40000,-30000,-50000,-60000,-90000,-40000,-30000,-50000,-60000,-90000,-40000,-30000];
intcon = [1:15];

A = [25,15,13,20,16,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,25,15,13,20,16,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,25,15,13,20,16;
    500,1500,2100,600,400,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,500,1500,2100,600,400,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,500,1500,2100,600,400;
    500,1500,2100,600,400,-500,-1500,-2100,-600,-400,500,1500,2100,600,400;
    -1000,-3000,-4200,-1200,-800,500,1500,2100,600,400,-1000,-3000,-4200,-1200,-800;
    1,0,0,0,0,1,0,0,0,0,1,0,0,0,0;
    0,1,0,0,0,0,1,0,0,0,0,1,0,0,0;
    0,0,1,0,0,0,0,1,0,0,0,0,1,0,0;
    0,0,0,1,0,0,0,0,1,0,0,0,0,1,0;
    0,0,0,0,1,0,0,0,0,1,0,0,0,0,1];
b = [200;500;300;8000;20000;6000;0;0;12;8;22;15;11];

lb = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);
fprintf('The maximum possible value is %d\n',-fval);

fprintf('Items in Front Segment:\n');
for i = 1:5
    fprintf('Type %d: %d\n',i,x(i));
end

fprintf('Items in Middle Segment:\n');
for i = 6:10
    fprintf('Type %d: %d\n',i-5,x(i));
end

fprintf('Items in Back Segment:\n');
for i = 11:15
    fprintf('Type %d: %d\n',i-10,x(i));
end