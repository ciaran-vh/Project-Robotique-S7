function [ q ] = CalculeQPolyDeg5(Param, t)
t = t - Param.ti;
if t<0
    error('Invalid Input : t')
end

qi=Param.qi;
qf=Param.qf;
tf=Param.tf - Param.ti;

q=zeros(1,6);

if tf==0 || t>=tf
    q=qf;
else
    for i=1:6
        a0=qi(i);
        a1=0;
        a2=0;
        a3=10*(qf(i)-qi(i))/tf^3;
        a4=-15*(qf(i)-qi(i))/tf^4;
        a5=6*(qf(i)-qi(i))/tf^5;
        
        % Calcul de la position
        q(i) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5;
    end
end
end

