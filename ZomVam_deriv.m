function [SIRDeriv] = ZomVam_deriv(SIR,lambda,beta,b,p,ds)
%Computer the derivative of H, V
%H: human; vampire: V

SIRDeriv = zeros(2,1);
%S
%SIRDeriv(1,1) = - beta*SIR(1,1)*SIR(2,1) + (lambda-ds)*SIR(1,1);
%Iv
%SIRDeriv(2,1) = b * beta*SIR(1,1)*SIR(2,1) - c * SIR(2,1);
SIRDeriv(1,1) = (lambda-ds)*SIR(1,1) - beta * SIR(2,1) * SIR(1,1) * (1 - (SIR(2,1) / (p * SIR(1,1))));
SIRDeriv(2,1) = b * beta * SIR(2,1) * SIR(1,1) * (1 - (SIR(2,1) / (p * SIR(1,1)))) - ds * (SIR(2,1) / (p * SIR(1,1))) * SIR(2,1);
end