% Parameters
n_bits = 2:1:8;
mu_values = [0, 5, 100, 200];

plot_arr = zeros(1, length(n_bits));
L = 2 .^ n_bits;
% Generate input signal
% Generate the random input
rng('default'); % For reproducibility
polarity = 2 * randi([0 1], 1, 10000) - 1; % +/- with probability 0.5
magnitude = exprnd(1, 1, 10000); % Exponential distribution
in_val = polarity .* magnitude; % Combine polarity and magnitude

P = mean(in_val .^ 2);

% xmax = max(abs(in_val));

colors = ['c' 'b' 'm' 'g'];

% Non-uniform mu-law quantization
for i = 1:length(mu_values)
    % Calculate SNR for each n_bits value
    simulated_snr = n_bits;
    % Calculate theoretical SNR
    theoretical_snr = zeros(size(n_bits));

    mu = mu_values(i);

    for j = 1:length(n_bits)
        % Normalize the signal
        xmax = max(abs(in_val));
        normalized = in_val / xmax;

        compressed_signal = polarity .* (log(1 + mu * abs(normalized)) / log(1 + mu));

        y_max = max(abs(compressed_signal));

        % Compress input signal
        % compressed_signal = sign(normalized) .* log(1 + mu * abs(normalized)) / log(1 + mu);

        % Quantize input signal
        q_ind = UniformQuantizer(compressed_signal, n_bits(j), y_max, 0);

        % Dequantize input signal
        deq_val = UniformDequantizer(q_ind, n_bits(j), y_max, 0);

        expanded_signal = polarity .* (((1 + mu) .^ abs(deq_val) - 1) / mu);

        % Expand input signal
        % expanded_signal = sign(deq_val) .* ((((1 + mu) .^ abs(deq_val)) - 1) / mu);

        % Normalize the signal
        denormalized = expanded_signal * xmax;

        % Calculate quantization error
        quant_error = abs(in_val - denormalized);

        % Calculate theoritical SNR
        theoretical_snr(j) = 10 * log10((3 * L(j) .^ 2) / log(1 + mu) .^ 2);

        % Calculate SNR
        simulated_snr(j) = 10 * log10(P / mean(quant_error .^ 2));
    end

    hold on;
    % Plot theoretical and simulated SNR
    %plot(n_bits, theoretical_snr, colorsTheo(i), n_bits, simulated_snr,colors(i));
    plot(n_bits, theoretical_snr, [colors(i) '--'], 'LineWidth', 0.5);
    hold on;
    plot(n_bits, simulated_snr, [colors(i) '-'], 'LineWidth', 0.5);
end

xlabel('Number of Bits');
ylabel('SNR (dB)');
legend(['Theoretical mu = ' num2str(mu_values(1))], ['Simulated mu = ' num2str(mu_values(1))], ['Theoretical mu = ' num2str(mu_values(2))], ['Simulated mu = ' num2str(mu_values(2))], ['Theoretical mu = ' num2str(mu_values(3))], ['Simulated mu = ' num2str(mu_values(3))], ['Theoretical mu = ' num2str(mu_values(4))], ['Simulated mu = ' num2str(mu_values(4))]);
title('Input vs. Output');
