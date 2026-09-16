function spatial = extractSpatialMetadata(img)
%EXTRACTSPATIALMETADATA Extract common WCS/grid metadata from a FITS image.
%
% The values are metadata only; no registration/resampling is performed.

    spatial = struct();
    info = img.info;

    spatial.nRows = size(img.data, 1);
    spatial.nCols = size(img.data, 2);
    spatial.crval1 = getFitsKeyword(info, "CRVAL1", NaN);
    spatial.crval2 = getFitsKeyword(info, "CRVAL2", NaN);
    spatial.crpix1 = getFitsKeyword(info, "CRPIX1", NaN);
    spatial.crpix2 = getFitsKeyword(info, "CRPIX2", NaN);
    spatial.cdelt1 = getFitsKeyword(info, "CDELT1", NaN);
    spatial.cdelt2 = getFitsKeyword(info, "CDELT2", NaN);
    spatial.ctype1 = string(getFitsKeyword(info, "CTYPE1", ""));
    spatial.ctype2 = string(getFitsKeyword(info, "CTYPE2", ""));
    spatial.radesys = string(getFitsKeyword(info, "RADESYS", ""));
    spatial.equinox = getFitsKeyword(info, "EQUINOX", NaN);
end
