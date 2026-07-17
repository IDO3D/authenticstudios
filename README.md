# Authentic Studios — Where Is My Mind Tee

Single-file product landing page. Paint intro → product page.

---

## Deploy in 3 steps

### 1. Supabase — run schema

1. Go to **supabase.com** → your project → **SQL Editor**
2. Paste and run the contents of `schema.sql`
3. Copy your **Project URL** and **anon public key** from  
   Settings → API → Project URL / Project API Keys

### 2. Add your credentials to `index.html`

Open `index.html` and find these two lines near the top (inside the Supabase `<script>` block):

```js
var SUPA_URL = 'https://YOUR_PROJECT_ID.supabase.co';
var SUPA_KEY = 'YOUR_ANON_PUBLIC_KEY';
```

Replace both values with your real ones. The anon key is safe to commit — it's public-facing by design, and RLS (Row Level Security) protects your data.

### 3. Push to GitHub + deploy Vercel

```bash
# First time
git init
git add .
git commit -m "Authentic Studios — Where Is My Mind Tee launch"
git remote add origin https://github.com/YOUR_USERNAME/authentic-studios.git
git push -u origin main

# Connect Vercel (one time)
# Go to vercel.com/new → Import Git Repository → authentic-studios
# No build settings needed — it auto-detects static HTML

# Every update after that
git add .
git commit -m "update"
git push
# Vercel auto-deploys on push
```

Or use Vercel CLI:

```bash
npm i -g vercel
vercel --prod
```

---

## What gets saved to Supabase

| Table | When | Fields |
|-------|------|--------|
| `orders` | Customer clicks "Place Order" | first_name, last_name, email, address, city, zip, size, total (6500 = $65.00), status |

View data: **Supabase Dashboard → Table Editor → orders**

---

## After launch checklist

- [ ] Replace Supabase credentials in `index.html`  
- [ ] Push to GitHub  
- [ ] Connect Vercel to the repo  
- [ ] Run `schema.sql` in Supabase  
- [ ] Test a full checkout — confirm the order appears in the `orders` table  
- [ ] Add real payment (Stripe) — current checkout is UI-only  
- [ ] Update social links in the footer  
- [ ] Set up email notification (Supabase → Database Webhooks → send to Resend/Postmark)  

---

## File structure

```
authentic-studios/
├── index.html      ← Everything. One file.
├── vercel.json     ← Vercel routing + headers
├── schema.sql      ← Run this in Supabase once
├── .gitignore
└── README.md
```

## Live URL

https://authenticstudios.vercel.app
