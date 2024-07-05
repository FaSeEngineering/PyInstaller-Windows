param (
    [switch]$NoProfile,
    [switch]$NoLogo,
    [string]$InputFormat,
    [string]$OutputFormat,
    [switch]$NonInteractive,
    [string]$ExecutionPolicy,
    [string]$EncodedCommand
)


#Output container information
Write-Output "------------------------------------------------------------------------------"
$ipv4Address = ipconfig | Select-String -Pattern "IPv4 Address" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
$ipv4Gateway = ipconfig | Select-String -Pattern "Default Gateway" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
Write-Output "Container IPv4 configuration:"
Write-Output "IPv4 Address: $ipv4Address"
Write-Output "IPv4 Gateway: $ipv4Gateway"
Write-Output "------------------------------------------------------------------------------"
Write-Output "Starting Windows Container"
Write-Output "------------------------------------------------------------------------------"
if ($EncodedCommand) {
    Write-Output "Received encoded command: $EncodedCommand"

    # Decode the base64-encoded command
    $decodedBytes = [System.Convert]::FromBase64String($EncodedCommand)
    $decodedCommand = [System.Text.Encoding]::Unicode.GetString($decodedBytes)
    
    Write-Output "Decoded command: $decodedCommand"

    # Execute the decoded command
    Invoke-Expression $decodedCommand
} else {
    Write-Output "No commands passed. Starting interactive PowerShell session..."
    Start-Process powershell.exe -NoNewWindow -Wait -ArgumentList '-NoExit'
}