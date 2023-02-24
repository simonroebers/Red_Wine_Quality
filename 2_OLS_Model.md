2_OLS_Model
================

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
glimpse(df)
```

    ## Rows: 36,275
    ## Columns: 19
    ## $ Booking_ID                           <chr> "INN00001", "INN00002", "INN00003…
    ## $ no_of_adults                         <int> 2, 2, 1, 2, 2, 2, 2, 2, 3, 2, 1, …
    ## $ no_of_children                       <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ no_of_weekend_nights                 <int> 1, 2, 2, 0, 1, 0, 1, 1, 0, 0, 1, …
    ## $ no_of_week_nights                    <int> 2, 3, 1, 2, 1, 2, 3, 3, 4, 5, 0, …
    ## $ type_of_meal_plan                    <chr> "Meal Plan 1", "Not Selected", "M…
    ## $ required_car_parking_space           <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ room_type_reserved                   <chr> "Room_Type 1", "Room_Type 1", "Ro…
    ## $ lead_time                            <int> 224, 5, 1, 211, 48, 346, 34, 83, …
    ## $ arrival_year                         <int> 2017, 2018, 2018, 2018, 2018, 201…
    ## $ arrival_month                        <int> 10, 11, 2, 5, 4, 9, 10, 12, 7, 10…
    ## $ arrival_date                         <int> 2, 6, 28, 20, 11, 13, 15, 26, 6, …
    ## $ market_segment_type                  <chr> "Offline", "Online", "Online", "O…
    ## $ repeated_guest                       <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ no_of_previous_cancellations         <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ no_of_previous_bookings_not_canceled <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ avg_price_per_room                   <dbl> 65.00, 106.68, 60.00, 100.00, 94.…
    ## $ no_of_special_requests               <int> 0, 1, 0, 0, 0, 1, 1, 1, 1, 3, 0, …
    ## $ booking_status                       <chr> "Not_Canceled", "Not_Canceled", "…