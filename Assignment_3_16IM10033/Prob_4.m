clc;
clear all;

%------------Decision variables------------%
% xij = Number of units produced by plant i in period j
% Iij = Number of inventory units in plant i in period j
% i = 1,2,3;    j = 1,2,3,4,5;  xij >= 0    Iij >= 0


% Production cost = 5(x11 + x12 + x13 + x14 + x15) + 7(x21 + x22 + x23 +
% x24 + x25) + 3(x31 + x32 + x33 + x34 + x35)

% Set up cost : Plant 1 - 1000
%               Plant 2 - 600
%               Plant 3 - 1200

% Inventory cost : 3(I11 + I12 + I13 + I14 + I15) + 2(I21 + I22 + I23 + I24
% + I25)+ 3(I31 + I32 + I33 + I34 + I35)

% Shortage cost = 7(6000 - (x11 + x21 + x31)) + 5(7000 - (x12 + x22 + x32))
% + 4(5000 - (x13 + x23 + x33)) + 9(12000 - (x14 + x24 + x34)) + 7(9000 - (x15 + x25 + x35))

%-------------Consraints------------------%
% I11 + I21 + I31 = x11 + x21 + x31 - 6000
% I12 + I22 + I32 = x12 + x22 + x32 - 7000
% I13 + I23 + I33 = x13 + x23 + x33 - 5000
% I14 + I24 + I34 = x14 + x24 + x34 - 12000
% I15 + I25 + I35 = x15 + x25 + x35 - 9000

% x11 <= 3000
% x12 <= 3000
% x13 <= 3000
% x14 <= 3000
% x15 <= 3000

% x21 <= 2500
% x22 <= 2500
% x23 <= 2500
% x24 <= 2500
% x25 <= 2500

% x31 <= 4000
% x32 <= 4000
% x33 <= 4000
% x34 <= 4000
% x35 <= 4000

%-------------Objective function------------%
% Minimize Z = Production cost + Set-up cost + Inventory cost + Shortage
% cost
% Production > Demand  --> Shortage cost = 0
% Production < Demand  --> Inventory cost = 0