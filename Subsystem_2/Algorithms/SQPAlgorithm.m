%% New Objective Function Optimisation

% Measuring run time
tic

syms x1 x2 x3 

% Coefficient of Drag & Lift Metamodel Equations
Cd = (2.922e-08).*x2.^4 + (-1.076e-05).*x2.^3 + 0.001021.*x2.^2 - 0.005576.*x2 + -0.0004696; 
Cl = (-1.593e-08).*x2.^4 + (1.05e-05).*x2.^3 - 0.001837.*x2.^2 + 0.07757.*x2 + 1.012;

% Inputs
paddlingtime = 180 % 3 mins race time
paddlerstrength = 125 % 125 N is the peak force the paddler can withstand

% Definitions
r = 0.5; % a quarter of average paddle length
travel = @(x) (x(2)-25).*0.01745.*r % space traveled by paddle during stroke
T = 0.5.*(x2./180);
x3 = paddlerstrength./(900.*((x1).^2)); % active constraint substitution 
pi = 180;

% Force Integration
fun(x2) = (500.*((x1.*sind(pi.*x2./180)).^2).*x3.*(Cd+Cl))
funindefinite = int(fun,x2); %indefinite integral
funintegrated = funindefinite(x2) - funindefinite(25)  
funintegratedanonymous = matlabFunction(funintegrated); % convert symbolic function to anonymous function      
                     
% Objective Function
funopti = @(x) -(-1.5.*(paddlingtime./((((x(2)-25).*0.01745.*r)./x(1))+0.2)).^2 + (paddlingtime./((((x(2)-25).*0.01745.*r)./x(1))+0.8)).*funintegratedanonymous(x(2))-(funintegratedanonymous(x(2))-1.5)) % objective function

% Set Bound Conditions
lb = [0.01,26]; % lower bound
ub = [5,180]; % upper bound
x0 = [1,91]; % starting point

% Plot Objective Function
t1 = linspace(0.0001,10,20);
t2 = linspace(26,180,20);
[xx,yy] = meshgrid(t1,t2);
surf(xx,yy,arrayfun(@(x,y)funopti([x,y]),xx,yy))
title('Objective Function')
xlabel('Peak Blade Velocity')
ylabel('Blade Angle of Exit')

% Linear Constraints (none)
A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = [];

% Fmincon Sequential Quadratic Programming (SQP) Algorithm
options = optimoptions('fmincon', 'Display', 'iter' , 'Algorithm','sqp');
[x,fval] = fmincon(funopti,x0,A,b,Aeq,beq,lb,ub,nonlcon, options);

% Stopping run time
toc

% Average Thrust Equation
AverageThrust = (125.*(-cosd(x(2))+cosd(25)))./3.14

% Sensitivity Analysis
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(funopti,x0,A,b,Aeq,beq,lb,ub)

% Display solution
disp(' ')
disp('Optimisation Results:')
disp(' ')
disp(['Elapsed Time = ' num2str(toc) ' seconds'])
disp(['Maximum Velocity = ' num2str(x(1)) ' m/s'])
disp(['Stroke Exit Angle = ' num2str(x(2)) ' degrees'])
disp(['Surface Area = ' num2str(0.139./((x(1)).^2)) ' m^2'])
disp(['Total Propulsive Force Generated = ' num2str(-fval) ' N'])
disp(['Stroke Rate = ' num2str((paddlingtime./((((x(2)-25).*0.01745.*r)./x(1))+0.2))./(paddlingtime./60)) ' strokes/min' ])
disp(['Number of Strokes = ' num2str((paddlingtime./((((x(2)-25).*0.01745.*r)./x(1))+0.2))) ' strokes' ])
disp(['Average Thrust = ' num2str(AverageThrust) ' N' ])


%% Global Search to find Global Minimum

rng default % For reproducibility
gs = GlobalSearch;
problem = createOptimProblem('fmincon','x0',[0.01,91],...
    'objective',funopti,'lb',[0.01,26],'ub',[5,180]);
x = run(gs,problem)