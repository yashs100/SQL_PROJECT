/* Question: What are the top-paying data analyst jobs in USA? */

SELECT job_posted_date::DATE,
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
LIMIT 10;
