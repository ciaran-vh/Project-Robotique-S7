function [ Param ] = CalculePolyDeg5( Param )
% Cette fonction renvoie les paramètres caractéristiques pour une commande
% en loi polynomiale (degré 5)
% q(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5

duree=Param.duree;
if duree<0
    error('Invalid Input : duree')
end

qi=Param.qi;
qf=Param.qf;
Param.tf = 0;

robot = RobotisH;
for i=1:6
    duree_ok=0;
    
    deltaq = abs(qf(i)-qi(i));
    if deltaq<1e-5
        continue;
    end
    
    Vmax=robot.M(i,3);
    Amax=robot.M(i,4);
    
    if duree>=1e-5
        a3=10*(qf(i)-qi(i))/duree^3;
        a4=-15*(qf(i)-qi(i))/duree^4;
        a5=6*(qf(i)-qi(i))/duree^5;
        
        dotqMax = 3*a3*(duree/2)^2 + 4*a4*(duree/2)^3 + 5*a5*(duree/2)^4;
        p       = [60*a5 24*a4 6*a3];
        r       = roots(p);
        ddotqMax= 6*a3*r(2) + 12*a4*r(2)^2 + 20*a5*r(2)^3;
        
        % duree_ok=1 ssi la position qf est atteignable en un temps == duree
        if (dotqMax<=Vmax) && (ddotqMax<=Amax)
            duree_ok = 1;
        end
    end
    
    if duree_ok
        Param.tf = duree;
    else
        tf1=(15/8)*deltaq/Vmax;                 %tps mis en atteignant Vmax
        tf2=sqrt(5.7735*abs(qf(i)-qi(i))/Amax); %tps mis en atteignant Amax
        Param.tf = max(Param.tf, max(tf1,tf2));
    end
end
Param.tf = Param.tf + Param.ti;

end

