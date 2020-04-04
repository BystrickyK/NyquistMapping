function line = complexLine(A,B)
    gamma = linspace(0,1);
    line = A*(1-gamma) + B*gamma;
    line = complex(real(line), imag(line));
    
