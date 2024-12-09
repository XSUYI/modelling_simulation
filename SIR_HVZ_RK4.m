%% RK4 Function
function SIRNext = SIR_HVZ_RK4(deltaT, SIR, M, Gamma, N, O, C, K_H, K_V, p)
    A = HVZ_deriv(SIR, M, Gamma, N, O, C, K_H, K_V, p);
    B = HVZ_deriv(SIR + 0.5 * deltaT * A, M, Gamma, N, O, C, K_H, K_V, p);
    C_step = HVZ_deriv(SIR + 0.5 * deltaT * B, M, Gamma, N, O, C, K_H, K_V, p);
    D = HVZ_deriv(SIR + deltaT * C_step, M, Gamma, N, O, C, K_H, K_V, p);
    
    SIRNext = SIR + (deltaT / 6) * (A + 2 * B + 2 * C_step + D);
end