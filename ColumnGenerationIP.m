%################- OR LAB-  ------------#################
function [sheet_number,packing_pattern] = ColumnGenerationIP( B,width,Number,TW,flag)
%This code solves the 1D cutting Stock Problem Using Column Generation
%width = column vector of required width
%Number = column vector of required number of corresponding width
%TW = maximum Width of the roll
%flag is used to come out from the loop 
%B is the initial basic matrix
%------- Initial Solution -------------------%
x = B\Number;% same as inv(B)*Number
%---- Size of basic variables -------%
m1 = size(width);
m = m1(1,1);
%------- Lower and Upperbound for solving MILP ----%
lb = zeros(m,1);
ub = inf(m,1);
%------- cost vector --------------%
cb = ones(m,1);% cb is the basic cost matrix
%------- Argument for calling intlinprog function --------%
f = (cb'/B)'; % f = transpse (transpose(cb)*inv(B))  
A = width';
b = TW;
intcon = 1:m;
options = optimoptions('intlinprog','Display','off');% check intlinprog for this
[a,F]= intlinprog(-f,intcon,A,b,[],[],lb,ub,options);
%---------------------------------------------------------------
%---------------------------------------------------------------
%----- flag=1 when current basic is optimal --------------------
%----- Unboundedness has not been considered ------------------
if flag~=1
    if F>=-1
        flag =1;
    else
        dir = B\a;% same as inv(B)*a
        theta =x./dir; % ./ provides element wise division of vector i.e. x1/d1, x2/d2.....
        for i =1:m;
            if theta(i) <= 0
                theta (i) = inf;
                %else
            end
        end
        [I,J]= min(theta);
%----------- Unboundedness checking --------------------------------        
        if I ~= inf
            B(:,J)= a;
        else
            flag =1; % this is the case of unboundedness--- Improve this code to tackle unboundedness
        end
    end
%------------------ Recursive calling of function till optimal solution----    
    [ x, B] = ColumnGenerationIP(B, width,Number,TW,flag);
%-------------------------------------------------------------------------        
end
sheet_number=x;
packing_pattern =B;
end

