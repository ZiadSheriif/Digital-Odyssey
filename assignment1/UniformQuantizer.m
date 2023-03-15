function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    L = 2 .^ n_bits;
    delta = (2 * xmax) / L;
    levels = (m * delta / 2) - xmax:delta:(m * delta / 2) + xmax;

    q_ind = zeros(1, length(in_val));

    for i = 1:length(in_val)

        for j = 1:length(levels) - 1

            if (in_val(i) <= levels(1))
                q_ind(i) = 1;
                break;
            elseif (in_val(i) >= levels(length(levels)))
                q_ind(i) = length(levels) - 1;
                break;
            elseif (in_val(i) >= levels(j) && in_val(i) <= levels(j + 1))
                q_ind(i) = j;
                break
            end

        end

    end

end
