close all
clear all
%% Formulae
% Equations used throughout code

%Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
%R_rot = (18.18*(x(1)^3.1)*(2.51 + exp(-0.998*(x(1)/x(2))) + 0.2716))
%Cd = 2.51 + exp(-0.998(L/D)) + 0.2716;
%Rrot = 181.18*(L^3.1)*Cd;

%% Initialisation
%Benchmark values for an average kayak
L_ben = 3.08; % Length
B_ben = 0.750; % Width
D_ben = 0.350; % Depth
p = 1000; % Density of water
w_sqr = (pi^2)/64; % Rotational velocity
V_ben = 1.55; % Velocity of boat in water

% Ratio of length to depth used as a constraint
ratio_ben = L_ben/D_ben; % benchmark boat ratio for comparison
% ratio = L/D;

% Used curve fitting tool to create relationship
% lam = 2.51*exp(-0.10008*ratio) + 0.2716
% goodness of fit: adjusted R-square = 0.9906

lam_ben = 2.51*exp(-0.10008*ratio_ben) + 0.2716;
% lam = 2.51*exp(-0.10008*ratio) + 0.2716;

%% Drag on boat rotating around z-axis in water

fd_rot_ben = 117.9*((L_ben^3.1)*lam_ben*(w_sqr));
% fd_rot = 117.9*((L^3.1)*lam*(w_sqr))

fprintf('\n') % New Line in output
fprintf('Rotational resistance of benchmark hull = %0.2d. N',fd_rot_ben);

%% Plotting Length against total resistance
% Initialise Values - Reset
D = D_ben;
L = 0.854; % initial length of boat
B = B_ben;
V = 1.55;

% Initialise lists - Reset
Rt_list = [];
L_list = [];
V_list = [];

% Iteratively increased - Length
for i = 1:1000
    L = L + 0.1;
    Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
    Rt_list = [Rt_list,Rt];
    L_list = [L_list,L];
    ratio = L/D;
    lam = 2.51*exp(-0.10008*ratio) + 0.2716; % laminar coefficient of friction at ratio of length to depth
    fd_rot = 117.9*((L^3.1)*lam*(w_sqr)); % rotational drag around z-axis
    if fd_rot > fd_rot_ben % when rotational drag is higher than the benchmark
        fin_L = L;
        fin_Rt = Rt;
        break
    end
end

figure();
plot(L_list,Rt_list)
xlabel('Length (m)')
ylabel('Resistance')
title('Plot of Length of hull against total resistance')

%% Plotting length vs width vs resistance
Rt_matrix = zeros(10,10);
B = 0;

for j = 1:10
    B = B + 1;
    L = 0;
    for i = 1:10 % lengths at depth
        L = L + 1;
        Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
        Rt_matrix(i,j)= Rt;
        ratio = L/D;
        lam = 2.51*exp(-0.10008*ratio) + 0.2716; % laminar coefficient of friction at ratio of length to depth
        fd_rot = 117.9*((L^3.1)*lam*(w_sqr)); % rotational drag around z-axis
%         if fd_rot > fd_rot_ben % when rotational drag is higher than the benchmark
%            fin_L = L;
%            fin_Rt = Rt;
%            break
%         end
    
    end
end
figure();
surf(Rt_matrix,Rt_matrix)
xlabel("Width (M)")
ylabel("Length (M)")
zlabel("Resistance(N)")

%% Plotting Length against rotational resitance

% Initialise Values - Reset
D = D_ben;
L = 0.854; % initial length of boat
B = B_ben;
p = 1000;
V = 1.55;

% Initialise lists - Reset
R_rot_list = [];
L_list = [];

% Iteratively increased - Length
for i = 1:1000
    L = L + 0.01;
    R_rot = (18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716));
    R_rot_list = [R_rot_list,R_rot];
    L_list = [L_list,L];
end

figure();
plot(L_list,R_rot_list)
xlabel('Length (m)')
ylabel('Resistance')
title('Plot of Length of hull against rotational resistance')

%% Weighted resistance sum
% Multi-objective function

% Initialise Values - Reset
D = D_ben;
L = 10; % initial length of boat
B = B_ben;
p = 1000;

% Initialise lists - Reset
R_sum_list = [];
L_list = [];

% Weighted sum calculation
%   A calculation is made at 10m for both linear and rotational resistances
Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
R_rot = (18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716));

