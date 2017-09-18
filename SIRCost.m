function [ Cost ] = SIRCost( param,timeData,InfectedData,YInit)
%Input: param: 2x1 vector of beta and lambda
% timeData: time data
% InfectedData: infected data
% YInit: initital values of S, I, and R
% Output:  Cost: value of sum of squared errors

n=length(timeData);

Cost=0;

gammaH=param(1);
gammaM=param(2);
r=param(3);
Thm=param(4);
delta=param(5);
muH=param(6);
muM=param(7);
muD=param(8);
nu=param(9);

options=[];
[time,Y]=ode15s(@SIRode2,timeData,YInit,options,gammaH,gammaM,r,Thm,delta,muH,muM,muD,nu);

predI=Y(:,2);

for i=1:n
    Cost=Cost+(predI(i)-InfectedData(i))^2;
end


end