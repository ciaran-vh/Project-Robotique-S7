function [ L ] = CalculeL( Ad, Ae )

% cours-cmd-cin p.51

sd=Ad(1:3,1);se=Ae(1:3,1);
nd=Ad(1:3,2);ne=Ae(1:3,2);
ad=Ad(1:3,3);ae=Ae(1:3,3);

sdc=chapeau(sd);sec=chapeau(se);
ndc=chapeau(nd);nec=chapeau(ne);
adc=chapeau(ad);aec=chapeau(ae);

L = -0.5*(sec*sdc+nec*ndc+aec*adc);

end

function vchapeau=chapeau(v)

vchapeau=[0,-v(3),v(2);
          v(3),0,-v(1);
         -v(2),v(1),0];

end