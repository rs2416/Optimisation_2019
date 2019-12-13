# Subsystem 2: Algorithms

<img align="right" src="https://github.com/gabrieledamone/DE4-OPT/blob/master/Images/objectivefunction.png" height="400" width="480">

**Author:** Gabriele D'Amone

**Overview:** This section aims to give an overview of the algorithms used in the study. 

Please find below a description of the two algorithms and their results:

## Fmincon Interior Point Algorithm

**File Name:** FminconInteriorPoint.m

**Description:** The interior-point approach to constrained minimization is to solve a sequence of approximate minimization problems.

**Results:** 
- Peak Blade Velocity: 4.4 m/s
- Blade Angle of Exit: 124.9 degrees
- Blade Surface Area: 70.6 cm^2
- Total Propulsive Force: 1,235,409 N
- Stroke Rate:	151.3 strokes/min
- Number of Strokes:	453.8
- Average Thrust:	58.8 N
- Elapsed Time: 3.52 seconds

## Fmincon Sequential Quadratic Programming

**File Name:** SQPAlgorithm.m

**Description:** The sqp algorithm takes every iterative step in the region constrained by bounds. Usually, sqp has faster execution time and less memory usage.

**Results:**
- Peak Blade Velocity: 4.4 m/s
- Blade Angle of Exit: 124.9 degrees
- Blade Surface Area: 70.6 cm^2
- Total Propulsive Force: 1,235,409 N
- Stroke Rate:	151.3 strokes/min
- Number of Strokes:	453.8
- Average Thrust:	58.8 N
- Elapsed Time: 3.15 seconds



## Dependencies

This subsystem runs using Matlab R2019b.

The packages used by this subsystem are listed in the section below.

## Getting Started

To run this code, first ensure you have installed on Matlab the following Toolboxes:

- **Optimisation Toolbox** (Download here https://uk.mathworks.com/products/optimization.html)
- **Global Optimisation Toolbox** (Download here https://uk.mathworks.com/products/global-optimization.html)

Then, please find below an overview of the Matlab files and their content:

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

