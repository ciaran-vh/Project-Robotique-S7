function [ q ] = CalculeQTrapeze(Param,t)
t = t - Param.ti;
if t<0
    error('Invalid Input : t')
end

qi=Param.qi;
qf=Param.qf;
t1=Param.t1 - Param.ti;
t2=Param.t2 - Param.ti;
tf=Param.tf - Param.ti;
q=zeros(1,6);
r=RobotisH;

if t>tf
    q=qf;
else
    for i=1:6
        deltaq  = qf(i)-qi(i);
        if abs(deltaq)<1e-5
            q(i)=qf(i);continue;
        end
        
        V       = deltaq/t2;
        A       = V/t1;
        
        if abs(A)>r.M(i,4)+1e-5 || abs(V)>r.M(i,3)+1e-5
            error('Impossible, V>Vmax ou A>Amax')
        end
        
        qt1     = (1/2)*A*t1^2;
        
        if 0<=t && t<t1
            q(i)=qi(i)+(1/2)*A*t^2;
        elseif t1<=t && t<t2
            q(i)=qi(i) + qt1 + ...
                V*(t-t1);
        else % t2<=t && t<=tf
            q(i)=qi(i) + qt1 + ...
                V*(t2-t1) + ...
                (1/2)*(-A)*(t-t2)^2 + V*(t-t2);
        end
    end
end
end
