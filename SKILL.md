---
name: hk-transit
description: >
  Plan Hong Kong public transport trips using official open data (DATA.GOV.HK ETA,
  TD GTFS, LandsD pedestrian routing or OSRM walk), plus optional community tips
  with cited sources. Use when the user asks how to go somewhere in Hong Kong by
  MTR, Light Rail, franchised bus, green minibus, ferry piers, airport/border
  defaults, or related open-data modes. Do not use for medical advice about
  motion sickness. Never present community tips as live ETA or journey duration.
---

# Hong Kong transit (V0 + V0.1 tips + V1-A/B hooks)

## Hard rules

1. **Official open data only for ETA / journey times.** Fetch DATA.GOV.HK / operator-published ETA and TD GTFS (`stop_times` / schedules). **Never scrape** Citymapper, Google Maps HTML, or closed operator apps.
2. **Every official option must include:**
   - **Route verification:** each leg aligned to official route / stop sequence (GTFS or operator open data), **or** explicitly labelled `未能核實` / `unverified`.
   - **Journey-time source:** operator or DATA.GOV.HK URL **plus** `queried_at` (ISO-8601, Asia/Hong_Kong). No URL + `queried_at` = incomplete — do not present as verified.
3. **Two output layers — never mix.**
   - **Official:** ETA, GTFS legs, PedRoute/OSRM walk, official fare tables.
   - **Community tip:** `references/local-tips.yaml` (and optional `tips/examples/`). Annotate / reorder only; **never** supply minutes or waits from tips.
4. **No sourceless tips.** Reject any tip missing `source`, `as_of`, or `community: true`. See `tips/SCHEMA.md` and `references/local-tips.yaml`.
5. **No secrets in this skill.** Keyless public endpoints only in V0; any future key stays in environment variables.
6. **No operator logos** as branding. Attribute text sources; do not impersonate HKeMobility or operators.
7. **AS IS.** Times and routes are planning aids. Live conditions, diversions, and typhoon suspensions override this skill.
8. **Motion comfort is preference, not medical advice.** Heuristics in `references/motion-comfort-heuristics.yaml` are community tags only.
9. **Honest coverage.** Red minibus / estate shuttles: **templates only** in `local-tips.yaml` until a cited source exists — never invent headways. Tram / Peak Tram live ETA and city-wide taxi vacancy remain gaps.

## V0 in scope (unchanged)

- ETA: KMB / LWB, Citybus V2 (CTB), Green Minibus (GMB), MTR Next Train, Light Rail
- Static transfer candidates: Transport Department GTFS
- Walking: LandsD PedRoute **or** OSRM walk

## V0.1 / V1-B (tips)

- Canonical tips: `references/local-tips.yaml`
- Schema: `tips/SCHEMA.md` (`route_check`, `unofficial`, etc.)
- Tourist / local bilingual aliases: `assets/aliases.yaml` (search hints only — **do not** overwrite official stop ids)

## V1-A (data thicken — scripts may land in follow-up commits)

- NLB, MTR bus, ferry ETA where official; tram / Star Ferry / Peak Tram **static** only until live ETA is verified on an official page

## Out of scope

- 100% red-van / estate-shuttle coverage or invented schedules
- Guaranteeing “fastest arrival” or navigation liability
- Medical advice for motion sickness

## Workflow

1. Clarify origin, destination, departure time, preferences (tourist vs local, motion-comfort, etc.).
2. Resolve places via `assets/aliases.yaml` **as search hints only**. Prefer official stop/station ids from GTFS / operator open data. Never replace an official id with an alias string.
3. Build candidate itineraries from TD GTFS (or local cache).
4. **Route verification (required):** for each leg, confirm route id + stop sequence against GTFS / operator open data. If not confirmed, mark that leg `未能核實` and say what is missing.
5. For each transit leg, call the matching ETA endpoint (see `references/data-sources.md`). Record **source URL** and **`queried_at`**. Respect HTTP 429 with backoff. Journey minutes come **only** from ETA or GTFS schedule — never from tips.
6. For walking legs, call PedRoute or OSRM walk; cite the routing source + `queried_at`.
7. Optionally load tips from `references/local-tips.yaml` (`tips` array; skip `templates` until filled with real `source`/`as_of`). Drop tips missing required fields; WARN if `as_of` older than 90 days.
8. Motion-sensitive users: down-rank heuristic-tagged routes with disclaimer.
9. **Reply structure (required):**
   - **Official options** — for each option / leg:
     - modes, verified route/stop ids (or `未能核實`)
     - waits / durations from ETA or GTFS only
     - `source_url` + `queried_at`
     - fare estimate if GTFS fare exists (label as estimate)
     - gaps
   - **Community tips (if any)** — separate section: `title`, `as_of`, `source`, `route_check.status`, `disclaimer`. Never fold into ETA lines.
10. Estate / RMB: ask for user timetable or cite tip habit only — never invent schedules.

## How to use `references/local-tips.yaml`

1. Read `tips/SCHEMA.md`.
2. Load `tips:`; require `community: true`, `unofficial: true`, non-empty `source`, valid `as_of`, and `route_check`.
3. Prefer tips matching `audience` (`tourist` / `local` / `both`).
4. Use tips only to annotate or reorder **already legal** official candidates.
5. High-`risk` (e.g. `rmb_habit`) → extra caution. `templates` are not publishable tips until sourced.

## Attribution

> Data from [DATA.GOV.HK](https://data.gov.hk/) and the respective operators / Transport Department. Provided AS IS; not affiliated with the Government of the HKSAR or the operators.

When citing tips:

> Community tip(s) from `references/local-tips.yaml`; not official schedules. Check `source` dated `as_of`.

## Scripts

Optional helpers under `scripts/`. Do not vendor GPL libraries into this MIT tree.
