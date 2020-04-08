function line = complexLine(A,B)

    % create parameter vector gamma
    % if B is much closer to origin than A
    if(abs(A)/abs(B) > 100)
        gamma = logspace(-8,0,400);
        gamma = 1-flip(gamma); %high resolution close to B
        gamma = gamma - gamma(1);
    % if A is much closer to origin than B
    elseif(abs(B)/abs(A) > 100)
        gamma = logspace(-8,0,400);
        gamma = gamma - gamma(1);
        gamma = gamma; %high resolution close to A
    else
        gamma = linspace(0,1,200);
    end
        
    line = A*(1-gamma) + B*gamma;
    
    line = complex(real(line), imag(line));

    
    
