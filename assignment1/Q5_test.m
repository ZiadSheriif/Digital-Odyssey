% Define the parameters
%n_bits = 4;

m = 0;

% Generate the random input
rng('default'); % For reproducibility
polarity = 2 * randi([0 1], 1, 10000) - 1; % +/- with probability 0.5
magnitude = exprnd(1, 1, 10000); % Exponential distribution
in_val = polarity .* magnitude; % Combine polarity and magnitude

xmax = max(abs(in_val));

% Define range of n_bits
n_bits = 2:1:8;
L = 2 .^ n_bits;
P = mean(in_val .^ 2);

% Calculate theoretical SNR
% theoretical_snr = 6.02 * n_bits + 1.76;i

% Calculate SNR for each n_bits value
simulated_snr = zeros(size(n_bits));
theoretical_snr = zeros(size(n_bits));

for i = 1:length(n_bits)
    % Quantize and dequantize the input
    q_ind = UniformQuantizer(in_val, n_bits(i), xmax, m);
    deq_val = UniformDequantizer(q_ind, n_bits(i), xmax, m);

    % Compute the SNR
    sig_pow = var(in_val);
    err_pow = mean((deq_val - in_val) .^ 2);

    theoretical_snr(i) = 10 * log10(P / (((xmax) .^ 2) / (3 * ((L(i) .^ 2)))));
    simulated_snr(i) = 10 * log10(sig_pow / err_pow);
end

% Plot theoretical and simulated SNR
figure;
plot(n_bits, theoretical_snr, 'r-', n_bits, simulated_snr, 'bo');
xlabel('Number of Bits');
ylabel('SNR (dB)');
legend('Theoretical', 'Simulated');

% Plot the input and output signals
figure;
plot(in_val);
hold on;
plot(deq_val);
legend('Input', 'Output');
