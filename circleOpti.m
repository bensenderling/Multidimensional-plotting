function [xmin] = circleOpti(N)

% [xmin] = circleOpti
% Inputs  - none
% Outputs - xmin, equaly spaced points on a circle.
% Remarks
% - This code was part of the initial attempt to develop a machine learning
%   algorithm that would produce equally spaced points on a circle. It was
%   sidelined as a function to find equally spaced points on a sphere was
%   developed.
% - This function will find equally spaced axes within the plane of a
%   sphere. It is incomplete and does not work well.

% Define the optimization function
f = @potential;
g = @(x) + f(x);

% Create the initial points.
x0 = 2*rand(N,1) - 1;

% Number of iterations for the optimization.
iter = 2000;

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

% Optional input arguements for the optimization.
% options = optimset('MaxFunEvals',iter*200*N,'MaxIter',iter*200*N,'TolFun',1e-16,'TolX',1e-16,'PlotFcn','optimplotfval');

% Performs the optimization.
% [xmin,gmin] = fminsearch(g,x0,options);

% Performs the optimization.
[x, fval, exitflag, output] = fmincon(g,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);

% This function helped serve as the constraint to keep points on the
% circle.
xmin(abs(xmin)>=1) = sign(xmin(abs(xmin)>=1))*1;

xmin = sort(xmin);

% Creates a unit circle for visual representation.
xc = (-1:0.05:1)';
yc = sqrt(1-xc.^2);

% Create a figure to view the axes and points.
figure
y = sqrt(1-xmin.^2);
plot([])
hold on
for i = 1:length(xmin)
    plot(xmin(i),y(i),'.k','MarkerSize',9)
    plot([xmin(i),-xmin(i)],[y(i),-y(i)],'r')
end
plot(xc,yc,'--k',xc,-yc,'--k')
hold off
axis([-1.5,1.5,-1.5,1.5])
axis square

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
% Inputs  - x, a vector with two columns where each row represents a 
%              point.
% Outputs - p, electric potential between the points.
% Remarks
% - This function is the cost function used in the optimization method.
% - It calculates the electric potential between the points in the input.
%   It assumes those point are on a circle.
% - To create equally spaced N axes there does need to be 2N points on the
%   surface of the sphere. All 2N points must be equally spaced.

% This function helped serve as the constraint to keep points on the
% circle.
x(abs(x)>=1) = sign(x(abs(x)>=1))*1;
p = 0;
y = sqrt(1-x.^2);
x = [x;-x];
y = [y;-y];
for i = 1:length(x)-1
    p = p + sum(1./sqrt((x(i+1:end)-x(i)).^2 + (y(i+1:end)-y(i)).^2));
end

end







