# Preprocessing Module Design

## 1. Purpose

The preprocessing module converts raw astronomical FITS observations into a consistent MATLAB representation suitable for the subsequent Digital Image Processing (DIP) stages.

The module is designed to be survey-independent and should work with FITS images from different astronomical surveys and wavelength regimes.

The preprocessing stage is limited to:

- FITS data ingestion
- Basic data validation
- Invalid-pixel handling
- Intensity normalization
- Extraction of spatial/WCS metadata
- Checking spatial compatibility between images

Image enhancement and analysis techniques are deliberately kept outside this module and will be implemented as separate DIP stages.


## 2. Inputs

The module accepts one FITS image per survey or wavelength regime.

For the current experiment, the input datasets are:

| Dataset | Survey / Wavelength Regime |
| `Centaurus_A_DSS.fits` | DSS optical |
| `Centaurus_A_DSS2_R.fits` | DSS2 red optical |
| `Centaurus_A_WISE12.fits` | WISE infrared |
| `Centaurus_A_RASS_CNT.fits` | ROSAT X-ray |

The preprocessing module should not depend on these specific files. They are used as the current test dataset.

## 3. Outputs

Each input FITS image is represented by one element of the MATLAB `images` structure.

```text
images(k)
│
├── name
├── data
├── normalized
├── validMask
├── validation
├── spatial
└── info