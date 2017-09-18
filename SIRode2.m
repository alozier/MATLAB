function [ dYdt ] = SIRode2( t,Y,gammaH,gammaM,r,Thm,delta,muH,muM,muD,nu)
% Input:
%t: time
%Y: populations for both mosquitoes and humans 
%gammaH: human birthrate
%r: rate at which humans interact with infection vector (biten by mosquito)
%Thm: probability of transmission of infection to human after bite
%epsilon: importation via external infection rate
%muH: natural human death rate
%delta: importation via immigration rate (how many immigrants come infected
%on average)
%nu: recovery rate
%gammaM: vector birthrate 0.636 per day
%muM: vector deathrate, .12 per day (only female mosquitos bite)
%muD: deathrate due to the illness

dYdt=zeros(6,1);    % hold both SIR models for vector and human populations

%Sh,Ih,Rh represent the human population
Sh=Y(1);
Ih=Y(2);
Rh=Y(3);

%Sm,Im,Rm represent mosquito or other vector population
Sm=Y(4);
Im=Y(5);
Rm=Y(6);      % stays zero as typically mosquitos stay infected even after "recovery"
N=Sh+Ih+Rh;     %N is total number of human population (constant)
N2=Sm+Im;       %N2 is total number of mosquito population (constant)

%SIR model for human population 
dYdt(1)= gammaH*N-(r*Thm*Im*Sh)/N-muH*Sh;
dYdt(2)= r*Thm*Im*Sh-muH*Ih-nu*Ih-muD*Ih+delta;
dYdt(3)= nu*Ih-muH*Rh;
%SIR model for mosquito population
dYdt(4)=gammaM*N2-(r*Thm*Ih*Sm)/N2-muM*Sm;
dYdt(5)=(r*Thm*Ih*Sm)-muM*Im;
dYdt(6)=0;
end
