# 🎙️ Podcast Automation Pipeline: Project Andromeday Podcast

<p align="center">
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/FFmpeg-007808?style=for-the-badge&logo=ffmpeg&logoColor=white" />
  <img src="https://img.shields.io/badge/Windows_Batch-4D4D4D?style=for-the-badge&logo=windows&logoColor=white" />
  <img src="https://img.shields.io/badge/Proxmox-E57020?style=for-the-badge&logo=proxmox&logoColor=white" />
</p>

Benvenuti in **Andromeday Podcast**, la pipeline di automazione meticolosa per la produzione e distribuzione di contenuti podcast a tema spaziale. Questo sistema trasforma il workflow manuale di elaborazione audio in un processo fluido, rapido e privo di errori.

---

## 🚀 Workflow di Automazione
Il core di Andromeday Podcast gestisce cicli di produzione complessi in pochi secondi:

1.  **Ingestion:** Recupero automatico dei segmenti grezzi (`andromeday_n.wav`) dal server FTP di produzione.
2.  **Transcoding:** Conversione immediata in MP3 a 192kbps per bilanciare qualità e peso del file.
3.  **Merging:** Unione intelligente dei segmenti tramite filtri complessi di FFmpeg.
4.  **Standardization:** Codifica finale in **CBR 128kbps** (Constant Bitrate) per una compatibilità totale con feed RSS e piattaforme di streaming.
5.  **Archiving:** Ridenominazione dinamica con timestamp e backup automatico.

---

## 🛠️ Requisiti Tecnici
Per garantire il funzionamento della pipeline, sono necessari i seguenti strumenti:
- **FFmpeg:** Il cuore pulsante dell'elaborazione media.
- **WinSCP:** (Per la versione Batch) Gestione sicura dei trasferimenti FTP su Windows.
- **Python 3.x:** (Per la versione Cross-Platform) Ideale per deployment su VM Linux o nodi Proxmox.

---

## 📂 Struttura del Repository
- `/batch_version`: Script nativi Windows per automazione locale.
- `/python_version`: Versione moderna e modulare per ambienti server.
- `LICENSE`: Licenza MIT.

---

## 🔧 Dietro le Quinte: Hardware & Infra
Questo progetto non vive nel vuoto. È supportato da un'infrastruttura solida:
- **Virtualizzazione:** Gestito su nodi **Proxmox** in ambiente HomeLab.
- **Hardware:** Sistemi assemblati e manutenuti personalmente per garantire performance costanti.
- **Filosofia:** Ridurre mille passaggi manuali a un singolo clic. Pulito, ordinato, efficiente.

---
> **Project Status:** Active. Sostituito il naming legacy con il nuovo standard *Andromeday Podcast*.
