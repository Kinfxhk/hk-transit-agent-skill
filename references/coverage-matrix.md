# Coverage matrix (V0 + V0.5)

| Mode / layer | Live ETA | Static route / fare | V0 status |
|--------------|----------|---------------------|-----------|
| KMB / LWB | Yes | Yes (+ GTFS) | **In** |
| Citybus (incl. ex-NWFB via CTB) | Yes (V2) | Yes | **In** |
| Green minibus | Yes | Yes | **In** |
| MTR heavy rail | Yes (Next Train) | CSV / GTFS | **In** |
| Light Rail | Yes | Yes | **In** |
| MTR bus / feeder | Yes | — | V1 candidate |
| HKKF / Sun Ferry | Partial ETA | Partial | V1 candidate |
| Tram | Stops CSV | Limited | **Gap** — no verified public ETA |
| Peak Tram | Fare/route resources | Limited | **Gap** — no verified public ETA |
| Red minibus | No unified official ETA | Informal | **Permanent gap** (tips only: `rmb_habit`) |
| Estate free shuttle | Usually none | Estate notices | **Permanent gap** (tips + user timetable) |
| Taxi (city-wide empty) | Fleet APIs only (partial) | Fare tables PDF | **Gap** — not city-wide |
| Walking last mile | PedRoute / OSRM | OSM | **In** (assistive) |
| Motion comfort | Heuristics YAML | — | **In** as preference only |
| Place aliases (tourist/local) | — | `assets/aliases.yaml` | **V0.5** hints only |
| Airport / border / ferry defaults | — | aliases + tips | **V0.5** search hints |
| Fare / Octopus reminders | — | official fare pages or `fare_hint` tips | **V0.5** cite source |
| Community tips layer | Never | `tips/` + SCHEMA | **Tips** — not ETA |

Update this file when a source is newly opened and verified on an official page.
Tips never flip a mode from Gap → In for live ETA.
