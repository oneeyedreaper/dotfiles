Import-Module posh-git
Import-Module oh-my-posh
Import-Module terminal-icons

#Alias
Set-Alias vim nvim
#Set-Alias .. cd..
Set-Alias g git
Set-Alias ff fuck
Set-Alias ll ls
Set-Alias github search-github
Set-Alias google search-google
Set-Alias tx taskx
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias nano 'C:\Program Files\Git\usr\bin\nano.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias restart Restart-Computer
Set-Alias shutdown Shutdown


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
 Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History

#fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Load Prompt config
$omp_config = "C:\Users\paras\.config\powershell\paras.omp.json"
$omp_jane_config =  "C:\Users\paras\OneDrive\Documents\PowerShell\Modules\oh-my-posh/themes/jandedobbeleer.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Cowsay
#cowsay Yo!! What up, bitch!!

#Winfetch
winfetch




#search google
function search-google {
  param(
    [Parameter(Mandatory = $false, Position = 0)]`
      [string]$SearchString
  )
  process {
    if (!$SearchString) {
      $SearchString = Get-Clipboard;
    }
    $URL = $SearchString -replace ' ', '+';
    $URL = "https://www.google.com/search?q=" + $URL;
    Write-Output ("Searching Google. . .");
    Write-Output ("Take a look at the browser. . .");
    Start-Process chrome.exe $URL;
  }
}

#search github
function search-github {
  param (
    [Parameter(Mandatory = $false, Position = 0)]`
      [string]$SearchString
  )
  process {
    if (!$SearchString) {
      $SearchString = Get-Clipboard;
    }
    $URL = $SearchString -replace ' ', '+';
    $URL = "https://github.com/search?q=" + $URL;
    Write-Output("Searching GitHub. . .");
    Write-Output("Take a look at the browser. . .");
    Start-Process chrome.exe $URL;
  }
}
# Touch Utility
function touch { 
  New-Item -ItemType File -Name ($args[0]) 
}

# Search end task
function taskx{
 taskkill /f /im ($args[0]+".exe")
}

# Create Folder
function nfd{
	New-Item -ItemType Directory -Name ($args[0])
}
#Sleep
function slep{
	rundll32.exe powrprof.dll,SetSuspendState 0,1,0
}

function cd..{cd ..}

foreach ( $level in 2..10 ) {
    Invoke-Expression "function GoUp$level { foreach (`$i in 2..$level) { cd .. } }"
    Set-Alias -Name ('.' * $level) -Value "Goup$level"
}

$env:PYTHONIOENCODING="utf-8"
$env:PYTHONIOENCODING="utf-8"

Import-Module PoShFuck

#virtualbox func

function Vmon {C:\'Program Files'\Oracle\VirtualBox\VBoxManage.exe startvm $args[0] --type headless}
function Vmoff {C:\'Program Files'\Oracle\VirtualBox\VBoxManage.exe controlvm $args[0] acpipowerbutton}
function ssh.UbuntuVM {ssh -q user@192.168.56.101}
function UbuntuVM {
    $condition = C:\'Program Files'\Oracle\VirtualBox\VBoxManage.exe list runningvms | Select-String UbuntuVM
    if ($null -ne $condition)
    {
        ssh.UbuntuVM
    }
    else
    {
        Vmon UbuntuVM
        Do {
        $status = Test-NetConnection 192.168.56.101 -Port 22 -InformationLevel Quiet
        Clear-Host
        } Until ($status -eq "True")
        Clear-Host
        ssh.UbuntuVM
        Clear-Host
    }
}
function lsVMS {C:\'Program Files'\Oracle\VirtualBox\VBoxManage.exe list vms}
function lsrVMS {C:\'Program Files'\Oracle\VirtualBox\VBoxManage.exe list runningvms}


