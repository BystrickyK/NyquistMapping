clear all
close all
clc

syms L(s) F(s) s

% open loop transfer function
L(s) = 2 / ((s-0.5)*(s-1));

% characteristic equation
F(s) = L(s);
F(s) = simplifyFraction(F(s))

% poles and zeroes
[num, den] = numden(F(s))
z = solve(num==0, s);
z = double(z);
z = complex(real(z), imag(z))
p = solve(den==0, s);
p = double(p);
p = complex(real(p), imag(p))


%% find poles and zeroes on the jw axis
pzcount = length(z); % number of poles P is equal to number of zeros Z
dp = []; % points to avoid in the s countour
for i = 1:pzcount
    if (real(z(i)) == 0)
        dp(end+1) = z(i);
    end
    if (real(p(i)) == 0)
        dp(end+1) = p(i);
    end
end
%% sort dangerous points by imaginary part

    dp_tmp = zeros(length(dp), 2);
    
    for i = 1:length(dp) %split Re and Im
        dp_tmp(i, :) = [real(dp(i)) imag(dp(i))];
    end
    
    dp_tmp = sortrows(dp_tmp, 1);
    
    for i = 1:length(dp) %connect Re and Im
        dp(i) = complex(dp_tmp(i,1), dp_tmp(i,2));
    end
    
%% complex plane line trajectory
segmentcount = 2 + length(dp);
points = zeros(segmentcount, 1);
points(1) = 0 - 0j;
points(end) = 0 + 10000j;
points(2:end-1) = dp;
% points = [-12 - 5j, 3-3j, -2-1j, 5+3j, 15+7j]
s_path = loopConnectPoints(points);
% s_path(end+1,:) = complexLoop(points(end), points(1), 'clockwise');

    

% s_path = [];
% s_path(end+1, :) = complexLine(A,B);
% s_path(end+1, :) = complexLoop(B,A,'clockwise');

%% map trajectories with F
% The total number N of clockwise
% encirclements of the origin of the F(s) plane, as a representative point s traces out the
% entire contour in the clockwise direction, is equal to Z-P. 
F_path = [];
segments = size(s_path);
segments = segments(1);
for column = 1:segments
    segment = s_path(column,:);
    F_path(end+1, :) = F(segment);
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

xlim([ -5 5 ])
ylim([ -3 3])

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title("F(s) plane")

segments = size(s_path);
segments = segments(1);
for column = 1:segments
    s_traj = s_path(column, :);
    F_traj = F_path(column, :);
    
    plotComplex(s_traj, F_traj);
end

subplot(121)
xlim([ min(real(s_path(:)))-10 max(real(s_path(:)))+10 ])
ylim([ min(imag(s_path(:)))-10 max(imag(s_path(:)))+10 ])

subplot(122)
xlim([ min(real(F_path(:))) max(real(F_path(:))) ])
ylim([ min(imag(F_path(:))) max(imag(F_path(:))) ])

