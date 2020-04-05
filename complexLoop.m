function loop = complexLoop(A,B,direction)

    if nargin < 3
        direction = 'counterclockwise';
    end

    A = complex(real(A), imag(A));
    B = complex(real(B), imag(B));
    S = A*0.5 + B*0.5;
    r = norm(A-S);
    
    gamma0 = atan2(imag(B)-imag(A), real(B)-real(A));
    if(strcmp(direction, 'clockwise'))
      gamma = linspace(-pi,-2*pi,500) + gamma0;
    else
      gamma = linspace(-pi,0,500) + gamma0;
    end
    
    loopRe = r*cos(gamma) + real(S);
    loopIm = r*sin(gamma) + imag(S);
    loop = complex(loopRe, loopIm);
end
    
