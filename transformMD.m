function [x, y, z] = transformMD(varargin)

projectPath = 'C:\Users\bense\OneDrive\Documents\Projects\012 Multi-dimensional Plotting\';

%% Read the vectors from a file

fid = fopen([projectPath 'Code\MDPlotVectors.json'], 'r');
txt = fgetl(fid);
fclose(fid);
vectors = jsondecode(txt);

%% Arrange inputs

ps = [];
m = length(varargin);
n = length(varargin{1});
for i = 1:m
    if length(varargin{i}) ~= n
        error('input dimensions do not agree')
    end
    ps = [ps, [varargin{i}]];
end
[~,dim] = size(ps);

% Identify which dimension from the vector file should be used.

fields = fieldnames(vectors);
ind = find(strcmp(fields, ['D' num2str(dim)]));

%% Translate inputs into three dimensions

np = [];
for i = 1:length(ps)
    temp = 0;
    for j = 1:dim
        temp = temp + ps(i, j)*vectors.(fields{ind})(j, :);
    end
    np(i, :) = temp;
end

x = np(:, 1);
y = np(:, 2);
z = np(:, 3);










