% Define the parameters
n_bits = 4;
xmax = 5;
m = 0;

% Generate the random input
rng('default'); % For reproducibility
polarity = 2 * randi([0 1], 1, 10000) - 1; % +/- with probability 0.5
magnitude = exprnd(1, 1, 10000); % Exponential distribution
in_val = polarity .* magnitude; % Combine polarity and magnitude

% Quantize and dequantize the input
q_ind = UniformQuantizer(in_val, n_bits, xmax, m);
deq_val = UniformDequantizer(q_ind, n_bits, xmax, m);

% Compute the SNR
sig_pow = var(in_val);
err_pow = mean((deq_val - in_val) .^ 2);
SNR = 10 * log10(sig_pow / err_pow)

% Plot the input and output signals
plot(in_val);
hold on;
plot(deq_val);
legend('Input', 'Output');
