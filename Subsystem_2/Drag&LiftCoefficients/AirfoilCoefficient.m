%% This function creates the fit to the data in x (Alpha Exit Angle) and y (Drag or Lift Coefficient)

% Read the table of Drag and Lift Coefficients per Angle of Attack

alpha = xlsread('Coefficient.xlsx', 'A2:A102');
LiftCoefficient = xlsread('Coefficient.xlsx', 'B2:B102');
DragCoefficient = xlsread('Coefficient.xlsx', 'C2:C102');

%  Create Lift Coefficient Metamodel with different degrees of Polynomial Surfaces 

[LiftMetamodel2,gof] = fit(alpha,LiftCoefficient,'poly2');
[LiftMetamodel3,gof] = fit(alpha,LiftCoefficient,'poly3');
[LiftMetamodel4,gof] = fit(alpha,LiftCoefficient,'poly4');

%  Create Drag Coefficient Metamodel with different degrees of Polynomial Surfaces 

[DragMetamodel2,gof] = fit(alpha,DragCoefficient,'poly2');
[DragMetamodel3,gof] = fit(alpha,DragCoefficient,'poly3');
[DragMetamodel4,gof] = fit(alpha,DragCoefficient,'poly4');

% Plot the Lift and Drag Coefficient Metamodels with respect to Alpha

hold on
plot(LiftMetamodel4,alpha,LiftCoefficient);
plot(DragMetamodel4,alpha,DragCoefficient);
hold off
legend('Lift Coefficient','Metamodel Lift','Drag Coefficient','Metamodel Drag','Location','NorthWest');

% Write Down Metamodel Functions and Goodness of Fit

LiftMetamodel4
DragMetamodel4