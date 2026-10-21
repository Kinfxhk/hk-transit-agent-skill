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

1. **Official open data only for ETA / journey times.** Fetch DATA.GOV.HK / operator-published ETA and TD GTFS (`stop_times` / schedules). **Never scrape** Citymapper, Google Maps HTML, or closed operator apps. Do not vendor GPL `hk-bus-eta`.
2. **`duration_policy: official_eta_or_gtfs_only`.** Journey minutes and waits come **only** from official ETA or GTFS. Community tips never embed or imply fixed minutes.
3. **Every official option must include (FAIL if missing):**
   - **Route verification** — see section below.
   - **`source_url`** — operator or DATA.GOV.HK page / API dataset URL used for that leg’s timing.
   - **`queried_at`** — ISO-8601 timestamp in Asia/Hong_Kong when you fetched the data. **Use this field name only** (do not substitute `opened_at` or `generated_timestamp` in user-facing option cards; those may appear inside raw API payloads but the Skill output field is always `queried_at`).
4. **Two output layers — never mix.**
   - **Official:** ETA, GTFS legs, PedRoute/OSRM walk, official fare tables.
   - **Community tip:** `references/local-tips.yaml`. Annotate / reorder only; **never** supply minutes or waits from tips.
5. **No sourceless tips.** Reject any tip missing `source`, `as_of`, or `community: true`. Templates with `source: REQUIRED` are not tips.
6. **No secrets / no operator-logo branding.** AS IS; do not impersonate HKeMobility or operators.
7. **Motion comfort is preference, not medical advice.**
8. **Honest coverage.** Red van / estate: tip or template only — never invent headways.

## 覆核路線（required — every official leg）

Before presenting an option, for **each transit leg**:

1. Resolve **official route id** and **stop sequence** from TD GTFS and/or the operator open-data stop list.
2. Confirm the proposed board/alight stops appear on that route’s sequence (or transfer node is a documented station).
3. If step 1–2 succeed → mark leg `route_check: verified` and list `official_route_ids` / `official_stop_ids` with `stop_id_source` (e.g. TD GTFS URL).
4. If not → mark leg **`未能核實` / `route_check: unverified`**, state what is missing, and **do not** invent stop ids from aliases or tips.
5. Aliases in `assets/aliases.yaml` are **search hints only** — never overwrite or invent official stop ids.

Walking legs: cite PedRoute or OSRM as `source_url` + `queried_at`; do not hardcode exit numbers from tips (`tip-exit-walk-pedroute` is process-only).

## V0 in scope

- ETA: KMB / LWB, Citybus V2 (CTB), Green Minibus (GMB), MTR Next Train, Light Rail
- Static transfers: TD GTFS · Walking: LandsD PedRoute **or** OSRM walk

## V0.1 / V1-B (tips)

- Canonical: `references/local-tips.yaml` (`duration_policy_global: official_eta_or_gtfs_only`)
- Schema: `tips/SCHEMA.md`
- Aliases: `assets/aliases.yaml` (tourist EN/zh hints)

## V1-A (follow-up scripts)

- NLB, MTR bus, ferry ETA where official; tram / Star Ferry / Peak Tram **static** until live ETA verified on an official page

## Workflow

1. Clarify origin, destination, time, tourist vs local, motion-comfort.
2. Resolve places via aliases (**hints only**); prefer official stop ids from GTFS / operator data.
3. Build GTFS candidates.
4. **Run 覆核路線** on each leg (section above).
5. Fetch ETA / schedule; set **`source_url` + `queried_at`** per leg. Respect HTTP 429.
6. Walking: PedRoute / OSRM + `source_url` + `queried_at`.
7. Load tips from `references/local-tips.yaml` → `tips` array only (skip `templates` and any tip missing required fields). WARN if `as_of` older than 90 days. Match `applies_when` / audience; honour `never_claim`.
8. Motion heuristics + disclaimer if requested.
9. **Reply structure (required):**
   - **Official options** — each option/leg: modes; `route_check` verified **or** `未能核實`; waits/durations from ETA/GTFS only; **`source_url`**; **`queried_at`**; fare estimate if any (label estimate); gaps.
   - **Community tips** — separate section: id/title, `as_of`, `source`, disclaimer. Never fold into ETA lines.
10. Advise HKeMobility for live confirmation when useful (`tip-verify-hkemobility`).

## How to use `references/local-tips.yaml`

1. Require `community: true`, non-empty `source`, valid `as_of`.
2. Prefer matching `audience` / `applies_when`.
3. Annotate or reorder **already legal** official candidates only.
4. High-risk (`rmb_habit`, estate): extra caution; no invented schedules.

## Attribution

> Data from [DATA.GOV.HK](https://data.gov.hk/) and the respective operators / Transport Department. Provided AS IS; not affiliated with the Government of the HKSAR or the operators.

> Community tip(s) from `references/local-tips.yaml`; not official schedules. Check `source` dated `as_of`.

## Scripts

Optional helpers under `scripts/`. Prefer official HTTPS endpoints directly.
