# Subsystem 2: Force Profile affected by Fatigue

<img align="right" src="https://github.com/gabrieledamone/DE4-OPT/blob/master/Images/Fatigue.png" height="400" width="480">

**Author:** Gabriele D'Amone

**Overview:** This section aims to give an explanation of how the force fatigue profile was determined.

## Metamodel Creation 

**File Name:** Fatigue.m

**Data:** https://www.frontiersin.org/articles/10.3389/fphys.2019.00260/full (Figure 4B)

**Description:** A study conducted on physiological responses of Kayak athletes identified significant negative correlations between the number of strokes and the peak force.
This linear regression model was used to estimate the effects of the number of strokes on the force efficiency. In fact, as the number of strokes increases, the fatigue will increase.
Data was extrapolated from that graph, imported in MATLAB and fitted with a metamodel. This metamodel was then integrated across the number of strokes to obtain a Force profile metamodel.

**Equation:**
- -1.5 x (strokes^2) + force x (strokes) + (force - 1.5)

## Dependencies

This subsystem runs using Matlab R2019b.
The packages used by this subsystem are listed in the section below.

## Getting Started

To run this code, first ensure you have installed on Matlab the following Toolboxes:

- **Curve Fitting Toolbox** (Download here https://uk.mathworks.com/products/curvefitting.html)
- **Symbolic Math Toolbox** (Download here https://uk.mathworks.com/products/symbolic.html)

Then, please find below an overview of the Matlab files and their content:

- **Fatigue.m** Matlab code for Metamodel generation.
