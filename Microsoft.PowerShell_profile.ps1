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
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
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
Set-Alias gs Git-Status

Function Edit-Profile {
    vim $profile
}

Function Edit-Vimrc {
    vim $home\_vimrc
}

Function Git-Status {
	git status
}
