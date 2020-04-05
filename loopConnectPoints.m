function path = loopConnectPoints(points)
    
    
    dangerousPoints = points(2:end-1);
    initPoint = points(1);
    endPoint = points(end);
    
    if (isempty(dangerousPoints))
        path = complexLine(A,B);
        return
    end
    
    %%
    vicinityPoints = zeros(2, length(dangerousPoints));
    currentPoint = initPoint;
    for i = 1:length(dangerousPoints);
        pointOfInterest = dangerousPoints(i);
        while(1) %do-while
            [~, vicinityPoints(:, i)] = complexLine(currentPoint, pointOfInterest);
            if(norm(vicinityPoints(1,i)-vicinityPoints(2,i)) < 1e-3);
                break
            else
            currentPoint = vicinityPoints(1, i);
            end
        end
    end
        
    %% make path
    currentPoint = initPoint
    path = [];
    for i = 1:length(dangerousPoints)
        path(end+1,:) = complexLine(currentPoint, vicinityPoints(1, i));
        path(end+1,:) = complexLoop(vicinityPoints(1,i), vicinityPoints(2,i));
        currentPoint = vicinityPoints(2,i);
    end
    path(end+1,:) = complexLine(currentPoint, endPoint);
end
        
        
    
    
    