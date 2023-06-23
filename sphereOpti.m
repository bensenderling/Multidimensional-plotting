function [x, fval, exitflag, output] = sphereOpti(N)

% [x, fval, exitflag, output] = sphereOpti(N)
% Inputs  - N, number of axes to create.
% Outputs - x, unit vectors for N axes.
%         - fval, value of the objective function.
%         - exitflag, integer exit flag from fmincon().
%         - output, contains more information about the optimization.
% Remarks
% - This code simulates the distribution of like point charges on the
%   surface of a sphere to find a vector transform from an N-dimentional
%   space to a 3-dimentional space.
% - A vertical line is always used as one of the axes. This is omitted in
%   the inputs to the algorithm, is set within the cost function, and added
%   in after the optimization is complete.

% Define the optimization function
f = @potential;
g = @(x) + f(x);

% Create the initial points. One is left out for the vertical axes.
% Get random numbers around a circle.
theta = 2*pi*rand(N-1,1);
% Get random numbers around a sphere.
phi = asin(-1 + 2*rand(N-1,1));
% Convert the two sets of random numbers to cartesion coordinates.
[X,Y,Z] = sph2cart(theta,phi,1);
x0 = [X,Y,Z]; % Initial conditions for the optimization.
iter = 2000; % Number of iterations for the optimization.

% Perform the optimization using MATLAB native methods.
A = [];
b = [];
Aeq = [];
beq = [];
lb = -1*ones(N,3);
ub = 1*ones(N,3);
% A constraint is used to keep the points on a sphere.
nonlcon = @spherecon;
% Optional input arguements for the optimization.
options = optimset('MaxFunEvals',iter*200*N,'MaxIter',iter*200*N,'TolFun',1e-9,'TolX',1e-9,'TolCon',1e-3);
% Performs the optimization.
[x, fval, exitflag, output] = fmincon(g,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
% Adds back in the vertical axis.
x = [0,0,1;x];

end

function d = distance(x)

% This was an initial attempt to use a distance formula as the cost
% function. It didn't work well.

d = 0;
y = sqrt(1-x.^2);
for i = 1:length(x)-1
    d = d + sum(sqrt((x(i+1:end)-x(i)).^2 + (y(i+1:end)-y(i)).^2));
end

end

function a = area(x)

% This was an initial attempt to use an area under the curve as the cost
% function. It didn't work well.

x = sort(x);
x = abs(x);
y = sqrt(1-x.^2);
a = trapz(x,y);

end

function p = potential(x)

% p = potential(x)
% Inputs  - x, a vector with three columns where each row represents a 
%              point.
% Outputs - p, electric potential between the points.
% Remarks
% - This function is the cost function used in the optimization method.
% - It calculates the electric potential between the points in the input.
%   It assumes those point are on the surface of a sphere.
% - To create equally spaced N axes there does need to be 2N points on the
%   surface of the sphere. All 2N points must be equally spaced.

% Add in the vertical axis.
x = [0,0,1;x];
% Initial potential.
p = 0;
% Mirror all the points to get end points of the axes that are also on the
% sphere.
x = [x;-x];
% Calculate the potential between all the points.
for i = 1:length(x)-1
    p = p + sum(1./sqrt((x(i+1:end,1)-x(i,1)).^2 + (x(i+1:end,2)-x(i,2)).^2 + (x(i+1:end,3)-x(i,3)).^2));
end

end

function [c,ceq] = spherecon(x)

% [c,ceq] = spherecon(x)
% Inputs  - x, a vector with three columns where each row represents a 
%              point.
% Outputs - c, distance from the points to the surface of a sphere that
%              will be minimized.
%         - ceq, unused equality constraint.
% Remarks
% - This contraint functiuon ensures the points stay on the surface of a
%   sphere.

% The square root is not taken so the value is larger and possibly easier
% to optimize.
c = x(:,1).^2 + x(:,2).^2 + x(:,3).^2 - 1;
ceq = [];

end





