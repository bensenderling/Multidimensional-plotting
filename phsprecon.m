function phsprecon(yy)
% function phsprecon(yy)
% phsprecon(yy) plots the time series, yy, using phase space reconstruction
% Remarks
% - This code creates a graphical user interphace, through which phase 
%   space reconstruction can be visualized in multiple dimensions.
% - The user controls the embedding dimension and the time lag through 
%   sliders at the bottom of the gui. These values are used to create a 
%   phase space matrix, which is then plotted using plotMD().
% - For an explaination of how the data is plotted in multiple dimensions
%   please see the plotMD code.
% Dec 2015 - Created by Ben Senderling, email bensenderling@gmail.com
% Example
% t=((0:4999)*0.01)'
% y=sin(2*pi*1*t)+sin(2*pi*0.5*t);
% phsprecon(y);
%% Gather inputs

[row,col]=size(yy);
if col~=1 && row==1;
    yy=yy';
elseif row~=1 && col==1
else
    error('input must be a 1xn or nx1 matrix')
end

%% Set up GUI

H=figure;
subplot(5,1,1), plot(yy); axis tight, grid on

% Create slider for embedding dimensions
sld1 = uicontrol('Style', 'slider',...
    'Min',1,'Max',8,'Value',4,...
    'Units','Normalized',...
    'Position', [0.05 0.11 0.7 0.05],...
    'Callback', @phasespace,...
    'SliderStep', [1/7 1/7]);

% Create slider for lag
sld2 = uicontrol('Style', 'slider',...
    'Min',1,'Max',200,'Value',4,...
    'Units','Normalized',...
    'Position', [0.05 0.05 0.7 0.05],...
    'Callback', @phasespace,...
    'SliderStep', [1/199 1/5]);

G=annotation('textbox',[0.8 0.11 0.2 0.05],'string',['dim = ' num2str(4)],'LineStyle','none');
H=annotation('textbox',[0.8 0.05 0.2 0.05],'string',['lag = ' num2str(4)],'LineStyle','none');

%% Initialize plot

phasespace

%% Perform phase space reconstruction and update plot

    function phasespace(source,callbackdata)
        dim=round(get(sld1,'Value'));
        lag=round(get(sld2,'Value'));
        
        delete(G)
        G=annotation('textbox',[0.8 0.11 0.2 0.05],'string',['dim = ' num2str(dim)],'LineStyle','none');
        delete(H)
        H=annotation('textbox',[0.8 0.05 0.2 0.05],'string',['lag = ' num2str(lag)],'LineStyle','none');

        ps=[];
        for i=1:dim
            ps(:,i)=yy(1+(i-1)*lag:end-(dim-(i-1))*lag);
        end
        
        subplot(5,1,2:4),plotMD(ps);
        
    end
end








