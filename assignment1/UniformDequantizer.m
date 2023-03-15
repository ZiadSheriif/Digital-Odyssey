function deq_val = UniformDequantizer(q_ind, n_bits, xmax, m)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    % Calculate the number of quantization intervals
    L = 2 ^ n_bits;

    % Calculate the width of each quantization interval
    delta = (2 * xmax) / L;

    q_levels = ((1 - m) * delta) / (2) - xmax:delta:((1 - m) * delta) / (2) + xmax;

    deq_val = q_levels(q_ind);
end
