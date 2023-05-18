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
s2(t <= 0.75) = 0;

% Plot the signal
figure;
plot(t, s1);
xlabel('Time');
ylabel('Magnitude');
title('Rectangular-like Signal (s1)');
grid on;

% Plot the signal
figure;
plot(t, s2);
xlabel('Time');
ylabel('Magnitude');
title('Signal s2: Two Rectangles');
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
plot(t, phi1);
xlabel('Time');
ylabel('Magnitude');
title('Basis Function \phi_1 for s_1');
grid on;

subplot(2, 1, 2);
plot(t, phi2);
xlabel('Time');
ylabel('Magnitude');
title('Basis Function \phi_2 for s_1');
grid on;

% Plot the obtained basis functions for s2
% figure;
% subplot(2, 1, 1);
% plot(t, phi1_s2);
% xlabel('Time');
% ylabel('Magnitude');
% title('Basis Function \phi_1 for s_2');
% grid on;
% 
% subplot(2, 1, 2);
% plot(t, phi2_s2);
% xlabel('Time');
% ylabel('Magnitude');
% title('Basis Function \phi_2 for s_2');
% grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use your “signal_space” function to get the signal space representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the signal space representation of s1
[v1_s1, v2_s1] = signal_space(s1, phi1, phi2);

% Calculate the signal space representation of s2
[v1_s2, v2_s2] = signal_space(s2, phi1, phi2);

disp([v1_s1,v2_s1]);
disp([v1_s2,v2_s2]);
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


% Plot the signal space representation for s1
figure;
subplot(2, 1, 1);
stem(1, v1_s1);
xlim([0, 2]);
xlabel('Basis Functions');
ylabel('Projection');
title('Signal Space Representation of s_1');
grid on;

subplot(2, 1, 2);
stem(1:2, [v1_s1, v2_s1]);
xlim([0, 3]);
xlabel('Basis Functions');
ylabel('Projection');
title('Signal Space Representation of s_1');
grid on;

% Plot the signal space representation for s2
figure;
subplot(2, 1, 1);
stem(1, v1_s2);
xlim([0, 2]);
xlabel('Basis Functions');
ylabel('Projection');
title('Signal Space Representation of s_2');
grid on;

subplot(2, 1, 2);
stem(1:2, [v1_s2, v2_s2]);
xlim([0, 3]);
xlabel('Basis Functions');
ylabel('Projection');
title('Signal Space Representation of s_2');
grid on;

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
plot(t, s1, 'b', t, reconstructed_s1, 'r--');
xlabel('Time');
ylabel('Magnitude');
title('Original Signal s_1 vs Reconstructed Signal');
legend('Original s_1', 'Reconstructed s_1');
grid on;

subplot(2, 1, 2);
plot(t, s2, 'b', t, reconstructed_s2, 'r--');
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

% Number of samples
num_samples = 1000;

figure;
% Generate samples of r1(t) and r2(t) for each SNR level
for i = 1:length(SNR_levels)
    % Calculate the noise variance based on the SNR level
    SNR_dB = SNR_levels(i);
    SNR = 10^(SNR_dB/10);
    noise_var = 1/SNR;
    
    % Generate noise samples
    w = sqrt(noise_var) * randn(1, num_samples);
    
    % Generate samples of r1(t) and r2(t)
    r1 = s1 + w;
    r2 = s2 + w;
    
    % Calculate the signal space representation of r1(t) and r2(t)
    [v1_r1, v2_r1] = signal_space(r1, phi1_s1, phi2_s1);
    [v1_r2, v2_r2] = signal_space(r2, phi1_s2, phi2_s2);
    
    % Plot the signal points
    scatter(v1_r1, v2_r1, 'filled');
    xlabel('Projection onto \phi_1 for r_1(t)');
    ylabel('Projection onto \phi_2 for r_1(t)');
    title(sprintf('Signal Points at SNR = %d dB', SNR_dB));
    grid on;
    hold on;
    scatter(v1_r2, v2_r2, 'filled');
    xlabel('Projection onto \phi_1 for r_1(t)');
    ylabel('Projection onto \phi_2 for r_1(t)');
    title(sprintf('Signal Points at SNR = %d dB', SNR_dB));
    grid on;
    hold on;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



