function [fval,x] =SimplexMatlab(c, A, b )
% % ----------- Simplex Implementation in Matlab ------------
%=====================================
%% ---LP Problem --------
%-------- Max c'x ---------
% ------- S.t. Ax  = b
% ------- x>=0 
% --------- c and b are column Vectors and A is  Matrix-----
%% ----- Intial Basic Feasible Solution --------------
[m,n] = size (A);
% -------- Set Indices of Initial basic variable B default to last m columns of  A
IB = n-m+1:n;
% ------  initialize  x vector 
x = zeros (n,1);
%-------- find first basic solution solution
B = A(:,IB); % Intial Basic variables 
x(IB) = B\b; % Intial basic solution of x 
%-------- calculate the function value 
fval = c'*x ;
%% ========== condition check for optimality and next iteration
% ----- ---cost reduction calculation with current basic --------
cbar = c' - c(IB)'/B*A ;
% find the entering varble
[cbarval, ex] = max(cbar);
% ex -----  entering basic variable ----- 
if  (cbarval <=0)
    disp('Optimality rached')
end
%% ------ If optimality condition has not reached then subsequent steps
iter = 0;
while (cbarval >0)
    iter = iter+1;
    disp('-------------------------------------------------------------');
    disp('Iteration:');
    disp(iter);
    disp('entering varible: x');
    disp(ex);
    % calculate the direction 'D' 
    % intialize the direction first
    D = zeros(n,1);
    % set the direction of basic variables
    D(IB) = -B\A(:,ex);
    % set the direction of entering variable
    D(ex) =1;
    disp('DIrection:');
    disp(D);
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
    disp('leaving variable is: x');
    disp(IB(lx));
    %---- update basic variable indices i.e. repace lx with ex
    IB(lx) = ex;
    %----  Update X--------------
    x = x+ theta*D
    % ----- Update Basic Matrix ------
    B= A(:,IB);
    % --- Calculate function value ---------- 
   fval = c'*x;
   cbar = c' - c(IB)'/B*A
% find the entering varble
   [cbarval,ex] = max(cbar);
   %ex = IB(z1);
%    if (cbar< 0)
%        optim =1;
%    end
%    %disp ('entering variable :x',ex);
    
end





