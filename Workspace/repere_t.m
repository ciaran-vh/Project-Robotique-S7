classdef repere_t < matlab.mixin.SetGet
    
    properties
        pts;            % Points du rep�re
        ptr;            % Pointeurs sur les 3 lignes du rep�re
    end
    properties (Constant)
        Len = 50;       % Longueur des traits du rep�re
        Width = 1.5;    % Epaisseur des traits du rep�re
    end
    
    methods
        % Constructeur du rep�re (� partir d'une matrice homog�ne)
        function    r = repere_t(T)
            % Points du rep�re
            x=T*[r.Len;0;0;1];y=T*[0;r.Len;0;1];z=T*[0;0;r.Len;1];
            r.pts = [T(1:3, 4),x(1:3),y(1:3),z(1:3)];
            
            % Lignes du rep�re
            for i=1:3
                r.ptr = [r.ptr, line([r.pts(1,1) r.pts(1,1+i)], ...
                    [r.pts(2,1) r.pts(2,1+i)], ...
                    [r.pts(3,1) r.pts(3,1+i)],...
                    'LineWidth',r.Width,...
                    'Color',[i==1 i==2 i==3])]; %'red'<=>[1 0 0], etc..
            end
        end
        
        % Met � jour les points et lignes du rep�re
        function    Update( obj, T )
            x=T*[obj.Len;0;0;1];y=T*[0;obj.Len;0;1];z=T*[0;0;obj.Len;1];
            obj.pts = [T(1:3, 4),x(1:3),y(1:3),z(1:3)];
            
            for i=1:3
                set(obj.ptr(i), 'XData', [obj.pts(1,1) obj.pts(1,1+i)],...
                    'YData', [obj.pts(2,1) obj.pts(2,1+i)], ...
                    'ZData', [obj.pts(3,1) obj.pts(3,1+i)]);
            end
        end
    end
    
end

