function spatial = extractSpatialMetadata(info)

    spatial = struct();

    % Initialize fields
    spatial.CTYPE1 = [];
    spatial.CTYPE2 = [];

    spatial.CRVAL1 = [];
    spatial.CRVAL2 = [];

    spatial.CRPIX1 = [];
    spatial.CRPIX2 = [];

    spatial.CDELT1 = [];
    spatial.CDELT2 = [];

    % FITS keyword table
    keywords = info.PrimaryData.Keywords;

    % Search for each keyword
    spatial.CTYPE1 = getFITSKeyword(keywords, "CTYPE1");
    spatial.CTYPE2 = getFITSKeyword(keywords, "CTYPE2");

    spatial.CRVAL1 = getFITSKeyword(keywords, "CRVAL1");
    spatial.CRVAL2 = getFITSKeyword(keywords, "CRVAL2");

    spatial.CRPIX1 = getFITSKeyword(keywords, "CRPIX1");
    spatial.CRPIX2 = getFITSKeyword(keywords, "CRPIX2");

    spatial.CDELT1 = getFITSKeyword(keywords, "CDELT1");
    spatial.CDELT2 = getFITSKeyword(keywords, "CDELT2");

end


function value = getFITSKeyword(keywords, keyword)

    value = [];

    row = strcmpi(string(keywords(:,1)), keyword);

    if any(row)
        value = keywords{find(row,1),2};
    end

end