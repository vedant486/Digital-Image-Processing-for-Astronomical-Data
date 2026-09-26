clear;
clc;
close all;

%% File paths

dataDir = "Input Images Centaurus A/";

files = {
    fullfile(dataDir, "Centaurus_A_DSS.fits")
    fullfile(dataDir, "Centaurus_A_DSS2_R.fits")
    fullfile(dataDir, "Centaurus_A_WISE12.fits")
    fullfile(dataDir, "Centaurus_A_RASS_CNT.fits")
};

names = {
    "DSS"
    "DSS2_R"
    "WISE12"
    "RASS"
};

%% Read FITS files

images = struct([]);

%disp(files)

for k = 1:length(files)

    images(k).name = names{k};
    images(k).filename = files{k};

    images(k).data = fitsread(files{k});
    images(k).info = fitsinfo(files{k});

    images(k).validation = validateImage(images(k).data);
    %displayImage(images(k).data, images(k).name);
    %displayHistogram(images(k).data, images(k).name);

    [images(k).cleanData, images(k).validMask] = createValidMask(images(k).data);


    % Extract spatial metadata
    images(k).spatial = extractSpatialMetadata(images(k).info);

    %Standardize spatial grid
    images(k).standardizedImage = standardizeSpatialGrid(images(k).cleanData, [300 300]);

    % Normalize image
    images(k).normalizedData = normalizeImage(images(k).standardizedImage, "percentile");
    %% Frequency-domain analysis
    [images(k).DFT, images(k).frequencyMagnitude, images(k).frequencySpectrum] = dftTransform(images(k).normalizedData);
    %displayImage(images(k).DFT, images(k).name + " - DFT");
    %displayImage(images(k).frequencyMagnitude, images(k).name + " - DFT Magnitude");
    %displayImage(images(k).frequencySpectrum, images(k).name + " - DFT Spectrum");

end

%% Intensity Transformation
gamma = 1.25;
for k = 1:length(images)

    images(k).logData = logTransform(images(k).normalizedData);
    %displayImage(images(k).logData,images(k).name + " - Log Transform");

    images(k).gammaData = gammaTransform(images(k).normalizedData, gamma);
    %displayImage(images(k).gammaData, images(k).name + " - Gamma Transform");

    images(k).contrastData = contrastStretch(images(k).normalizedData, 1, 99);
    %displayImage(images(k).contrastData, [images(k).name ' - Contrast Stretch']);

    images(k).filteredGaussian = spatialFilter(images(k).normalizedData, "gaussian", 1.5);
    %displayImage(images(k).filteredGaussian, [images(k).name ' - Guassian Filter']);
    
    images(k).FidealFiltered = frequencyFilter(images(k).DFT, "ideal", 30);
    %displayImage(images(k).FidealFiltered, [images(k).name ' - Ideal Filter (Frequency)']);
    
    images(k).FgaussianFiltered = frequencyFilter(images(k).DFT, "gaussian", 30);
    %displayImage(images(k).FgaussianFiltered, [images(k).name ' - Gaussian Filter (Frequency)']);
    
    images(k).FbutterworthFiltered = frequencyFilter(images(k).DFT, "butterworth", [30,2]);
    %displayImage(images(k).FbutterworthFiltered, [images(k).name ' - Butterworth Filter (Frequency)']);

end