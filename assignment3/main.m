
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate s1 and s2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the time vector
t = linspace(0, 1, 1000); % Adjust the number of points (1000) as needed

% Generate the rectangular-like signal
s1 = ones(size(t)); % Magnitude of 1

% Generate the first rectangle
rect1 = ones(size(t)); % Magnitude of 1
rect1(t > 0.75) = 0; % Set values after 0.75 to 0

% Generate the second rectangle
rect2 = -1 * ones(size(t)); % Magnitude of -1
rect2(t <= 0.75) = 0; % Set values before or at 0.75 to 0

% Combine the rectangles to form the signal
s2 = rect1 + rect2;

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