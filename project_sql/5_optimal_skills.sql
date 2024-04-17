WITH skills_demand AS (
    SELECT sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND job_country = 'United States'
        AND salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id,
        sd.skills
),
average_salary AS (
    SELECT sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_data_analyst_salary
    FROM job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.job_country = 'United States'
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id,
        sd.skills
)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_data_analyst_salary
FROM skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY average_data_analyst_salary DESC,
    demand_count DESC
LIMIT 25;