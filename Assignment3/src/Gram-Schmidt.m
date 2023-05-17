function [phi1, phi2] = GM_Bases(s1, s2)
    % Check if s1 and s2 have the same length
    if numel(s1) ~= numel(s2)
        error('Input signals must have the same length.');
    end

    % Calculate phi1 (first basis function) using Gram-Schmidt
    phi1 = s1 / norm(s1);

    % Calculate phi2 (second basis function) using Gram-Schmidt
    v2 = s2 - dot(s2, phi1) * phi1;

    if norm(v2) > eps % Check if v2 is not a zero vector
        phi2 = v2 / norm(v2);
    else
        phi2 = zeros(size(s2));
    end

end
