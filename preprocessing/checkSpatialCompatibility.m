function report = checkSpatialCompatibility(images, tolerance)
%CHECKSPATIALCOMPATIBILITY Compare WCS/grid metadata across images.
%
% report = checkSpatialCompatibility(images)
% report = checkSpatialCompatibility(images, tolerance)
%
% This is an initial diagnostic. It does not claim scientific registration.
% It tells us whether the images share the same basic output grid.

    arguments
        images (1,:) struct
        tolerance (1,1) double = 1e-9
    end

    n = numel(images);
    metadata = repmat(struct(), 1, n);

    for i = 1:n
        metadata(i) = extractSpatialMetadata(images(i));
    end

    report = struct();
    report.metadata = metadata;
    report.sameDimensions = all(arrayfun(@(m) m.nRows == metadata(1).nRows && ...
        m.nCols == metadata(1).nCols, metadata));

    report.samePixelScale = all(arrayfun(@(m) abs(m.cdelt1 - metadata(1).cdelt1) <= tolerance && ...
        abs(m.cdelt2 - metadata(1).cdelt2) <= tolerance, metadata));

    report.sameReference = all(arrayfun(@(m) abs(m.crval1 - metadata(1).crval1) <= tolerance && ...
        abs(m.crval2 - metadata(1).crval2) <= tolerance, metadata));

    report.sameProjection = all(arrayfun(@(m) m.ctype1 == metadata(1).ctype1 && ...
        m.ctype2 == metadata(1).ctype2, metadata));

    report.gridCompatible = report.sameDimensions && report.samePixelScale && ...
        report.sameReference && report.sameProjection;
end
