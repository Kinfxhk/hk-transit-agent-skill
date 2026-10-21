# Local tips schema (community layer)

**Canonical store:** `references/local-tips.yaml` (`tips` array).

Tips are **not** official ETA. Never merge tip text into official wait times or journey durations.  
Global: `duration_policy_global: official_eta_or_gtfs_only`.

## Required fields (every tip in `tips:`)

| Field | Type | Rule |
|-------|------|------|
| `id` | string | Stable kebab-case |
| `title` | string | Short EN title |
| `community` | bool | **Must be `true`** |
| `source` | string | URL or citable publication |
| `as_of` | date | `YYYY-MM-DD` |
| `disclaimer` | string | AS IS line |
| `risk` | enum | `low` · `medium` · `high` |
| `summary_zh` and/or `summary_en` / `summary` | string | Annotation only — **no minute claims** |
| `duration_policy` | string | Prefer `official_eta_or_gtfs_only` |

## Strongly recommended

`title_zh` · `category` · `audience` · `unofficial` · `never_claim` · `applies_when` · `related_sources` · `route_check` · `expires`

## Forbidden

- Missing `source` / `as_of` / `community` / `title` / `disclaimer` / `risk`
- Embedding ETA / journey **minutes** in tip text
- Inventing red-van or estate-shuttle schedules
- Treating aliases as official stop ids

## Categories

`mode_choice` · `shortcut_walk` · `tourist_default` · `fare_hint` · `rmb_habit` · `estate_shuttle` · `other`

## Templates / deferred

`templates:` with `source: REQUIRED` are not tips. Weak-source entries may sit under `deferred_v01` until reinforced.
