function results = testPreprocessing(dataFolder)
%TESTPREPROCESSING Quick smoke test for the preprocessing pipeline.
%
% results = testPreprocessing("data/raw")

    arguments
        dataFolder (1,1) string = "data/raw"
    end

    files = dir(fullfile(dataFolder, "*.fits"));

    if isempty(files)
        error('testPreprocessing:NoFitsFiles', ...
            'No FITS files found in %s.', dataFolder);
    end

    results = repmat(struct(), 1, numel(files));

    for i = 1:numel(files)
        filename = fullfile(files(i).folder, files(i).name);
        out = preprocessImage(string(filename));

        results(i).file = files(i).name;
        results(i).size = size(out.rawData);
        results(i).invalidPixels = out.validation.invalidPixels;
        results(i).min = out.validation.min;
        results(i).max = out.validation.max;
        results(i).mean = out.validation.mean;
        results(i).std = out.validation.std;
    end

    fprintf('\nPreprocessing smoke test\n');
    fprintf('-------------------------\n');
    for i = 1:numel(results)
        fprintf('%-30s %4d x %-4d | invalid: %d\n', ...
            results(i).file, results(i).size(1), results(i).size(2), ...
            results(i).invalidPixels);
    end
end
