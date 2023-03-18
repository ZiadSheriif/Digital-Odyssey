function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    L = 2 .^ n_bits;
    delta = (2 * xmax) / L;
    levels = -xmax:delta:xmax;
    q_ind = max(min(floor((in_val + xmax + ((m) * delta / 2))/delta) + 1,length(levels) - (1-m)*1),1);

end
