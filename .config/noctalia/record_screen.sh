#!/bin/bash
# 保存为 ~/bin/noctalia-record-toggle.sh

OUTPUT_DIR="$HOME/Videos/recordings"
mkdir -p "$OUTPUT_DIR"
PID_FILE="/tmp/noctalia-recording.pid"

if [ -f "$PID_FILE" ]; then
    # 停止录制
    PID=$(cat "$PID_FILE")
    kill -SIGINT $PID 2>/dev/null
    rm "$PID_FILE"
    notify-send "录屏结束" "文件已保存"
else
    # 开始录制
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    OUTPUT_FILE="$OUTPUT_DIR/screen_$TIMESTAMP.mp4"

    gpu-screen-recorder -w screen -f 60 -a default_output -o "$OUTPUT_FILE" &
    echo $! > "$PID_FILE"
    notify-send "录屏开始" "$TIMESTAMP"
fi
