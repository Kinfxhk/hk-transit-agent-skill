# Data sources (V0 attribution)

Always cite the dataset page and the live response timestamp. Re-open official pages before claiming new endpoints.

| Mode | Dataset / API (index) | Notes |
|------|----------------------|--------|
| KMB / LWB ETA | https://data.gov.hk/en-data/dataset/hk-td-tis_21-etakmb · `https://data.etabus.gov.hk/` | ETA ~1 min; IP of operators via TD |
| Citybus V2 ETA | https://data.gov.hk/en-data/dataset/ctb-eta-transport-realtime-eta · `https://rt.data.gov.hk/v2/transport/citybus/` | Use **V2** / company id `CTB`; expect 429 |
| GMB ETA | https://data.gov.hk/en-data/dataset/hk-td-sm_7-real-time-arrival-data-of-gmb · `https://data.etagmb.gov.hk/` | Green minibus only — not red |
| MTR Next Train | https://data.gov.hk/en-data/dataset/mtr-data2-nexttrain-data | ~10 s; MTR IP |
| Light Rail | https://data.gov.hk/en-data/dataset/mtr-lrnt_data-light-rail-nexttrain-data | ~10 s; MTR IP |
| TD GTFS (static) | https://data.gov.hk/en-data/dataset/hk-td-tis_11-pt-headway-en | Bi-weekly; not live |
| Pedestrian walk | LandsD CSDI PedRoute API docs · or OSRM walk | Follow Map API terms; no hammering |
| HKeMobility | https://www.td.gov.hk/en/public_services/hong_kong_emobility/ | Official app — fallback for users; **no verified public PT journey API in V0 research** |

## Forbidden

- Scraping Citymapper or Google Maps web/app content
- Embedding operator trademarks / logos as product branding
- Storing API keys in the repository
