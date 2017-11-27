# senseBox - A **R**-package for the senseBox API

[![Build Status](https://travis-ci.org/JohannesFriedrich/HypeRIMU.svg?branch=master)](https://travis-ci.org/JohannesFriedrich/HypeRIMU)
[![Build status](https://ci.appveyor.com/api/projects/status/lm7jn3t558yxveve?svg=true)](https://ci.appveyor.com/project/JohannesFriedrich/hyperimu)
[![Coverage Status](https://codecov.io/gh/JohannesFriedrich/HypeRIMU/branch/master/graph/badge.svg)](https://codecov.io/gh/JohannesFriedrich/HypeRIMU)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)


## Installation and usage

```r
if(!require("devtools"))
  install.packages("devtools")
devtools::install_github("JohannesFriedrich/senseBox@master")
```

Download all available senseBoxes

```r
library(senseBox)
list <- get_senseBox_Ids()
Ids <- list$senseBoxId[1:2]
```

Get some information about the senseBoxId

```r
Ids <- list$senseBoxId[1:2]

```
