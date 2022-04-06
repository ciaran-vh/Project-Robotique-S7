function [ newlistPd, listVd ] = listPdCine( listPd, qi, dist )
% Ajoute des points à la liste de points désirées, lorsque l'écart entre
% les points d'origine est supérieur à 'dist'.
% Crée également 'Vd' (vitesse désirée) pour chaque point.
% Vd est nulle pour les points d'origine, et Vd=u (vecteur unitaire
% pointant vers le prochain point) pour les points ajoutés.

if dist<=0 || size(listPd,2)==0 || size(listPd,1)~=3
    error('Invalid input')
end

M=MGD(qi,8);
listPd = [M(1:3,4) listPd];

newlistPd=[];listVd=[];
for i=1:size(listPd,2)-1
    newlistPd   = [newlistPd listPd(:,i)];
    listVd      = [listVd zeros(3,1)];
    
    len = norm(listPd(:,i+1)-listPd(:,i));
    if len>dist
        u = (listPd(:,i+1)-listPd(:,i))/len;
        nbNewPts = fix((len-0.1)/dist);
        newPts = ones(3,nbNewPts);
        for j=1:nbNewPts
            newPts(:,j) = j*u*len/(nbNewPts+1) + listPd(:,i);
            listVd      = [listVd u];
        end
        
        newlistPd   = [newlistPd newPts];
    end
end
newlistPd   = [newlistPd listPd(:,size(listPd,2))];
listVd      = [listVd zeros(3,1)];

end

