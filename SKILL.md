---
name: hk-transit
description: >
  Plan Hong Kong public transport trips using official open data (DATA.GOV.HK ETA,
  TD GTFS, LandsD pedestrian routing or OSRM walk). Use when the user asks how to
  go somewhere in Hong Kong by MTR, Light Rail, franchised bus, green minibus, or
  related open-data modes. Do not use for medical advice about motion sickness.
---

# Hong Kong transit (V0)

## Hard rules

1. **Official open data only.** Fetch DATA.GOV.HK / operator-published ETA and TD GTFS. **Never scrape** Citymapper, Google Maps HTML, or closed operator apps.
2. **No secrets in this skill.** Do not invent API keys. Keyless public endpoints only in V0; any future key stays in environment variables.
3. **No operator logos** as branding. Attribute text sources; do not impersonate HKeMobility or operators.
4. **AS IS.** Times and routes are planning aids. Live conditions, diversions, and typhoon suspensions override this skill — tell the user to check the operator / HKeMobility when unsure.
5. **Motion comfort is preference, not medical advice.** Heuristics in `references/motion-comfort-heuristics.yaml` are community tags only.
6. **Honest coverage.** If a mode has no official ETA (red minibus, most estate free shuttles, tram real-time, Peak Tram real-time, city-wide taxi vacancy), say so — do not fabricate.

## V0 in scope

- ETA: KMB / LWB, Citybus V2 (CTB), Green Minibus (GMB), MTR Next Train, Light Rail
- Static transfer candidates: Transport Department GTFS headway / routes / stops / fares
- Walking: LandsD 3D Pedestrian Route Search **or** OSRM walk (OSM); landmark names from OSM / user hints
- Output always includes: source URLs, data timestamps (`opened_at` / `generated_timestamp`), coverage gaps, AS IS disclaimer

## Out of scope (document only — permanent gaps for V0)

- Red minibuses (RMB), most estate free shuttles, tram / Peak Tram live ETA, city-wide empty taxi locations
- Guaranteeing “fastest arrival” or turn-by-turn legal navigation liability

## Workflow

1. Clarify origin, destination (place name or coordinates), departure time, and preferences: fastest / fewest transfers / less walking / motion-comfort / accessibility.
2. Resolve places (aliases in `assets/aliases.yaml` if present). Prefer official stop/station ids when known.
3. Build candidate itineraries from TD GTFS (or a local cache). Do not claim a single official “PT journey planner API” unless one is later verified on an official page.
4. For each transit leg, call the matching ETA script or HTTPS endpoint (see `references/data-sources.md`). Respect HTTP 429 with backoff.
5. For walking legs, call PedRoute (zh-HK directions if available) or OSRM walk. Summarise road names and key landmarks; do not promise every street sign.
6. If the user is motion-sensitive, down-rank routes tagged in `motion-comfort-heuristics.yaml` (long tunnels, windy ferry legs, winding hill routes) and explain the trade-off.
7. Reply with ranked options. Each option: modes, waits (if ETA), walk summary, fare estimate if GTFS fare exists (label as estimate), sources + timestamps, gaps.
8. For estate bus / RMB / missing ETA: ask the user for a timetable, or point them to HKeMobility / the operator — never invent schedules.

## Attribution sentence (include when using DATA.GOV.HK data)

> Data from [DATA.GOV.HK](https://data.gov.hk/) and the respective operators / Transport Department. Provided AS IS; not affiliated with the Government of the HKSAR or the operators.

## Scripts

Optional helpers under `scripts/` (thin HTTPS clients). Prefer calling official URLs directly if scripts are missing. Do not vendor GPL libraries into this MIT tree.
