WITH year_table AS (
    SELECT job_id,
        EXTRACT(
            MONTH
            FROM job_posted_date
        ) AS month,
        EXTRACT(
            YEAR
            FROM job_posted_date
        ) AS year
    FROM job_postings_fact
)
SELECT yt.month,
    COUNT(*) AS job_posted_count
FROM year_table yt
    JOIN job_postings_fact jpf ON yt.job_id = jpf.job_id
WHERE year = 2023
GROUP BY yt.month
ORDER BY job_posted_count DESC