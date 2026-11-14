# SQL Practice Questions (MySQL)

Try before checking `SQL_PRACTICE_ANSWERS.md`.

## Fundamentals
1. Count all records in `IE3_Data`.
2. List member ID, name, status and pay-to-date for `TERMED_NONPAY`.
3. Find records where APTC is zero.
4. List distinct plan names.
5. Show 20 members with earliest effective dates.
6. Count members by plan status.
7. Count members by plan and status.
8. Find NULL names or DOBs.
9. Find duplicate member IDs in IE3.
10. Find pay-to-dates earlier than today.

## Reconciliation
11. Find IE3 members missing from Mainframe extract.
12. Find IDs present in both tables.
13. Find premium mismatches.
14. Find APTC mismatches.
15. Find member-responsibility mismatches.
16. Find DOB mismatches.
17. Find name mismatches after trimming spaces.
18. Find address mismatches.
19. Find effective-date mismatches.
20. Build one report with field-level mismatch labels.

## Exception rules
21. Use CASE to flag non-payment termination for review.
22. Compare pay-to-date with requested effective date using `Enrollment_Requests`.
23. Flag zero APTC for review.
24. Find retro dependent cancellations relative to premium effective date.
25. Compare IE3 values with `Custom_Tab_Rates` where status is `RECALCULATED`.
26. Classify request types into dependent change, member update, and premium reconciliation.
27. Create an exception list with reason and recommended action.
28. Find records with two or more exception flags.
29. Count exceptions by category.
30. Identify records requiring manual review.

## Reporting and BA metrics
31. Count source records by month.
32. Count source records by week.
33. Calculate missing-match percentage.
34. Calculate premium mismatch percentage among matched members.
35. Create a monthly premium mismatch trend.
36. Report member count by plan status.
37. Count dependent cancellations by month.
38. Count requests by request type and status.
39. Create a management summary of total, matched, missing, and premium mismatch counts.
40. Define reconciliation rate, mismatch rate, and missing-match rate.

## Advanced
41. Use a CTE to summarize mismatch counts.
42. Use conditional aggregation to count mismatch types in one row.
43. Demonstrate an UPDATE safely in a disposable practice table using preview SELECT and ROLLBACK.
44. Design an audit table with member ID, field, old value, new value, action, timestamp, and approval status.
45. Explain why a detected discrepancy must not automatically change a real Mainframe without approved integration and controls.
