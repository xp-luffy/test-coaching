# PRD — Sales Ops Tracker

## Problem
The sales team manages deals, statuses, and contacts across spreadsheets and chat threads. There is no single shared view of what's open, who owns it, or what changed last.

## Target Users
Internal sales team: reps log and update records; managers monitor the full pipeline.

## Core Objects
- **Sales Record** — the primary unit of work (deal/opportunity)
- **Contact** — the person or company attached to a record
- **Activity** — every status change, note, or edit on a record
- **Team Member** — rep or manager identity
- **Audit Log** — immutable history of every meaningful action

## MVP Must-Haves (v1)
- [ ] Create a sales record: title, contact, status, owner, deal value, notes
- [ ] Edit and update a record's status and notes
- [ ] Dashboard: filterable table of all records with status badge and owner
- [ ] Record detail view with full activity timeline
- [ ] Activity feed showing the last 20 actions across all records
- [ ] All data persists to Supabase; every form button writes real data
- [ ] App is viewable without login (seed data loads on first visit)

## Non-Goals (v1)
- User authentication and per-user data isolation
- Email or in-app notifications
- AI scoring or auto-tagging
- Reporting, charts, or exports
- Mobile-native UI

## Definition of Done
A rep opens the app, creates a new record for a real deal, sets the status to *In Progress*, saves it, and immediately sees it appear on the shared dashboard and in the activity feed — without refreshing or logging in. A second team member opening the same URL sees the identical record.