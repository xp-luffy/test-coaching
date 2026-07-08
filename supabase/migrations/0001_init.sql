create table if not exists contacts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  company text,
  email text,
  phone text
);

alter table contacts enable row level security;
drop policy if exists "contacts_v1_read" on contacts;
create policy "contacts_v1_read" on contacts for select using (true);
drop policy if exists "contacts_v1_write" on contacts;
create policy "contacts_v1_write" on contacts for all using (true) with check (true);

create table if not exists sales_records (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  contact_id uuid references contacts(id),
  status text not null default 'new',
  owner_name text,
  deal_value numeric,
  notes text,
  closed_at timestamptz,
  health_score numeric,
  health_score_source text,
  health_score_confidence numeric,
  health_score_review_status text default 'unreviewed',
  tags text[],
  tags_source text,
  tags_confidence numeric,
  tags_review_status text default 'unreviewed'
);

alter table sales_records enable row level security;
drop policy if exists "sales_records_v1_read" on sales_records;
create policy "sales_records_v1_read" on sales_records for select using (true);
drop policy if exists "sales_records_v1_write" on sales_records;
create policy "sales_records_v1_write" on sales_records for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  record_id uuid references sales_records(id),
  actor_name text,
  action_type text not null,
  old_value text,
  new_value text,
  note text
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists team_members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  email text,
  role text not null default 'rep'
);

alter table team_members enable row level security;
drop policy if exists "team_members_v1_read" on team_members;
create policy "team_members_v1_read" on team_members for select using (true);
drop policy if exists "team_members_v1_write" on team_members;
create policy "team_members_v1_write" on team_members for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  table_name text not null,
  row_id uuid,
  action text not null,
  actor_name text,
  payload jsonb
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into contacts (id, name, company, email) values
  ('a1000000-0000-0000-0000-000000000001', 'Jordan Lee', 'Acme Corp', 'jordan@acme.com'),
  ('a1000000-0000-0000-0000-000000000002', 'Sam Rivera', 'Beta Industries', 'sam@beta.io'),
  ('a1000000-0000-0000-0000-000000000003', 'Casey Kim', 'Gamma Solutions', 'casey@gamma.co'),
  ('a1000000-0000-0000-0000-000000000004', 'Alex Morgan', 'Delta Ventures', 'alex@delta.com')
on conflict (id) do nothing;

insert into team_members (id, name, email, role) values
  ('b1000000-0000-0000-0000-000000000001', 'Priya Shah', 'priya@team.com', 'manager'),
  ('b1000000-0000-0000-0000-000000000002', 'Marcus Webb', 'marcus@team.com', 'rep'),
  ('b1000000-0000-0000-0000-000000000003', 'Dana Cho', 'dana@team.com', 'rep')
on conflict (id) do nothing;

insert into sales_records (id, title, contact_id, status, owner_name, deal_value, notes) values
  ('c1000000-0000-0000-0000-000000000001', 'Acme Annual Renewal', 'a1000000-0000-0000-0000-000000000001', 'in_progress', 'Marcus Webb', 42000, 'Renewal call scheduled for Friday.'),
  ('c1000000-0000-0000-0000-000000000002', 'Beta Industries Upsell', 'a1000000-0000-0000-0000-000000000002', 'new', 'Dana Cho', 15000, 'Sent proposal deck — awaiting feedback.'),
  ('c1000000-0000-0000-0000-000000000003', 'Gamma Solutions Expansion', 'a1000000-0000-0000-0000-000000000003', 'in_progress', 'Marcus Webb', 28000, 'Legal reviewing contract draft.'),
  ('c1000000-0000-0000-0000-000000000004', 'Delta Ventures New Logo', 'a1000000-0000-0000-0000-000000000004', 'won', 'Dana Cho', 19500, 'Closed! PO received 2025-01-10.'),
  ('c1000000-0000-0000-0000-000000000005', 'Acme Add-On Seats', 'a1000000-0000-0000-0000-000000000001', 'lost', 'Marcus Webb', 5000, 'Budget cut — revisit Q3.')
on conflict (id) do nothing;

insert into activities (record_id, actor_name, action_type, old_value, new_value, note) values
  ('c1000000-0000-0000-0000-000000000001', 'Marcus Webb', 'status_change', 'new', 'in_progress', 'Kicked off renewal conversation.'),
  ('c1000000-0000-0000-0000-000000000004', 'Dana Cho', 'status_change', 'in_progress', 'won', 'PO received and logged.'),
  ('c1000000-0000-0000-0000-000000000005', 'Marcus Webb', 'status_change', 'in_progress', 'lost', 'Budget cut confirmed by client.')
on conflict do nothing;