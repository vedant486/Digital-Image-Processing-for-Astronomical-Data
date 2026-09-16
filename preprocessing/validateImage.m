function report = validateImage(img)

    report.size = size(img);
    report.class = class(img);

    report.hasNaN = any(isnan(img(:)));
    report.hasInf = any(isinf(img(:)));

    report.min = min(img(:), [], "omitnan"); %omits any pixel with value NaN
    report.max = max(img(:), [], "omitnan");
    report.mean = mean(img(:), "omitnan");
    report.std = std(img(:), 0, "omitnan");

end