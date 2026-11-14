USE enrollment_project;

-- Classify records for review; this does not update enrollment data
SELECT member_id, member_name, plan_status, pay_to_date, aptc_amount,
 CASE
   WHEN plan_status = 'TERMED_NONPAY' THEN 'SYSTEM_LIMITATION_REVIEW'
   WHEN pay_to_date < CURRENT_DATE() THEN 'PAY_TO_DATE_REVIEW'
   WHEN aptc_amount = 0 THEN 'ZERO_APTC_REVIEW'
   ELSE 'NO_FLAG_FROM_THESE_RULES'
 END AS review_category
FROM IE3_Data;

-- Retro dependent cancellation compared with premium effective date
SELECT d.member_id, d.dependent_id, d.cancellation_effective_date,
       r.premium_effective_date,
 CASE WHEN d.cancellation_effective_date < r.premium_effective_date
      THEN 'RETRO_CANCELLATION_REVIEW'
      ELSE 'NON_RETRO_OR_SAME_DATE_REVIEW'
 END AS cancellation_review
FROM Dependent_Details d
JOIN Custom_Tab_Rates r ON r.member_id = d.member_id
WHERE d.dependent_status = 'CANCELLED'
  AND d.cancellation_effective_date IS NOT NULL;

-- Compare current values with simulated Custom Tab values for re-rated records
SELECT i.member_id, i.total_quoted_premium AS current_premium,
       r.custom_tab_total_premium, i.aptc_amount AS current_aptc,
       r.custom_tab_aptc, i.member_responsibility AS current_responsibility,
       r.custom_tab_member_responsibility
FROM IE3_Data i
JOIN Custom_Tab_Rates r ON r.member_id = i.member_id
WHERE r.rate_calculation_status = 'RECALCULATED';
