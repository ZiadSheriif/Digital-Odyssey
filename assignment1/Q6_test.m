% Parameters
n_bits = 2:1:8;
mu_values = [0.0001, 5, 100, 200];
L = 2 .^ n_bits;
P = mean(in_val .^ 2);

% Generate input signal
% Generate the random input
rng('default'); % For reproducibility
polarity = 2 * randi([0 1], 1, 10000) - 1; % +/- with probability 0.5
magnitude = exprnd(1, 1, 10000); % Exponential distribution
in_val = polarity .* magnitude; % Combine polarity and magnitude

xmax = max(abs(in_val));

% Calculate theoretical SNR
theoretical_snr = zeros(size(n_bits));

% Non-uniform mu-law quantization
for i = 1:length(mu_values)
    % Calculate SNR for each n_bits value
    simulated_snr = zeros(size(n_bits));
    mu = mu_values(i);

    for n = 1:length(n_bits)
        % Compress input signal
        compressed_signal = sign(in_val) .* log(1 + mu * abs(in_val)) / log(1 + mu);

        % Quantize input signal
        q_ind = UniformQuantizer(compressed_signal, n, xmax, 0);

        % Dequantize input signal
        deq_val = UniformDequantizer(q_ind, n, xmax, m);

        % Expand input signal
        expanded_signal = sign(deq_val) .* (1 / mu) .* ((1 + mu) .^ abs(deq_val) - 1);

        % Calculate quantization error
        quant_error = in_val - expanded_signal;

        theoretical_snr(i) = 10 * log10(P / (((xmax) .^ 2) / (3 * ((L(i) .^ 2)))));

        % Calculate SNR
        simulated_snr(n) = 10 * log10(mean(in_val .^ 2) / mean(quant_error .^ 2));
    end

    figure;
    % Plot theoretical and simulated SNR
    plot(n_bits, theoretical_snr, 'r-', n_bits, simulated_snr, 'bo');
    xlabel('Number of Bits');
    ylabel('SNR (dB)');
    legend('Theoretical', 'Simulated');
    title(['Input vs. Output for \mu = ' num2str(mu)]);
end
