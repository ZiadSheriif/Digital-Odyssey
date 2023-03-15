% Parameters
n_bits = 2;
xmax = 2;
m = 0;

% Generate input values
x = [0.25, -0.25, 1.25, -0.75, -1.1, -2.2];
% [ 0,0,1
disp("x = ");
disp(x);
% Quantize input values
q_ind = UniformQuantizer(x, n_bits, xmax, m);
disp("Quantizer = ");
disp(q_ind);

deq_val = UniformDequantizer(q_ind, n_bits, xmax, m)
disp("Dequantizer = ");
disp(q_ind);
