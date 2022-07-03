# PowerMess
a simple chaos generator written in powershell witch monitors and manipulates processes to create chaos senarios

features

- Cpu Limit 
- Memory Limit
- Random Fault

### Cpu Limit

Monitors Process Cpu time (total time the process spend on any core of cpu (physical/virtual))
if cpu time passes a threshold kills the process

```
New-CpuLimit -MaxCputime 2 -ProcessName firefox
```

### Memory Limit

Monitors Process Private Memory Size which is the actual used memory (not reserved memory)
if Private Memory Size a threshold kills the process

```
New-MemoryLimit  -MaxPrivateMemory 200 -ProcessName firefox
```

### Random Fault

Kills Process with a uniform probablilty

*Probability argument is percent*
```
New-RandomKill -Probability 2 -ProcessName firefox
```

*ProcessName accepts wildcard names e.g. fire\* instead of firefox*

Also there is a little tool witch helps in scenario desctiption

### Start-Chaos

arguments:
- StartAfter: delay before applying chaos in seconds
- StopAfter: retry count of same chaos
- Body: any of chaos options described before or combination of them

```
Start-Chaos -StartAfter 15 -StopAfter 10  -Body { 
    New-MemoryLimit  -MaxPrivateMemory 200 -ProcessName firefox 
    New-RandomKill -Probability 2 -ProcessName firefox
    ...
}
```

## technology independant 

this project injects faults in process level so is doesnt matter what application is running on it. therefore can be used with any technology.

# How To Use

Create a powershell script and import ChaosContainer Module

```
Import-Module src\ChaosContainer.psm1
```

Describe your scenario using chaos commands

```
Start-Chaos -StartAfter 0  -StopAfter 1  -Body { 
    New-RandomKill   -Probability 2 -ProcessName firefox 
}
Start-Chaos -StartAfter 5  -StopAfter 1  -Body { 
    New-CpuLimit     -MaxCputime 2 -ProcessName firefox 
}
Start-Chaos -StartAfter 15 -StopAfter 10  -Body { 
    New-MemoryLimit  -MaxPrivateMemory 200 -ProcessName firefox 
}
```

run the script

```
PS> ./yourscriptname.ps1
```

complete code (TestBench.ps1 in src folder)

```
Import-Module src\ChaosContainer.psm1

Start-Chaos -StartAfter 0 -StopAfter 1 -Body { 
    New-RandomKill   -Probability 2 -ProcessName firefox 
}
Start-Chaos -StartAfter 5 -StopAfter 1 -Body { 
    New-CpuLimit     -MaxCputime 2 -ProcessName firefox 
}
Start-Chaos -StartAfter 15 -StopAfter 10 -Body { 
    New-MemoryLimit  -MaxPrivateMemory 200 -ProcessName firefox 
}
```