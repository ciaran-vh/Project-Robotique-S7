function [ ] = CloseVREP( vrep, clientID )

% Arrete le simulateur
vrep.simxStopSimulation(clientID,vrep.simx_opmode_oneshot_wait);

% Ferme la connexion réseau à VREP
vrep.simxFinish(-1);

vrep.delete();

end

