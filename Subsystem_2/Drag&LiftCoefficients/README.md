# Subsystem 2: Drag & Lift Coefficients Metamodel

<img align="right" src="https://github.com/gabrieledamone/DE4-OPT/blob/master/Images/Coefficients.png" height="400" width="480">

**Author:** Gabriele D'Amone

**Overview:** This section aims to give an explanation of how were the equations for these two parameters obtained. 

## Blade Cross Section Selection

**Website:** http://airfoiltools.com/airfoil/details?airfoil=goe448-il

**Website:** Coefficient.xlsx

**Description:** Since the lift creates the thrust and the drag is related to the strength of the athlete, the design should minimize the drag and maximize the lift. The Airfoil selected was the one with the highest Lift to Drag ration, the Airfoil GOE 448.

**Data:** 
The data provided by the Nasa database only had the coefficients values for angles of attack from 0 to 20 degrees. The values though, followed a sinusoidal profile, which allowed to get a more accurate estimate over the whole 180 degrees. 

## Metamodel Creation

**File Name:** AirfoilCoefficient.m

**Description:** The MatLab function polyfit(x,y,n) found the coefficients of a polynomial p(x) of degree n that fitted the data. 

**Equations:**
- C_D=2.9e^(-8) 〖∝_f〗^4  -1.07e^(-5) 〖∝_f〗^3  + 0.001〖∝_f〗^2  - 0.005∝_f- 0.0004
- C_L=1.6e^(-8) 〖∝_f〗^4+1.05e^(-5) 〖∝_f〗^3  - 0.002〖∝_f〗^2+ 0.077∝_f+ 1.01


## Dependencies

This subsystem runs using Matlab R2019b and Microsoft Excel.

The packages used by this subsystem are listed in the section below.

## Getting Started

To run this code, first ensure you have installed on Matlab the following Toolboxes:

- **Curve Fitting Toolbox** (Download here https://uk.mathworks.com/products/curvefitting.html)
- **Symbolic Math Toolbox** (Download here https://uk.mathworks.com/products/symbolic.html)

Then, please find below an overview of the Matlab files and their content:

- **Coefficient.xlsx** Drag & Lift Coefficients Data provided by NASA for Airfoil GOE 448.
- **AirfoilCoefficient.m** Matlab code for Metamodel generation.

