function q_ind = Uniform(in_val, n_bits, xmax, m)

    % Compute number of quantization levels
    L = 2 ^ n_bits;

    % Compute step size and reconstruction levels
    delta = 2 * xmax / L;

    disp(["delta = ", delta]);
    disp(["L = ", L]);

    if m == 0 % midrise quantizer
        q_levels = delta / 2:delta:2 * xmax - delta / 2;
    else % midtread quantizer
        q_levels = delta:delta:2 * xmax;
    end

    % Quantize the input values
    q_ind = zeros(size(in_val));

    for i = 1:length(in_val)
        [~, q_ind(i)] = min(abs(in_val(i) - q_levels));
    end

end
