# SQL Practice Answers (MySQL)

```sql
-- 1
SELECT COUNT(*) AS total_members FROM IE3_Data;

-- 2
SELECT member_id, member_name, plan_status, pay_to_date
FROM IE3_Data WHERE plan_status = 'TERMED_NONPAY';

-- 3
SELECT member_id, member_name, aptc_amount FROM IE3_Data WHERE aptc_amount = 0;

-- 4
SELECT DISTINCT plan_name FROM IE3_Data ORDER BY plan_name;

-- 5
SELECT member_id, member_name, member_effective_date
FROM IE3_Data ORDER BY member_effective_date LIMIT 20;

-- 6
SELECT plan_status, COUNT(*) AS member_count FROM IE3_Data GROUP BY plan_status;

-- 7
SELECT plan_name, plan_status, COUNT(*) AS member_count
FROM IE3_Data GROUP BY plan_name, plan_status;

-- 8
SELECT * FROM IE3_Data WHERE member_name IS NULL OR dob IS NULL;

-- 9
SELECT member_id, COUNT(*) AS occurrences FROM IE3_Data
GROUP BY member_id HAVING COUNT(*) > 1;

-- 10
SELECT member_id, member_name, pay_to_date
FROM IE3_Data WHERE pay_to_date < CURRENT_DATE();

-- 11
SELECT i.member_id, i.member_name
FROM IE3_Data i LEFT JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE m.member_id IS NULL;

-- 12
SELECT i.member_id FROM IE3_Data i
JOIN Mainframe_Extract m ON i.member_id=m.member_id;

-- 13
SELECT i.member_id, i.total_quoted_premium, m.total_quoted_premium AS mainframe_premium
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (i.total_quoted_premium <=> m.total_quoted_premium);

-- 14
SELECT i.member_id, i.aptc_amount, m.aptc_amount AS mainframe_aptc
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (i.aptc_amount <=> m.aptc_amount);

-- 15
SELECT i.member_id, i.member_responsibility, m.member_responsibility AS mainframe_responsibility
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (i.member_responsibility <=> m.member_responsibility);

-- 16
SELECT i.member_id, i.dob, m.dob AS mainframe_dob
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (i.dob <=> m.dob);

-- 17
SELECT i.member_id, i.member_name, m.member_name AS mainframe_name
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (TRIM(i.member_name) <=> TRIM(m.member_name));

-- 18
SELECT i.member_id, i.address, m.address AS mainframe_address
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (TRIM(i.address) <=> TRIM(m.address));

-- 19
SELECT i.member_id, i.member_effective_date, m.member_effective_date AS mainframe_eff
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
WHERE NOT (i.member_effective_date <=> m.member_effective_date);

-- 21
SELECT member_id,
 CASE WHEN plan_status='TERMED_NONPAY' THEN 'SYSTEM_LIMITATION_REVIEW'
      ELSE 'OTHER_REVIEW' END AS action
FROM IE3_Data;

-- 22
SELECT r.request_id, r.member_id, r.requested_effective_date, i.pay_to_date,
 CASE WHEN i.pay_to_date < r.requested_effective_date THEN 'PAY_TO_DATE_REVIEW'
      ELSE 'CHECK_OTHER_RULES' END AS review_action
FROM Enrollment_Requests r JOIN IE3_Data i ON i.member_id=r.member_id;

-- 23
SELECT member_id, aptc_amount,
 CASE WHEN aptc_amount=0 THEN 'ZERO_APTC_REVIEW' ELSE 'NOT_ZERO_APTC' END AS flag
FROM IE3_Data;

-- 24
SELECT d.member_id, d.dependent_id, d.cancellation_effective_date, r.premium_effective_date
FROM Dependent_Details d JOIN Custom_Tab_Rates r ON r.member_id=d.member_id
WHERE d.dependent_status='CANCELLED'
  AND d.cancellation_effective_date < r.premium_effective_date;

-- 25
SELECT i.member_id, i.total_quoted_premium, r.custom_tab_total_premium,
       i.aptc_amount, r.custom_tab_aptc,
       i.member_responsibility, r.custom_tab_member_responsibility
FROM IE3_Data i JOIN Custom_Tab_Rates r ON i.member_id=r.member_id
WHERE r.rate_calculation_status='RECALCULATED';

-- 26
SELECT request_id, member_id, request_type,
 CASE WHEN request_type IN ('ADD_DEPENDENT','CANCEL_DEPENDENT') THEN 'DEPENDENT_CHANGE'
      WHEN request_type='UPDATE_MEMBER' THEN 'MEMBER_UPDATE'
      WHEN request_type='PREMIUM_RECON' THEN 'PREMIUM_RECON'
      ELSE 'MANUAL_REVIEW' END AS request_category
FROM Enrollment_Requests;

-- 31
SELECT DATE_FORMAT(source_file_date,'%Y-%m') AS report_month, COUNT(*) AS records_received
FROM IE3_Data GROUP BY DATE_FORMAT(source_file_date,'%Y-%m') ORDER BY report_month;

-- 32
SELECT YEAR(source_file_date) AS report_year, WEEK(source_file_date,3) AS report_week,
       COUNT(*) AS records_received
FROM IE3_Data GROUP BY YEAR(source_file_date), WEEK(source_file_date,3)
ORDER BY report_year, report_week;

-- 33
SELECT ROUND(100*SUM(m.member_id IS NULL)/NULLIF(COUNT(*),0),2) AS missing_match_pct
FROM IE3_Data i LEFT JOIN Mainframe_Extract m ON i.member_id=m.member_id;

-- 34
SELECT ROUND(100*SUM(NOT (i.total_quoted_premium <=> m.total_quoted_premium))
 / NULLIF(COUNT(*),0),2) AS premium_mismatch_pct
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id;

-- 36
SELECT plan_status, COUNT(*) AS member_count FROM IE3_Data
GROUP BY plan_status ORDER BY member_count DESC;

-- 37
SELECT DATE_FORMAT(cancellation_effective_date,'%Y-%m') AS cancel_month, COUNT(*) AS cancellations
FROM Dependent_Details
WHERE dependent_status='CANCELLED' AND cancellation_effective_date IS NOT NULL
GROUP BY DATE_FORMAT(cancellation_effective_date,'%Y-%m');

-- 38
SELECT request_type, request_status, COUNT(*) AS request_count
FROM Enrollment_Requests GROUP BY request_type, request_status;

-- 39
SELECT
 (SELECT COUNT(*) FROM IE3_Data) AS ie3_total,
 (SELECT COUNT(*) FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id) AS matched_count,
 (SELECT COUNT(*) FROM IE3_Data i LEFT JOIN Mainframe_Extract m ON i.member_id=m.member_id
  WHERE m.member_id IS NULL) AS missing_count,
 (SELECT COUNT(*) FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id=m.member_id
  WHERE NOT (i.total_quoted_premium <=> m.total_quoted_premium)) AS premium_mismatch_count;
```

Questions 20, 27-30, 40-45 have multiple valid approaches; use the practice questions to design and explain your own solution. Always preview data and use only a disposable practice schema for UPDATE/DELETE learning.
