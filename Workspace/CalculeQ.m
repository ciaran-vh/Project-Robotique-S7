function [ q, Param ] = CalculeQ( Param, t, q )

Param = UpdateParam(Param, t, q);

i=Param.idxE;
switch Param.E(i).typeC
    case 'trap'
        q = CalculeQTrapeze(Param.E(i),t);
    case 'poly'
        q = CalculeQPolyDeg5(Param.E(i),t);
    case 'cine'
        q = CalculeQCine(Param.E(i),q,Param.dt);
    otherwise
        error('Type de commande non défini.')
end


end

