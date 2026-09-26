function output = contrastStretch(image, lowPercentile, highPercentile)
%CONTRASTSTRETCH Apply percentile-based contrast stretching.
%
%   output = contrastStretch(image, lowPercentile, highPercentile)
%
%   INPUT:
%       image          - normalized input image
%       lowPercentile  - lower intensity percentile
%       highPercentile - upper intensity percentile
%
%   OUTPUT:
%       output         - contrast-stretched image in [0,1]
%
%   Example:
%       output = contrastStretch(image, 1, 99);

    % Calculate intensity limits
    lowValue = prctile(image(:), lowPercentile);
    highValue = prctile(image(:), highPercentile);

    % Avoid division by zero
    if highValue <= lowValue
        output = zeros(size(image));
        return;
    end

    % Stretch intensity range
    output = (image - lowValue) ./ (highValue - lowValue);

    % Clip values outside the selected range
    output = max(min(output, 1), 0);

end