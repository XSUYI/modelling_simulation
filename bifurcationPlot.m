function bifurcationPlot(f)

    % Plots bifurcation diagram with:
    % - red where df/dx > 0 (unstable branches).
    % - green lines where df/dx < 0 (stable branches).
    %


    syms x r

    % Compute the derivative of f with respect to x
    df = diff(f, x);

    % Generate a grid of r values
    r_values = linspace(-3, 3, 200);
    x_values = linspace(-3, 3, 200);

    figure;
    hold on;

    % Loop through each r value and solve f = 0 for x
    for i = 1:length(r_values)
        r_val = r_values(i);
        f_current = subs(f, r, r_val);
        df_current = subs(df, r, r_val);

        % Solve f = 0 for x
        x_solutions = double(solve(f_current == 0, x, 'Real', true));

        for j = 1:length(x_solutions)
            x_sol = x_solutions(j);
            df_value = double(subs(df_current, x, x_sol));

            % Plot the solution with red or green depending on df/dx
            if df_value > 0
                plot(r_val, x_sol, 'r.', 'MarkerSize', 5,Color='red'); % Unstable (red)
            else
                plot(r_val, x_sol, 'b.', 'MarkerSize', 5,Color='green'); % Stable (green)
            end
        end
    end

    % Add labels and title
    xlabel('r');
    ylabel('x^*');
    %title('Bifurcation Diagram');
    grid on;
    hold off;
end