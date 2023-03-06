2 OLS Regression Model
================

- <a href="#load-packages-and-data" id="toc-load-packages-and-data">Load
  packages and data</a>
- <a href="#ols-models" id="toc-ols-models">OLS Models</a>
- <a href="#standardized-regression-coefficients"
  id="toc-standardized-regression-coefficients">Standardized Regression
  Coefficients</a>

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
library(lm.beta)
df <- read.csv('~/Red_Wine_Quality/winequality-red.csv')
glimpse(df)
```

    ## Rows: 1,599
    ## Columns: 12
    ## $ fixed.acidity        <dbl> 7.4, 7.8, 7.8, 11.2, 7.4, 7.4, 7.9, 7.3, 7.8, 7.5…
    ## $ volatile.acidity     <dbl> 0.700, 0.880, 0.760, 0.280, 0.700, 0.660, 0.600, …
    ## $ citric.acid          <dbl> 0.00, 0.00, 0.04, 0.56, 0.00, 0.00, 0.06, 0.00, 0…
    ## $ residual.sugar       <dbl> 1.9, 2.6, 2.3, 1.9, 1.9, 1.8, 1.6, 1.2, 2.0, 6.1,…
    ## $ chlorides            <dbl> 0.076, 0.098, 0.092, 0.075, 0.076, 0.075, 0.069, …
    ## $ free.sulfur.dioxide  <dbl> 11, 25, 15, 17, 11, 13, 15, 15, 9, 17, 15, 17, 16…
    ## $ total.sulfur.dioxide <dbl> 34, 67, 54, 60, 34, 40, 59, 21, 18, 102, 65, 102,…
    ## $ density              <dbl> 0.9978, 0.9968, 0.9970, 0.9980, 0.9978, 0.9978, 0…
    ## $ pH                   <dbl> 3.51, 3.20, 3.26, 3.16, 3.51, 3.51, 3.30, 3.39, 3…
    ## $ sulphates            <dbl> 0.56, 0.68, 0.65, 0.58, 0.56, 0.56, 0.46, 0.47, 0…
    ## $ alcohol              <dbl> 9.4, 9.8, 9.8, 9.8, 9.4, 9.4, 9.4, 10.0, 9.5, 10.…
    ## $ quality              <int> 5, 5, 5, 6, 5, 5, 5, 7, 7, 5, 5, 5, 5, 5, 5, 5, 7…

# OLS Models

``` r
model1 <- lm(quality ~ alcohol + sulphates + citric.acid + 
  volatile.acidity, data=df)
model2 <- lm(quality ~ alcohol + sulphates + citric.acid + volatile.acidity + 
  sulphates*citric.acid + citric.acid*alcohol + citric.acid*volatile.acidity
  , data=df)
stargazer(model1, model2, intercept.bottom=FALSE, type='text')
```

    ## 
    ## ================================================================================
    ##                                              Dependent variable:                
    ##                              ---------------------------------------------------
    ##                                                    quality                      
    ##                                         (1)                       (2)           
    ## --------------------------------------------------------------------------------
    ## Constant                             2.646***                  2.919***         
    ##                                       (0.201)                   (0.331)         
    ##                                                                                 
    ## alcohol                              0.309***                  0.251***         
    ##                                       (0.016)                   (0.027)         
    ##                                                                                 
    ## sulphates                            0.696***                  1.193***         
    ##                                       (0.103)                   (0.192)         
    ##                                                                                 
    ## citric.acid                           -0.079                    -1.283          
    ##                                       (0.104)                   (0.965)         
    ##                                                                                 
    ## volatile.acidity                     -1.265***                 -1.235***        
    ##                                       (0.113)                   (0.177)         
    ##                                                                                 
    ## sulphates:citric.acid                                          -1.324***        
    ##                                                                 (0.457)         
    ##                                                                                 
    ## alcohol:citric.acid                                             0.194**         
    ##                                                                 (0.076)         
    ##                                                                                 
    ## citric.acid:volatile.acidity                                     0.100          
    ##                                                                 (0.551)         
    ##                                                                                 
    ## --------------------------------------------------------------------------------
    ## Observations                           1,599                     1,599          
    ## R2                                     0.336                     0.343          
    ## Adjusted R2                            0.334                     0.340          
    ## Residual Std. Error              0.659 (df = 1594)         0.656 (df = 1591)    
    ## F Statistic                  201.777*** (df = 4; 1594) 118.508*** (df = 7; 1591)
    ## ================================================================================
    ## Note:                                                *p<0.1; **p<0.05; ***p<0.01

- Base model without interaction effects shows that citric acid does not
  have a statistically significant impact on quality
- Second model indicates that interactions of citric acid with sulphates
  and alcohol are significant
- Model performance does however not increase meaningfully
- Around 33 % of variation in quality can be described with these
  regressions

# Standardized Regression Coefficients

``` r
summary(lm.beta(model2))
```

    ## 
    ## Call:
    ## lm(formula = quality ~ alcohol + sulphates + citric.acid + volatile.acidity + 
    ##     sulphates * citric.acid + citric.acid * alcohol + citric.acid * 
    ##     volatile.acidity, data = df)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -2.69486 -0.39041 -0.07031  0.44455  2.33952 
    ## 
    ## Coefficients:
    ##                              Estimate Standardized Std. Error t value Pr(>|t|)
    ## (Intercept)                   2.91935           NA    0.33141   8.809  < 2e-16
    ## alcohol                       0.25100      0.33122    0.02671   9.397  < 2e-16
    ## sulphates                     1.19283      0.25037    0.19217   6.207 6.87e-10
    ## citric.acid                  -1.28281     -0.30944    0.96542  -1.329   0.1841
    ## volatile.acidity             -1.23520     -0.27388    0.17745  -6.961 4.92e-12
    ## sulphates:citric.acid        -1.32351     -0.26638    0.45660  -2.899   0.0038
    ## alcohol:citric.acid           0.19401      0.51074    0.07556   2.568   0.0103
    ## citric.acid:volatile.acidity  0.09955      0.01109    0.55140   0.181   0.8568
    ##                                 
    ## (Intercept)                  ***
    ## alcohol                      ***
    ## sulphates                    ***
    ## citric.acid                     
    ## volatile.acidity             ***
    ## sulphates:citric.acid        ** 
    ## alcohol:citric.acid          *  
    ## citric.acid:volatile.acidity    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.6562 on 1591 degrees of freedom
    ## Multiple R-squared:  0.3427, Adjusted R-squared:  0.3398 
    ## F-statistic: 118.5 on 7 and 1591 DF,  p-value: < 2.2e-16

- Standardizing coefficients allows for direct comparison of effect size
- Alcohol seems to have the highest direct impact on quality

``` r
# Export R Script
library(knitr)
knitr::purl('~/Red_Wine_Quality/1_R_Markdown/2_OLS_Model.Rmd', 
            '~/Red_Wine_Quality/2_R_Scripts/2_OLS_Model.R',
  documentation = 2, quiet = TRUE)
```

    ## [1] "~/Red_Wine_Quality/2_R_Scripts/2_OLS_Model.R"
