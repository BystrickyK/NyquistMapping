function line = complexLine(A,B)

    % create parameter vector gamma
    % if B is much closer to origin than A
    if(abs(A)/abs(B) > 100)
        gamma = logspace(-10,0,300);
        gamma = gamma.^0.7; %% redistributes the points to a more uniform density
        gamma = gamma - gamma(1);
        gamma = 1-flip(gamma); %high resolution close to B
    % if A is much closer to origin than B
    elseif(abs(B)/abs(A) > 100)
        gamma = logspace(-10,0,300);
        gamma = gamma.^0.7;
        gamma = gamma - gamma(1);
        gamma = gamma; %high resolution close to A
    else
        gamma = linspace(0,1,200);
    end
        
    line = A*(1-gamma) + B*gamma;
    
    line = complex(real(line), imag(line));

    
    
