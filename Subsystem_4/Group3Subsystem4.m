clc

%x1-restoring moment
%x2-half width of kayak
%x3-half length of kayak
%x4-tilt angle
%x5-mass of boat
%x6-mass of person
rho = 1000; %water density
g = 9.81; %gravitational acceleration

%fmincon

obj_f = @(x)(((-24*x(1)*x(2)*x(3)*rho)-(32*(x(2))^4*(x(3))^2*x(4)*rho^2*g)+(3*(x(5)+x(6))^2*x(4)*g))/(24*(x(5)+x(6))*g*x(4)*x(2)*x(3)*rho*100));
nonlin = @cons; %calling the nonlinear constraint function  
x0 = [1,0.6,2.9,-1,7.9,53.3]; 
A = [];
b = [];
Aeq = [];
Beq = [];
lb = [-3.14,0.15,0.9,-3.14,7.9,53.3];     
ub = [3.14,0.6,2.9,3.14,20,79];

obj_f(x0)

%SQP

options1 = optimoptions('fmincon','Display','iter','Algorithm','sqp', 'MaxFunEvals',500000000);
[x, fval, exitflag, output, lambda] = fmincon(obj_f,x0,A,b,Aeq,Beq,lb,ub,@cons,options1)
disp(table(x(1),x(2),x(3),x(4),x(5), x(6), 'VariableNames',{'moment','width', 'length', 'angle','massboat', 'massperson' }))
disp(['SQP: ' num2str(obj_f(x))])
disp(['center of gravity: ' num2str(-obj_f(x))])

%global search

problem = createOptimProblem('fmincon','x0',x0,'objective',obj_f,'nonlcon',nonlin,'lb',lb,'ub',ub);
x = run(GlobalSearch,problem)

function [c,ceq] = cons(x)
ceq= [];
c1 = x(1)*x(4) ;
c = [c1];
end

%plot

% b = 0.6; %2
% c = 2.9; %3
% mp = 7.9; %5
% mb = 53.3; %6

% [X,Y] = meshgrid(-3.14:.002:3.14);                                
% Z = (((-24*X.*b*c*rho)-(32*b^4*c^2*Y.*rho^2*g)+(3*(mp+mb)^2*Y.*g))/(24*(mp+mb)*g*Y.*b*c)*rho*100);
% surf(X,Y,Z)