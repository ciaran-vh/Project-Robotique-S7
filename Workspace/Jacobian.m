function J = Jacobian(theta, P)

N = 6;

T = eye(4);
l = zeros(3,N);
z = zeros(3,N);
J = zeros(6,N);
DH=RobotisH;
theta(2)=theta(2)-1.4576;
theta(3)=theta(3)-0.8985;
for i=1:N
    ct=cos(theta(i)); st=sin(theta(i)); d=DH.d(i); ca=cos(DH.a(i)); sa=sin(DH.a(i)); r=DH.r(i);
    
    T = T* [   ct      -st     0       d    ;...
        ca*st   ca*ct   -sa     -r*sa  ;...
        sa*st   sa*ct    ca      r*ca  ;...
        0         0     0       1    ];
    l(:,i)=P-T(1:3,4);
    z(:,i)=T(1:3,3);
    
    J(1:3,i)=cross(z(:,i),l(:,i));
    J(4:6,i)=z(:,i);
end

end