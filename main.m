function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)

    L = 2 ^ n_bits;
    delta = 2 * xmax / L;
    xq = zeros(size(in_val));

    for i = 1:length(in_val)
        q_level = round((in_val(i) + xmax - m * delta) / delta);
        q_level = max(min(q_level, L - 1), 0);
        xq(i) = (q_level + 0.5) * delta - m * xmax;
    end

    q_ind = xq;

    % function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)

    %     % Compute the number of quantization intervals
    %     L = 2 ^ n_bits;

    %     % Compute the quantization interval width
    %     delta = 2 * xmax / L;

    %     % Compute the quantization step size
    %     step = delta / 2;

    %     % Compute the quantization levels
    %     if m == 0
    %         levels = -xmax + step:delta:xmax - step;
    %     elseif m == 1
    %         levels = -xmax:delta:xmax - delta;
    %     else
    %         error('Invalid value of m. Must be 0 or 1.')
    %     end

    %     % Quantize the input samples
    %     q_ind = zeros(size(in_val));

    %     for i = 1:length(in_val)
    %         [~, ind] = min(abs(in_val(i) - levels));
    %         q_ind(i) = ind - 1; % MATLAB indexing starts at 1, so subtract 1
    %     end
