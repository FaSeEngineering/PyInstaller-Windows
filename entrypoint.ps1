param(
    [string[]]$args
)

#Output container information
Write-Output "------------------------------------------------------------------------------"
$ipv4Address = ipconfig | Select-String -Pattern "IPv4 Address" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
$ipv4Gateway = ipconfig | Select-String -Pattern "Default Gateway" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
Write-Output "Container IPv4 configuration:"
Write-Output "IPv4 Address: $ipv4Address"
Write-Output "IPv4 Gateway: $ipv4Gateway"
Write-Output "------------------------------------------------------------------------------"

#Keep the system running
if ($args.Length -eq 0) {
    Write-Output "No arguments passed. Running infinite loop..."
    while ($true) {
        Start-Sleep -Seconds 1
    }
} else {
    Write-Output "Arguments passed: $args"
    $command = "powershell.exe " + $args -join " "
    Write-Output "Executing command: [$command]"
    Invoke-Expression $command
}