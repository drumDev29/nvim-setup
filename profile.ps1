function add {
    param(
        [string]$Name,
        [string]$Value
    )
    $filePath = "$env:USERPROFILE\.$Name"
    $existing = Get-Content $filePath -ErrorAction SilentlyContinue
    if ($existing -notcontains $Value) {
        $list = @($Value) + $existing
        $list | Set-Content $filePath
        return $list
    }
    return $existing
}

function get {
    param([string]$Name)
    $filePath = "$env:USERPROFILE\.$Name"
    if (Test-Path $filePath) {
        return Get-Content $filePath
    }
    return @()
}

function getPath {
    param([string]$Name)
    return "$env:USERPROFILE\.$Name"
}

function cdf {
    param([int]$Depth = 2)
    
    $directory = Get-ChildItem -Directory -Recurse -Depth $Depth | Select-Object -ExpandProperty FullName | fzf
    
    if ($directory) {
        add "dirhistory" $directory
        Set-Location $directory
    }
}

function cdh {
    $selected =  get "dirhistory" | fzf
    if ($selected) {
        Set-Location $selected
    }
}

function kill-all {
    Get-Process -Name node,powershell | Stop-Process
}

function nv {
    # Get current PowerShell directory and convert to WSL path
    $wslWorkingDir = wsl wslpath -a "$(Get-Location)"
    
    # Process arguments and convert Windows paths to WSL paths
    $wslArgs = @()
    foreach ($arg in $args) {
        # Convert absolute Windows paths, leave relative paths and options untouched
        if ($arg -match '^[a-zA-Z]:\\') {
            $wslArgs += (wsl wslpath -a "$arg")
        } else {
            $wslArgs += $arg
        }
    }
    
    # Launch Neovim in WSL with proper working directory and arguments
    wsl --cd "$wslWorkingDir" nvim $wslArgs
}
