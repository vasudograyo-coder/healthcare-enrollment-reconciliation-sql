USE enrollment_project;

-- IE3 members absent from the simulated Mainframe extract
SELECT i.member_id, i.member_name, i.plan_name, i.member_effective_date
FROM IE3_Data i
LEFT JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE m.member_id IS NULL;

-- Premium mismatch
SELECT i.member_id, i.total_quoted_premium AS ie3_premium,
       m.total_quoted_premium AS mainframe_premium
FROM IE3_Data i
JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (i.total_quoted_premium <=> m.total_quoted_premium);

-- DOB, name, address and effective-date mismatches
SELECT i.member_id, i.dob AS ie3_dob, m.dob AS mainframe_dob
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (i.dob <=> m.dob);

SELECT i.member_id, i.member_name AS ie3_name, m.member_name AS mainframe_name
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (TRIM(i.member_name) <=> TRIM(m.member_name));

SELECT i.member_id, i.address AS ie3_address, m.address AS mainframe_address
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (TRIM(i.address) <=> TRIM(m.address));

SELECT i.member_id, i.member_effective_date AS ie3_eff,
       m.member_effective_date AS mainframe_eff
FROM IE3_Data i JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (i.member_effective_date <=> m.member_effective_date);

-- Combined field-level discrepancy labels
SELECT i.member_id,
 CASE WHEN NOT (i.member_name <=> m.member_name) THEN 'NAME_MISMATCH' END AS name_issue,
 CASE WHEN NOT (i.dob <=> m.dob) THEN 'DOB_MISMATCH' END AS dob_issue,
 CASE WHEN NOT (i.address <=> m.address) THEN 'ADDRESS_MISMATCH' END AS address_issue,
 CASE WHEN NOT (i.member_effective_date <=> m.member_effective_date) THEN 'EFFECTIVE_DATE_MISMATCH' END AS effective_date_issue,
 CASE WHEN NOT (i.total_quoted_premium <=> m.total_quoted_premium) THEN 'PREMIUM_MISMATCH' END AS premium_issue,
 CASE WHEN NOT (i.aptc_amount <=> m.aptc_amount) THEN 'APTC_MISMATCH' END AS aptc_issue,
 CASE WHEN NOT (i.member_responsibility <=> m.member_responsibility) THEN 'MEMBER_RESPONSIBILITY_MISMATCH' END AS responsibility_issue
FROM IE3_Data i
JOIN Mainframe_Extract m ON i.member_id = m.member_id
WHERE NOT (i.member_name <=> m.member_name)
 OR NOT (i.dob <=> m.dob)
 OR NOT (i.address <=> m.address)
 OR NOT (i.member_effective_date <=> m.member_effective_date)
 OR NOT (i.total_quoted_premium <=> m.total_quoted_premium)
 OR NOT (i.aptc_amount <=> m.aptc_amount)
 OR NOT (i.member_responsibility <=> m.member_responsibility);
