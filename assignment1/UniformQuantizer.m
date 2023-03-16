function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    L = 2 .^ n_bits;
    delta = (2 * xmax) / L;
    levels = (m * delta / 2) - xmax:delta:(m * delta / 2) + xmax;
    
    q_ind = min(max(floor((in_val + -1*levels(1))/delta) + 1,1),length(levels) - 1);

end
