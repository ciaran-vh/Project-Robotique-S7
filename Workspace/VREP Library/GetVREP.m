function [ q , all_ok] = GetVREP( vrep, clientID, listObjects )

q = zeros(1,6);

% Lecture des positions dans VREP
all_ok = true;
for j=1:6
    [err, q(j)]=vrep.simxGetJointPosition(clientID, listObjects(j).handle, vrep.simx_opmode_streaming);%vrep.simx_opmode_oneshot_wait);
    all_ok = all_ok & (err == vrep.simx_return_ok);
end

% if all_ok==false
%     error('An error occured while getting joint positions ==> stop simulation')
% end

end

