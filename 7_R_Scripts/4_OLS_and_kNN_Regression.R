#' ---
#' title: '4 OLS and kNN Regression'
#' knit: (function(inputFile, encoding) { 
#'       out_dir <- '~/Red_Wine_Quality/';
#'       rmarkdown::render(inputFile,
#'                         encoding=encoding, 
#'                         output_file='4_OLS_and_kNN_Regression.md') })
#' output:
#'   github_document:
#'     toc: true
#'     toc_depth: 2
#' ---
#' 
#' # Load packages and data
## -----------------------------------------------------------------------------
library(tidymodels)
df <- read.csv('~/Red_Wine_Quality/winequality-red.csv')
glimpse(df)

#' 
#' # Create train, validation and test split
## -----------------------------------------------------------------------------
set.seed(1)
wine_split <- initial_split(df, prop = 0.7)
wine_split

wine_train <- training(wine_split)
wine_train_val <- validation_split(wine_train, prop = 0.7)
wine_test  <- testing(wine_split)

#' 
#' - Data set is split into 70% training data and 30% test data
#' - Out of the 70% training data, 70% are used for model training and 30 % for parameter evaluation
#' 
#' # Linear Regression Model
#' ## Set model and workflow
## -----------------------------------------------------------------------------
linear_model <- linear_reg() |> set_engine("lm")
linear_model_recipe <- recipe(quality ~ alcohol + sulphates + volatile.acidity,
  data = wine_train)
linear_model_workflow <- workflow() |> add_model(linear_model) |> 
  add_recipe(linear_model_recipe)
linear_model_workflow

#' 
#' - Linear regression model is defined and combined into a workflow
#' 
#' # K-Nearest Neighbours Model
#' ## Set model and workflow
## -----------------------------------------------------------------------------
knn_model <- nearest_neighbor(neighbors = tune()) |> 
  set_mode("regression") |> set_engine("kknn")
knn_recipe <- recipe(quality ~ alcohol + sulphates + volatile.acidity,
  data = wine_train) |> step_normalize(all_predictors())
knn_workflow <- workflow() |> add_model(knn_model) |> 
  add_recipe(knn_recipe)
knn_workflow

#' 
#' - K-nearest neighbor model is defined and combined into a workflow
#' - Variables are normalized to not bias distance calculations of the model
#' - The model parameter K will be tuned on the validation set
#' 
#' ## Tune model
## -----------------------------------------------------------------------------
tune_grid <- tibble(neighbors = 1:20*2)
knn_tune <- knn_workflow |> tune_grid(resamples = wine_train_val, 
    grid = tune_grid, metrics = metric_set(rmse, mae, rsq_trad))
knn_tune_metrics <- knn_tune |> collect_metrics()

#' 
#' - Tune grid is defined as 2-40 in steps of 2
#' - Grid search is performed to evaluate model performance with different hyper parameters
#' 
#' ## Evaluation of tuning results
## -----------------------------------------------------------------------------
knn_tune_metrics |> 
  ggplot(aes(x = neighbors, y = mean, colour = .metric)) + geom_point() + 
  geom_line() + facet_wrap(~ .metric, scales = "free_y")
knn_tune |> show_best("rmse", n = 5) 
knn_best_model <- select_best(knn_tune, metric = "rmse")
knn_workflow_final <- knn_workflow |> 
  finalize_workflow(knn_best_model)

#' 
#' - Model performance is evaluated on the mean absolute error, the root mean squared error and R²
#' - Best RMSE performance can be achieved at k=26
#' - Best tuning parameter is included into the workflow
#' 
#' # Compare model performances
## -----------------------------------------------------------------------------
linear_model_last_fit <- linear_model_workflow |> 
  last_fit(wine_split, metrics = metric_set(rmse, mae, rsq_trad))
linear_model_metrics <- linear_model_last_fit |> collect_metrics()

knn_last_fit <- knn_workflow_final |> 
  last_fit(wine_split, metrics = metric_set(rmse, mae, rsq_trad))
knn_metrics <- knn_last_fit |> collect_metrics()

linear_model_metrics <- linear_model_metrics |> select(-.estimator, -.config) |> 
  mutate(model = "linear regression")
knn_metrics <- knn_metrics |> select(-.estimator, -.config) |> 
  mutate(model = "k-nearest neighbors")
linear_model_metrics |> bind_rows(knn_metrics) |> 
  pivot_wider(names_from = .metric, values_from = .estimate)

#' 
#' - Models are applied to test data and resulting performances are compared
#' - K-nearest neighbors is the better model
#'   - Lower errors of predictions
#'   - It can explain more variation of the dependent variable
#'   
#' 
## -----------------------------------------------------------------------------
# Export R Script
library(knitr)
knitr::purl('~/Red_Wine_Quality/6_R_Markdown/4_OLS_and_kNN_Regression.Rmd', 
            '~/Red_Wine_Quality/7_R_Scripts/4_OLS_and_kNN_Regression.R',
  documentation = 2, quiet = TRUE)

