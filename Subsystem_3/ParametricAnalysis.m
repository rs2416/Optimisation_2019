clc
clear all
close all
tic

%%%--------Variables

% d = diameter (inches)
% p = pitch (inches)
% v = voltage (volts)

%---Average, upper & lower bounds for variables

d = 6.5;
v = 18;
p = 6;

d_lower = 1;
d_upper = 12;
v_lower = 12;
v_upper = 24;
p_lower = 1;
p_upper = 10; 

%%%--------Parameters

% Rho = Density of freshwater (kg/m^3)
% k = Motor velocity constant
% v = voltage (volts), solved using monotonicity

k = 150;
Rho = 1000;

%---upper & lower bounds  for calculated/assumed parameter

k_lower = 100;
k_upper = 200;

%% Parametric analysis of variables in objective function

figure

subplot(1,3,1, 'align')

%Diameter plot

d_values = linspace(d_lower,d_upper, 100);
T = -(3.859*(10^-12))*pi*Rho.*(k.*v)^2.*(d_values).^3.5.*(p).^0.5;
plot(d_values,T)
xlim([d_lower d_upper])
title('Effect of Diameter on Thrust Force')
xlabel('Diameter(inches)')
ylabel('Thrust (N)')
set(gca,'Color','w')

subplot(1,3,2, 'align')

%Voltage plot

v_values = linspace(v_lower,v_upper, 100);
T2 = -(3.859*(10^-12))*pi*Rho.*(k.*v_values).^2*(d).^3.5.*(p).^0.5;
plot(v_values, T2)
xlim([v_lower v_upper])
title('Effect of Voltage on Thrust Force')
xlabel('Voltage(V)')
ylabel('Thrust (N)')
set(gca,'Color','w')

subplot(1,3,3, 'align')

%Pitch plot

p_values = linspace(p_lower,p_upper, 100);
T3 = -(3.859*(10^-12))*pi*Rho.*(k.*v).^2*(d).^3.5.*(p_values).^0.5;
plot(p_values,T3)
xlim([p_lower p_upper])
title('Effect of Pitch on Thrust Force')
xlabel('Pitch(inches)')
ylabel('Thrust (N)')
set(gca,'Color','w')



%% Sub plot for comparing Kv and Pitch 


figure 

subplot(1,2,1, 'align')

%Pitch plot

p_values = linspace(p_lower,p_upper, 100);
T3 = -(3.859*(10^-12))*pi*Rho.*(k.*v).^2*(d).^3.5.*(p_values).^0.5;
plot(p_values,T3)
xlim([p_lower p_upper])
ylim([-276 -60])
title('Effect of Pitch on Thrust Force')
xlabel('Pitch(inches)')
ylabel('Thrust (N)')
set(gca,'Color','w')

subplot(1,2,2, 'align')

%kv plot

k_values = linspace(k_lower,k_upper, 100);
T4 = -(3.859*(10^-12))*pi*Rho.*(k_values.*v).^2*(d).^3.5.*(p).^0.5;
plot(k_values,T4, 'r')
xlim([k_lower k_upper])
ylim([-276 -60])
title('Effect of Kv on Thrust Force')
xlabel('kv, Motor Constant')
ylabel('Thrust (N)')
set(gca,'Color','w')

