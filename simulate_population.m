%% Function to simulate the population dynamics using RK4 and find the minimum human population
function min_h = simulate_population(M, N, ds, p_val, SIR_initial_ND, deltaT_ND, tTotal_ND)
    % Initialize time and population arrays
    t_ND = zeros(1, tTotal_ND / deltaT_ND + 1);
    t_ND(1) = 0;
    SIR_RK_ND = zeros(length(SIR_initial_ND), tTotal_ND / deltaT_ND + 1);
    SIR_RK_ND(:, 1) = SIR_initial_ND;
    
    % RK4 simulation loop
    n = 1;
    while t_ND(n) <= tTotal_ND
        SIR_RK_ND(:, n + 1) = SIR_VAM_RK4_ND(deltaT_ND, SIR_RK_ND(:, n), M, N, ds, p_val);
        t_ND(n + 1) = t_ND(n) + deltaT_ND;
        n = n + 1;
    end
    
    % Find the minimum human population during the simulation
    min_h = min(SIR_RK_ND(1, :));
end