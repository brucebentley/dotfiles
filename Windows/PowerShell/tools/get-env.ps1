& {
    $hostName = $Host.Name
    if ($hostName -eq "ConsoleHost" -and (Get-Command Get-CimInstance -ErrorAction SilentlyContinue)) {
        $id = $PID; $inWindowsTerminal = $false
        while ($true) {
            $p = Get-CimInstance -ClassName Win32_Process -Filter "ProcessId Like $id"
            if (!$p -or !$p.Name) { break }
            if ($p.Name -eq "WindowsTerminal.exe") { $inWindowsTerminal = $true; break }
            $id = $p.ParentProcessId
        }
        if ($inWindowsTerminal) { $hostName += " (Windows Terminal)" }
    }

    $m = Get-Module PSReadline
    $v = $m.Version; $pre = $m.PrivateData.PSData.Prerelease
    if ($pre) { $v = "$v-$pre" }
    $os = if ($IsLinux -or $IsMacOS) { uname -a } else { (dir $env:SystemRoot\System32\cmd.exe).VersionInfo.FileVersion }

    Write-Host ''
    Write-Host "PS Version: $($PSVersionTable.PSVersion)"
    Write-Host "PS HostName: $hostName"
    Write-Host "PSReadLine Version: $v"
    Write-Host "PSReadLine EditMode: $((Get-PSReadLineOption).EditMode)"
    Write-Host "OS: $os"
    Write-Host "BufferWidth: $([console]::BufferWidth)"
    Write-Host "BufferHeight: $([console]::BufferHeight)"
    Write-Host ''
}
