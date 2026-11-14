# Healthcare Enrollment Reconciliation & Reporting (MySQL)

**Portfolio project using synthetic practice data only.** This is not connected to any real IE3, Mainframe, Pega, or production environment.

## What this project demonstrates
- Compare IE3 source records with a simulated Mainframe extract.
- Identify missing members and field-level mismatches.
- Classify exceptions: premium/APTC differences, DOB/name/address/effective-date mismatches, non-payment termination, pay-to-date flags, zero APTC, and retro dependent cancellation.
- Produce weekly/monthly reports and operational KPIs.
- Document safe automation boundaries and audit requirements.

## Suggested setup
1. Import the companion synthetic CSV files into MySQL Workbench.
2. Use schema name `enrollment_project` (or update `USE` statements).
3. Run SQL files in the `sql/` folder.
4. Practice questions in `docs/SQL_PRACTICE_QUESTIONS.md` before checking answers.
5. Use `docs/BA_INTERVIEW_QUESTIONS.md` and `docs/RESUME_AND_GITHUB_GUIDE.md`.

Expected tables: `IE3_Data`, `Mainframe_Extract`, `Dependent_Details`, `Custom_Tab_Rates`, `Enrollment_Requests`.

## Important assumptions
- `member_id` is used to match source and target records.
- A missing match is an exception to investigate, not proof that a member should be automatically enrolled.
- Do not blindly overwrite Mainframe fields with source values.
- Non-payment, expired pay-to-date, and zero APTC are review flags, not universal rejection rules.
- Custom Tab rates are simulated returned values, not a universal premium formula.
- SQL scripts only query the imported practice tables; they do not change a real system.

## GitHub safety
Only upload synthetic data. Never upload real member information, PHI/PII, production screenshots, credentials, or confidential employer documentation.
