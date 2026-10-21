# Local tips schema (community layer)

**Canonical store:** `references/local-tips.yaml` (`tips` array).  
Optional per-file copies under `tips/examples/` must match the same fields.

Tips are **not** official ETA. Agents must label them `community` in every user-facing reply and never merge them into official wait times or journey durations.

## Required fields (every tip in `tips:`)

| Field | Type | Rule |
|-------|------|------|
| `id` | string | Stable kebab-case id |
| `title` | string | Short EN or zh-HK title |
| `title_zh` | string | Traditional Chinese title (optional if `title` is already zh-HK) |
| `category` | enum | See categories below |
| `audience` | enum[] | `tourist` · `local` · `both` |
| `summary` | string | Preference / shortcut annotation only — **no minute claims** |
| `summary_zh` | string | zh-HK summary |
| `community` | bool | **Must be `true`** |
| `unofficial` | bool | **Must be `true`** |
| `source` | string | URL or named published source |
| `as_of` | date | `YYYY-MM-DD` |
| `expires` | date \| null | Optional; stale tips → WARN if `as_of` > 90 days (QA) |
| `route_check` | object | See below |
| `risk` | enum | `low` · `medium` · `high` |
| `disclaimer` | string | Short AS IS line |

### `route_check` (required)

| Field | Rule |
|-------|------|
| `status` | `verified` \| `unverified` |
| `official_route_ids` | list; empty if unknown |
| `official_stop_ids` | list; empty if unknown |
| `stop_id_source` | required when any id is listed (e.g. TD GTFS URL) |
| `note` | required when `unverified` |

## Forbidden

- Tip with empty / missing `source` or `as_of`
- Presenting tip wait times or durations as live ETA / official journey time
- Inventing red-van or estate-shuttle schedules (`templates` only until sourced)
- Writing official stop ids without `stop_id_source`

## Categories (`category`)

| Value | Meaning |
|-------|---------|
| `interchange` | Station exit / concourse / cross-platform tips |
| `shortcut_walk` | Pedestrian shortcut |
| `mode_choice` | When bus/minibus is often preferred vs rail (**still verify with ETA**) |
| `tourist_default` | Airport / ferry pier / border defaults |
| `fare_hint` | Octopus / tourist ticket reminders (cite official fare page) |
| `rmb_habit` | Red minibus habit — tip only |
| `estate_shuttle` | Estate free bus — tip + user timetable |
| `other` | Misc; still needs source |
