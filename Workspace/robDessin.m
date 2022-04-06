function listPd = robDessin()

figure;
axis equal;
axis([-500 500 0 500 0 20]); % Dimensions du terrain de simulation
view(0,90)
hold on

% Dessin du cercle (limite accessibilité du robot)
theta = 0:0.01:2*pi;
rayon = 500;
x = rayon*cos(theta);
y = rayon*sin(theta);
plot(x,y)

%
h=10; % hauteur du crayon lorsqu'il est levé
listPd=[];i=1;z=1;
while 1
    if i==1
        title('First point')
    else
        if z==1
            title('UP')
        else
            title('DOWN')
        end
    end
    
    [x,y,b]=ginput(1);
    
    
    if size(listPd,2)==0
        listPd=[listPd [y;-x;z*h]];
    else
        switch b
            case 1 % Left clic
                listPd=[listPd [y;-x;z*h]];
            case 2 % Mid clic
                close; return
            case 3 % Right clic
                z = ~z; % swap height (0/1)
                listPd=[listPd [listPd(1,i-1);listPd(2,i-1);z*h]];
        end
    end
    
    if i>1
        l=line([-listPd(2,i-1) -listPd(2,i)],[listPd(1,i-1) listPd(1,i)], [listPd(3,i-1) listPd(3,i)]);
        if listPd(3,i)==0
            set(l, 'Color', [1 0 0]) %red line
        else
            set(l, 'Visible', 'off') %nothing
        end
    end
    
    i=i+1;
end

end
