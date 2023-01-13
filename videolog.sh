# Set configuration
STREAMURL='rtmp://live.zuidwesttv.nl/live'
LOGDIR=/var/video
TIMESTAMP=$(/usr/bin/date +"%Y-%m-%d_%Hu") #YYYY-MM-DD_UUu
# TODO: Define time to keep files

# Check for ffmpeg
if ! command -v ffmpeg &> /dev/null
then
    echo "FFmpeg not found. Installing..."
    sudo apt-get install -y ffmpeg
else
    echo "FFmpeg is already installed."
fi

# Log for 1h
ffmpeg -i $STREAMURL -t 3600 -c:v copy -c:a copy $LOGDIR/$TIMESTAMP.mp4

# TODO: Validation etc.
