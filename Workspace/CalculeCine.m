function [ Param ] = CalculeCine( Param )

Param.Kp = 200;
Param.Ka = 1;
Param.dist = 10;

Param.Ad    =[-1,0,0;0,1,0;0,0,-1];   %Orientation désirée (effecteur)

[Param.listPd,Param.listVd]=listPdCine(Param.listPd, Param.qi, Param.dist);

Param.Pd = Param.listPd(:,1);
Param.Vd = Param.listVd(:,1);
end

