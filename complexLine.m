function [line, loopPoints] = complexLine(A,B)
    gamma = linspace(0,1,500);
    line = A*(1-gamma) + B*gamma;
    
    vicinity = [0.99 1.01];
    loopPoints = A*(1-vicinity) + B*vicinity;
    
    line = complex(real(line), imag(line));
    loopPoints = complex(real(loopPoints), imag(loopPoints));
    
    
