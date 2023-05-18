function [v1, v2] = signal_space(s, phi1, phi2)
    % Check if the input vectors have the same length
    if length(s) ~= length(phi1) || length(s) ~= length(phi2)
        error('Input vectors must have the same length');
    end

    % Calculate the projections (correlations) of s over phi1 and phi2
    v1 = dot(s, phi1);
    v2 = dot(s, phi2);
end
