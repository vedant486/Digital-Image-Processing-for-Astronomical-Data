function out = preprocessImage(filename, clipPercentiles)
%PREPROCESSIMAGE Run the complete preprocessing block for one FITS image.
%
% out = preprocessImage(filename)
% out = preprocessImage(filename, [1 99])

    arguments
        filename (1,1) string
        clipPercentiles (1,2) double = [1 99]
    end

    img = readFitsImage(filename);
    report = validateImage(img);
    out = prepareImage(img, clipPercentiles);
    out.validation = report;
    out.spatial = extractSpatialMetadata(out);
end
