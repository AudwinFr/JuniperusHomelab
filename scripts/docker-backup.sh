#!/usr/bin/env bash
# ------------------------------------------------------------
# backup.sh – backup Docker‑Compose monitoring stack
# Location: /opt/docker/monitoring/backup.sh
# ------------------------------------------------------------

# Exit immediately if a command exits with a non‑zero status.
# (You can remove `set -e` if you prefer the script to continue on errors.)
set -e

# ---------- 1. Prepare a timestamped backup directory ----------
TIMESTAMP=$(date +%Y%m%d-%H%M)                     # e.g. 20240115-0230
BACKUP_ROOT="/opt/docker/monitoring/backups"
BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"

mkdir -p "${BACKUP_DIR}"                         # create the target folder
echo "Created backup directory: ${BACKUP_DIR}"

# ---------- 2. Stop the Docker‑Compose services ----------
cd /opt/docker/monitoring
echo "Stopping Docker‑Compose services…"
docker compose stop

# ---------- 3. Copy configuration files ----------
cp docker-compose.yml "${BACKUP_DIR}/"
cp prometheus/prometheus.yml "${BACKUP_DIR}/"
echo "Configuration files copied."

# ---------- 4. Archive persistent data ----------
tar czf "${BACKUP_DIR}/grafana-data.tar.gz"   data/grafana/
tar czf "${BACKUP_DIR}/prometheus-data.tar.gz" data/prometheus/
echo "Data archives created."

# ---------- 5. Restart the services ----------
echo "Starting Docker‑Compose services…"
docker compose start

# ---------- 6. Prune old backups (keep the top‑level folder) ----------
# -mindepth 1 prevents removal of the parent `${BACKUP_ROOT}` directory.
# -mtime +7 selects directories older than 7 days.
find "${BACKUP_ROOT}" -mindepth 1 -type d -mtime +7 -exec rm -rf {} \;
echo "Old backups (older than 7 days) removed."

echo "Backup completed successfully."
