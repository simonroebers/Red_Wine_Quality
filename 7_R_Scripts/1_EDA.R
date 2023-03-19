#' ---
#' title: "1 Exploratory Data Analysis"
#' knit: (function(inputFile, encoding) { 
#'       out_dir <- '~/Red_Wine_Quality/';
#'       rmarkdown::render(inputFile,
#'                         encoding=encoding, 
#'                         output_file='1_EDA.md') })
#' output:
#'   github_document:
#'     toc: true
#'     toc_depth: 2
#' ---
#' 
#' # Load packages and data
## -----------------------------------------------------------------------------
library(tidyverse)
library(skimr)
library(corrplot)
library(dagitty)
df <- read.csv('~/Red_Wine_Quality/winequality-red.csv')
glimpse(df)

#' 
#' # Summary Statistics
## -----------------------------------------------------------------------------
df |> skim()

#' 
#' - Data set is already clean
#' - Features are all numeric
#' 
#' # Create features
## -----------------------------------------------------------------------------
df$quality_fct <- as.factor(df$quality)

#' 
#' 
#' # Correlations
## -----------------------------------------------------------------------------
df |> select(where(is.numeric)) |> cor() |> 
  corrplot(method = "color", type = "upper", diag = FALSE, tl.cex = 0.8)

#' 
#' - Alcohol, sulphates, and citric acid appear to positively correlate with the quality
#' - The volatile acidity seems to have a negative correlation
#' 
#' 
#' # Explore some features
#' 
#' ## Wine Quality
## -----------------------------------------------------------------------------
ggplot() +
  geom_histogram(data = df, aes(x = quality), bins = 6, color = 'black', 
                 fill = 'white') +
theme_bw(base_size = 14)

#' 
#' - The outcome variable is very unbalanced
#' - Wine quality is largely 5 and 6
#' 
#' ## Alcohol
## -----------------------------------------------------------------------------
ggplot(df, aes(x = alcohol, fill = quality_fct)) +
  geom_density(alpha = 0.5) +
theme_bw(base_size = 14)

#' 
#' - The level of alcohol is greater with higher quality
#' 
#' 
#' ## Volatile acidity
## -----------------------------------------------------------------------------
ggplot(df, aes(x = quality_fct, y = volatile.acidity, fill = quality_fct)) +
  geom_violin(alpha = 0.5) +
  guides(fill="none") +
  theme_bw(base_size = 14)

#' 
#' - The aciditiy of higher quality wines is less volatile
#' 
#' ## Sulphates
## -----------------------------------------------------------------------------
ggplot() +
  geom_point(data=df, aes(x = quality,  y = sulphates, group = quality_fct, 
    color = quality_fct),position = position_dodge2(w = 0.75)) +
  geom_smooth(data=df, aes(x = quality,  y = sulphates),
              method="lm", formula = y ~ x) +
  theme_bw(base_size = 14) + 
  scale_x_continuous(breaks = c(3:8))


#' 
#' - Higher quality wine tends to have on average more sulphates
#' 
#' ## Citric acid
## -----------------------------------------------------------------------------
ggplot(df, aes(x = citric.acid,  y = quality_fct, color = quality_fct)) +
  geom_boxplot() +
  stat_summary(fun = "mean", geom = "point", shape = 2, size = 2, color = "black") +
  theme_bw(base_size = 14)

#' 
#' - The same seems to hold true for the citric acid
#' 
#' # DAG
#' 
## -----------------------------------------------------------------------------
dag <- dagitty('
dag {
alcohol -> quality
sulphates -> quality
sulphates -> citric.acid
volatile.acidity -> quality
citric.acid -> quality
citric.acid -> volatile.acidity
citric.acid -> alcohol
}
')
plot(graphLayout(dag))

#' 
#' - Correlation does not equal causation
#' - Similarities are assumed here for ease of application
#' - I don't have domain knowledge about wine, this is my best guess
#' 
## -----------------------------------------------------------------------------
# Export R Script
library(knitr)
knitr::purl('~/Red_Wine_Quality/6_R_Markdown/1_EDA.Rmd',
            '~/Red_Wine_Quality/7_R_Scripts/1_EDA.R',
  documentation = 2, quiet = TRUE)

#' 
