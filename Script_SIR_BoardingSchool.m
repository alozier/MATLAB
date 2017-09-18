YInit=[31530 0 0 60000 0 0]; % Initial condition of S, I, and R

timeData=[1 61];

InfectedData=[ 1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,3,3,3,3,4,4,5,6,5,5,5,6,6,6,5,4,3,2,2,2,1,0,1,2,2,2,2,5,5,5,5,5,4,3,5,5,5,2,2,4,5,5,6,6,7,8];


paramInit=[0.0157 0.04762 0.7 0.5 0.1 0.0041 0.04762 0.001 0.14286];    %initial parameter guesses

options=[];
[paramOpt]=fminsearch(@SIRCost,paramInit,options,timeData,InfectedData,YInit);  %optimization of parameters

gammaHOpt=paramOpt(1);
gammaMOpt=paramOpt(2);
rOpt=paramOpt(3);
ThmOpt=paramOpt(4);
deltaOpt=paramOpt(5);
muHOpt=paramOpt(6);
muMOpt=paramOpt(7);
muDOpt=paramOpt(8);
nuOpt=paramOpt(9);

%uses optimized parameters to simulate infection rates
t=[1 61];
options=[];
[time,Y]=ode15s(@SIRode2,t,YInit,options,gammaHOpt,gammaMOpt,rOpt,ThmOpt,muHOpt,muMOpt,muDOpt,nuOpt,deltaOpt);
% Solves ODE

predI=Y(:,2);

%plot of simulation data
figure
plot(time, predI.*100,'-')
xlabel('Time (days)')
ylabel('Number Infected')
title('Simulation Data')

%plot of data used for optimization
figure
plot([1:1:61],InfectedData,'*');
xlabel 'Time';
ylabel 'Number Infected'
title('Chikungunya Infections from October to December 2013 on Saint Martin Island')