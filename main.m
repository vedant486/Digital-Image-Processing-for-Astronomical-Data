%% Astronomical DIP Project
% Main orchestration script.
% The main script should call modules rather than contain their internals.

clear;
clc;
close all;

addpath(genpath("preprocessing"));

%% Input data
rawFolder = "data/raw";
fitsFiles = dir(fullfile(rawFolder, "*.fits"));

if isempty(fitsFiles)
    error('main:NoInputData', ...
        'Put the Centaurus A FITS files into %s before running the pipeline.', rawFolder);
end

%% Preprocess each wavelength image
images = repmat(struct(), 1, numel(fitsFiles));

for k = 1:numel(fitsFiles)
    filename = fullfile(fitsFiles(k).folder, fitsFiles(k).name);
    fprintf('Processing: %s\n', fitsFiles(k).name);
    images(k) = preprocessImage(string(filename));
end

%% Compare the requested output grids
spatialReport = checkSpatialCompatibility(images);

disp('Spatial compatibility:');
disp(spatialReport);

%% Quick visual inspection
figure('Name', 'Preprocessing Preview');
for k = 1:numel(images)
    subplot(ceil(sqrt(numel(images))), ceil(sqrt(numel(images))), k);
    imagesc(images(k).normalized);
    axis image off;
    colormap gray;
    title(images(k).name, 'Interpreter', 'none');
    colorbar;
end

%% Next modules will be called here:
% enhancement
% transforms
% morphology
% fusion
% visualization
% analysis
