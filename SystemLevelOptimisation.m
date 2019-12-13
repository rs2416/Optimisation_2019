clc
clear all
close all
%% System level optimisation
% Combination of Thrust and Hull Resistance.
% This code is a simplified and reduced version of each relevant subsystem
% as used for the calculation of final velocity of the motor.

%% Motor Subsystem
%Parameters
K = 150;
v = 24;
Rho = 1000;

%Inputs & Function
motorfun = @(x)-(3.859*(10^-12))*pi*Rho*(K*v)^2*(x(1))^3.5*(x(2))^0.5;
%nonlcon = @motorcon;
x0 = [2,7,1,1];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1 1 1 1];
ub = [12,9,3,4];

% Sequential Quadratic Programming Algorithm
options1 = optimoptions('fmincon','Algorithm','sqp', 'MaxFunEvals',500);
[x, fval] = fmincon(motorfun,x0,A,b,Aeq,beq,lb,ub,@motorcon,options1);
motorfun = fval;

%% Paddle subsystem
syms x1 x2 x3 y

% Coefficient of Drag & Lift Metamodel Equations
Cd = (2.922e-08).*x2.^4 + (-1.076e-05).*x2.^3 + 0.001021.*x2.^2 - 0.005576.*x2 + -0.0004696; 
Cl = (-1.593e-08).*x2.^4 + (1.05e-05).*x2.^3 - 0.001837.*x2.^2 + 0.07757.*x2 + 1.012;

% Definitions
r = 0.5; % a quarter of average paddle length
travel = @(x) (x(2)-25).*0.01745.*r; % space traveled by paddle during stroke
T = 0.5.*(x2./180);
paddlerstrength = 125; % 125 N is the peak force the paddler can withstand
x3 = paddlerstrength./(900.*((x1).^2)); % active constraint substitution 
pi = 180;
fun(x2) = (500.*((x1.*sind(pi.*x2./180)).^2).*x3.*(Cd+Cl));
funindefinite = int(fun,x2); %indefinite integral
funintegrated = funindefinite(x2) - funindefinite(25);  
racetime = 180; % 3 mins race time

funintegratedanonymous = matlabFunction(funintegrated); % convert symbolic function to anonymous function                            

% Objective Function
funopti = @(x) -(-1.5.*(racetime./((((x(2)-25).*0.01745.*r)./x(1))+0.2)).^2 + (racetime./((((x(2)-25).*0.01745.*r)./x(1))+0.8)).*funintegratedanonymous(x(2))-(funintegratedanonymous(x(2))-1.5)); % objective function

% Set Bound Conditions
lb = [0.01,26]; % lower bound
ub = [5,180]; % upper bound
x0 = [3,91]; % starting point

% Linear Constraints (none)
A = [];
b = [];
Aeq = [];
beq = [];

% Fmincon Interior Point Algorithm
[x] = fmincon(funopti,x0,A,b,Aeq,beq,lb,ub);

% Average Thrust

AverageThrust = (125.*(-cosd(x(2))+cosd(25)))./3.14;

%% Hull subsystem
% Non-linear solving - fmincon
V = 1.55;   % Initial speed
p = 1000;    % Density

% Weighted sum of objective funtions
w1 = 1;
w2 = 0.001;
hullfun = @(x)(w1*(2*p*(V^2)*pi)*(((x(1)*x(2))^1.6+(x(1)*x(3))^1.6+(x(2)*x(3))^1.6)/3)^(1/16)*(0.075/(log10((x(1)*V)/(1.004*10^(-6)))-2)^2)) + (w2*(18.18*(x(1)^3.1)*(2.51 + exp(-0.998*(x(1)/x(2))) + 0.2716)));

ub = [5,3,3]; % Upper limits for: Length, Width, Depth
lb = [0.1,0.2,0.2]; % Lower Limits for: Length, Width, Depth
A = [0,-1,0;-1,0,0]; % Linear constraints: seating depth (g6), Max length (g7), 
b = [-0.350;-4];
Aeq = []; % No equality constraints
beq = [];
x0 = [1,0.5,0.25]; % Initial numbers for, Length, Width, Depth
%nonlcon = @hullcon; % Non linear constraints

X = fmincon(hullfun,x0,A,b,Aeq,beq,lb,ub,@hullcon);

fprintf('fmincon optimised: Length (L) %0.2d., Width (B) %0.2d., Depth (D) %0.2d.', X(1),X(2),X(3));

%% Convert thrust to velocity

%Init Values
thrust_pad = AverageThrust; % Newtons
thrust_mot = -motorfun; % Newtons
%Resistance will increase to match that with an increased velocity
V = 0.1;
L = X(1);
B = X(2);
D = X(3);

for i = 1:1000
    Rt = 1.5*((2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2));
    V  = V + 0.1;
    if Rt > thrust_pad
        break
    end
end
Pvel = 10*V;
fprintf('\n') % New Line in output
fprintf('Final speed for Paddle = %0.2d m/s',Pvel);

V = 0.1;

for i = 1:1000
    Rt = 1.5*((2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2));
    V  = V + 0.1;
    if Rt > thrust_mot
        break
    end
end
Mvel = 10*V;
fprintf('\n') % New Line in output
fprintf('Final speed for Motor = %0.2d m/s',Mvel);

%% Comparison to benchmark values
% Paddling velocity of benchmark boat.
Pvel_ben = 1.54; % m/s
Mvel_ben = 4.20; % m/s

V_pad_pct = ((Pvel - Pvel_ben)/ Pvel_ben)*100;
M_pad_pct = ((Mvel - Mvel_ben)/ Mvel_ben)*100;

fprintf('\n') % New Line in output
fprintf('Increase in speed from paddle = %0.2d %', V_pad_pct);

fprintf('\n') % New Line in output
fprintf('Increase in speed from motor = %0.2d %', M_pad_pct);

%% Functions
% Non Linear Constraints Motor constraints
function [c,ceq] = motorcon(x)
ceq= [];
c1 = 0.85 - x(2)/x(1) ;
c2 = 0.35 -((x(3)*x(4))/(pi*x(1)));
c = [c1 c2];
end

% Non linear constraint
function [c,ceq] = hullcon(x)
c(1) = 0.350 - (2/3)*pi*x(1)*x(2)*x(3); % Volume constraint - used to maintain enough boyancy
c(2) = (0.3151/23) - (x(2))^2 - (x(3))^2; % x-axis inertia
ceq = [];
end