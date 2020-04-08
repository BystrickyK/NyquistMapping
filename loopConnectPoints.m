function path = loopConnectPoints(points)
    
    
    dangerousPoints = points(2:end-1);
    initPoint = points(1);
    endPoint = points(end);
    
    if (isempty(dangerousPoints))
        path = complexLine(initPoint,endPoint);
        return
    end
    
    %% for every pole and zero, create two points for the loop-around
    loopPoints = zeros(2, length(dangerousPoints));
    currentPoint = initPoint;
    D = 0.1; % approximate loop diameter
    for i = 1:length(dangerousPoints)
        pointOfInterest = dangerousPoints(i);
        while(1) %technically a do-while loop
            %in every iteration, move loop points closer to the pole|zero
            vicinity = [0.01 1.99];
            loopPoints(:,i) = currentPoint*(1-vicinity) + pointOfInterest*vicinity;
            loopPoints(:,i) = complex(real(loopPoints(:,i)), imag(loopPoints(:,i)));
%             [~, vicinityPoints(:, i)] = complexLine(currentPoint, pointOfInterest);
            %break condition, euclidean distance between loop ends < R
                if(norm(loopPoints(1,i)-loopPoints(2,i)) < D); 
                    break
                else
            %set current point to the first point of the loop
            currentPoint = loopPoints(1, i);
            end
        end
    end
        
    %% make path
    currentPoint = initPoint
    path = {};
    for i = 1:length(dangerousPoints)
        %go from current point to the first point of the pole|zero loop
        path{end+1} = complexLine(currentPoint, loopPoints(1, i));
        %loop around the pole|zero
        path{end+1} = complexLoop(loopPoints(1,i), loopPoints(2,i));
        %set current point to the end of the loop
        currentPoint = loopPoints(2,i);
    end
    path{end+1} = complexLine(currentPoint, endPoint);
end
        
        
    
    
    