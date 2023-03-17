% Test code
n_bits = 3;
xmax = 6;
m_values = [0, 1];
x = -6:0.01:6;
% disp(["x = ", x])

y_quant_m0 = UniformQuantizer(x, n_bits, xmax, 0);
y_quant_m1 = UniformQuantizer(x, n_bits, xmax, 1);


y_dequant_m0 = UniformDequantizer(y_quant_m0, n_bits, xmax, 0);
y_dequant_m1 = UniformDequantizer(y_quant_m1, n_bits, xmax, 1);

% disp(y_quant_m0)
% disp(y_quant_m1)

% Plot results
figure
plot(x, x, 'LineWidth', 2)
hold on
plot(x, y_dequant_m0, 'LineWidth', 2)
plot(x, y_dequant_m1, 'LineWidth', 2)
legend('Original signal', 'Dequantized signal (m=0)', 'Dequantized signal (m=1)')
xlabel('Input signal')
ylabel('Output signal')
title('Uniform quantization/dequantization with nbits=3, xmax=6')

figure
plot(x, x, 'LineWidth', 2)
hold on
plot(x, y_quant_m0, 'LineWidth', 2)
plot(x, y_quant_m1, 'LineWidth', 2)
legend('Original signal', 'Quantized signal (m=0)', 'Quantized signal (m=1)')
xlabel('Input signal')
ylabel('Quantized signal')
title('Uniform quantization with nbits=3, xmax=6')

% Plot results
figure
plot(x, x, 'LineWidth', 2)
hold on
plot(x, y_dequant_m0, 'LineWidth', 2)
legend('Original signal', 'Dequantized signal (m=0)')
xlabel('Input signal')
ylabel('Output signal')
title('Uniform quantization/dequantization with nbits=3, xmax=6')

% Plot results
figure
plot(x, x, 'LineWidth', 2)
hold on
plot(x, y_dequant_m1, 'LineWidth', 2)
legend('Original signal', 'Dequantized signal (m=1)')
xlabel('Input signal')
ylabel('Output signal')
title('Uniform quantization/dequantization with nbits=3, xmax=6')
