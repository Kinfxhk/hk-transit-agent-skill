# Coverage matrix (V0 + V0.1 tips + V1-A/B)

| Mode / layer | Live ETA | Static route / fare | Status |
|--------------|----------|---------------------|--------|
| KMB / LWB | Yes | Yes (+ GTFS) | **In (V0)** |
| Citybus (incl. ex-NWFB via CTB) | Yes (V2) | Yes | **In (V0)** |
| Green minibus | Yes | Yes | **In (V0)** |
| MTR heavy rail | Yes (Next Train) | CSV / GTFS | **In (V0)** |
| Light Rail | Yes | Yes | **In (V0)** |
| NLB | Official where published | Yes | **V1-A** |
| MTR bus / feeder | Yes | — | **V1-A** |
| HKKF / Sun Ferry / Fortune | Partial ETA | Partial | **V1-A** |
| Tram / Star Ferry / Peak Tram | — | Static fare/route | **V1-A static**; live ETA = Gap until verified |
| Red minibus | No unified official ETA | Informal | **Permanent gap** (templates in `local-tips.yaml` only) |
| Estate free shuttle | Usually none | Estate notices | **Permanent gap** (template + user timetable) |
| Taxi (city-wide empty) | Fleet APIs only (partial) | Fare tables PDF | **Gap** |
| Walking last mile | PedRoute / OSRM | OSM | **In** |
| Motion comfort | Heuristics YAML | — | Preference only |
| Place aliases (tourist/local) | — | `assets/aliases.yaml` | **V0.1** hints only |
| Community tips | Never for minutes | `references/local-tips.yaml` | **V0.1 / V1-B** annotate only |
| Option output: route check + `queried_at` | — | SKILL hard rule | **Required** |

Tips never flip a mode from Gap → In for live ETA.
Every official option must cite journey-time source URL + `queried_at`, or label unverified.
