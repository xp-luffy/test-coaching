# Data Model

## contacts
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner scoping (Sprint 3) |
| name | text | |
| company | text | |
| email | text | |
| phone | text | |
| created_at | timestamptz | |

## sales_records
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner scoping (Sprint 3) |
| title | text | |
| contact_id | uuid FK → contacts | |
| status | text | new / in_progress / won / lost |
| owner_name | text | free text until auth added |
| deal_value | numeric | |
| notes | text | |
| closed_at | timestamptz | |
| health_score | numeric | AI field |
| health_score_source | text | AI field |
| health_score_confidence | numeric | AI field |
| health_score_review_status | text | default 'unreviewed' |
| tags | text[] | AI field |
| tags_source | text | AI field |
| tags_confidence | numeric | AI field |
| tags_review_status | text | default 'unreviewed' |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| record_id | uuid FK → sales_records | |
| actor_name | text | |
| action_type | text | status_change / note_added / field_edit |
| old_value | text | |
| new_value | text | |
| note | text | |
| created_at | timestamptz | |

## team_members
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| name | text | |
| email | text | |
| role | text | rep / manager |
| created_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| table_name | text | |
| row_id | uuid | |
| action | text | insert / update / delete / ai_suggest |
| actor_name | text | |
| payload | jsonb | before/after snapshot |
| created_at | timestamptz | |

## RLS
- v1: all tables open read + write (demo-first)
- Sprint 3: replace with `auth.uid() = user_id`; managers get a broader select policy