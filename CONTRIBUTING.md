# Contributing

- Clean-room: do not copy closed apps’ UI, strings, or scraped feeds.
- Prefer MIT-compatible code only inside this tree. Do not vendor GPL libraries (e.g. do not ship `hkbus/hk-bus-eta` as a dependency).
- AI-assisted patches OK if a human reviews and no secrets / trademarks / scraped content are introduced.
- Update `references/coverage-matrix.md` when you verify a new official endpoint (open the official page; note URL + date).
- Estate shuttle timetables: contribute as clearly labelled user/community data, never as “official ETA”.

## Tips (`tips/`)

- Every tip YAML must include `community: true`, `source` (URL or citable publication), and `as_of` (`YYYY-MM-DD`).
- No source / no date = **reject** (QA FAIL).
- Do not invent red-van or estate-shuttle schedules.
- Aliases are search hints only; do not pollute official stop ids.
