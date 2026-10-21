# Local tips schema (community layer)

Tips are **not** official ETA. Agents must label them `community` in every user-facing reply and never merge them into official wait times.

## Required fields (every tip)

| Field | Type | Rule |
|-------|------|------|
| `id` | string | Stable kebab-case id |
| `title` | string | Short EN or zh-HK title |
| `title_zh` | string | Traditional Chinese title (optional if `title` is already zh-HK) |
| `category` | enum | See categories below |
| `audience` | enum[] | `tourist` · `local` · `both` |
| `summary` | string | One or two sentences; what to do |
| `summary_zh` | string | zh-HK summary |
| `community` | bool | **Must be `true`** |
| `source` | string | URL or named published source (forum post with URL, news, estate notice PDF, etc.) |
| `as_of` | date | `YYYY-MM-DD` — last verified or published |
| `expires` | date \| null | Optional; if past `expires`, agent must say tip may be stale |
| `applies_to` | object | Optional: `from` / `to` / `modes` / `stations` (hints only — **not** official stop ids unless copied from GTFS with `stop_id_source`) |
| `risk` | enum | `low` · `medium` · `high` (e.g. informal RMB habit = high) |
| `disclaimer` | string | Short AS IS line |

## Forbidden

- Tip with empty / missing `source` or `as_of`
- Presenting tip wait times as live ETA
- Inventing red-van schedules or estate shuttle times
- Writing official `stop_id` / station codes without citing GTFS or operator open data (`stop_id_source`)

## Categories (`category`)

| Value | Meaning |
|-------|---------|
| `interchange` | Station exit / concourse / cross-platform tips |
| `shortcut_walk` | Pedestrian shortcut (footbridge, alley) |
| `mode_choice` | When bus/minibus is often faster than rail (still verify with ETA) |
| `tourist_default` | Airport / ferry pier / border defaults |
| `fare_hint` | Octopus / tourist ticket reminders (cite official fare page) |
| `rmb_habit` | Red minibus **habit** lines — tip only, never live ETA |
| `estate_shuttle` | Estate free bus — tip + user timetable only |
| `other` | Misc; still needs source |

## File layout

```
tips/
  SCHEMA.md           # this file
  README.md
  examples/
    _template.yaml    # copy for new tips
    *.yaml            # curated tips (research / community)
```

One tip per file under `examples/` (or a single list file with `tips: []` — prefer one file per tip for review).
