clear all
close all
clc

syms L(s) M(s) CL(s) s

% open loop transfer function
L(s) = 2 / ((s-1)*s*(s-2)*(s-1j)*(s+1j)*(s-1-1j)*(s-1+1j));
L(s) = simplifyFraction(L(s))

[Lnum, Lden] = numden(L(s));
Lnum = double(coeffs(Lnum, 'all'));
Lden = double(coeffs(Lden,'all'));
L_sys = tf(Lnum, Lden);
figure
pzplot(L_sys);
title("Open loop system");

%characteristic polynomial
M(s) = 1+L(s);
M(s) = simplifyFraction(M(s));
[Mnum, Mden] = numden(M(s));
Mnum = double(coeffs(Mnum, 'all'));
Mden = double(coeffs(Mden,'all'));
M_sys = tf(Mnum, Mden);
figure
pzplot(M_sys);
title("Characteristic polynomial");

% closed loop transfer function
CL(s) = L(s)/M(s);
CL(s) = simplifyFraction(CL(s))

[CLnum, CLden] = numden(CL(s));
CLnum = double(coeffs(CLnum, 'all'));
CLden = double(coeffs(CLden,'all'));
CL_sys = tf(CLnum, CLden);
figure
pzplot(CL_sys);
title("Closed loop system");

% poles and zeroes
[num, den] = numden(L(s));
z = solve(num==0, s);
z = double(z);
z = complex(real(z), imag(z))
p = solve(den==0, s);
p = double(p);
p = complex(real(p), imag(p))


%% find poles and zeroes on the jw axis
P = length(p);
dp = []; % points to avoid in the s countour
for i = 1:P
%     if (real(z(i)) == 0)
%         dp(end+1) = z(i);
%     end
    disp(p(i));
    if (real(p(i)) == 0)
        dp(end+1) = p(i);
    end
end
%% sort points on jw axis - ascending

    dp_tmp = zeros(length(dp), 2);
    
    for i = 1:length(dp) %split Re and Im
        dp_tmp(i, :) = [real(dp(i)) imag(dp(i))];
    end
    
    dp_tmp = sortrows(dp_tmp, 2);
    
    for i = 1:length(dp) %connect Re and Im
        dp(i) = complex(dp_tmp(i,1), dp_tmp(i,2));
    end
    
%% complex plane line trajectory
points = 0 - 10000j;
points = [ points dp ];
points = [ points, 0 + 10000j];
% points = [-12 - 5j, 3-3j, -2-1j, 5+3j, 15+7j]
s_path = loopConnectPoints(points);
s_path{end+1} = complexLoop(points(end), points(1), 'clockwise');

%% map trajectories with F
% The total number N of clockwise
% encirclements of the origin of the F(s) plane, as a representative point s traces out the
% entire contour in the clockwise direction, is equal to Z-P. 
L_path = {};
segments = length(s_path);
for column = 1:segments
    segment = s_path{column};
    L_path{end+1} = double(L(segment));
end


figure

subplot(121)
hold on
grid on
axis equal
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title("s plane")

subplot(122)
hold on
grid on
axis equal

findMinReal = @(C) min(real(C)) 
findMaxReal = @(C) max(real(C)) 
findMinImag = @(C) min(imag(C)) 
findMaxImag = @(C) max(imag(C)) 

xlim([ min(cellfun(findMinReal,L_path)) max(cellfun(findMaxReal,L_path)) ])
ylim([ min(cellfun(findMinImag,L_path)) max(cellfun(findMaxImag,L_path)) ])

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title("L(s) plane")

segments = length(s_path);
segments = segments(1);
s_traj = [s_path{:}];
L_traj = [L_path{:}];

% animate the trajectories and calculate vector rotations
N = plotComplex(s_traj, L_traj);


subplot(121)
xlim auto
ylim auto

subplot(122)
xlim auto
ylim auto

