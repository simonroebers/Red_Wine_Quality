# Red Wine Quality Analysis

This GitHub repository showcases my proficiency in data analytics using **R**. The repository focuses on a **regression** problem, where the goal is to **infer** about and **predict** the quality of red wine based on several factors such as acidity, alcohol content, and sugar levels. The dataset used for this exercise is publicly available on Kaggle (https://www.kaggle.com/uciml/red-wine-quality-cortez-et-al-2009) and contains information on the quality of red wine.

The first step in the project is to perform **exploratory data analysis** (EDA), where I gain insights into the data by generating descriptive statistics and creating informative visualizations. I also create a **directed acyclic graph** (DAG) to better understand the relationships between different variables.

Next, an **OLS regression model** is created for inference. The model is used to identify which variables have a significant impact on the quality of red wine. The model's **assumptions** are also checked to ensure that it is valid.

The OLS model is then used for prediction and compared to a **knn model**. In addition, a one hidden layer **neural network** is created for prediction. I evaluate the performance of each model using metrics such as root mean squared error (RMSE), mean absolute error (MAE), and R-squared.

This repository demonstrates my skills in:
- R programming and the use of libraries such as tidyverse and tidymodels for data analysis and modeling.
- Understanding and implementation of exploratory data analysis (EDA) to gain insights into the data.
- Apply various regression algorithms such as OLS, KNN, and neural networks.
- Validate model assumptions to allow for robust inference about features.
- Ability to evaluate the performance of different models and choose the best one for the problem.

Included Notebooks:
- [1_EDA](1_EDA.md)
- [2_OLS_Model](2_OLS_Model.md)
- [3_Check_OLS_Assumptions](3_Check_OLS_Assumptions.md)
- [4_OLS_and_kNN_Regression](4_OLS_and_kNN_Regression.md)
- [5_Neural_Network](5_Neural_Network.md)
