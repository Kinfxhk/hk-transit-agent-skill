# Local tips schema (community layer)

**Canonical store:** `references/local-tips.yaml` (`tips` array).  
Optional per-file copies under `tips/examples/` must match the same required fields.

Tips are **not** official ETA. Agents must label them `community` and never merge them into official wait times or journey durations.  
Global policy: `duration_policy_global: official_eta_or_gtfs_only`.

## Required fields (every tip in `tips:`)

| Field | Type | Rule |
|-------|------|------|
| `id` | string | Stable kebab-case |
| `community` | bool | **Must be `true`** |
| `source` | string | URL or citable publication |
| `as_of` | date | `YYYY-MM-DD` |
| `summary_zh` and/or `summary_en` / `summary` | string | Annotation only — **no minute claims** |
| `duration_policy` | string | Prefer `official_eta_or_gtfs_only` |

## Strongly recommended

| Field | Rule |
|-------|------|
| `category` | See categories |
| `audience` | `tourist` · `local` · `both` |
| `unofficial` | `true` |
| `never_claim` | list of forbidden assertions |
| `applies_when` | when to surface |
| `related_sources` | extra official URLs |
| `route_check` | `verified` \| `unverified` + ids / note |
| `risk` | `low` · `medium` · `high` |
| `disclaimer` | AS IS line |
| `expires` | optional; `as_of` > 90 days → QA WARN |

## Forbidden

- Missing `source` or `as_of` or `community: true`
- Embedding ETA / journey **minutes** in tip text
- Inventing red-van or estate-shuttle schedules
- Treating aliases as official stop ids

## Categories (examples)

`mode_choice` · `shortcut_walk` · `tourist_default` · `fare_hint` · `rmb_habit` · `estate_shuttle` · `other`  
Research may also use descriptive `category` strings (`mode_tradeoff`, `last_train_check`, …) — keep them; map in docs if needed.

## Templates

`templates:` entries with `source: REQUIRED` are **not** tips until filled. Do not surface them to users.
