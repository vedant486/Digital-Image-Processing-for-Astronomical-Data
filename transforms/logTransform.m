function output = logTransform(image)
%LOGTRANSFORM Apply logarithmic intensity transformation.
%
%   output = logTransform(image)
%
%   Applies the logarithmic transformation:
%
%       s = c * log(1 + r)
%
%   The input image is assumed to be normalized to [0,1].
%   The output is also scaled to [0,1].
%
%   INPUT:
%       image  - normalized input image
%
%   OUTPUT:
%       output - log-transformed image in [0,1]

    % Ensure numerical stability
    image = max(image, 0);

    % Logarithmic transformation
    output = log(1 + image);

    % Normalize output to [0,1]
    output = output ./ max(output(:));

end