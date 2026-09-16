function img = readFitsImage(filename)
%READFITSIMAGE Read an astronomical FITS image and its metadata.
%
% img = readFitsImage(filename)
%
% Returns a struct with:
%   img.data        - original FITS image data (single precision)
%   img.validMask   - finite-valued pixel mask
%   img.info        - FITS metadata returned by fitsinfo
%   img.filename    - input filename
%   img.name        - file name only
%
% The original numerical values are preserved. No enhancement or
% normalization is performed here.

    arguments
        filename (1,1) string
    end

    if ~isfile(filename)
        error('readFitsImage:FileNotFound', ...
            'FITS file not found: %s', filename);
    end

    info = fitsinfo(filename);
    data = fitsread(filename, 'image');

    if isempty(data) || ~isnumeric(data)
        error('readFitsImage:InvalidImage', ...
            'No numeric primary image data found in %s.', filename);
    end

    data = single(data);

    img = struct();
    img.data = data;
    img.validMask = isfinite(data);
    img.info = info;
    img.filename = filename;
    img.name = string(filename);
end
