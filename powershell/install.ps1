scoop install neovim
scoop install tree-sitter
scoop install ripgrep
scoop install lazygit
scoop install gdu
scoop install bottom
scoop install python
scoop install nvm
nvm install lts 
scoop install gcc
scoop install win32yank 
# scoop install ollama
#
# ollama pull deepseek-r1:14b
# ollama pull qwen2.5-coder:7b
#

Copy-Item -Path "./" -Destination "$env:LOCALAPPDATA" -Recurse
