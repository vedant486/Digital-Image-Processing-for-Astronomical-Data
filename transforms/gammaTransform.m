function output = gammaTransform(image, gamma)
%GAMMATRANSFORM Apply gamma intensity transformation.
%
%   output = gammaTransform(image, gamma)
%
%   Applies the transformation:
%
%       s = r^gamma
%
%   INPUT:
%       image  - normalized input image, expected in [0, 1]
%       gamma  - gamma parameter
%
%   OUTPUT:
%       output - gamma-transformed image in [0, 1]

    % Ensure non-negative input
    image = max(image, 0);

    % Apply gamma transformation
    output = image .^ gamma;

    % Ensure output remains within [0, 1]
    output = min(max(output, 0), 1);

end