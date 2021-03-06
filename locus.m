clear all
close all
clc

syms L(s) M(s) CL(s) s

% open loop transfer function
% L(s) = 1 / ((s-1)*s*(s-2)*(s-1j)*(s+1j)*(s-1-1j)*(s-1+1j)*(s-5j)*(s+5j)*(s-0.1j)*(s+0.1j));
% L(s) = 0.99 / (s-1)
L(s) = (s^3 + 5*s + 7)*s^2/(2*s^6 + 4*s^3 + 6*s^2 + 8*s + 2);
L(s) = simplifyFraction(L(s))

[Lnum, Lden] = numden(L(s));
Lnum = double(coeffs(Lnum, 'all'));
Lden = double(coeffs(Lden,'all'));
L_sys = tf(Lnum, Lden);
f0 = figure('Name', 'Open loop | pole-zero map');
pzplot(L_sys);
title("Open loop transfer function L(s)");

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
    if (real(p(i)) == 0)
        dp(end+1) = p(i);
    end
end

ZL = length(z);
for i = 1:ZL
    if (real(z(i)) == 0)
        dp(end+1) = z(i);
    end
end

dp = unique(dp); 
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
points = 0 - 1e7*j; %start point
points = [ points dp ]; %loop points
points = [ points, 0 + 1e7*j]; %end point
if(length(dp)==0)
    s_path = {complexLine(points(1), 0), complexLine(0,points(end))}
else
s_path = loopConnectPoints(points);
end
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

segments = length(s_path);
segments = segments(1);
s_traj = [s_path{:}];
L_traj = [L_path{:}];

% animate the trajectories and calculate vector rotations
N = plotComplex(s_traj, L_traj);
disp("N = " + string(N(end)))

%% Compare results to pzmaps
%characteristic polynomial
M(s) = 1+L(s);
M(s) = simplifyFraction(M(s));
[Mnum, Mden] = numden(M(s));
Mnum = double(coeffs(Mnum, 'all'));
Mden = double(coeffs(Mden,'all'));
M_sys = tf(Mnum, Mden);
f1 = figure('Name', 'Characteristic polynomial | pole-zero map');
pzplot(M_sys);
title("Characteristic polynomial M(s)");

% closed loop transfer function
CL(s) = L(s)/M(s);
CL(s) = simplifyFraction(CL(s))

[CLnum, CLden] = numden(CL(s));
CLnum = double(coeffs(CLnum, 'all'));
CLden = double(coeffs(CLden,'all'));
CL_sys = tf(CLnum, CLden);
f2 = figure('Name', 'Closed loop | pole-zero map');
pzplot(CL_sys);
title("Closed loop transfer function CL(s)");
