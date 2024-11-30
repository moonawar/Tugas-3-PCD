function result = edge_roberts(input, c)
    if nargin < 2
        c = 1; % Default scaling factor if not provided
    end

    % Roberts cross-gradient operators
    Gx = [1 0; 0 -1];
    Gy = [0 1; -1 0];

    % Compute gradients
    gradX = conv2(input, Gx, 'same') * c;
    gradY = conv2(input, Gy, 'same') * c;

    % Compute gradient magnitude
    result = sqrt(gradX.^2 + gradY.^2);
end