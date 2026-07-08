# Security

## Secret Handling
- Supabase URL and `anon` key live in `.env.local` and Vercel env vars only
- Service-role key is never used client-side or committed to the repo
- No secrets in frontend bundles; all privileged calls go through Next.js server actions or API routes

## Permission Model (end-state, reached at Sprint 3)
- **Anonymous:** read-only on `sales_records`, `activities`, `contacts` (dashboard view)
- **Rep:** create/edit own records and activities (`auth.uid() = user_id`)
- **Manager:** read + write all rows (role-checked via `team_members.role`)
- RLS enforced at the database level — app logic is a second layer, not the first

## Approved-Tools Rule
- Agents may only call the named tools listed in `AGENTIC_LAYER.md`
- No `run_any`, `eval`, or raw SQL execution from agent context
- Every agent action inherits the calling user's session permissions

## Audit Principle
- Every create, update, delete, and agent action writes a row to `audit_logs`
- `audit_logs` is append-only; no update or delete policy is granted
- Payload stores before/after snapshot as jsonb

## What Cannot Be Verified Without a Human
- Penetration testing and rate-limit validation require external tooling
- PII handling compliance (GDPR/CCPA) needs legal review before real customer data is stored
- npm dependency audit should be run pre-launch (`npm audit`)