close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate s1 and s2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the time vector
t = linspace(0, 1, 1000); % Adjust the number of points (1000) as needed

% Generate s1
s1 = ones(size(t)); % Magnitude of 1

% Generate s2
s2 = -ones(size(t));
s2(t <= 0.75) = 1;

% Plot the signal
figure;
plot(t, s1, 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Signal s1');
grid on;

% Plot the signal
figure;
plot(t, s2, 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Signal s2');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Use your “GM_Bases” function to get the bases functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Obtain the basis functions using GM_Bases function
[phi1, phi2] = GM_Bases(s1, s2);
%[phi1_s2, phi2_s2] = GM_Bases(s2, s1);

% Plot the obtained basis functions for s1
figure;
subplot(2, 1, 1);
plot(t, phi1, 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Basis Function \phi_1');
grid on;

subplot(2, 1, 2);
plot(t, phi2, 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Basis Function \phi_2');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use your “signal_space” function to get the signal space representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the signal space representation of s1
[v1_s1, v2_s1] = signal_space(s1, phi1, phi2);

% Calculate the signal space representation of s2
[v1_s2, v2_s2] = signal_space(s2, phi1, phi2);

% Plot the signal space representation for s1 and s2 as scatter plot
figure;
scatter(v1_s1, v2_s1, 'filled');
hold on;
scatter(v1_s2, v2_s2, 'filled');
xlabel('Projection onto \phi_1');
ylabel('Projection onto \phi_2');
title('Signal Space Representation');
legend('\phi_1', '\phi_2');
grid on;


% % Plot the signal space representation for s1
% figure;
% subplot(2, 1, 1);
% stem(1, v1_s1);
% xlim([0, 2]);
% xlabel('Basis Functions');
% ylabel('Projection');
% title('Signal Space Representation of s_1');
% grid on;
% 
% subplot(2, 1, 2);
% stem(1:2, [v1_s1, v2_s1]);
% xlim([0, 3]);
% xlabel('Basis Functions');
% ylabel('Projection');
% title('Signal Space Representation of s_1');
% grid on;

% % Plot the signal space representation for s2
% figure;
% subplot(2, 1, 1);
% stem(1, v1_s2);
% xlim([0, 2]);
% xlabel('Basis Functions');
% ylabel('Projection');
% title('Signal Space Representation of s_2');
% grid on;
% 
% subplot(2, 1, 2);
% stem(1:2, [v1_s2, v2_s2]);
% xlim([0, 3]);
% xlabel('Basis Functions');
% ylabel('Projection');
% title('Signal Space Representation of s_2');
% grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verifiy the solution by getting the original signals from the basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reconstruct the original signals from the obtained basis functions
reconstructed_s1 = v1_s1 * phi1 + v2_s1 * phi2;
reconstructed_s2 = v1_s2 * phi1 + v2_s2 * phi2;

% Plot the original signals and the reconstructed signals
figure;
subplot(2, 1, 1);
plot(t, s1, 'b', t, reconstructed_s1, 'r--', 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Original Signal s_1 vs Reconstructed Signal');
legend('Original s_1', 'Reconstructed s_1');
grid on;

subplot(2, 1, 2);
plot(t, s2, 'b', t, reconstructed_s2, 'r--', 'LineWidth', 2);
xlabel('Time');
ylabel('Magnitude');
title('Original Signal s_2 vs Reconstructed Signal');
legend('Original s_2', 'Reconstructed s_2');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Effect of AWGN on signal space representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the SNR levels (in dB)
SNR_levels = [-5, 0, 10];

figure;
grid on;
hold on;
xlabel('\phi_1');
ylabel('\phi_2');
% Plot the signal points
scatter(v1_s1, v2_s1,'r', 'filled');
scatter(v1_s2, v2_s2,'m', 'filled');

% Generate samples of r1(t) and r2(t) for each SNR level
for i = 1:length(SNR_levels)
    % Calculate the noise variance based on the SNR level
    SNR_dB = SNR_levels(i);
    
    % Generate samples of r1(t) and r2(t) using awgn
    r1 = awgn(s1, SNR_dB, 'measured');
    r2 = awgn(s2, SNR_dB, 'measured');
    
    % Calculate the signal space representation of r1(t) and r2(t)
    [v1_r1, v2_r1] = signal_space(r1, phi1, phi2);
    [v1_r2, v2_r2] = signal_space(r2, phi1, phi2);
    
    % Plot the signal points
    scatter(v1_r1, v2_r1,'r', 'filled');
    scatter(v1_r2, v2_r2,'m', 'filled');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
TODO: NEED review

4. How does the noise affect the signal space? Does the noise effect increase or decrease with increasing ?2?

The noise in the signal affects the signal space representation by introducing additional variability and spreading out the signal points. When the noise variance ?^2 increases, the effect of noise becomes more prominent.

Specifically, as ?^2 increases:

The spread of the signal points in the signal space increases. This is because higher noise levels cause more uncertainty in the signal measurements, leading to larger variations in the signal projections onto the basis functions.
The signal points become more dispersed and less concentrated around the ideal positions determined by the original signals and basis functions. The noise introduces randomness, causing the signal points to deviate from the expected positions.
The distinction between different signal points becomes less clear. With higher noise levels, the signal points may overlap or cluster together, making it more challenging to distinguish between different signals or determine their relative positions in the signal space.
In summary, the effect of noise on the signal space representation increases with increasing noise variance ?^2. Higher noise levels lead to greater spread, dispersion, and reduced distinguishability of the signal points in the signal space.
%}



