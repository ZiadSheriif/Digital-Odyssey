% Parameters
n_bits = 3;
xmax = 5;
mu_values = [0, 5, 100, 200];

% Generate input signal
rng('default'); % For reproducibility
x = rand(1, 10000);
polarity = sign(x - 0.5);
magnitude = exprnd(1, 1, 10000);
input_signal = polarity .* magnitude;

% Non-uniform mu-law quantization
for i = 1:length(mu_values)
    mu = mu_values(i);
    expanded_signal = sign(input_signal) .* log(1 + mu * abs(input_signal) / xmax) / log(1 + mu);
    q_ind = UniformQuantizer(expanded_signal, n_bits, xmax, 0);
    %     s = (q_ind - 2 ^ (n_bits - 1)) * (2 * xmax / (2 ^ n_bits - 1));
    %     quantized_signal = sign(s) .* (exp(abs(s) * log(1 + mu)) - 1) / mu;
    %     deq_val = UniformDequantizer(q_ind, n_bits, xmax, m);
    %     quantized_signal=deq_val;
    compressed_signal = sign(quantized_signal) .* ((1 + mu) .^ abs(quantized_signal) - 1) / (mu * sign(quantized_signal));
    figure;
    plot(input_signal);
    hold on;
    plot(compressed_signal);
    title(['Input vs. Output for \mu = ' num2str(mu)]);
    xlabel('Sample index');
    ylabel('Signal value');
    legend('Input', 'Output');

    figure;
    plot(input_signal);
    legend('Input');
    figure
    plot(deq_val);
    legend('Output');

end
