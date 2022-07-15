import yt_dlp
import sys

ydl_opts = {
    'format': 'bestaudio/best',
    'outtmpl': '%(title)s.%(ext)s',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '320',
    }],
}

URL = 'https://www.youtube.com/watch?v=K0JlIleYkqM&list=PLOCxtAXFGwVhtYByO_mrGc49T9DHo1Ehl&index=2'

with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    ydl.download(URL)