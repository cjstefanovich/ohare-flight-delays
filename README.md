# ohare-flight-delays
I completed this project for a data mining class for my graduate degree in Fall 2025. It utilizes Amazon Web Services and PySpark for machine learning on a large dataset of flight records from Chicago O'Hare airport to predict if a flight will be delayed or not, and how long the delay might be.

Note that the code files included here are for a local version of my project.

The data came from the [Airline On-Time Performance Data database](https://www.transtats.bts.gov/Tables.asp?QO_VQ=EFD&QO_anzr=Nv4yv0r%20b0-gvzr%20cr4s14zn0pr%20Qn6n), which is provided by the Bureau of Transportation Statistics (U.S. Department of Transportation). I used the Reporting Carrier On-Time Performance (1987-present) data from this database. This dataset includes detailed information for every commercial flight in the U.S., reported monthly.

In AWS, I used the following pipeline for my project:
-	Unzip the monthly files locally, then upload the .csv files into an Amazon S3 bucket.
-	Launch an AWS EMR cluster configured with Apache Spark.
-	From within an EMR notebook/EMR Studio, use PySpark to read the .csv files from S3 and apply the same cleaning steps as in the local version, but optimized for distributed processing (Spark dataframes instead of Pandas dataframes).
-	Write the cleaned dataset back to S3 in Parquet format.
-	Create an external table in Athena that points to the Parquet data.
-	Pull the cleaned dataset from Athena directly into Spark on EMR for analysis.
-	Use PySpark to run exploratory queries and summary statistics.
-	Train a logistic regression model using Spark MLlib to predict DepDel15.
-	Compute accuracy, precision, recall, and AUC for the logistic regression model. Extract feature importances.
- Build a linear regression model (XGBoost) to predict DepDelay.
-	Compute MAE, RMSE, and R^2 for linear regression model. Extract feature importances.
-	Save final model(s) to S3 for future use.

The machine learning models, created with Spark MLlib, were: 
- A logistic regression classifier, which predicted an outcome of yes or no regarding whether a flight will likely be delayed by more than 15 minutes or not. Evaluation metrics included accuracy, precision, recall, ROC-AUC, a confusion matrix, and feature coefficients.
- A GBTRegressor, which predicted the number of minutes a flight might be delayed by. Evaluation metrics included MAE, RMSE, R^2, and feature importance.

Model results:
- The logistic regression model demonstrated strong discriminatory power with an ROC AUC of 0.9148, indicating high ability to distinguish delayed flights from on-time flights. Additional evaluation metrics included accuracy of 0.9141, precision of 0.8637, and recall of 0.7661. The confusion matrix showed 25,781 true negatives, 1,036 false positives, 2,004 false negatives, and 6,563 true positives, reflecting the model’s effectiveness in correctly identifying both delayed and non-delayed flights.
- The GBTRegressor model achieved an MAE of 16.412 minutes, an RMSE of 44.920 minutes, and an R^2 of 0.372. While less precise than the logistic model (unsurprising given the inherent variability in flight delays), this performance demonstrates the model’s ability to capture general patterns and major drivers of delays. Feature importances from the model highlighted several influential variables: the most important predictor was LateAircraftDelay (16.6%), followed by day of month (14.1%), reporting airline (13.3%), scheduled departure time (10.6%), and carrier delay (10.5%).
