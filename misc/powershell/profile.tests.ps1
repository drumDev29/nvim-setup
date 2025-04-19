BeforeAll {
    . $PSScriptRoot\profile.ps1
}

Describe "n function path conversion" {
    BeforeEach {
        # Mock external commands
        Mock wsl { $args }
        Mock Get-Item { 
            [PSCustomObject]@{
                FullName = "C:\Code\nvim-setup"
            }
        }
    }

    It "preserves relative paths starting with ./" {
        $result = n "./test.txt"
        $result | Should -Contain "bash"
        $result | Should -Contain "-ic"
        $result | Should -Contain "nvim ./test.txt"
    }

    It "preserves relative paths starting with ../" {
        $result = n "../test.txt"
        $result | Should -Contain "bash"
        $result | Should -Contain "-ic"
        $result | Should -Contain "nvim ../test.txt"
    }

    It "converts absolute Windows paths to WSL format" {
        $result = n "C:\path\to\file.txt"
        $result | Should -Contain "bash"
        $result | Should -Contain "-ic"
        $result | Should -Contain "nvim /mnt/c/path/to/file.txt"
    }

    It "uses correct WSL working directory" {
        $result = n "test.txt"
        $result | Should -Contain "--cd"
        $result | Should -Contain "/mnt/c/Code/nvim-setup"
        $result | Should -Contain "nvim test.txt"
    }

    It "handles Windows-style relative paths with backslashes" {
        $result = n ".\folder\test.txt"
        $result | Should -Contain "bash"
        $result | Should -Contain "-ic"
        $result | Should -Contain "nvim ./folder/test.txt"
    }
}
