WITH sql_job_ids AS (
    SELECT DISTINCT jpf.job_id
    FROM job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE skills LIKE 'spark'
)
SELECT sd.skills,
    COUNT(*) AS count_of_skill_listed_with_spark
FROM skills_job_dim sjd
    JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE sjd.job_id IN (
        SELECT job_id
        FROM sql_job_ids
    )
    AND sd.skills NOT LIKE 'spark'
GROUP BY sd.skills
ORDER BY count_of_skill_listed_with_spark DESC
LIMIT 10;