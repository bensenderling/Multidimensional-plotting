# Multidimensional-plotting
This package uses the geometry of regular polyhedra to create axes representing multiple dimensions. It allows multi-dimentional data to be transformed and visualized in a three-dimentional space. Plotting in a one-dimensional system up to an eight dimensional system is currently possible. Not all of these are perfect representations of a multidimentional space. Those are spaces with 5, 6 and 7 dimensions. They are created by combinations of other geometries.

# Installation
The code will need to be added to your MATLAB path.

# Usage

[x, y, z] = plotMD(x)
Plots each column as a seperate dimension.

[x, y, z] = plotMD(x,y)
Plots each column of the variable inputs in seperate dimensions.

[x, y, z] = plotMD(x,y,z)
Plots three time series using as many dimensions as necessary.

[x, y, z] = plotsMD(x,y,z,w,...)
Plots four, or more, time series using as many dimensions as the total number of columns.

phsprecon(yy)
Provide a graphical interfase through which to explore plotting in multiple dimensions.

# Contributing

If you'd like to make changes feel free to initiate a pull request with a full description of what you have changed. If there is an issue please create an issue first so we can discuss it and plan future improvements.

# License
[GNU](https://www.gnu.org/licenses/gpl-3.0.html)
