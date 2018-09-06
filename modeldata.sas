/*Taken from http://support.sas.com/resources/papers/proceedings13/401-2013.pdf*/

%let nObs = 50000000;
%let nContIn = 20;
%let nContOut = 80;
%let nClassIn = 5;
%let nClassOut = 5;
%let maxLevs = 5;


data modeldata;
array xIn{&nContIn};
array xOut{&nContOut};
array cIn{&nClassIn};
array cOut{&nClassOut};
drop i j sign nLevs xBeta expXBeta logitXBeta;
do i=1 to &nObs;
sign = -1;
xBeta = 0;
do j=1 to dim(xIn);
xIn{j} = ranuni(1);
xBeta = xBeta + j*sign*xIn{j};
sign = -sign;
end;
do j=1 to dim(xOut);
xOut{j} = ranuni(1);
end;
xSubtle = ranuni(1);
xTiny = ranuni(1);
xBeta = xBeta + 0.1*xSubtle + 0.05*xTiny;
do j=1 to dim(cIn);
nLevs = min(1+j,&maxlevs);
cIn{j} = 1+int(ranuni(1)*nLevs);
xBeta = xBeta + j*sign*(cIn{j}-nLevs/2);
sign = -sign;
end;
do j=1 to dim(cOut);
nLevs = min(1+j,&maxlevs);
cOut{j} = 1+int(ranuni(1)*nLevs);
end;
expXBeta = exp(xBeta/20);
yPoisson = ranpoi(1,expXBeta);
yNormal = xBeta + 10*rannor(1);
logitXBeta = expXBeta/(1+expXBeta);
if ranuni(1) < logitXBeta then yBinary = 0;
else yBinary = 1;
output;
end;
run;
