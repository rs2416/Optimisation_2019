# Subsystem 2: Optimising Paddle 

<img align="right" src="https://github.com/gabrieledamone/DE4-OPT/blob/master/Images/Paddle%20Subsystem%20Image.png" height="420" width="480">

**Author:** Gabriele D'Amone

**Overview:** This study aims to maximise the propulsive force that a paddler with a muscular strength of 125 N can generate in a specific amount of time (180 seconds).

The outputs of this Optimisation will suggest a personalised Paddle blade design and Paddling Tecnique:

**Paddling Tecnique**

- Peak Blade Velocity 
- Stroke Exit Angle
- Stroke Rate

**Paddle Blade Design**

- Blade Cross Section
- Blade Surface Area


## Dependencies

This subsystem runs using Matlab R2019b and Microsoft Excel.

The packages used by this subsystem are listed in the section below.

## Getting Started

To run this code, first ensure you have installed on Matlab the following Toolboxes:

- **Optimisation Toolbox** (Download here https://uk.mathworks.com/products/optimization.html)
- **Global Optimisation Toolbox** (Download here https://uk.mathworks.com/products/global-optimization.html)
- **Curve Fitting Toolbox** (Download here https://uk.mathworks.com/products/curvefitting.html)
- **Symbolic Math Toolbox** (Download here https://uk.mathworks.com/products/symbolic.html)
- **Statistics and Machine Learning Toolbox** (Download here https://uk.mathworks.com/products/statistics.html)
- **Simulink** (Download here https://uk.mathworks.com/products/simulink.html)


Then, please find below an overview of the Matlab files and their content:

- Drag&LiftCoefficients
  - **AirfoilCoefficient.m** Metamodel of equations for Coefficient of Drag and Coefficient of Lift
  - Download **Coefficient.xlsx**
- FatigueProfile
  - **Fatigue.m** Metamodel of Force Profile affected by Fatigue
- Algorithms
  - **FminconInteriorPoint.m** Fmincon Interior Point Algorithm + Global Search 
  - **SQPAlgorithm.m** Fmincon Sequential Quadratic Programming Algorithm + Global Search


## Performance

This subsystems code was developed **up to Friday, December 15th**, on a HP running Windows 10 with the following specifications:

| Processor Name: Intel Core i7 | Processor Speed: 2.6 GHz | Number of Processors: 1 | Total Number of Cores: 8

The code was developed **from Monday, December 19th**, on an MSI Laptop running Windows 10.0.1 with the following specifications:

| Processor Name: Intel Core i7 | Processor Speed: 2.6 GHz | Number of Processors: 1 | Total Number of Cores: 4

Execution time is noted at the end of the Matlab output. Last run time was approximately 3.52 seconds for **FminconInteriorPoint.m**, while 3.15 seconds for **SQPAlgorithm.m**.

## Now it's your turn!

Feel free to change the input values in the code for the **Paddler Strength** and the **Paddling Time**, and determine what paddle specifications best fit your needs. 
