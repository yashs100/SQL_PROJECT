/* Question: What are the most in-demand skills for data analyst */
SELECT skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND job_country = 'United States'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;