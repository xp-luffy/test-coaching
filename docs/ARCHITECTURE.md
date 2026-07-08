# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Auth)
- **Styling:** Tailwind CSS
- **No external AI APIs in v1**

## What to Build Now vs Later

**Now:** tables → CRUD forms → shared dashboard → activity feed 
**Next:** auth, role-based access, per-user scoping 
**Later:** AI health scoring, auto-tagging, draft follow-ups

## Key User Action — Step by Step
1. Rep opens `/` — Next.js fetches all `sales_records` rows from Supabase (server component)
2. Rep clicks **New Record** — modal form renders client-side
3. Rep submits form — client calls Supabase `insert` on `sales_records`; on success, inserts a row in `activities`
4. Dashboard query re-fetches (or real-time subscription fires) — new row appears immediately
5. Any teammate on the same URL sees the update without refresh (Supabase Realtime)
6. Every insert/update also writes a row to `audit_logs`

## Layer Plan
1. **Data layer first** — schema, RLS, seed data
2. **App logic** — forms, filters, status transitions enforced server-side
3. **Smart features later** — scoring and AI suggestions sit on top; removing them doesn't break the core

## Why the Core Runs Without AI
All status transitions, activity logging, and filtering are rule-based Postgres operations. The AI scoring columns are nullable; the app renders fully without them.