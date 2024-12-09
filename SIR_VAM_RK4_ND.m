% RK4 Function
function [SIRNext] = SIR_VAM_RK4_ND(deltaT, SIR, M, N, O, p)
    A = ZomVam_deriv_ND(SIR, M, N, O, p);
    B = ZomVam_deriv_ND(SIR + 0.5 * deltaT * A, M, N, O, p);
    C = ZomVam_deriv_ND(SIR + 0.5 * deltaT * B, M, N, O, p);
    D = ZomVam_deriv_ND(SIR + deltaT * C, M, N, O, p);
    
    SIRNext = SIR + (deltaT / 6) * (A + 2 * B + 2 * C + D);
end
