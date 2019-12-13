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
% K = Motor velocity constant
% v = voltage (volts), solved using monotonicity

Rho = 1000;
K = 150; 
v = 24; 

%%%--------Function

fun = @(x)-(3.859*(10^-12))*pi*Rho*(K*v)^2*(x(1))^3.5*(x(2))^0.5;

%%%--------Inputs

nonlcon = @cons;
x0 = [2,2,1,1];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1 1 1 1];
ub = [12,9,3,4];

%%%--------Global Search Algorithm

rng default %for reproduciblity

opts = optimoptions(@fmincon,'Algorithm','sqp');

problem = createOptimProblem('fmincon','x0',x0,'objective',fun,'nonlcon',@cons,'lb',lb,'ub',ub);
gs = GlobalSearch;
x = run(gs,problem);

toc

disp(table(x(1),x(2),x(3),x(4), v, 'VariableNames',{'diameter','pitch', 'bladenumber', 'chordlength','voltage' }))
disp(['Global Search: ' num2str(fun(x))])
disp(['Final Thrust, calculated by GlobalSearch: ' num2str(-fun(x))])


%% Non Linear Constraints
% constraint c3 was removed, despite being active as it was less dominating than c1

function [c,ceq] = cons(x)
ceq= [];
c1 = 0.85 - x(2)/x(1) ;
c2 = 0.35 -((x(3)*x(4))/(pi*x(1)));
%c3 = (x(2)/x(1)) - 1.5;
c = [c1 c2];
end