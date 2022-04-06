classdef RobotisH
    
    properties (Constant)
        % Parmaètres DH modifiés
        a = [0.0; -pi/2; 0.0; -pi/2; pi/2; -pi/2];
        d = [0.0; 0.0; 265.69; 30.0; 0.0; 0.0];
        r = [159.0; 0.0; 0.0; 258.0; 0.0; 0.0];
        
        
        % Paramètres des moteurs
        % Position min et max (rad), vit. max, accel. max
        %Mx=[ qmin  , qmax   ,  q'  ,  q''  , Cmax   ];
        M = [ -pi   , pi     , 3.3  ,  30   , 44.2   ;
        	  -pi/2	, pi/2   , 3.3  ,  30	, 44.2   ;
        	  -pi/2	, 3*pi/4 , 3.3  ,  30	, 21.142 ;
        	  -pi   , pi     , 3.3  ,  30	, 21.142 ;
        	  -pi/2	, pi/2   , 3.2  ,  30	, 6.3    ;
        	  -pi   , pi     , 3.2  ,  30	, 6.3    ];
        
    end
    
    methods
        
    end
    
end

