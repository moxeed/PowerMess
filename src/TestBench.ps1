Import-Module .\ChaosContainer.psm1

#Start-Chaos -StartAfter 0  -StopAfter 1  -Body { New-RandomKill   -Probability 2 -ProcessName firefox }
#Start-Chaos -StartAfter 5  -StopAfter 1  -Body { New-CpuLimit     -MaxCputime 2 -ProcessName firefox }
#Start-Chaos -StartAfter 15 -StopAfter 10  -Body { New-MemoryLimit  -MaxPrivateMemory 200 -ProcessName firefox }

