function value = getFitsKeyword(info, keyword, defaultValue)
%GETFITSKEYWORD Read a FITS header keyword from fitsinfo output.
%
% value = getFitsKeyword(info, keyword, defaultValue)
%
% This helper keeps header parsing isolated from the rest of the pipeline.

    arguments
        info (1,1) struct
        keyword (1,1) string
        defaultValue = []
    end

    value = defaultValue;

    if ~isfield(info, 'PrimaryData') || ...
            ~isfield(info.PrimaryData, 'Keywords')
        return;
    end

    keys = info.PrimaryData.Keywords;
    if isempty(keys)
        return;
    end

    % MATLAB FITS keywords are returned as an N-by-3 cell array in common
    % releases: {keyword, value, comment}.
    for k = 1:size(keys, 1)
        key = string(keys{k, 1});
        if strcmpi(strtrim(key), strtrim(keyword))
            value = keys{k, 2};
            return;
        end
    end
end
