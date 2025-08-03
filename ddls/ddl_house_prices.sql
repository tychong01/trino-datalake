CREATE TABLE IF NOT EXISTS hive.housing.house_prices (
    price BIGINT,
    area BIGINT,
    bedrooms BIGINT,
    bathrooms BIGINT,
    stories BIGINT,
    mainroad VARCHAR,
    guestroom VARCHAR,
    basement VARCHAR,
    hotwaterheating VARCHAR,
    airconditioning VARCHAR,
    parking BIGINT,
    prefarea VARCHAR,
    furnishingstatus VARCHAR
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://datalake/housing/'
);