% --------Normalisation-------------
%Initial limiting values
L_max = 5;
B_max  = 3;
D_max = 3;
L_min = 0.1;
B_min = 0.2;
D_min = 0.2;

Rt_max = (2*p*(V_ben^2)*pi)*(((L_min*B_max)^1.6+(L_min*D_max)^1.6+(B_max*D_max)^1.6)/3)^(1/16)*(0.075/(log10((L_min*V_ben)/(1.004*10^(-6)))-2)^2);
Rt_min = (2*p*(V_ben^2)*pi)*(((L_max*B_min)^1.6+(L_max*D_min)^1.6+(B_min*D_min)^1.6)/3)^(1/16)*(0.075/(log10((L_max*V_ben)/(1.004*10^(-6)))-2)^2);
%Rt_norm = ((Rt - Rt_min)/(Rt_max - Rt_min));

R_rot_max = (18.18*(L_max^3.1)*(2.51 + exp(-0.998*(L_max/B_max)) + 0.2716));
R_rot_min = (18.18*(L_min^3.1)*(2.51 + exp(-0.998*(L_min/B_min)) + 0.2716));
%R_rot_norm = ((R_rot - R_rot_min)/(R_rot_max - R_rot_min));


% --------Weighting---------------
w1 = 20;
%w2 = Rt/R_rot;
w2 = 0.001;

%R_sum = (w1*Rt_norm) + (w2*R_rot_norm);

%---------Plotting---------------
% Variables are reset again
L = 0.854;
B = 0;
V = 1.55;

% Iteratively increased - Width
for j = 1:100
    B = B + 0.1;
    L = 0;
    
    % Iteratively increased - Length
    for i = 1:1000
        L = L + 0.01;
        %Normalised Weighted Sum calculation
        Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
        R_rot = (18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716));
        Rt_norm = ((Rt - Rt_min)/(Rt_max - Rt_min));
        R_rot_norm = ((R_rot - R_rot_min)/(R_rot_max - R_rot_min));
        R_sum = (w1*Rt_norm) + (w2*R_rot_norm);
        %R_sum = (w1*(2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2)) + (w2*(18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716)));
        R_sum_matrix(i,j)= R_sum;
        if j == 7
            R_sum_list = [R_sum_list,R_sum];
            L_list = [L_list,L];
        end
        if L > 5
            break
        end
    end
end
figure()
surf(R_sum_matrix,R_sum_matrix)
xlabel("Width (mm)")
ylabel("Length (mm)")
zlabel("Weighted Sum Resistance(N)")
figure();
   
% Iteratively increased - Length
L = 0;
R_sum = 0;
R_sum_list = [];
L_list = [];

w2 = 0.001;

for i = 1:1000
    L = L + 0.01;
    Rt = (2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2);
    R_rot = (18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716));
    Rt_norm = ((Rt - Rt_min)/(Rt_max - Rt_min));
    R_rot_norm = ((R_rot - R_rot_min)/(R_rot_max - R_rot_min));
    R_sum = (w1*Rt_norm) + (w2*R_rot_norm);
    %R_sum = (w1*(2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2)) + (w2*(18.18*(L^3.1)*(2.51 + exp(-0.998*(L/B)) + 0.2716)));
    R_sum_list = [R_sum_list,R_sum];
    L_list = [L_list,L];
    if L > 10
        break
    end
end
plot(L_list,R_sum_list)
xlabel('Length (m)')
ylabel('Normalised Weighted Resistance')
title('Plot of Length of hull against weighted resistance')

% ----------------------------------------------------------------------------------------

%% Non-linear solving - fmincon
%https://uk.mathworks.com/matlabcentral/answers/144705-how-to-create-constraints-in-fmincon
% x(1) = L
% x(2) = B
% x(3) = D

V = 1.55;   % Initial speed
p = 1000;    % Density
D = D_ben;  % Initial depth
B = B_ben;  % Initial width

% Weighted sum of objective funtions
w1 = 1;
w2 = 0.001;
fun = @(x)(w1*(2*p*(V^2)*pi)*(((x(1)*x(2))^1.6+(x(1)*x(3))^1.6+(x(2)*x(3))^1.6)/3)^(1/16)*(0.075/(log10((x(1)*V)/(1.004*10^(-6)))-2)^2)) + (w2*(18.18*(x(1)^3.1)*(2.51 + exp(-0.998*(x(1)/x(2))) + 0.2716)));

