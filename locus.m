clear all
close all
clc

syms L(s) F(s) s

% open loop transfer function
L(s) = 2 / ((s-1)*(s+1));

% characteristic equation
F(s) = 1 + L(s);
F(s) = simplifyFraction(F(s))

% poles and zeroes
[num, den] = numden(F(s))
z = solve(num==0, s);
z = double(z);
z = complex(real(z), imag(z))
p = solve(den==0, s);
p = double(p);
p = complex(real(p), imag(p))

%% complex plane line trajectory
A = -2 - 1*j;
B = 2 + 1*j;
C = 2 - 1*j;
D = -2 - 1*j;

s_path = [];
% s_path(end+1, :) = complexLine(A,B);
% s_path(end+1, :) = complexLine(B,C);
% s_path(end+1, :) = complexLine(C,D);
% s_path(end+1, :) = complexLine(D,A);
s_path(end+1, :) = complexLoop(B,C);
s_path(end+1, :) = complexLoop(C,B);

%% map trajectories with F
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
xlim([-3 6])
ylim([-3 6])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
title("s plane")

subplot(122)
hold on
grid on
axis equal
xlim([-3 6])
ylim([-3 6])
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