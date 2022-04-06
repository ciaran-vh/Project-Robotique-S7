function [ q ] = CalculeQCine( Param, q, dt )

Pd=Param.Pd;
Vd=Param.Vd;
Ad=Param.Ad;
Kp=Param.Kp;
Ka=Param.Ka;
dist=Param.dist;

T=MGD(q,8);

Pe=T(1:3,4);    % Position effecteur
Ae=T(1:3,1:3);  % Orientation effecteur

A=Ad*(Ae');

epsP = Pd-Pe;   % Erreur de position
epsO = 0.5*[A(3,2)-A(2,3);A(1,3)-A(3,1);A(2,1)-A(1,2)];

L       = CalculeL(Ad,Ae);
omegaE  = L\(Ka*epsO);
J       = Jacobian(q,Pe);

if norm(Vd)==0
    buff=Kp*epsP/dist;
else
    buff=Kp*epsP/norm(epsP);
end
dot_q   = pinv(J)*[buff; omegaE];
dot_q   = Clamp_dotQ(dot_q');
q       = q + dot_q*dt;

end