% Weighted NORMALISED sum of objective functions
%fun = @(x)(w1*(((2*p*(V^2)*pi)*(((x(1)*x(2))^1.6+(x(1)*x(3))^1.6+(x(2)*x(3))^1.6)/3)^(1/16)*(0.075/(log10((x(1)*V)/(1.004*10^(-6)))-2)^2))-Rt_min)/(Rt_max - Rt_min)) + (w2*(((18.18*(x(1)^3.1)*(2.51 + exp(-0.998*(x(1)/x(2))) + 0.2716)) - R_rot_min)/(R_rot_max - R_rot_min)));

ub = [L_max,B_max,D_max]; % Upper limits for: Length, Width, Depth
lb = [L_min,B_min,D_min]; % Lower Limits for: Length, Width, Depth
A = [0,-1,0;-1,0,0]; % Linear constraints: seating depth (g6), Max length (g7), 
b = [-0.350;-4];
Aeq = []; % No equality constraints
beq = [];
x0 = [1,0.5,0.25]; % Initial numbers for, Length, Width, Depth
nonlcon = @hullcon; % Non linear constraints

X = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);

fprintf('fmincon optimised: Length (L) %0.2u., Width (B) %0.2u., Depth (D) %0.2u.', X(1),X(2),X(3));

%-----------------------------------------------------------------------------------------
%% Optimised Hull resistance comparison
% Comparing optimised hull Vs Benchmark Hull
% At 3 knots (1.55 m/s)

% Benchmarch hull resistance
Rt_ben = (2*p*(V_ben^2)*pi)*(((L_ben*B_ben)^1.6+(L_ben*D_ben)^1.6+(B_ben*D_ben)^1.6)/3)^(1/16)*(0.075/(log10((L_ben*V_ben)/(1.004*10^(-6)))-2)^2);
%Optimised hull resistance
Rt_opt = (2*p*(V_ben^2)*pi)*(((X(1)*X(2))^1.6+(X(1)*X(3))^1.6+(X(2)*X(3))^1.6)/3)^(1/16)*(0.075/(log10((X(1)*V_ben)/(1.004*10^(-6)))-2)^2);
% Percentage improvement over benchmark
Rt_pct = ((Rt_ben - Rt_opt)/ Rt_ben)*100;
fprintf('\n') % New Line in output
fprintf('Percentage perfomance increase = %0.2d. N',Rt_pct);

% Benchmarch hull resistance
R_rot_ben = (18.18*(L_ben^3.1)*(2.51 + exp(-0.998*(L_ben/B_ben)) + 0.2716));
%Optimised hull resistance
R_rot_opt = (18.18*(X(1)^3.1)*(2.51 + exp(-0.998*(X(1)/X(2))) + 0.2716));
% Percentage improvement over benchmark
Rt_pct = ((R_rot_ben - R_rot_opt)/ R_rot_ben)*100;
fprintf('\n') % New Line in output
fprintf('Percentage Rotational perfomance increase = %0.2d. N',Rt_pct);

% ---------------------------------------------
%% Convert thrust to velocity

Rt_list = [];
L_list = [];
V_list = [];

%Init Values
thrust_pad = 250; % Newtons
thrust_mot = 1820; % Newtons
%Resistance will increase to match that with an increased velocity
V = 0.1;
L = X(1);

for i = 1:1000
    Rt = 1.5*((2*p*(V^2)*pi)*(((L*B)^1.6+(L*D)^1.6+(B*D)^1.6)/3)^(1/16)*(0.075/(log10((L*V)/(1.004*10^(-6)))-2)^2));
    V  = V + 0.1;
    if Rt > thrust_mot
    %if Rt > thrust_pad
        break
    end
end


fprintf('\n') % New Line in output
dispRt = sprintf('Total resistance = %0.2u N',Rt);
dispL = sprintf('Final Length = %0.2d m',L);
dispV = sprintf('Final speed = %0.2d m/s',V);

disp(dispRt)
disp(dispV)
disp(dispL)

%% Functions
% Non linear constraint
function [c,ceq] = hullcon(x)
c(1) = 0.350 - (2/3)*pi*x(1)*x(2)*x(3); % Volume constraint - used to maintain enough boyancy
c(2) = (0.3151/23) - (x(2))^2 - (x(3))^2; % x-axis inertia
ceq = [];
end
