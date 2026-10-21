---
name: hk-transit
description: >
  Plan Hong Kong public transport trips using official open data (DATA.GOV.HK ETA,
  TD GTFS, LandsD pedestrian routing or OSRM walk), plus optional community tips
  with cited sources. Use when the user asks how to go somewhere in Hong Kong by
  MTR, Light Rail, franchised bus, green minibus, ferry piers, airport/border
  defaults, or related open-data modes. Do not use for medical advice about
  motion sickness. Never present community tips as live ETA.
---

# Hong Kong transit (V0 + V0.5 tips)

## Hard rules

1. **Official open data only for ETA / routes.** Fetch DATA.GOV.HK / operator-published ETA and TD GTFS. **Never scrape** Citymapper, Google Maps HTML, or closed operator apps.
2. **Two output layers — never mix.**
   - **Official:** ETA, GTFS legs, PedRoute/OSRM walk, official fare tables.
   - **Community tip:** files under `tips/` (`community: true`). Always label as tip; never invent waits from tips.
3. **No sourceless tips.** Reject any tip missing `source` or `as_of`. See `tips/SCHEMA.md`.
4. **No secrets in this skill.** Keyless public endpoints only in V0; any future key stays in environment variables.
5. **No operator logos** as branding. Attribute text sources; do not impersonate HKeMobility or operators.
6. **AS IS.** Times and routes are planning aids. Live conditions, diversions, and typhoon suspensions override this skill — tell the user to check the operator / HKeMobility when unsure.
7. **Motion comfort is preference, not medical advice.** Heuristics in `references/motion-comfort-heuristics.yaml` are community tags only.
8. **Honest coverage.** If a mode has no official ETA (red minibus, most estate free shuttles, tram real-time, Peak Tram real-time, city-wide taxi vacancy), say so — do not fabricate. RMB / estate habits may appear only as **tips** with source + date.

## V0 in scope (unchanged)

- ETA: KMB / LWB, Citybus V2 (CTB), Green Minibus (GMB), MTR Next Train, Light Rail
- Static transfer candidates: Transport Department GTFS headway / routes / stops / fares
- Walking: LandsD 3D Pedestrian Route Search **or** OSRM walk (OSM); landmark names from OSM / user hints
- Output always includes: source URLs, data timestamps (`opened_at` / `generated_timestamp`), coverage gaps, AS IS disclaimer

## V0.5 add-ons

- Tourist / local bilingual place aliases in `assets/aliases.yaml` (hints only — **do not** overwrite official stop ids)
- Airport / border crossings / ferry pier default place hints
- Fare / Octopus reminders only when citing an official fare page (or a tip with `category: fare_hint` + source)
- Community tips layer: `tips/` (schema + examples)

## Out of scope

- Promising 100% red-van / estate-shuttle coverage
- Guaranteeing “fastest arrival” or turn-by-turn legal navigation liability
- Medical advice for motion sickness

## Workflow

1. Clarify origin, destination (place name or coordinates), departure time, and preferences: fastest / fewest transfers / less walking / motion-comfort / accessibility / tourist vs local.
2. Resolve places via `assets/aliases.yaml` **as search hints only**. Prefer official stop/station ids from GTFS / operator open data when known. Never replace an official id with an alias string.
3. Build candidate itineraries from TD GTFS (or a local cache). Do not claim a single official “PT journey planner API” unless one is later verified on an official page.
4. For each transit leg, call the matching ETA script or HTTPS endpoint (see `references/data-sources.md`). Respect HTTP 429 with backoff.
5. For walking legs, call PedRoute (zh-HK directions if available) or OSRM walk. Summarise road names and key landmarks.
6. Optionally load matching tips from `tips/examples/*.yaml` (skip `_template.yaml`). Match by `applies_to` / keywords. Drop tips past `expires` or missing `source`/`as_of`.
7. If the user is motion-sensitive, down-rank routes tagged in `motion-comfort-heuristics.yaml` and explain the trade-off (heuristic + disclaimer).
8. **Reply structure (required):**
   - **Official options:** modes, waits (if ETA), walk summary, fare estimate if GTFS fare exists (label as estimate), sources + timestamps, gaps.
   - **Community tips (if any):** bullet each tip with `title`, `as_of`, `source`, and `disclaimer`. Never fold tip text into ETA lines.
9. For estate bus / RMB / missing ETA: ask the user for a timetable, or point them to HKeMobility / the operator — never invent schedules. Tip files with `rmb_habit` / `estate_shuttle` may be shown only as habits.

## How to use `tips/`

1. Read `tips/SCHEMA.md` before adding or citing a tip.
2. Load YAML tips; require `community: true`, non-empty `source`, valid `as_of`.
3. Prefer tips whose `audience` matches the user (`tourist` / `local` / `both`).
4. Surface high-`risk` tips with extra caution (e.g. informal RMB).
5. Update `references/coverage-matrix.md` when tip categories expand coverage *documentation* — tips do not change ETA “In” status.

## Attribution sentence (include when using DATA.GOV.HK data)

> Data from [DATA.GOV.HK](https://data.gov.hk/) and the respective operators / Transport Department. Provided AS IS; not affiliated with the Government of the HKSAR or the operators.

When citing tips, add:

> Community tip(s) from this skill’s `tips/` files; not official schedules. Check sources dated `as_of`.

## Scripts

Optional helpers under `scripts/` (thin HTTPS clients). Prefer calling official URLs directly if scripts are missing. Do not vendor GPL libraries into this MIT tree.
