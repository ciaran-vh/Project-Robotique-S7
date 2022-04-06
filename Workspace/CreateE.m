function [ Etape ] = CreateE( )

Etape.typeC = 'name';   % Nom du type de commande souhaité
Etape.isDone= false;    % Etat de l'étape (terminé ou pas)

Etape.qi    = [];       % Position angulaire initiale
Etape.qf    = [];       % Position angulaire finale

Etape.duree = [];       % Durée souhaité pour ce déplacement

Etape.ti    = [];       % Temps initial = début de l'étape
Etape.t1    = [];       % Paramètre t1 (pour commande trapèze)
Etape.t2    = [];       % Paramètre t2 (pour commande trapèze)
Etape.tf    = [];       % Temps final = fin de l'étape

Etape.listPd= [];       % Liste de points désirés (génération trajectoire)
Etape.listVd= [];       % Vitesse désirées pour chaque point
Etape.dist  = [];       % Distance maximale entre 2 points
Etape.idxPd = 1;        % idx du point cible dans la liste de Pd

Etape.Pd    = [];       % Point cible actuel (évolue au cours du programme)
Etape.Vd    = [];       % Vitesse correspondant au point cible
Etape.Ad    = [];       % Orientation désirée de l'effecteur

Etape.Kp    = [];       % Coefficient correcteur pour le déplacement
Etape.Ka    = [];       % Coefficient correcteur pour l'orientation

end

