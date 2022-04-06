function [ Param ] = CalculeTrapeze(Param)
% Cette fonction renvoie les paramètres caractéristique du trapèze pour une
% commande 'bang-bang'

duree=Param.duree;
if duree<0
    error('Invalid Input : duree')
end

qi=Param.qi;
qf=Param.qf;
deltaq = abs(qf-qi);

robot = RobotisH; Vmax=robot.M(:,3); Amax=robot.M(:,4);

tau=zeros(1,6);
tf=zeros(1,6);

% En y allant au plus vite :
for i=1:6
    if deltaq(i) < Vmax(i)^2/Amax(i)
        % Forme triangle /\
        tau(i)  = sqrt(deltaq(i)/Amax(i));
        tf(i)   = 2*tau(i);
    else
        % Forme trapèze /-\
        tau(i)  = Vmax(i)/Amax(i);
        tf(i)   = deltaq(i)/Vmax(i) + tau(i);
    end
end

duree_ok = tf<=duree;
[~,idx] = max(tf);

for i=1:6
    if duree_ok(i)
        p       = [-1 duree -deltaq(i)/Amax(i)];
        tau(i)  = min(roots(p));
        tf(i)   = duree;
    end
end

Param.t1 = tau(idx)         +Param.ti;
Param.t2 = tf(idx)-tau(idx) +Param.ti;
Param.tf = tf(idx)          +Param.ti;

end