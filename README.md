# hk-transit-agent-skill

**Status: V0 scaffold** — Agent Skill recipe for Hong Kong public transport using **official open data** (DATA.GOV.HK ETA, TD GTFS, pedestrian walk). Not affiliated with the Government of the HKSAR, MTR, KMB, Citybus, or other operators.

[繁體中文說明見下方](#繁體中文)

## What this is

A Cursor / agent-compatible [`SKILL.md`](./SKILL.md) plus attribution tables and thin fetch examples so an agent can:

- Suggest multi-leg trips (MTR / Light Rail / franchised bus / green minibus)
- Attach live ETA when official APIs exist
- Summarise walking transfers (LandsD PedRoute or OSRM walk)
- Apply optional motion-comfort **preferences** (not medical advice)

## V0 scope (Boss-approved)

| In | Out (documented gaps) |
|----|------------------------|
| KMB/LWB + Citybus V2 + GMB ETA | Red minibus unified ETA |
| MTR Next Train + Light Rail | Most estate free shuttles |
| TD GTFS static transfers | Tram / Peak Tram live ETA |
| Walk assist + coverage matrix + AS IS | City-wide empty taxi map |
| `.github/FUNDING.yml` → Buy Me a Coffee | Scraping Citymapper / Google |

## Use as a skill

1. Copy or clone this repo into your agent skills folder (or point the agent at `SKILL.md`).
2. Ask in natural language: e.g. “點樣由觀塘去中環，易暈、少轉。”
3. The agent should follow `SKILL.md` and cite sources from `references/`.

## Sponsor (Buy Me a Coffee)

GitHub Sponsors button is wired via [`.github/FUNDING.yml`](./.github/FUNDING.yml).

1. Create a page on [Buy Me a Coffee](https://www.buymeacoffee.com/) (Hong Kong is listed for Stripe payouts on their Help — re-verify on their site when you sign up).
2. Replace `YOUR_BMC_USERNAME` in `FUNDING.yml`.
3. Repo **Settings → General → Features → Sponsorships** → enable.

No PayMe / PayPal required for this path. Do not put payment secrets in the repo.

## Disclaimer

Planning aid only. Data from open portals is **AS IS**. Typhoons, diversions, and last trains: check operators or [HKeMobility](https://www.td.gov.hk/en/public_services/hong_kong_emobility/). Motion-comfort tags are **not medical advice**.

## License

MIT — see [LICENSE](./LICENSE) and [NOTICE](./NOTICE). Operator datasets remain their IP; attribute DATA.GOV.HK / TD / operators.

---

## 繁體中文

香港公共交通 **Agent Skill** 脚手架（V0）：用官方開放數據幫手規劃轉乘同到站時間，**唔刮** Citymapper／Google，**唔入** API key，**唔嵌**營辦商標 logo。

- 範圍同缺口：見 [`references/coverage-matrix.md`](./references/coverage-matrix.md)
- 資料源歸因：見 [`references/data-sources.md`](./references/data-sources.md)
- 贊助：Buy Me a Coffee（改 `FUNDING.yml` 用戶名）

紅巴、多數屋苑免費巴、電車／纜車實時、全市的士空車＝**永久缺口**，只寫明、唔做假。
