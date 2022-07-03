Import-Module ./ChaosCore.psm1

function  Start-Cycle {
    param (
        $StartAfter = 0,
        $StopAfter = 1,
        $Body
    )
    
    $cmd = [Scriptblock]::Create($Body)

    Start-Sleep($StartAfter)    
    while ($StopAfter -gt 0) {
        Start-Sleep(1)
        
        Invoke-Command -ScriptBlock $cmd

        $StopAfter = $StopAfter - 1
    }
}

function Start-Chaos {
    param (
        $StartAfter = 0,
        $StopAfter = 1,
        $Body
    )

    $Location = Get-Location
    $Path = $Location.Path

    Start-Job -Name Chaos -InitializationScript { 
            Import-Module ./ChaosContainer.psm1 
        } -ScriptBlock { 
            Set-Location $args[0]
            Start-Cycle -StartAfter $args[1] -StopAfter $args[2] -Body $args[3]
        } -ArgumentList $Path, $StartAfter, $StopAfter, $Body
}

Export-ModuleMember -Function Start-Cycle
Export-ModuleMember -Function Start-Chaos