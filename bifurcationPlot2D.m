% Clear workspace and command window
clear all; close all; clc;

% Define parameter ranges
p_values = linspace(0.01, 2, 100); % Range of p values (scaling factor for vampire self-regulation)
v_value = linespace(0.0001, 2, 100);

% Fixed parameter values
M = 3.970879120879121e+02;        % Non-dimensional hunting rate
N = 39.708791208791204;         % Non-dimensional vampire growth rate
ds = 0.0079 / 365; % Human death rate per day
lambda = 0.017 / 365; % Human birth rate per day

% Initialize arrays to store equilibrium points
h_eq = [];
v_eq = [];
p_eq = [];
stability = [];

% Loop over each p value to compute equilibrium points
for p = p_values
    % Recalculate O based on the current p value
    O = ds / ((lambda - ds) * p);
    
    % Define the system of equations for equilibrium points
    syms h v
    eq1 = h * (1 - M * v * (1 - v / (p * h))) == 0;
    eq2 = v * (N * h * (1 - v / (p * h)) - O * v) == 0;

    % Solve the system for equilibrium points
    solutions = solve([eq1, eq2], [h, v], 'Real', true);

    % Extract the solutions
    h_sol = double(solutions.h);
    v_sol = double(solutions.v);

    % Loop through each solution
    for i = 1:length(h_sol)
        h_temp = h_sol(i);
        v_temp = v_sol(i);

        % Check if the solution is valid (positive populations)
        if ~isempty(h_temp) && ~isempty(v_temp) && h_temp ~= 0 %&& v_temp ~= 0
            % Compute the Jacobian at the equilibrium point
            J = jacobian([h * (1 - M * v * (1 - v / (p * h))), ...
                          v * (N * h * (1 - v / (p * h)) - O * v)], [h, v]);
            J_eval = subs(J, [h, v], [h_temp, v_temp]);
            J_numeric = double(J_eval);

            % Compute eigenvalues of the Jacobian
            eigenvalues = eig(J_numeric);

            % Determine stability based on eigenvalues
            if all(real(eigenvalues) < 0)
                stability = [stability; 1]; % Stable equilibrium
            else
                stability = [stability; 0]; % Unstable equilibrium
            end

            % Store the equilibrium points and corresponding p values
            h_eq = [h_eq; h_temp];
            v_eq = [v_eq; v_temp];
            p_eq = [p_eq; p];
        end
    end
end

% Plot the bifurcation diagram for h
figure;
scatter(p_eq(stability == 1), h_eq(stability == 1), 'b', 'DisplayName', 'Stable');
hold on;
scatter(p_eq(stability == 0), h_eq(stability == 0), 'r', 'DisplayName', 'Unstable');
xlabel('p (Self-Regulation Parameter)');
ylabel('h (Non-Dimensional Human Population)');
%title('Bifurcation Diagram for Non-Dimensional Humans');
legend;
ylim([-25 25])
grid on;
hold off;

% Plot the bifurcation diagram for v
figure;
scatter(p_eq(stability == 1), v_eq(stability == 1), 'b', 'DisplayName', 'Stable');
hold on;
scatter(p_eq(stability == 0), v_eq(stability == 0), 'r', 'DisplayName', 'Unstable');
xlabel('p (Self-Regulation Parameter)');
ylabel('v (Non-Dimensional Vampire Population)');
title('Bifurcation Diagram for Non-Dimensional Vampires');
legend;
grid on;
hold off;
