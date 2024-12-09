function [SIRNext] = SIR_Euler(deltaT,SIR,lambda,beta,sigma,omega,mu,ds,di,dr)
%forward Euler of a basic SIR model as a starting point
%   S: susceptible, I: infectded, R: removed
    SIRDeriv = SIR_deriv(SIR,lambda,beta,sigma,omega,mu,ds,di,dr);
    SIRNext = SIR + deltaT * SIRDeriv;
end