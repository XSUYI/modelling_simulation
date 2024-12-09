% Derivatives Function
function [SIRDeriv] = ZomVam_deriv_ND(SIR, M, N, O, p)
    % Compute the derivative of h and v
    % h: Non-dimensional human population
    % v: Non-dimensional vampire population

    h = SIR(1);
    v = SIR(2);
    
    % Initialize the derivative vector
    SIRDeriv = zeros(2, 1);
    
    % Non-dimensional human population derivative (dh/dτ)
    SIRDeriv(1) = h * (1 - M * v * (1 - v / (p * h)));
    
    % Non-dimensional vampire population derivative (dv/dτ)
    SIRDeriv(2) = v * (N * h * (1 - v / (p * h)) - O * v);
end