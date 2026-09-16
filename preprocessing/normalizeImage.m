function normalizedImage = normalizeImage(img, method)

    % Identify valid pixels
    validMask = isfinite(img);

    % Initialize output
    normalizedImage = zeros(size(img));

    % Extract valid pixel values
    validPixels = img(validMask);

    switch lower(method)

        case "minmax"

            minValue = min(validPixels);
            maxValue = max(validPixels);

            if maxValue == minValue
                normalizedImage(validMask) = 0;
            else
                normalizedImage(validMask) = (validPixels - minValue) / (maxValue - minValue);
            end

        case "zscore"

            meanValue = mean(validPixels);
            stdValue = std(validPixels);

            if stdValue == 0
                normalizedImage(validMask) = 0;
            else
                normalizedImage(validMask) = (validPixels - meanValue) / stdValue;
            end

        otherwise

            error("Unknown normalization method: %s", method);

    end

end