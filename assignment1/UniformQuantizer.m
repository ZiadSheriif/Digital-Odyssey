% in_val : vector with original samples
% n_bits : the number of bits available
% xmax and m define the range of the quantizer from m? /2-xmax to m? /2+xmax
function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    % Calculate the number of quantization intervals
    L = 2^n_bits;
    disp(["L = ",L]);
    % Calculate the width of each quantization interval
    delta = (2*xmax)/L;
    
    disp(["delta = ",delta]);
    
    q_levels = (m*delta)/(2)- xmax:delta:(m*delta)/(2) + xmax;
    
    disp(["q_levels",q_levels]);
    
    % Quantize the input values
    q_ind = zeros(size(in_val));
    
    % Quantize the input values
    q_ind = zeros(size(in_val));
    for i = 1:length(in_val)
        %disp(["error",abs(in_val(i)-q_levels)]);
        [~,q_ind(i)] = min(abs(in_val(i)-q_levels));
        q_ind(i) = q_levels(q_ind(i));
end