#' ---
#' title: "3 Check OLS Assumptions"
#' knit: (function(inputFile, encoding) { 
#'       out_dir <- '~/Red_Wine_Quality/';
#'       rmarkdown::render(inputFile,
#'                         encoding=encoding, 
#'                         output_file='3_Check_OLS_Assumptions.md') })
#' output:
#'   github_document:
#'     toc: true
#'     toc_depth: 2
#' ---
#' 
#' # Load packages and data
## -----------------------------------------------------------------------------
library(tidyverse)
library(stargazer)
library(AER)
df <- read.csv('~/Red_Wine_Quality/winequality-red.csv')
glimpse(df)

#' 
#' # Recreate Model
## -----------------------------------------------------------------------------
model2 <- lm(quality ~ alcohol + sulphates + citric.acid + volatile.acidity + 
  sulphates*citric.acid + citric.acid*alcohol + citric.acid*volatile.acidity
  , data=df)
stargazer(model2, intercept.bottom=FALSE, type="text")

#' 
#' 
#' # Check Model Assumptions
#' ## Check Normality
## -----------------------------------------------------------------------------
hist(df$quality)

shapiro.test(df$quality)

#' 
#' - Shapiro test: Null hypothesis has to be rejected -> Not normally distributed
#' - Quality does not seem to follow a normal distribution
#' - Visual impression does not seem too far off
#' 
#' ### trying to restore normality
## -----------------------------------------------------------------------------
shapiro.test(log(df$quality))
shapiro.test((df$quality)^(1/2))
shapiro.test(1/(df$quality))

#' 
#' - Transforming quality by log, square root or inverse does not restore normality
#' 
#' ## Check Heteroskedasticity
## -----------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(model2)
bptest(model2)

#' 
#' - QQ Plot hints toward heteroskedasticity
#' - Breusch-Pagan test: Null hypothesis has to be rejected -> Heteroskedastic
#' - Use robust standard errors to not make biased interpretations of variable significance
#' 
## -----------------------------------------------------------------------------
seBasic <- sqrt(diag(vcov(model2)))
seWhite <- sqrt(diag(vcovHC(model2, type="HC0")))

stargazer(model2, model2,  se=list(seBasic, seWhite), intercept.bottom=FALSE, type="text")

#' 
#' - Using White robust standard errors lowers significance of citric.acid interactions -> citric acid could potentially be excluded from the model, in case not much explanatory power is lost
#' 
#' 
#' ## Test simpler model
## -----------------------------------------------------------------------------
model3 <- lm(quality ~ alcohol + sulphates +  volatile.acidity, data=df)
seWhite <- sqrt(diag(vcovHC(model3, type="HC0")))
stargazer(model3, se=list(seWhite), intercept.bottom=FALSE, type="text")

#' 
#' - Model barely loses R², but becomes much more simple
#' - Additionally, all parameters are now highly significant
#' 
#' ## Check Multicollinearity
## -----------------------------------------------------------------------------
# Variance Inflation Factors
vif(mod=model3)
# Tolerances
1 / vif(mod=model3)

#' 
#' - Variance Inflation Factors are below 4 and Tolerances are above 0.25 -> Points toward absence of multicollinearity
#' 
## -----------------------------------------------------------------------------
# Export R Script
library(knitr)
knitr::purl('~/Red_Wine_Quality/1_R_Markdown/3_Check_OLS_Assumptions.Rmd', 
            '~/Red_Wine_Quality/2_R_Scripts/3_Check_OLS_Assumptions.R',
  documentation = 2, quiet = TRUE)

