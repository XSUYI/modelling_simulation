function bifurcationPlot3D()
    % Define symbolic variables
    syms x y z r

    % Define the system of equations
    fx = x * y + r * x;
    fy = -x * y + r * y * z;
    fz = -r * y * z;

    % Create a figure for plotting
    figure;
    hold on;

    % Range of r values
    r_values = linspace(-30, 30, 100);

    % Loop through r values
    for i = 1:length(r_values)
        r_val = r_values(i);

        % Substitute the current r value into the system
        eqs = [fx == 0, fy == 0, fz == 0];
        eqs_subs = subs(eqs, r, r_val);

        % Solve the system for equilibrium points (x, y, z)
        solutions = vpasolve(eqs_subs, [x, y, z]);

        % Check if solutions exist
        if ~isempty(solutions)
            for j = 1:length(solutions.x)
                x_sol = double(solutions.x(j));
                y_sol = double(solutions.y(j));
                z_sol = double(solutions.z(j));

                % Compute the Jacobian matrix at the equilibrium point
                J = jacobian([fx, fy, fz], [x, y, z]);
                J_eval = double(subs(J, [x, y, z, r], [x_sol, y_sol, z_sol, r_val]));

                % Calculate eigenvalues of the Jacobian
                eigenvalues = eig(J_eval);

                % Determine stability: if all real parts are negative, it's stable
                if all(real(eigenvalues) < 0)
                    plot(r_val, x_sol, 'b.', 'MarkerSize', 10); % Stable equilibrium (blue)
                else
                    plot(r_val, x_sol, 'r.', 'MarkerSize', 10); % Unstable equilibrium (red)
                end
            end
        end
    end

    % Plot settings
    xlabel('r');
    ylabel('x');
    title('Bifurcation Diagram for 3D System');
    grid on;
    hold off;
end