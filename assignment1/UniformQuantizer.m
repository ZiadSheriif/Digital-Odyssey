function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    L = 2 .^ n_bits;
    delta = (2 * xmax) / L;
    q_ind = max(min(floor((in_val + xmax - ((m) * delta / 2))/delta) + 1,L),1);

end
