function [ Param ] = UpdateParam( Param, t, q )
i=Param.idxE;

if t==0
    % Si il y a une étape de type commande cinématique, alors :
    for idx=1:Param.nbEtape
        if strcmp(Param.E(idx).typeC,'cine')
            
            % Si aucun dessin n'est défini => appel automatique du script de dessin
            if isempty(Param.E(idx).listPd)
                Param.E(idx).listPd = robDessin(); figure(1);
            end
        end
    end
    
    Param.E(1) = CalculeParam(Param.E(1));
end

switch Param.E(i).typeC
    
    case {'trap','poly'}
        if t>=Param.E(i).tf && max(abs(q-Param.E(i).qf))<0.001 && ~Param.E(i).isDone
            Param.E(i).isDone = true;
            
            if i+1 <= Param.nbEtape
                Param.idxE = i+1;
                Param.E(i+1).qi = q;
                Param.E(i+1).ti = t;
                Param.E(i+1)    = CalculeParam(Param.E(i+1));
            end
        end
        
    case 'cine'
        
        Pd      = Param.E(i).Pd;
        Vd      = Param.E(i).Vd;
        nbPd    = size(Param.E(i).listPd,2);
        lastPd  = Param.E(i).listPd(:,nbPd);
        T       = MGD(q, 8);Pe=T(1:3,4);
        
        
        if (norm(Pd-Pe)<0.5 && norm(Vd)==0) || (norm(Pd-Pe)<5 && norm(Vd)~=0)
            if Param.E(i).idxPd+1 <= nbPd
                Param.E(i).idxPd    = Param.E(i).idxPd+1;
                Param.E(i).Pd       = Param.E(i).listPd(:,Param.E(i).idxPd);
                Param.E(i).Vd       = Param.E(i).listVd(:,Param.E(i).idxPd);
            end
        end
        
        if Pd==lastPd & abs(lastPd-Pe)<0.5
            Param.E(i).isDone   = true;
            Param.E(i).qf       = q;
            Param.E(i).tf       = t;
            
            if i+1 <= Param.nbEtape
                Param.idxE = i+1;
                Param.E(i+1).qi = Param.E(i).qf;
                Param.E(i+1).ti = Param.E(i).tf;
                Param.E(i+1)    = CalculeParam(Param.E(i+1));
            end
        end
        
    otherwise
        error('Type de commande non défini.')
end


end

