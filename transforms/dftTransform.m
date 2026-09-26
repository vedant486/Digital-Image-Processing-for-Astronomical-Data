function [F, magnitude, spectrum] = dftTransform(image)
%DFTTRANSFORM Compute the 2-D discrete Fourier transform of an image.
%
%   [F, magnitude, spectrum] = dftTransform(image)
%
%   INPUT:
%       image     - normalized input image
%
%   OUTPUT:
%       F         - shifted 2-D DFT
%       magnitude - magnitude spectrum |F|
%       spectrum  - log-scaled magnitude spectrum for visualization

    % Compute 2-D DFT
    F = fft2(image);

    % Shift zero frequency component to the center
    F = fftshift(F);

    % Magnitude of the frequency components
    magnitude = abs(F);

    % Log scaling for visualization
    spectrum = log(1 + magnitude);

    % Normalize visualization spectrum to [0,1]
    spectrum = spectrum ./ max(spectrum(:));

end