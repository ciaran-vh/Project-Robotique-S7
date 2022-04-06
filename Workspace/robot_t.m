classdef robot_t < handle
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        R;          % Ensemble des rep�res du robot
        Bras;       % Bras du robot
        Crayon;     % Crayon
        
        theta;
    end
    properties (Constant)
        Width = 1;  % Largeur des bras du robot
    end
    
    methods
        % Constructeur du robot (avec tt les theta � 0)
        function rob = robot_t()
            
            % Calcul des rep�res de chaque articulation + rep�re du crayon
            rob.theta=zeros(1,6);
            for i=0:8
                rob.R = [rob.R, repere_t(MGD(rob.theta, i))];
            end
            
            % Masque le rep�re du crayon
            for i=1:3
                set(rob.R(9).ptr(i),'Visible','off')
            end
            
            % Cr�ation de lignes entre les rep�res (bras)
            for i=1:7
                rob.Bras = [rob.Bras, line([rob.R(i).pts(1,1) rob.R(i+1).pts(1,1)], ...
                    [rob.R(i).pts(2,1) rob.R(i+1).pts(2,1)], ...
                    [rob.R(i).pts(3,1) rob.R(i+1).pts(3,1)],...
                    'LineWidth',rob.Width,...
                    'Color','k')];
                
            end
            
            % Cr�ation du crayon
            rob.Crayon = line([rob.R(8).pts(1,1) rob.R(9).pts(1,1)], ...
                [rob.R(8).pts(2,1) rob.R(9).pts(2,1)], ...
                [rob.R(8).pts(3,1) rob.R(9).pts(3,1)],...
                'LineWidth',rob.Width/3,...
                'Color','red');
        end
        
        function Update(obj, theta)
            
            % Met � jour les rep�res
            if obj.isInRange(theta) && ~max(isnan(theta))
                % No need to update R0 (always the same)
                for i=1:8
                    obj.R(i+1).Update(MGD(theta, i));
                end
            else
                error('Invalid input : theta is out of range')
            end
            
            % Met � jour les bras
            for i=1:7
                set(obj.Bras(i), 'XData', [obj.R(i).pts(1,1) obj.R(i+1).pts(1,1)], ...
                    'YData', [obj.R(i).pts(2,1) obj.R(i+1).pts(2,1)], ...
                    'ZData', [obj.R(i).pts(3,1) obj.R(i+1).pts(3,1)]);
            end
            
            % Met � jour le crayon
            set(obj.Crayon, 'XData', [obj.R(8).pts(1,1) obj.R(9).pts(1,1)], ...
                'YData', [obj.R(8).pts(2,1) obj.R(9).pts(2,1)], ...
                'ZData', [obj.R(8).pts(3,1) obj.R(9).pts(3,1)]);
            
            obj.theta=theta;
        end
        
    end
    
    
    methods (Static)
        % Cette fonction permet de v�rifier : thetaMin <= theta <= thetaMax
        function ret=isInRange(theta)
            r=RobotisH;
            lim=r.M(:, 1:2);
            for i=1:length(theta)
                if theta(i)<lim(i,1) || theta(i)>lim(i,2)
                    ret=0;return;
                end
            end
            ret=1;
        end
    end
    
end

