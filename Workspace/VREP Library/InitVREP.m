function [ vrep, clientID, listObjects, qi ] = InitVREP( dt )

disp('Open Vrep Api...');
[vrep, clientID]=VrepOpenApi();
disp('Done.');

%%%%%%%%%%%%%%%%%%%%%%%%  POUR MODE SYNCHRO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure le mode synchronous
vrep.simxSynchronous(clientID,true);

% Configure le pas de simulation à dt
% ATTENTION : pris en compte uniquement si dt=Custom sur VREP
vrep.simxSetFloatingParameter(clientID,...
    vrep.sim_floatparam_simulation_time_step,dt,vrep.simx_opmode_oneshot);

% Démarre la simulation en mode oneshot_wait (un pas et attend)
vrep.simxStartSimulation(clientID,vrep.simx_opmode_oneshot_wait);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Retrieving all the joint handles...');

% Récupération des handles des articulations (joint1..joint6)
for idobj=1:6
    objectName=strcat('joint',num2str(idobj));
    listObjects(idobj).name=objectName;
end
[all_ok, listObjects]=VrepGetHandles(vrep, clientID, listObjects);

if all_ok == false
    error('An error occured while retrieving the object handles ==> stop simulation');
else
    disp('Done.')
end

% Lecture des positions dans VREP
disp('Retrieving all the joint positions...');
qi = zeros(1,6);
all_ok = true;
for j=1:6
    [err, qi(j)]=vrep.simxGetJointPosition(clientID, listObjects(j).handle, vrep.simx_opmode_oneshot_wait);
    all_ok = all_ok & (err == vrep.simx_return_ok);
end

if all_ok==false
    error('An error occured while getting joint positions ==> stop simulation')
else
    disp('Done.')
end

end

