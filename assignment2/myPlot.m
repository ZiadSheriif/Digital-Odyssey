function [] = myPlot(func,xLabel,yLabel,tit)
%MYPLOT Summary of this function goes here
%   Detailed explanation goes here
    plot(func); % plot the triangle signal
    xlabel(xLabel); % label the x-axis
    ylabel(yLabel); % label the y-axis
    title(tit); % add a title to the plot
end

