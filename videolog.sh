# Set configuration
STREAMURL='rtmp://live.zuidwesttv.nl/live'
LOGDIR=/var/video
TIMESTAMP=$(/usr/bin/date +"%Y-%m-%d_%Hu") #YYYY-MM-DD_UUu
# TODO: Define time to keep files

# Check for ffmpeg
if ! command -v ffmpeg
then
    echo "FFmpeg not found. Installing..."
    sudo apt-get install -y ffmpeg
else
    echo "FFmpeg is already installed."
fi

# Check for logdir
if [ ! -d "$LOGDIR" ]; 
then
    echo "Logdir not found. Creating it.."
    mkdir -p $LOGDIR
else
    echo "Logdir found. Nothing to do. Good!"
fi

# Log for 1h
echo "Starting log for 1h..."
ffmpeg -y -hide_banner -loglevel error -i $STREAMURL -t 3600 -c:v copy -c:a copy $LOGDIR/$TIMESTAMP.mp4

# TODO: Validation etc.
