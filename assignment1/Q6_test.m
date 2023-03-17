% Parameters
n_bits = 2:1:8;
mu_values = [0.0001, 5, 100, 200];
L = 2 .^ n_bits;


disp(L);
% Generate input signal
% Generate the random input
rng('default'); % For reproducibility
polarity = 2 * randi([0 1], 1, 10000) - 1; % +/- with probability 0.5
magnitude = exprnd(1, 1, 10000); % Exponential distribution
in_val = polarity .* magnitude; % Combine polarity and magnitude

P = mean(in_val .^ 2);

xmax = max(abs(in_val));



% Non-uniform mu-law quantization
for i = 1:length(mu_values)
    % Calculate SNR for each n_bits value
    simulated_snr = zeros(size(n_bits));
    % Calculate theoretical SNR
    theoretical_snr = zeros(size(n_bits));
    
    mu = mu_values(i);
   
    for n = 1:length(n_bits)
        % Normalize the signal
        normalized = in_val / xmax;
        
        % Compress input signal
        compressed_signal = sign(normalized) .* log(1 + mu * abs(normalized)) / log(1 + mu);

        % Quantize input signal
        q_ind = UniformQuantizer(compressed_signal, n, xmax, 0);

        % Dequantize input signal
        deq_val = UniformDequantizer(q_ind, n, xmax, m);

        % Expand input signal
        expanded_signal = sign(deq_val) .* ((((1 + mu) .^ abs(deq_val)) - 1)/mu);

        % Normalize the signal
        denormalized = expanded_signal * xmax;
        
        % Calculate quantization error
        quant_error = in_val - denormalized;

        % Calculate theoritical SNR
        theoretical_snr(n) = 10 * log10((3*L(n).^2) /log(1+mu).^2 );

        % Calculate SNR
        simulated_snr(n) = 10 * log10(P / mean(quant_error .^ 2));
    end

    figure;
    % Plot theoretical and simulated SNR
    plot(n_bits, theoretical_snr, 'r-', n_bits, simulated_snr, 'b-');
    xlabel('Number of Bits');
    ylabel('SNR (dB)');
    legend('Theoretical', 'Simulated');
    title(['Input vs. Output for \mu = ' num2str(mu)]);
end
