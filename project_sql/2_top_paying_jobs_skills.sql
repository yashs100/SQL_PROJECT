/* Question: What skills are required for the top-paying data analyst jobs? */
WITH top_paying_jobs AS (
    SELECT job_id,
        job_posted_date::DATE,
        cd.name AS company_name,
        job_title,
        salary_year_avg,
        SPLIT_PART(search_location, ',', 1) AS usa_state,
        job_via,
        job_schedule_type
    FROM job_postings_fact jpf
        LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
    WHERE salary_year_avg IS NOT NULL
        AND job_country = 'United States'
        AND job_title = 'Data Analyst'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT tpj.*,
    skills
FROM top_paying_jobs tpj
    INNER JOIN skills_job_dim sjd ON tpj.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC