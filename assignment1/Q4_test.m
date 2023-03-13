% Generate input signal
in_val = 10*(rand(1, 10000) - 0.5);

% Define quantization parameters
xmax = 5;
m = 0;

% Define range of n_bits
n_bits = 2:1:8;

% Calculate theoretical SNR
theoretical_snr = 6.02 * n_bits + 1.76;

% Calculate SNR for each n_bits value
simulated_snr = zeros(size(n_bits));
for i = 1:length(n_bits)
    % Quantize input signal
    q_ind = UniformQuantizer(in_val, n_bits(i), xmax, m);

    % Dequantize quantized signal
    deq_val = UniformDequantizer(q_ind, n_bits(i), xmax, m);

    % Calculate quantization error
    quant_error = in_val - deq_val;

    % Calculate SNR
    simulated_snr(i) = 10*log10(mean(in_val.^2)/mean(quant_error.^2));
end

% Plot theoretical and simulated SNR
plot(n_bits, theoretical_snr, 'r-', n_bits, simulated_snr, 'bo');
xlabel('Number of Bits');
ylabel('SNR (dB)');
legend('Theoretical', 'Simulated');