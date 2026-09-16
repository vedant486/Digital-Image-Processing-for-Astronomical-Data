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

disp(files)

for k = 1:length(files)

    images(k).name = names{k};
    images(k).filename = files{k};

    images(k).data = fitsread(files{k});
    images(k).info = fitsinfo(files{k});

    images(k).validation = validateImage(images(k).data);

end