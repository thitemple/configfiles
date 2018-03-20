# Import module from previous step
Import-Module Get-ChildItemColor

Start-SshAgent

Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

# Paths
function path2proj {cd "$home/documents/projects"}
Set-Alias -Name proj -Value path2proj

# http://serverfault.com/questions/95431
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    # https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
    $origLastExitCode = $LastExitCode
    Write-VcsStatus

    if (Test-Administrator) {
        # if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower())) {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    $LastExitCode = $origLastExitCode
    "`n$('>' * ($nestedPromptLevel + 1)) "
}

Import-Module posh-git

$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText = '] '

$VIMPATH = "C:\Program Files (x86)\Vim\vim80\vim.exe"

Set-Alias vi $VIMPATH
Set-Alias vim $VIMPATH

Function Edit-Profile {
    vim $profile
}

Function Edit-Vimrc {
    vim $home\_vimrc
}

Function Edit-ProfileLocal { vim $home\documents\WindowsPowerShell\Scripts\local.ps1 } 

# Bash aliases
Set-Alias -Name touch -Value Bash-Touch
Function Bash-Touch ($fileName) { echo $null >> $fileName } 
# End Bash

# Git aliases
Set-Alias gis Git-Status
Function Git-Status {
git status
}

Set-Alias -Name gico -Value Git-Checkout
Function Git-Checkout ($branch) { git checkout $branch } 

Set-Alias -Name gicm -Value Git-Commit
Function Git-Commit ($message) { git commit -m $message }

Set-Alias -Name gia -Value Git-Add
Function Git-Add ($x) { git add $x }

Set-Alias -Name gips -Value Git-Push
Function Git-Push { git push }

Set-Alias -Name gires -Value Git-Reset
Function Git-Reset { git reset --hard }
# End Git
 
# Local config
$path = "$home/documents/WindowsPowerShell/Scripts/local.ps1"
if([System.IO.File]::Exists($path)) {
	. $path
}
