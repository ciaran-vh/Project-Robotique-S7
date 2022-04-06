


%% Initialisation

% Environnement graphique
%--------------------------------------------------------------------------
clearvars -except listPd

% Crée la figure
fig=figure(1);clf(1);view(3);hold on        
axis equal; axis([-600 600 -600 600 0 1000]); grid ON;

% Ajoute 2 boutons de contrôle à la figure
btnPAUSE=uicontrol('Parent',fig,'Style','togglebutton','String','Pause',...
    'Units','normalized','Position',[0.03    0.1    0.1    0.05]);
btnSTOP=uicontrol('Parent',fig,'Style','togglebutton','String','Stop',...
    'Units','normalized','Position',[0.03    0.05    0.1    0.05]);
%--------------------------------------------------------------------------

dt      = 0.05;
useVREP = false;        % Enable/disable VREP simulator


% Création du robot (on l'appelera 'bob')
bob=robot_t;
if useVREP
    addpath(genpath([pwd, filesep, 'VREP_lib'])); % Add VREP library
    [vrep, clientID, listObjects, qi] = InitVREP(dt);
    Update(bob,qi);
end


%% Planification des étapes de déplacement

Param.nbEtape   = 2;    % Choix du nb d'étapes
Param.dt        = dt;

Param.idxE=1;
for i=1:Param.nbEtape
    Param.E(i)  = CreateE();
end;
Param.E(1).qi   = bob.theta;
Param.E(1).ti   = 0;

% -------------------------------------------------------------------------
% -  A lire attentivement (parce que je me suis bien fatigué à l'écrire)  -
% -------------------------------------------------------------------------
% 
% 1 - Commencez par définir le nombre d'étape (nbEtape)
% 
% 2 - Ensuite, pour ajouter une étape :
% - de type trapèze ou polynomiale, il faut définir :
%   typeC   = 'trap' ou 'poly'          -> Type de commande
%   qf      = [q1 q2 q3 q4 q5 q6]       -> Position finale souhaité
%   duree   = 0..X                      -> Durée souhaité
%
% - de type cinématique, il faut définir :
%   typeC   = 'cine'
%
% Remarque 1: la liste de points est générée automatiquement par la
% fonction 'robDessin', qui sera lancée automatiquement.
% Remarque 2: l'orientation est par défaut définie pour avoir la pointe du
% crayon à la verticale, il est conseillé de ne pas la modifier.
% Remarque 3: avant d'effectuer une commande cinématique, il faudra amener
% le robot dans sa position de départ (à l'aide d'une commande 
% 'trap' ou 'poly'): qf = [0 -0.0673 1.7309 0 0.6925 0].
%
% /!\ Ce code ne permet pas de faire plusieurs commandes cinématique
% successives: il doit y avoir au max 1 étape de type 'cine'.

% Etape 1
Param.E(1).typeC= 'trap';
Param.E(1).qf   = [0 -0.0673 1.7309 0 0.6925 0];
Param.E(1).duree= 0;

% Etape 2
Param.E(2).typeC= 'cine';

% Etape 3
Param.E(3).typeC= 'poly';
Param.E(3).qf   = [0 0 0 0 0 0];
Param.E(3).duree= 2;



%% Simulation
% Lance la simulation, qui s'arrête lorsque la dernière étape est marquée 
% comme achevée, ou que l'utilisateur clique sur le bouton d'arrêt.

disp('Start simulation...')

i=1;t=0;
while ( ~Param.E(Param.nbEtape).isDone )
    
    % Affiche le temps
    figure(1); title(sprintf('t=%.03f',t)) 
    
    % Vérifie l'état des boutons
    if get(btnSTOP, 'Value') == 1
        disp('Simulation has been stopped by user.')
        if useVREP
            CloseVREP(vrep, clientID);
            return
        end
        return
    end
    if get(btnPAUSE, 'Value')==1
        set(btnPAUSE, 'String', 'Play');
        while get(btnPAUSE, 'Value') == 1
            pause(0.1);
        end
        set(btnPAUSE, 'String', 'Pause');
    end
    
    % Calcul de la commande
    [qc, Param] = CalculeQ(Param,t,bob.theta);
    
    % Envoi de la commande 
    if useVREP
        SetVREP(qc, vrep, clientID, listObjects);
        [q,all_ok]=GetVREP(vrep, clientID, listObjects);
        if all_ok
            Update(bob,q);
        end
    else
        Update(bob,qc);
    end
    
    % Récupère les positions et calcule les vitesses/accélérations 
    % correspondantes pour afficher les courbes à la fin
    p(i,:) = bob.theta;
    v(i,:) = (p(i,:)-p((i-2)*((i-1)>0)+1,:))/dt;
    a(i,:) = (v(i,:)-v((i-2)*((i-1)>0)+1,:))/dt;
    
    % Dessine (si la pointe du robot touche le sol)
    figure(1);hold on;
    if bob.R(9).pts(3,1)<2
        plot3(bob.R(9).pts(1,1),bob.R(9).pts(2,1),0,'r.');
    end
    
    drawnow;i=i+1;t=t+dt;
end
disp('Simulation done.')


%% Affichage des courbes de positions et vitesses

figure(2);clf(2);
subplot(311);hold on;
title('Positions')
plot(0:dt:(size(p,1)-1)*dt, p)

subplot(312);hold on;
title('Vitesses')
plot(0:dt:(size(v,1)-1)*dt, v)

subplot(313);hold on;
title('Accélérations')
plot(0:dt:(size(a,1)-1)*dt, a)



%% Fin de la simulation
if useVREP
    while get(btnSTOP, 'Value') == 0
        pause(0.1);
    end
    CloseVREP(vrep, clientID);
end


