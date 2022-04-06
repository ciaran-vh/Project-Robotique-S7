function [ Etape ] = CreateE( )

Etape.typeC = 'name';   % Nom du type de commande souhait�
Etape.isDone= false;    % Etat de l'�tape (termin� ou pas)

Etape.qi    = [];       % Position angulaire initiale
Etape.qf    = [];       % Position angulaire finale

Etape.duree = [];       % Dur�e souhait� pour ce d�placement

Etape.ti    = [];       % Temps initial = d�but de l'�tape
Etape.t1    = [];       % Param�tre t1 (pour commande trap�ze)
Etape.t2    = [];       % Param�tre t2 (pour commande trap�ze)
Etape.tf    = [];       % Temps final = fin de l'�tape

Etape.listPd= [];       % Liste de points d�sir�s (g�n�ration trajectoire)
Etape.listVd= [];       % Vitesse d�sir�es pour chaque point
Etape.dist  = [];       % Distance maximale entre 2 points
Etape.idxPd = 1;        % idx du point cible dans la liste de Pd

Etape.Pd    = [];       % Point cible actuel (�volue au cours du programme)
Etape.Vd    = [];       % Vitesse correspondant au point cible
Etape.Ad    = [];       % Orientation d�sir�e de l'effecteur

Etape.Kp    = [];       % Coefficient correcteur pour le d�placement
Etape.Ka    = [];       % Coefficient correcteur pour l'orientation

end

