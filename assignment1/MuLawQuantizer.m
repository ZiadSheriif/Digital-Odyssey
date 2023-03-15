function q_ind = MuLawQuantizer(in_val, n_bits, xmax, mu)
    % Non-uniform mu-law quantizer
    % in_val: input signal
    % n_bits: number of bits available to quantize one sample in the quantizer
    % xmax: maximum amplitude of the signal
    % mu: parameter that controls the non-uniformity of the quantization

    % Compute the quantization step
    L = 2 ^ n_bits;
    delta = 2 * xmax / L;

    % Apply the mu-law function and quantize
    x_mu = sign(in_val) .* log(1 + mu * abs(in_val) / xmax) ./ log(1 + mu);
    q_ind = floor((x_mu + 1) / delta);
end
