function [ fval,x,D,flag ] = BigM( c,A,b )
%% Max c'x , s.t. Ax = b
m1 =length(b);
n1 =length(c);
M = 10*max(abs(c));
A = [A,eye(m1)];

for i =1:m1
    c(n1+i)=-M;
end
flag = 0;
%% ----- Intial Basic Feasible Solution --------------
[m,n] = size (A);
% -------- Set Indices of Initial basic variable B default to last m columns of  A
IB = n-m+1:n;
% ------  initialize  x vector 
x = zeros (n,1);
%-------- find first basic solution solution
B = A(:,IB); % Intial Basic variables 
x(IB) = B\b; % Intial basic solution of x (Same as inv(B)*b
D = zeros(n,1);
%-------- calculate the function value 
fval = c'*x ;
%% ========== condition check for optimality and next iteration
% ----- ---cost reduction calculation with current basic --------
cbar = c' - c(IB)'/B*A
% find the entering varble
[cbarval, ex] = max(cbar);
% ex -----  entering basic variable ----- 
if  (cbarval <=0)
    disp('Optimality rached')
    x(n1+1:n1+m1)=[];
    D(n1+1:n1+m1)=[];   
    return;
end
%% ------ If optimality condition has not reached then subsequent steps
iter = 0;
while (cbarval >0)
    iter = iter+1;
%     disp('-------------------------------------------------------------');
%     disp('Iteration:');
%     disp(iter);
%     disp('entering varible: x');
%     disp(ex);
    % calculate the direction 'D' 
    % intialize the direction first
    D = zeros(n,1);
    % set the direction of basic variables
    D(IB) = -B\A(:,ex);% same as - inv(B)*A
    % set the direction of entering variable
    D(ex) =1;
%     disp('DIrection:');
%     disp(D);
% ---------- finding leaving variable ------------------------------
    theta = -x(IB)./D(IB);
 % ---  Discarding theta with negative value ----------------
    for i =1:m
            if theta(i) <= 0
                theta (i) = inf;
            end
    end
    % --- Taking minimum theta to abide non- negativity constrained of x
    % --- lx is the leaving basic variables -----
    [theta,lx] = min(theta);
    if (theta == inf)
        disp('solution is unbounded')
        flag =1;
         D(ex)=1;
         x(n1+1:n1+m1)=[];
         D(n1+1:n1+m1)=[];
         return
    end
%     disp('leaving variable is: x')
%     disp(IB(lx));
    %---- update basic variable indices i.e. repace lx with ex
    IB(lx) = ex;
    %----  Update X--------------
    x = x+ theta*D;
    % ----- Update Basic Matrix ------
    B= A(:,IB);
    % --- Calculate function value ---------- 
   fval = c'*x;
   cbar = c' - c(IB)'/B*A;
% find the entering varble
   [cbarval,ex] = max(cbar);
end
% x
% D
% n1
% m1
   x(n1+1:n1+m1)=[];
   D(n1+1:n1+m1)=[];
end

