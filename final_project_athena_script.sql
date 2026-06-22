CREATE EXTERNAL TABLE IF NOT EXISTS flight_analytics.ord_flight_data (
    DayofMonth INT,
    Month INT,
    DayOfWeek INT,
    Reporting_Airline STRING,
    Dest STRING,
    CRSDepTime_minutes INT,
    DepDelay DOUBLE,
    DepDel15 INT,
    CRSElapsedTime DOUBLE,
    Distance DOUBLE,
    CarrierDelay INT,
    WeatherDelay INT,
    NASDelay INT,
    SecurityDelay INT,
    LateAircraftDelay INT
)
STORED AS PARQUET
LOCATION 's3://final-project-bucket/data/flight_data_parquet/';