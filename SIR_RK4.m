function [SIRNext] = SIR_RK4(deltaT,SIR,lambda,beta,sigma,omega,mu,ds,di,dr)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A = SIR_deriv(SIR,lambda,beta,sigma,omega,mu,ds,di,dr);
B = SIR_deriv(SIR + 0.5*A,lambda,beta,sigma,omega,mu,ds,di,dr);
C = SIR_deriv(SIR + 0.5*B,lambda,beta,sigma,omega,mu,ds,di,dr);
D = SIR_deriv(SIR + C,lambda,beta,sigma,omega,mu,ds,di,dr);

SIRNext = SIR + deltaT * (A + 2*B + 2*C + D) / 6;
end