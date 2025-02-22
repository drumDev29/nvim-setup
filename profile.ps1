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
function n {
    $winDir = (Get-Item -Path .).FullName.Replace('\', '/')
    $wslDir = if ($winDir -match '^([A-Z]):/') {
        "/mnt/$($Matches[1].ToLower())$($winDir.Substring(2))"
    } else {
        "/mnt/c"  
    }

    $wslArgs = @()
    foreach ($arg in $args) {
        if ($arg -match '^[A-Za-z]:[\\/]') {
            # Handle absolute Windows paths
            $wslPath = $arg.Replace('\', '/') -replace '^([A-Z]):/','/mnt/$1/'
            $wslArgs += $wslPath.ToLower()
        } elseif ($arg.StartsWith('./') -or $arg.StartsWith('../') -or 
                  $arg.StartsWith('.\') -or $arg.StartsWith('..\')) {
            # Handle relative paths, converting backslashes to forward slashes
            $wslArgs += $arg.Replace('\', '/')
        } else {
            # Handle other paths
            $wslArgs += $arg
        }
    }

    wsl --cd "$wslDir" bash -ic "nvim $wslArgs"
}
