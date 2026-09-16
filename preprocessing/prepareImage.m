function out = prepareImage(img, clipPercentiles)
%PREPAREIMAGE Create a working image for DIP processing.
%
% out = prepareImage(img)
% out = prepareImage(img, [low high])
%
% The raw FITS values are preserved. The function creates:
%   out.rawData       - original data
%   out.workingData   - finite working copy
%   out.normalized    - percentile-clipped data in [0,1]
%   out.validMask     - pixels that were finite in the raw image
%   out.clipLimits    - numerical limits used for normalization
%
% This function intentionally does NOT perform noise filtering, sharpening,
% histogram equalization, DFT filtering, or other Unit-3 enhancement.

    arguments
        img (1,1) struct
        clipPercentiles (1,2) double = [1 99]
    end

    if clipPercentiles(1) < 0 || clipPercentiles(2) > 100 || ...
            clipPercentiles(1) >= clipPercentiles(2)
        error('prepareImage:InvalidPercentiles', ...
            'clipPercentiles must satisfy 0 <= low < high <= 100.');
    end

    raw = single(img.data);
    validMask = isfinite(raw);
    values = double(raw(validMask));

    if isempty(values)
        error('prepareImage:NoFinitePixels', ...
            'Cannot prepare an image with no finite pixels.');
    end

    % Working copy: only invalid pixels are replaced so downstream matrix
    % operations do not propagate NaN/Inf. The original data remain intact.
    working = raw;
    fillValue = median(values);
    working(~validMask) = single(fillValue);

    limits = prctile(values, clipPercentiles);

    if limits(1) == limits(2)
        normalized = zeros(size(working), 'single');
    else
        normalized = (working - single(limits(1))) / single(limits(2) - limits(1));
        normalized = min(max(normalized, 0), 1);
    end

    out = img;
    out.rawData = raw;
    out.workingData = working;
    out.normalized = normalized;
    out.validMask = validMask;
    out.clipLimits = limits;
    out.fillValueForInvalidPixels = fillValue;
end
