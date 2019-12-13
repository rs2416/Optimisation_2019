clc
clear all
tic

%%%--------Variables

% x(1) = diameter (inches)
% x(2) = pitch (inches)
% x(3) = blade number
% x(4) = chord length (inches)

%%%--------Parameters

% Rho = Density of freshwater (kg/m^3)
% K = Motor velocity constant, x(5), inputted for sensitivity analysis/lagrange multipliers
% v = voltage (volts), x(6), inputted for sensitivity analysis/lagrange multipliers, solved using monotonicity

Rho = 1000;
K = 150; 
v = 24; 

%%%--------Function

fun = @(x)-(3.859*(10^-12))*pi*Rho*(x(5)*x(6))^2*(x(1))^3.5*(x(2))^0.5;

%%%--------Inputs

nonlcon = @cons;
x0 = [2,2,1,1,150, 24];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1 1 1 1 150, 24];
ub = [12,9,3,4, 150, 24];


%%--------Interior Point Algorithm

options1 = optimoptions('fmincon','Algorithm', 'interior-point');

[x,fval,exitflag,output,lambda]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,@cons,options1);

toc

disp(['Initial Objective: ' num2str(fun(x0))])
disp(table(x(1),x(2),x(3),x(4), x(6), 'VariableNames',{'diameter','pitch', 'bladenumber', 'chordlength','voltage' }))
disp(['Final Objective Interior-Point: ' num2str(fun(x))])
disp(['Final Thrust, calculated from Interior-Point: ' num2str(-fun(x))])


%% Non Linear Constraints 
% constraint c3 was removed, despite being active as it was less dominating than c1

function [c,ceq] = cons(x)
ceq= [];
c1 = 0.85 - x(2)/x(1) ;
c2 = 0.35 -((x(3)*x(4))/(pi*x(1)));
%c3 = (x(2)/x(1)) - 1.5;
c = [c1 c2];
end