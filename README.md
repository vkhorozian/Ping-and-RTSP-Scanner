# 📹 Daily Camera Health Check (PowerShell)

A PowerShell-based camera monitoring tool that performs daily health checks on IP cameras using:

* ✅ ICMP Ping Test
* ✅ RTSP Port (554) Connectivity Test
* ✅ HTML Report Generation
* ✅ Daily Timestamped Results
* ✅ Automatic Results Folder Creation
* ✅ Logging for Historical Tracking

This script is designed for lightweight infrastructure monitoring without requiring third-party software.

---

## 📂 Project Structure

```
C:\Monitoring\
│
├── cameras.csv
├── CameraHealthLog.txt
├── CameraHealthCheck.ps1
└── Results\
      ├── CameraHealthReport_2026-02-12_09-15-32.html
      └── CameraHealthReport_2026-02-12_15-47-10.html
```

---

## 📄 cameras.csv Format

Your CSV file must include the following headers:

```csv
Unit,IP address
1st - Back Exit Corner 129-A,192.168.65.109
4th - Stair S-2,192.168.65.137
```

* **Unit** → Camera name/location
* **IP address** → Camera IP

---

## 🚀 How It Works

For each camera in the CSV file:

1. Sends a single ping test
2. Tests RTSP port 554 connectivity
3. Logs results to `CameraHealthLog.txt`
4. Generates a timestamped HTML report in `/Results`

Each run creates a unique file like:

```
CameraHealthReport_YYYY-MM-DD_HH-MM-SS.html
```

This ensures reports are **never overwritten**, even if run multiple times per day.

---

## ▶ Running the Script

### Run Manually

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Monitoring\CameraHealthCheck.ps1"
```

### If Scripts Are Blocked

Temporarily allow execution:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

---

## ⏰ Scheduling (Daily Task Scheduler)

When creating a scheduled task:

**Program/script:**

```
powershell
```

**Add arguments:**

```
-ExecutionPolicy Bypass -File "C:\Monitoring\CameraHealthCheck.ps1"
```

This ensures the script runs even if system execution policy is restricted.

---

## 📊 HTML Report Features

* Green = Online
* Red = Offline
* Clean styled table layout
* Timestamp displayed in header
* Saved automatically in `/Results`

---

## 🔮 Future Improvements (Planned)

* Compare today vs yesterday to detect newly offline cameras
* Email alerts for offline cameras
* Automatic cleanup of reports older than X days
* Dashboard version (web UI)
* API integration

---

## 🛡 Requirements

* Windows 10/11 or Windows Server
* PowerShell 5.1+
* Network access to cameras
* RTSP enabled on cameras (Port 554)

---

## 📌 Why This Exists

Many camera systems only alert when completely unreachable.
This script provides lightweight infrastructure-level visibility without vendor lock-in or expensive monitoring platforms.

---

## 📜 License

MIT License (or choose your preferred license)

