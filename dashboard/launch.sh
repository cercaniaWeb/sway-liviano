# Dashboard launcher script
# Opens the system dashboard in a clean Chrome app window

DASHBOARD_FILE="${1:-index.html}"
DASHBOARD_PATH="file:///home/lro/.gemini/antigravity/scratch/dashboard/$DASHBOARD_FILE"

# Use Chrome in app mode - this gives a clean window without address bar
thorium-browser --app="$DASHBOARD_PATH" --class="dashboard" &
