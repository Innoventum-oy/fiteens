#!/bin/bash
# Build FITeens web application for production deployment
# Base href is set to /app/ for deployment under a subdirectory

flutter build web \
  --base-href "/app/" \
  --release

# Note: As of Flutter 3.22+, the web renderer is auto-selected by default
# CanvasKit is used by default for better performance and compatibility

# Alternative options (uncomment as needed):
# --source-maps                         # Generate source maps for debugging
# --dart-define=PRODUCTION=true         # Pass environment variables
# --dart-define=FLUTTER_WEB_USE_SKIA=true   # Force CanvasKit renderer
# --dart-define=FLUTTER_WEB_USE_SKIA=false  # Force HTML renderer
# --web-resources-cdn                   # Use CDN for Flutter resources (faster load)
# --no-tree-shake-icons                 # Include all material icons (larger bundle)

