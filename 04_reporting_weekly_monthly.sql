USE enrollment_project;

-- Monthly source volume
SELECT DATE_FORMAT(source_file_date, '%Y-%m') AS report_month,
       COUNT(*) AS ie3_records_received
FROM IE3_Data
GROUP BY DATE_FORMAT(source_file_date, '%Y-%m')
ORDER BY report_month;

-- Weekly source volume
SELECT YEAR(source_file_date) AS report_year,
       WEEK(source_file_date, 3) AS report_week,
       COUNT(*) AS ie3_records_received
FROM IE3_Data
GROUP BY YEAR(source_file_date), WEEK(source_file_date, 3)
ORDER BY report_year, report_week;

-- Reconciliation coverage
SELECT COUNT(*) AS ie3_total,
       SUM(m.member_id IS NOT NULL) AS matched_in_mainframe,
       SUM(m.member_id IS NULL) AS missing_in_mainframe,
       ROUND(100 * SUM(m.member_id IS NULL) / NULLIF(COUNT(*),0), 2) AS missing_match_pct
FROM IE3_Data i
LEFT JOIN Mainframe_Extract m ON i.member_id = m.member_id;

-- Premium mismatch rate among matched members
SELECT COUNT(*) AS matched_members,
       SUM(NOT (i.total_quoted_premium <=> m.total_quoted_premium)) AS premium_mismatch_count,
       ROUND(100 * SUM(NOT (i.total_quoted_premium <=> m.total_quoted_premium))
             / NULLIF(COUNT(*),0), 2) AS premium_mismatch_pct
FROM IE3_Data i
JOIN Mainframe_Extract m ON i.member_id = m.member_id;

-- Monthly status mix
SELECT DATE_FORMAT(source_file_date, '%Y-%m') AS report_month,
       plan_status, COUNT(*) AS member_count
FROM IE3_Data
GROUP BY DATE_FORMAT(source_file_date, '%Y-%m'), plan_status
ORDER BY report_month, plan_status;
