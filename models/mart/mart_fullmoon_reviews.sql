{{ config(
    materialized="table"
) }}

WITH
    fct_reviews AS (
        SELECT * FROM {{ ref("fct_reviews") }}
    ),
    full_moon_dates AS (
        SELECT
            TO_DATE(full_moon_date, 'DD-MM-YYYY') AS full_moon_date
        FROM {{ ref("seed_data") }}
    )

SELECT
    r.*,
    CASE
        WHEN fm.full_moon_date IS NULL THEN 'not full moon'
        ELSE 'full moon'
    END AS is_full_moon
FROM fct_reviews r
LEFT JOIN full_moon_dates fm
    ON CAST(r.review_date AS DATE) = DATEADD(day, 1, fm.full_moon_date)
