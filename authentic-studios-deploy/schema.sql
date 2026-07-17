-- ─────────────────────────────────────────────
-- Authentic Studios — Supabase Schema
-- Run this in: Supabase Dashboard → SQL Editor
-- ─────────────────────────────────────────────

-- 1. Email signups (notify + CTA forms)
create table if not exists public.signups (
  id         uuid        primary key default gen_random_uuid(),
  email      text        not null,
  source     text        default 'landing',   -- 'notify' | 'cta' | 'footer'
  created_at timestamptz default now()
);

-- 2. Orders (from checkout)
create table if not exists public.orders (
  id         uuid        primary key default gen_random_uuid(),
  first_name text,
  last_name  text,
  email      text        not null,
  address    text,
  city       text,
  zip        text,
  size       text,
  total      integer,                          -- in cents  e.g. 6500 = $65.00
  status     text        default 'pending',    -- 'pending' | 'paid' | 'fulfilled'
  created_at timestamptz default now()
);

-- 3. Row Level Security — read is locked, insert is public
alter table public.signups enable row level security;
alter table public.orders  enable row level security;

-- Allow anyone to insert (the site POSTs signups/orders)
create policy "public insert signups"
  on public.signups for insert
  to anon
  with check (true);

create policy "public insert orders"
  on public.orders for insert
  to anon
  with check (true);

-- Only service role can SELECT (your dashboard / admin only)
create policy "service read signups"
  on public.signups for select
  to service_role
  using (true);

create policy "service read orders"
  on public.orders for select
  to service_role
  using (true);
