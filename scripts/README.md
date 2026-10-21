# Scripts (V0 stubs)

Thin HTTPS examples will live here (`eta_kmb.mjs`, `eta_ctb.mjs`, `eta_gmb.mjs`, `eta_mtr.mjs`, `eta_lr.mjs`).

Rules:

- Call official URLs from `../references/data-sources.md` only
- No GPL dependencies (do not vendor `hkbus/hk-bus-eta` into this MIT tree)
- Print JSON + `fetched_at` (ISO8601 Asia/Hong_Kong)
- Exit non-zero on HTTP errors; backoff on 429

Until stubs land, the agent should `curl` the documented endpoints directly.
