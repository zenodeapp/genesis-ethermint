REPO_DIR=$(cd "$(dirname "$0")"/.. && pwd)

# Add service
cp $REPO_DIR/services/genesisd.service /etc/systemd/system/genesisd.service
systemctl daemon-reload
systemctl enable genesisd
