function [phi1, phi2] = GM_Bases(s1, s2)
    % Check if the input signals have the same length
    if length(s1) ~= length(s2)
        error('Input signals must have the same length');
    end

    N = length(s1); % Length of the input signals
    
    % Initialize the basis functions
    phi1 = zeros(1, N);
    phi2 = zeros(1, N);

    % Calculate the first basis function (phi1)
    phi1 = s1 / (norm(s1/(N.^0.5)));

    % Calculate the projection of s2 onto phi1
    proj = dot(s2, phi1) * phi1/N;
    
    % Calculate the second basis function (phi2)
    phi2 = s2 - proj;
    phi2 = phi2 / norm(phi2/(N.^0.5));

    % Set phi2 to a zero vector if s1 and s2 have one basis function
    if norm(s2 - proj) == 0
        phi2 = zeros(1, N);
    end
end
