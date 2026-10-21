#!/usr/bin/env bash
# Example only: Citybus V2 ETA — stop_id + route required.
# Usage: ./eta_ctb_example.sh 001145 11
set -euo pipefail
STOP="${1:?stop_id}"
ROUTE="${2:?route}"
URL="https://rt.data.gov.hk/v2/transport/citybus/eta/CTB/${STOP}/${ROUTE}"
echo "GET $URL" >&2
curl -fsS "$URL"
echo
echo "fetched_at=$(TZ=Asia/Hong_Kong date -Iseconds)" >&2
