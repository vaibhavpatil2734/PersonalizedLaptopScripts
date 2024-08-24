$soundPathFull = "E:\k9\wav2.wav" # Sound for 100% battery
$soundPathIncrement = "E:\k9\wav3.wav" # Sound for every 5% increase after 70%

# Function to play a sound
function Play-Sound($soundPath) {
    (New-Object Media.SoundPlayer $soundPath).PlaySync()
}

# Variable to track the last battery level for the increment sound
$lastBatteryLevel = -1

while ($true) {
    $battery = (Get-WmiObject -Query "Select * from Win32_Battery").EstimatedChargeRemaining

    if ($battery -eq 100) {
        Play-Sound $soundPathFull
        Start-Sleep -Seconds 300 # Wait 5 minutes before checking again
    }
    elseif ($battery -gt 70 -and $battery -ne $lastBatteryLevel -and ($battery - 70) % 5 -eq 0) {
        Play-Sound $soundPathIncrement
        $lastBatteryLevel = $battery # Update the last battery level
    }

    Start-Sleep -Seconds 60 # Check every minute
}
