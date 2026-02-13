# -------------------------
# Camera Health Check Script
# -------------------------

# Paths
$csvPath = "C:\Monitoring\cameras.csv"
$logFile = "C:\Monitoring\CameraHealthLog.txt"

# Ensure results folder exists
$resultsFolder = "C:\Monitoring\Results"
if (-not (Test-Path $resultsFolder)) {
    New-Item -ItemType Directory -Path $resultsFolder | Out-Null
}

# Add date + time to HTML report filename for uniqueness
$timestampForFile = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$htmlFile = Join-Path $resultsFolder "CameraHealthReport_$timestampForFile.html"

# Timestamp for display/log
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Read cameras CSV
$cameras = Import-Csv $csvPath

# Initialize HTML
$html = @"
<html>
<head>
<style>
body { font-family: Arial; }
table { border-collapse: collapse; width: 80%; }
th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
th { background-color: #333; color: white; }
.online { background-color: #c6efce; } 
.offline { background-color: #f8cbcb; }
</style>
<title>Camera Health Report</title>
</head>
<body>
<h2>Camera Health Report - $timestamp</h2>
<table>
<tr><th>Unit</th><th>IP</th><th>Ping</th><th>RTSP</th></tr>
"@

# Start log entry
Add-Content $logFile "`n=== Health Check: $timestamp ==="

# Check each camera
foreach ($cam in $cameras) {
    # Ping test
    $ping = Test-Connection -ComputerName $cam.'IP address' -Count 1 -Quiet
    # RTSP test
    $rtsp = Test-NetConnection -ComputerName $cam.'IP address' -Port 554 -InformationLevel Quiet

    # Determine status
    $pingStatus = if ($ping) { "Online" } else { "Offline" }
    $rtspStatus = if ($rtsp) { "Online" } else { "Offline" }

    # Log to file
    Add-Content $logFile "$($cam.Unit) [$($cam.'IP address')] - Ping: $pingStatus | RTSP: $rtspStatus"

    # Add HTML row
    $html += "<tr>"
    $html += "<td>$($cam.Unit)</td><td>$($cam.'IP address')</td>"
    $html += "<td class='$($pingStatus.ToLower())'>$pingStatus</td>"
    $html += "<td class='$($rtspStatus.ToLower())'>$rtspStatus</td>"
    $html += "</tr>`n"
}

# Close HTML
$html += "</table></body></html>"

# Save HTML to today's file in Results folder
$html | Out-File $htmlFile -Encoding UTF8

Write-Host "Health check complete. Log: $logFile | Report: $htmlFile"
