# Multi-Wavelength Astronomical Image Processing

Digital Image Processing course project using Centaurus A observations from multiple electromagnetic regimes.

## Project idea

Use classical digital image-processing techniques to preprocess, enhance, transform,
and fuse astronomical observations from optical, infrared, X-ray, and radio surveys.
The goal is to reveal spatial structures and relationships that are difficult to see
in an individual wavelength image.

## Current architecture

```text
FITS observations
      |
      v
Preprocessing
  - FITS ingestion
  - data validation
  - invalid-pixel handling
  - intensity preparation
  - spatial/grid checks
      |
      v
DIP modules
  - transforms
  - enhancement/restoration
  - morphology
  - color/false-color
      |
      v
Image fusion
      |
      v
Visualization + quantitative analysis
```

## Repository structure

```text
preprocessing/   Input handling and standardization
enhancement/     Spatial/frequency enhancement and restoration
transforms/      DFT, DCT, Haar, SVD, etc.
morphology/      Morphological operations and feature extraction
fusion/          Multi-wavelength fusion methods
visualization/   Plots and false-color representations
analysis/        Quantitative comparison metrics
```

## Preprocessing design rule

The preprocessing stage prepares the observations for DIP. It should not perform the
main course techniques that we intend to study experimentally, such as histogram
equalization, DFT filtering, sharpening, or morphological processing.

The original FITS numerical values are preserved. A separate normalized image is
created for downstream image-processing/visualization use.

## Running the project

1. Put FITS files in `data/raw/`.
2. Open MATLAB in the repository root.
3. Run `main.m`.
4. The script loads each FITS image, validates it, prepares a normalized working image,
   and checks whether the requested output grids are compatible.

## Git workflow

```bash
git init
git add .
git commit -m "Add modular FITS preprocessing pipeline"
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```
