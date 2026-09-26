function output = frequencyFilter(image, method, parameter)
%FREQUENCYFILTER Apply frequency-domain filtering to an image.
%
%   output = frequencyFilter(image, method, parameter)
%
%   INPUTS:
%       image     - Input 2-D image
%
%       method    - Frequency-domain filter:
%                   "ideal"
%                   "butterworth"
%                   "gaussian"
%
%       parameter - Filter parameters:
%
%                   Ideal:
%                       D0
%
%                   Gaussian:
%                       D0
%
%                   Butterworth:
%                       [D0, order]
%
%   OUTPUT:
%       output    - Frequency-filtered image
%
%   The function performs:
%
%       Image -> DFT -> Frequency mask -> Inverse DFT -> Output


    %% Frequency coordinate grid

    [rows, cols] = size(image);

    [u, v] = meshgrid((-floor(cols/2)):(ceil(cols/2)-1),(-floor(rows/2)):(ceil(rows/2)-1));

    % Distance from centre of frequency domain
    D = sqrt(u.^2 + v.^2);


    %% Select frequency-domain filter

    switch lower(method)

        case "ideal"

            D0 = parameter;

            % Ideal low-pass filter
            H = double(D <= D0);


        case "butterworth"

            D0 = parameter(1);
            order = parameter(2);

            % Butterworth low-pass filter
            H = 1 ./ (1 + (D ./ D0).^(2 * order));


        case "gaussian"

            D0 = parameter;

            % Gaussian low-pass filter
            H = exp(-(D.^2) / (2 * D0^2));


        otherwise

            error("Unknown frequency filter: %s", method);

    end


    %% Apply frequency-domain filter

    G = image .* H;


    %% Inverse DFT

    G = ifftshift(G);

    output = real(ifft2(G));

end