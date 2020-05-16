\set nowtime now()
INSERT INTO demo_companies (
  name,
  corporate_num,
  address,
  prefecture_id,
  city_id,
  created_at,
  updated_at
)
SELECT
  companies.name AS name,
  companies.corporate_num AS corporate_num,
  company_addresses.address AS address,
  company_addresses.prefecture_id AS prefecture_id,
  company_addresses.city_id AS city_id,
  :nowtime AS created_at,
  :nowtime AS updated_at
  FROM companies
    JOIN company_addresses ON companies.id = company_addresses.company_id
;

UPDATE demo_companies
SET
  yahoo_flag = yahoo_sources.id,
  phone_number = yahoo_sources.phone_number,
  postal_code = yahoo_sources.postal_code,
  president_name = yahoo_sources.president_name,
  capital = yahoo_sources.capital,
  employee = yahoo_sources.employees,
  listing = yahoo_sources.listed,
  industry_id = yahoo_sources.industry_code,
  facebook_url = yahoo_sources.facebook_url,
  twitter_url = yahoo_sources.twitter_url,
  web_url = yahoo_sources.web_url
FROM
  yahoo_sources
WHERE
  yahoo_sources.corporate_num = demo_companies.corporate_num
;

UPDATE demo_companies
SET mynavi_flag = t2.mynavi_flag
FROM (
  SELECT
    mynavi_tenshokus.name,
    COUNT(mynavi_tenshokus.name) AS mynavi_flag
  FROM (
    SELECT name FROM demo_companies GROUP BY name HAVING COUNT(name) = 1
  ) AS t1
  JOIN mynavi_tenshokus ON t1.name = mynavi_tenshokus.name
  GROUP BY mynavi_tenshokus.name
) AS t2
WHERE demo_companies.name = t2.name
;

UPDATE demo_companies
SET prtimes_flag = t2.prtimes_flag
FROM (
  SELECT
    pr_times.name,
    COUNT(pr_times.name) AS prtimes_flag
  FROM (
    SELECT name FROM demo_companies GROUP BY name HAVING COUNT(name) = 1
  ) AS t1
  JOIN pr_times ON t1.name = pr_times.name
  GROUP BY pr_times.name
) AS t2
WHERE demo_companies.name = t2.name
;

UPDATE demo_companies
SET
  capital = t2.capital,
  employee = t2.employees
FROM (
  SELECT
    *
  from mynavi_tenshokus
  where id in (
    select min(id)
    from mynavi_tenshokus
    group by name
  )
) AS t2
WHERE t2.name = demo_companies.name
;

UPDATE demo_companies
SET
  capital = CASE
    WHEN t2.capital IS NOT NULL THEN t2.capital
    ELSE demo_companies.capital
  END
FROM (
  SELECT
    *
  from pr_times
  where id in (
    select min(id)
    from pr_times
    group by name
  )
) AS t2
WHERE t2.name = demo_companies.name
;
