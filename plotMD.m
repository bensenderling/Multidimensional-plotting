function [x,y,z]=plotMD(varargin)
% function [x,y,z]=plotMD(varargin)
% plotMD(x) plots each column as a seperate dimension.
% plotMD(x,y) plots each column of the variable inputs in seperate 
%             dimensions.
% plotMD(x,y,z) plots three time series using as many dimensions as 
%               necessary.
% plotsMD(x,y,z,w,...) plots four, or more, time series using as many 
%                      dimensions as the total number of columns.
% Remarks
% - This code can be used to visualize a time series existing in more than
%   three dimensions. The number of inputs and columns determines the 
%   number of dimensions.
% - The geometries of regular polyhedra are used to plot in each of the 
%   available dimensions. But as the number of regular polyhedra are 
%   limited the available dimensions are limited from 1 to 8 dimensions.
% - Dimensions not immediately available from the 5 regular polyhedra are
%   constructed from a combination of shapes. The method used here is not a
%   perfect method but is adequate for the visualization of data in more 
%   than three dimensions.
% Example
% t=(0:4999)*0.01;
% x=sin(2*pi*1*t);
% y=sin(2*pi*1.5*t);
% z=sin(2*pi*2*t);
% w=sin(2*pi*2.5*t);
% plotMD(x,y,z,w);
% Dec 2015 - Created by Ben Senderling, bensenderling@gmail.com
%% Grab inputs

ps=[];
m=length(varargin);
n=length(varargin{1});
for i=1:m
    if length(varargin{i})~=n
        error('input dimensions do not agree')
    end
    ps=[ps,[varargin{i}]];
end
[~,dim]=size(ps);

%% Trim dimensions if too many

if dim>8
    error('too many inputs')
end

%% Dimensions based on regular polyhedra

vectors=[];
switch dim
    case 1 % a line
        vectors=[1,0,0];
    case 2 % square
        x=[1,0,0];
        y=[0,1,0];
        vectors=[x;y];
    case 3; % tetrahedron
        x=[1,0,0];
        y=[0,1,0];
        z=[0,0,1];
        vectors=[x;y;z];
    case 4 % cube
        x=1/sqrt(3)*[1,1,1];
        y=1/sqrt(3)*[-1,1,1];
        z=1/sqrt(3)*[1,-1,1];
        w=1/sqrt(3)*[-1,-1,1];
        vectors=[x;y;z;w];
    case 5 % cube with vertical line, fundged because this shape is hard
        x=1/sqrt(3)*[1,1,1];
        y=1/sqrt(3)*[-1,1,1];
        z=1/sqrt(3)*[1,-1,1];
        w=1/sqrt(3)*[-1,-1,1];
        u=[0,0,1];
        vectors=[x;y;z;w;u];
    case 6 % two tetrahedrons
        x=[1,0,0];
        y=[0,1,0];
        z=[0,0,1];
        w=1/sqrt(3)*[1,1,1];
        v=1/sqrt(3)*[1,-1,1];
        u=1/sqrt(3)*[-1,1,1];
        vectors=[x;y;z;w;v;u];
    case 7 % tetrahedron and cube
        x=1/sqrt(3)*[1,1,1];
        y=1/sqrt(3)*[-1,1,1];
        z=1/sqrt(3)*[1,-1,1];
        w=1/sqrt(3)*[-1,-1,1];
        v=[1,0,0];
        u=[0,1,0];
        t=[0,0,1];
        vectors=[x;y;z;w;v;u;t];
    case 8 % icosahedron
        phi=(1+sqrt(5))/2;
        x=[1,1,1];
        y=[-1,1,1];
        z=[1,-1,1];
        w=[-1,-1,1];
        v=[1/phi-(-1/phi),phi-(-phi),0];
        u=[-1/phi-(1/phi),phi-(-phi),0];
        t=[phi-(-phi),0,1/phi-(-1/phi)];
        s=[-phi-(phi),0,1/phi-(-1/phi)];
        
        % normalize vectors for this shape
        x=x/norm(x);
        y=y/norm(y);
        z=z/norm(z);
        w=w/norm(w);
        v=v/norm(v);
        u=u/norm(u);
        t=t/norm(t);
        s=s/norm(s);
        
        vectors=[x;y;z;w;v;u;t;s];
end

%% Translate inputs into three dimensions

np=[];
for i=1:length(ps)
    temp=0;
    for j=1:dim
        temp=temp+ps(i,j)*vectors(j,:);
    end
    np(i,:)=temp;
end

%% Plot time series

a=max(np);
a(a==0)=0.01;

plot3(np(:,1),np(:,2),np(:,3),'b','linewidth',1), hold on
for u=1:dim
    plot3(a(1)*[-vectors(u,1);vectors(u,1)],a(2)*[-vectors(u,2);vectors(u,2)],a(3)*[-vectors(u,3);vectors(u,3)],'k','linewidth',2)
    text(a(1)*vectors(u,1),a(2)*vectors(u,2),a(3)*vectors(u,3),['a' num2str(u)])
end
axis([-a(1) a(1) -a(2) a(2) -a(3) a(3)])
grid on
hold off

x=np(:,1);
y=np(:,2);
z=np(:,3);









