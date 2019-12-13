# Subsystem 3: Optimising a Trolling Motor


**Author:** Ruksana Shaukat Jali

**Overview:** A trolling motor is made up of two main components, a propeller and a motor. The power developed by a trolling motor is available at the propeller shaft in the form of torque. This torque is then converted into thrust, a reactional force caused by a pressure differential that pushes the boat. The objective for this subsystem was to maximise this thrust force. The thrust created by a trolling motor, is affected by variables relating to the motor and propeller design.

#### Overview of the MATLAB files:

- **MATLAB'S fmincon algorithms**
  - *fminconInteriorPoint.m* -
  Run to find minimum values for variables as well as the lagrange multipliers at solution (multipliers can be found in *'Lambda'* matrix) . Using MATLAB's Interior Point algorithm.
  - *fminconSQP.m* -
  Run to find minimum values for variables as well as the lagrange multipliers at solution (multipliers can be found in *'Lambda'* matrix). Using MATLAB's Sequential Quadratic algorithm.
- **Global Search Algorithm**
  - *Globalsearch.m* -
  Run to identify global minimum values using MATLAB's Global Search algorithm.
- **Parametric Plots**
  - *ParametricAnalysis.m* -
  Run to generate the parametric plots of variables and parameter Kv. 

#### Dependencies

- **Optimisation Toolbox** (Download here https://uk.mathworks.com/products/optimization.html)
- **Global Optimisation Toolbox** (Download here https://uk.mathworks.com/products/global-optimization.html)
