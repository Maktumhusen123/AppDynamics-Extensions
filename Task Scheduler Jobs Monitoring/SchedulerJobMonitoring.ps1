$min=(Get-Date) - (New-TimeSpan -M 15)
$a=Get-WinEvent -LogName 'Microsoft-Windows-TaskScheduler/Operational' -MaxEvents 2000|Where-Object {$_.TimeCreated -ge $min}

$job_name="JobName"
$warning=$a|Where-Object { ($_.TimeCreated -ge $min) -and ($_.LevelDisplayName -eq "Warning") -and ($_.Message.Contains($job_name))}|Measure-Object -Line
$error=$a|Where-Object { ($_.TimeCreated -ge $min) -and ($_.LevelDisplayName -eq "Error") -and ($_.Message.Contains($job_name))}|Measure-Object -Line
$warning_count=$w.Lines
$error_count=$e.Lines
echo "name=Custom Metrics|SchedulerJobMonitoring|$j|Warn|Occurances,value=$warning_count"
echo "name=Custom Metrics|SchedulerJobMonitoring|$j|Error|Occurances,value=$error_count"
