# regbl-validation-maker
This code is a tool for the creation of validation datasets from the regbl database

# Overview

This code may help in the creation of validation datasets for the detection of building's year of construction based on swisstopo maps. It's important to state that this must be adpated to each case, but most important inputs are all in the beginning of the code. Changes may refer to 'being more rough' on the selection or not, or if too few/much maps are available. In general, this is a priori in selecting validation houses, but its main output should not be considered as a final result and requires human validation anyway.

# Copyright and License

**rgb-from-geotiff** - Huriel Reichel, Nils Hamel <br >

# Copyright and License
Copyright (c) 2020 Republic and Canton of Geneva

This program is licensed under the terms of the GNU GPLv3. Documentation and illustrations are licensed under the terms of the CC BY-NC-SA.

# Dependencies

Packages can all be installed with install.packages("packagename")

* rgdal
* raster
* ggplot2
* gridExtra
