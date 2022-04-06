function T = MGD(theta, j)
% Renvoie la matrice homogène T_j
% j peut prendre les valeurs 1..8

N = 6;
if j>N+2 || j<0
    error('Invalid input : j')
end

T = eye(4);
DH=RobotisH;
theta(2)=theta(2)-1.4576;
theta(3)=theta(3)-0.8985;

for i = 1 : j*(j<=N)+N*(j>N)
    ct=cos(theta(i)); st=sin(theta(i)); d=DH.d(i); ca=cos(DH.a(i)); sa=sin(DH.a(i)); r=DH.r(i);
    T = T*[   ct   , -st     ,   0    ,    d    ;...
        ca*st , ca*ct   , -sa    ,  -r*sa	;...
        sa*st , sa*ct   ,  ca    ,   r*ca	;...
        0   ,   0     ,   0    ,     1    ];
end

if j==N+1 || j==N+2
    % Translation + rotation -> repère outil (comme VREP)
    T = T * [  -1.0    0.0     0.0    0.0	;
        0.0   -1.0     0.0    0.0	;
        0.0    0.0     1.0    123.0	;
        0.0    0.0     0.0    1.0    ];
end

if j==N+2
    % Translation de 112mm -> pointe du crayon (comme VREP)
    T = T * [   1.0    0.0     0.0    0.0	;
        0.0    1.0     0.0    0.0	;
        0.0    0.0     1.0    112.0  ;
        0.0    0.0     0.0    1.0    ];
end

end
