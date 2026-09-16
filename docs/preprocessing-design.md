# Preprocessing module design

## Inputs

One FITS image per survey/wavelength regime.

## Outputs

Each input becomes a MATLAB struct containing:

- `rawData`: original floating-point image values
- `workingData`: finite working copy for numerical algorithms
- `normalized`: percentile-clipped image in [0, 1]
- `validMask`: pixels that were finite in the source
- `validation`: basic quality statistics
- `spatial`: basic WCS/grid metadata
- `info`: complete `fitsinfo` metadata

## Functions

- `readFitsImage.m` — FITS ingestion only
- `validateImage.m` — quality checks only
- `prepareImage.m` — invalid-pixel handling + intensity normalization
- `getFitsKeyword.m` — small WCS/header helper
- `extractSpatialMetadata.m` — extract common spatial metadata
- `checkSpatialCompatibility.m` — compare grids across surveys
- `preprocessImage.m` — orchestrator for one file

## What is intentionally not here yet

Do not add the following to preprocessing until the experimental DIP stage is defined:

- histogram equalization
- Gaussian/median/average denoising as the main experiment
- DFT low/high-pass filtering
- sharpening
- morphology
- fusion

These will become separate modules so their effect can be measured independently.
