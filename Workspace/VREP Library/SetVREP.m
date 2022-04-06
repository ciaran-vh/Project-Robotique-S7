function [ ] = SetVREP( joint_positions, vrep, clientID, listObjects)

if length(listObjects) ~= length(joint_positions)
    error('handles and joint position must have the same dimension');
end

vrep.simxPauseCommunication(clientID, 1);

% Envoie les consignes
for j=1:6
    [ret]=vrep.simxSetJointTargetPosition(clientID, listObjects(j).handle , joint_positions(j), vrep.simx_opmode_oneshot);
%     if ret ~= vrep.simx_return_ok
%         error('An error occured while setting joint position')
%     end
end

% Réactive VREP et applique toutes les consignes simultanément
vrep.simxPauseCommunication(clientID, 0);

% Active 1 pas de simulation
vrep.simxSynchronousTrigger(clientID);

end

