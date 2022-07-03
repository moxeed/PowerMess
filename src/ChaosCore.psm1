function Stop-ProcessWithLog {
    param (
        $Proccess,
        $Reason
    )
    
    $Process.Kill()
    "$(Get-Date -Format "yyyy-MM-dd hh:mm:ss.fff") $($Process.Name) Reason: $($Reason)" >> ..\log.txt
}
    
function New-CpuLimit {
    param (
        $MaxCpuTime,
        $ProcessName
    )   
    
    $ServiceList = Get-Process | Where-Object Name -like $ProcessName
    
    foreach ($Process in $ServiceList) {    
        if ($Process.CPU -gt $MaxCpuTime) {
            Stop-ProcessWithLog -Process $Process -Reason "cputime $($MaxCpuTime)"
        }
    }
}
        
function New-MemoryLimit {
    param (
        $MaxPrivateMemory,
        $ProcessName
    )   
    
    $ServiceList = Get-Process | Where-Object Name -like $ProcessName
    
    foreach ($Process in $ServiceList) {    
        if ($Process.PrivateMemorySize -gt $MaxPrivateMemory) {
            Stop-ProcessWithLog -Process $Process -Reason "memorylimit $($MaxPrivateMemory)"
        }
    }
}

function New-RandomKill {
    param (
        $Probability,
        $ProcessName
    )
    
    $ServiceList = Get-Process | Where-Object Name -like $ProcessName
    
    foreach ($Process in $ServiceList) {
        $Random = Get-Random -Maximum 100 -Minimum 0
        
        if ($Probability -gt $Random) {
            Stop-ProcessWithLog -Process $Process -Reason "random"
        }
    }
}

Export-ModuleMember -Function New-CpuLimit
Export-ModuleMember -Function New-MemoryLimit
Export-ModuleMember -Function New-RandomKill