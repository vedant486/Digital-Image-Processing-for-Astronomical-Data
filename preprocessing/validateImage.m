function report = validateImage(img)
%VALIDATEIMAGE Validate numerical properties of a FITS image.
%
% report = validateImage(img)
%
% The function reports dimensions, finite/invalid pixels, and basic
% statistics. It does not modify the image.

    arguments
        img (1,1) struct
    end

    data = img.data;

    if ~isnumeric(data) || ~ismatrix(data)
        error('validateImage:InvalidData', ...
            'img.data must be a numeric 2-D matrix.');
    end

    valid = isfinite(data);
    values = double(data(valid));

    report = struct();
    report.size = size(data);
    report.class = class(data);
    report.totalPixels = numel(data);
    report.validPixels = nnz(valid);
    report.invalidPixels = nnz(~valid);

    if isempty(values)
        report.min = NaN;
        report.max = NaN;
        report.mean = NaN;
        report.std = NaN;
        report.percentiles = nan(1, 5);
        warning('validateImage:NoFinitePixels', ...
            'Image contains no finite pixels.');
        return;
    end

    report.min = min(values);
    report.max = max(values);
    report.mean = mean(values);
    report.std = std(values);
    report.percentiles = prctile(values, [0 1 50 99 100]);

    if report.invalidPixels > 0
        warning('validateImage:InvalidPixels', ...
            '%d invalid pixels detected.', report.invalidPixels);
    end

    if report.min == report.max
        warning('validateImage:ConstantImage', ...
            'Image has constant finite intensity.');
    end
end
