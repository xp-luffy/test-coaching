# Tasks & Sprints

## Sprint 1 — Database + Core Record Engine
**Goal:** Every record action (create / edit / delete) persists to Supabase and is reflected in the UI.

- [ ] Apply migration SQL to Supabase project
- [ ] Confirm seed data loads on `/` without login
- [ ] Build `NewRecordModal` form: title, contact, status, owner, deal value, notes
- [ ] Wire form submit to Supabase `insert` on `sales_records`
- [ ] On successful insert, write activity row (`action_type: 'record_created'`)
- [ ] Build `EditRecordDrawer`: pre-filled form, updates row, logs activity on save
- [ ] Build delete: removes row, writes audit_log entry
- [ ] Handle loading / error / empty states on all forms
- [ ] No dead buttons: every interactive element has a real handler

**Definition of Done:** Open the app, create a record, edit its status, delete it — all three operations persist and the list updates without a page reload.

---

## Sprint 2 — Operational Dashboard ✅ v1 functional milestone
**Goal:** Shared real-time view of all records; team can run daily workflow here.

- [ ] Dashboard table: columns = title, contact, status badge, owner, deal value, last activity
- [ ] Status filter tabs: All / New / In Progress / Won / Lost
- [ ] Owner filter dropdown populated from `team_members`
- [ ] Record detail page `/records/[id]`: full fields + activity timeline
- [ ] Activity feed sidebar: last 20 activities across all records
- [ ] Supabase Realtime subscription on `sales_records` — new rows appear without refresh
- [ ] All screens: loading skeleton, empty state with CTA, error banner
- [ ] Verify app fully usable by anonymous visitor at live URL

**Definition of Done:** Rep creates a record on one browser tab; manager sees it appear on the dashboard on another tab within 2 seconds, no refresh needed. Success scenario from PRD passes.

---

## Sprint 3 — Lock It Down
**Goal:** Real user identities; only authenticated reps can write data.

- [ ] Enable Supabase Auth (email/password)
- [ ] Add login and signup pages
- [ ] Populate `user_id` on insert for all tables
- [ ] Replace v1 open RLS policies with owner-scoped policies
- [ ] Manager role: select policy allows all rows; write policy allows all rows
- [ ] Rep role: write policy restricted to `auth.uid() = user_id`
- [ ] Dashboard remains viewable without login; write actions redirect to login
- [ ] Test: unauthenticated POST to `sales_records` is rejected by RLS

**Definition of Done:** Logged-out user can view dashboard but cannot save a new record. Logged-in rep can only edit their own records. Manager can edit any record.

---

## Sprint 4 — Intelligence Layer
**Goal:** Records are automatically scored and tagged; managers can review and approve.

- [ ] Implement `score_record` rule engine (see INTELLIGENCE_LAYER.md)
- [ ] Implement `tag_record` keyword scanner
- [ ] Run both on record save (server action)
- [ ] Display health score badge and tags on dashboard and detail page
- [ ] Manager review queue: filter `review_status = 'unreviewed'`
- [ ] One-click approve/override for tags and score
- [ ] Log every AI suggestion in `audit_logs` with `action = 'ai_suggest'`

**Definition of Done:** Save a record with notes containing "cancel" — health score ≤ 50 appears within 1 second; `review_status` is `unreviewed`; manager approves it and status updates to `approved`.

---

## Gantt (sprint → feature)
```
Sprint 1: DB schema · seed data · create/edit/delete records · activity logging
Sprint 2: Dashboard · filters · detail page · activity feed · Realtime · [v1 functional]
Sprint 3: Auth · login/signup · RLS lockdown · role enforcement
Sprint 4: Health scoring · auto-tagging · manager review queue · audit trail
```