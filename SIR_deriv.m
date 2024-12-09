function [SIRDeriv] = SIR_deriv(SIR,lambda,beta,sigma,omega,mu,ds,di,dr)
%Computer the derivative of S, I ,R
%   Detailed explanation goes here
SIRDeriv = zeros(3,1);
SIRDeriv(1,1) = - beta*SIR(1,1)*SIR(2,1) + (lambda-ds)*SIR(1,1) + omega*SIR(3,1);
SIRDeriv(2,1) = beta*SIR(1,1)*SIR(2,1) - (di+mu+sigma)*SIR(2,1);
SIRDeriv(3,1) = sigma*SIR(2,1) - (dr+omega)*SIR(3,1);
end