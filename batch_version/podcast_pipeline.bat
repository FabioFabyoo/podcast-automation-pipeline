@echo off
setlocal enabledelayedexpansion

:: --- CONFIGURAZIONE ---
set "WINSCP_PATH=C:\Program Files (x86)\WinSCP\WinSCP.com"
set "TEMP_DIR=.\temp_work"
set "EXPORT_DIR=.\podcast"

:: Credenziali (Utilizzate nei comandi WinSCP) 
set "FTP_USER=utente"
set "FTP_PASS=password"
set "FTP_HOST=ftp.sito.com"

if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"
if not exist "%EXPORT_DIR%" mkdir "%EXPORT_DIR%"

:: 1. DOWNLOAD & PULIZIA 
echo [1/4] Download asset via WinSCP...
"%WINSCP_PATH%" /command ^
    "open ftp://%FTP_USER%:%FTP_PASS%@%FTP_HOST%/" ^
    "get andromeday_1.wav %TEMP_DIR%\" ^
    "get andromeday_2.wav %TEMP_DIR%\" ^
    "get andromeday_3.wav %TEMP_DIR%\" ^
    "get andromeday_4.wav %TEMP_DIR%\" ^
    "rm andromeday_1.wav" ^
    "rm andromeday_2.wav" ^
    "rm andromeday_3.wav" ^
    "rm andromeday_4.wav" ^
    "exit"

cd /d "%TEMP_DIR%"

:: 2. TRANSCODIFICA MP3 (192k) 
echo [2/4] Conversione segmenti in MP3...
ffmpeg -i andromeday_1.wav -vn -ar 44100 -ac 2 -b:a 192k -y andromeday_1.mp3
ffmpeg -i andromeday_2.wav -vn -ar 44100 -ac 2 -b:a 192k -y andromeday_2.mp3
ffmpeg -i andromeday_3.wav -vn -ar 44100 -ac 2 -b:a 192k -y andromeday_3.mp3
ffmpeg -i andromeday_4.wav -vn -ar 44100 -ac 2 -b:a 192k -y andromeday_4.mp3

:: 3. UNIONE & CBR (128k) [cite: 3, 4]
echo [3/4] Unione segmenti e normalizzazione CBR...
ffmpeg -i andromeday_1.mp3 -i andromeday_2.mp3 -i andromeday_3.mp3 -i andromeday_4.mp3 ^
    -filter_complex "[0:a][1:a][2:a][3:a]concat=n=4:v=0:a=1" -y andromeday_temp.mp3

ffmpeg -i andromeday_temp.mp3 -b:a 128k -c:a libmp3lame -ac 2 -y andromeday_output.mp3

:: 4. ARCHIVIAZIONE CON DATA [cite: 5]
echo [4/4] Ridenominazione finale...
set "datestamp=%date:~-4,4%%date:~-7,2%%date:~-10,2%"
copy andromeday_output.mp3 "..\%EXPORT_DIR%\andromeday_p_%datestamp%.mp3"

echo Procedura completata con successo.
pause
