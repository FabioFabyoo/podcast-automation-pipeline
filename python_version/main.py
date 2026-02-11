import os
import subprocess
from ftplib import FTP
from datetime import datetime

# Configurazione 
FTP_CONFIG = {"host": "ftp.sito.com", "user": "utente", "pass": "password"}
BASE_NAME = "andromeday"

def run_pipeline():
    # 1. Download & Clean FTP 
    with FTP(FTP_CONFIG["host"]) as ftp:
        ftp.login(FTP_CONFIG["user"], FTP_CONFIG["pass"])
        for i in range(1, 5):
            fname = f"{BASE_NAME}_{i}.wav"
            with open(fname, 'wb') as f:
                ftp.retrbinary(f"RETR {fname}", f.write)
            ftp.delete(fname) # Pulizia server 

    # 2. Transcode & Merge [cite: 2, 3]
    for i in range(1, 5):
        subprocess.run(f"ffmpeg -i {BASE_NAME}_{i}.wav -ar 44100 -ac 2 -b:a 192k {BASE_NAME}_{i}.mp3 -y", shell=True)
    
    # Merge, CBR 128k e ridenominazione data 
    today = datetime.now().strftime("%Y%m%d")
    final_cmd = (
        f"ffmpeg -i {BASE_NAME}_1.mp3 -i {BASE_NAME}_2.mp3 -i {BASE_NAME}_3.mp3 -i {BASE_NAME}_4.mp3 "
        f"-filter_complex '[0:a][1:a][2:a][3:a]concat=n=4:v=0:a=1' "
        f"-b:a 128k -c:a libmp3lame andromeday_p_{today}.mp3 -y"
    )
    subprocess.run(final_cmd, shell=True)

if __name__ == "__main__":
    run_pipeline()
