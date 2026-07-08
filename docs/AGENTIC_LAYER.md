# Agentic Layer

## Risk Levels & Actions

### Low Risk — auto-execute, log only
- Tag a record based on note keywords
- Compute and write health score
- Summarise record activity into one sentence

### Medium Risk — show draft, one-click approval
- Change a record's status (e.g. auto-move stale records to "at-risk" tag)
- Create a follow-up activity entry

### High Risk — always requires explicit approval
- Send an email or Slack message referencing a record
- Bulk-update status across multiple records

### Critical — human only, no agent
- Delete a record or contact
- Export or share data externally
- Any action affecting billing or legal

## Named Tools (approved list)
- `score_record(record_id)` — runs rule engine, writes health_score fields
- `tag_record(record_id)` — keyword scan of notes, writes tags fields
- `draft_followup(record_id)` → returns text for human review before any send
- `log_audit(table, row_id, action, payload)` — append-only, always called

## Audit Log Fields
`id, created_at, table_name, row_id, action, actor_name, payload (jsonb)`

## Flow
Trigger → Draft → (if medium/high) Approval screen → Execute named tool → Audit log entry

## v1 vs Later
- **v1:** `score_record` and `tag_record` only (low risk, auto)
- **Later:** `draft_followup`, bulk-status actions, Slack integration