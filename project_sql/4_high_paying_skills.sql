SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS average_data_analyst_salary
FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_country = 'United States'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_data_analyst_salary DESC -- Skill  | Average Salary