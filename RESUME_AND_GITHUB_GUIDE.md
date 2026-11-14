# Resume and GitHub Guide

## Repository name
`healthcare-enrollment-reconciliation-sql`

## Repository description
A synthetic-data portfolio project using MySQL to reconcile healthcare enrollment source and target extracts, classify exceptions, and build weekly/monthly operational reports.

## Resume project entry (use after running and understanding the work)
**Healthcare Enrollment Reconciliation & Reporting | MySQL, Excel/CSV**
- Built SQL queries to compare synthetic IE3 source records with a simulated Mainframe extract and identify missing matches and field-level discrepancies.
- Used joins, conditional logic, aggregations, and date functions to classify exceptions and create weekly/monthly reporting metrics.
- Designed exception-review logic for premium/APTC differences, dependent cancellation scenarios, non-payment termination, and pay-to-date flags.
- Documented validation assumptions, a data dictionary, and audit requirements for a simulated enrollment workflow.

These bullets describe this personal portfolio project, not live automation at an employer.

## Interview explanation
"I created a personal portfolio project using synthetic healthcare enrollment data. I loaded source and simulated target extracts into MySQL, compared them using joins and null-safe comparisons, classified discrepancies with CASE logic, and built weekly/monthly metrics. It demonstrates SQL-based reconciliation and exception reporting; it does not connect to a real Mainframe or perform production updates."

## GitHub steps
1. Create repository `healthcare-enrollment-reconciliation-sql`.
2. Upload README.md, sql/, and docs/.
3. Add only synthetic CSV data if desired.
4. Add screenshots of your own query outputs after checking for sensitive information.
5. Never upload real member data, PHI/PII, production screenshots, credentials, or confidential company documents.

## Limitations
Synthetic data only; business rules are illustrative and require stakeholder validation in a real project. Premium/APTC are not calculated by actuarial rules. No live system integration.
