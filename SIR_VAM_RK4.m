function [SIRNext] = SIR_VAM_RK4(deltaT,SIR,lambda,beta,b,p,ds)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A = ZomVam_deriv(SIR,lambda,beta,b,p,ds);
B = ZomVam_deriv(SIR+0.5*A,lambda,beta,b,p,ds);
C = ZomVam_deriv(SIR+0.5*B,lambda,beta,b,p,ds);
D = ZomVam_deriv(SIR+C,lambda,beta,b,p,ds);

SIRNext = SIR + deltaT * (A + 2*B + 2*C + D) / 6;
end