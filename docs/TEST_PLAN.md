# Test Plan

## v1 Success Scenario (manual walk-through)
1. Open the app URL as an anonymous visitor — dashboard loads with seeded records (no login prompt).
2. Click **New Record** — modal opens with empty form.
3. Fill in: title = "Test Deal", contact = any, status = "New", owner = "Dana Cho", value = 10000, notes = "Test note".
4. Click **Save** — modal closes; new row appears in the dashboard table.
5. Click the record — detail page opens; activity timeline shows "record_created" entry.
6. Click **Edit** — change status to "In Progress", save.
7. Detail page refreshes; activity timeline shows "status_change: new → in_progress".
8. Open the same URL in a second browser tab — new record is visible without refresh (Realtime).
9. Delete the record — it disappears from the dashboard; `audit_logs` contains a delete entry.

## Empty States
- Delete all records: dashboard shows empty state with "No records yet. Create your first one." and a CTA button.
- Record with no activities: detail page shows "No activity yet" message, not a blank panel.

## Error States
- Disconnect from network, submit form — error banner appears: "Could not save record. Check your connection and try again."
- Submit form with blank title — inline validation message shown before any network call.
- Navigate to `/records/nonexistent-id` — 404 page renders, not a blank screen.

## Regression Check (after each sprint)
- All buttons from prior sprints still write data.
- Seed data rows are still present (or replaceable via re-run of migration seed block).
- No Supabase keys visible in browser network tab or page source.