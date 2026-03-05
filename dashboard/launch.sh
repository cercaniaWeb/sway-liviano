# Dashboard launcher script
# Opens the system dashboard in a clean Chrome app window

DASHBOARD_FILE="${1:-index.html}"
# Add a timestamp to the index.html URL to bypass browser cache
if [ "$DASHBOARD_FILE" = "index.html" ]; then
    DASHBOARD_PATH="file:///home/lrs/sway-liviano/dashboard/index.html?t=$(date +%s)"
else
    DASHBOARD_PATH="file:///home/lrs/sway-liviano/dashboard/$DASHBOARD_FILE"
fi

# Special handle for Manager (points to local service)
if [ "$DASHBOARD_FILE" = "manager" ]; then
    DASHBOARD_PATH="http://localhost:8045/?t=$(date +%s)"
fi

# Select class based on file (index.html is the sidebar, others are centered)
WINDOW_CLASS="sway-dashboard-sidebar"
if [ "$DASHBOARD_FILE" != "index.html" ]; then
    WINDOW_CLASS="sway-dashboard-center"
fi

# Toggle logic
if [ "$DASHBOARD_FILE" = "index.html" ]; then
    TARGET_NAME="Sway Liviano Dashboard"
elif [ "$DASHBOARD_FILE" = "agent_skills.html" ]; then
    TARGET_NAME="Sway Liviano - Agent Skills"
else
    TARGET_NAME="Sway Liviano - Master Shortcuts"
fi

if swaymsg -t get_tree | jq -r '.. | select(.name? != null) | .name' | grep -i "$TARGET_NAME" > /dev/null; then
    swaymsg "[title=\"(?i)$TARGET_NAME\"] kill"
    exit 0
fi

# Antigravity Manager Background Service
if ! pgrep -x "antigravity_too" > /dev/null; then
    # Set critical environment variables for headless operation
    export ABV_WEB_PASSWORD="Correo123"
    export ABV_API_KEY="Correo123"
    # Disable auth for localhost access to avoid 401 issues in headless mode
    export ABV_AUTH_MODE="off"
    # Point to the correct static files directory
    export ABV_DIST_PATH="/home/lrs/Antigravity-Manager/dist"
    
    /home/lrs/Antigravity-Manager/deb-extract/usr/bin/antigravity_tools --headless > /tmp/antigravity_manager.log 2>&1 &
    
    if [ "$DASHBOARD_FILE" = "manager" ]; then
        sleep 2
    fi
fi

# Use Thorium in app mode
thorium-browser --app="$DASHBOARD_PATH" \
                --class="$WINDOW_CLASS" \
                --name="$WINDOW_CLASS" \
                --app-id="$WINDOW_CLASS" \
                --enable-features=UseOzonePlatform \
                --ozone-platform=wayland \
                --enable-transparent-visuals \
                --disable-background-color-optimization &
