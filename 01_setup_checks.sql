USE enrollment_project;

SELECT COUNT(*) AS ie3_record_count FROM IE3_Data;
SELECT COUNT(*) AS mainframe_extract_count FROM Mainframe_Extract;
SELECT * FROM IE3_Data LIMIT 10;

SELECT member_id, COUNT(*) AS occurrences
FROM IE3_Data
GROUP BY member_id
HAVING COUNT(*) > 1;

SELECT
  SUM(member_id IS NULL) AS null_member_id,
  SUM(member_name IS NULL OR TRIM(member_name) = '') AS blank_member_name,
  SUM(dob IS NULL) AS null_dob,
  SUM(member_effective_date IS NULL) AS null_effective_date
FROM IE3_Data;
