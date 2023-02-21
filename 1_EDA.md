1_EDA
================
Simon Roebers

- <a href="#load-packages-and-data" id="toc-load-packages-and-data">Load
  packages and data</a>

# Load packages and data

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.4.1     ✔ purrr   1.0.1
    ## ✔ tibble  3.1.8     ✔ dplyr   1.1.0
    ## ✔ tidyr   1.3.0     ✔ stringr 1.5.0
    ## ✔ readr   2.1.4     ✔ forcats 1.0.0
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(stargazer)
```

    ## 
    ## Please cite as: 
    ## 
    ##  Hlavac, Marek (2022). stargazer: Well-Formatted Regression and Summary Statistics Tables.
    ##  R package version 5.2.3. https://CRAN.R-project.org/package=stargazer

``` r
df <- read.csv('Hotel Reservations.csv')
```

``` r
stargazer(df, type='text')
```

    ## 
    ## ============================================================================
    ## Statistic                              N      Mean    St. Dev.  Min    Max  
    ## ----------------------------------------------------------------------------
    ## no_of_adults                         36,275   1.845    0.519     0      4   
    ## no_of_children                       36,275   0.105    0.403     0     10   
    ## no_of_weekend_nights                 36,275   0.811    0.871     0      7   
    ## no_of_week_nights                    36,275   2.204    1.411     0     17   
    ## required_car_parking_space           36,275   0.031    0.173     0      1   
    ## lead_time                            36,275  85.233    85.931    0     443  
    ## arrival_year                         36,275 2,017.820  0.384   2,017  2,018 
    ## arrival_month                        36,275   7.424    3.070     1     12   
    ## arrival_date                         36,275  15.597    8.740     1     31   
    ## repeated_guest                       36,275   0.026    0.158     0      1   
    ## no_of_previous_cancellations         36,275   0.023    0.368     0     13   
    ## no_of_previous_bookings_not_canceled 36,275   0.153    1.754     0     58   
    ## avg_price_per_room                   36,275  103.424   35.089  0.000 540.000
    ## no_of_special_requests               36,275   0.620    0.786     0      5   
    ## ----------------------------------------------------------------------------
