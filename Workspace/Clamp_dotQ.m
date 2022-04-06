function [ dotQClamped ] = Clamp_dotQ( dotQ )
% Limite la vitesse des articulations

robot = RobotisH;
Vmax=robot.M(:,3)';

% Clamp speed
w=ones(1,6);
for i=1:6
    if abs(dotQ(i))>Vmax(i)
        w(i) = Vmax(i)/abs(dotQ(i));
    end
end

dotQClamped = dotQ*min(w);

end

