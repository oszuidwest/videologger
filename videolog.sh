# Set configuration
STREAMURL='rtmp://live.zuidwesttv.nl/live'
LOGDIR=/var/video
TIMESTAMP=$(/usr/bin/date +"%Y-%m-%d_%Hu") #YYYY-MM-DD_UUu
# TODO: Define time to keep files

# Bail if no RTMP
if [[ ! $STREAMURL =~ ^rtmp.*:// ]]; then
  echo "We can only record RTMP streams for now. Sorry. Exiting!"
  exit 1
fi

# Check for ffmpeg
if ! hash ffmpeg 2>/dev/null; 
then
    echo "FFmpeg not found. Installing..."
    sudo apt-get install -y ffmpeg >/dev/null 2>&1
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
