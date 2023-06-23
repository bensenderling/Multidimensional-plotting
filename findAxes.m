function findAxes

%%

clear
clc

projectPath = 'C:\Users\bense\OneDrive\Documents\Projects\012 Multi-dimensional Plotting\';

plotOption = 1;

iter = 10;

N = (4:20);

for i = 1:length(N)

    fprintf('finding D%i...', i)

    for j = 1:iter
        
        [x, fval, exitflag, output] = sphereOpti(N(i));

        if j == 1 || fval < results.potential(N(i), 1)

            results.vectors{N(i), 1} = round(x, 3);
            results.potential(N(i), 1) = fval;
            results.exitflag(N(i), 1) = exitflag;
            results.outputs{N(i), 1} = output;

            results.output.(['D' num2str(N(i))]) = x;

        end
    end

    if plotOption

    % Creates a unit sphere for the visual representation.
    [xs,ys,zs] = sphere;

    H = figure;

    % Plot all the points.
    for k = 1:size(x,1)
        plot3([x(k, 1), -x(k, 1)], [x(k, 2), -x(k, 2)], [x(k, 3), -x(k, 3)], 'MarkerSize', 15, 'Color', 'b', 'Marker', '.')
        hold on
        plot3([x(k, 1), -x(k, 1)], [x(k, 2), -x(k, 2)], [x(k, 3), -x(k, 3)], 'LineWidth', 4, 'Color', 'r')
    end
    % Plot the unit circle.
    plot3(xs,ys,zs,'--k','LineWidth',0.5)
    hold off
    axis([-1,1,-1,1,-1,1])
    axis square
    title([num2str(N(i)) 'D'])

    if N(i) > 9
        num = [num2str(N(i)) 'D'];
    else
        num = ['0' num2str(N(i)) 'D'];
    end
    savefig(H, [projectPath 'Figures\figure012_005_' num ])
    saveas(H, [projectPath 'Figures\figure012_005_' num '.jpg'])
    saveas(H, [projectPath 'Figures\figure012_005_' num ], 'svg')


    end

    fprintf('complete\n')

end

txt = jsonencode(results.output);
fid = fopen([projectPath 'Code\MDPlotVectors.json'], 'w');
fprintf(fid, txt)
fclose(fid)



