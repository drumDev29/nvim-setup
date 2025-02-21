FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    git

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && install lazygit /usr/local/bin \
    && rm lazygit.tar.gz

RUN apt-get install -y \
    neovim \
    ripgrep \
    fd-find \
    python3 \
    nodejs \
    npm \
    locales \
    language-pack-en \
    tmux \
    git

# Install TPM (Tmux Plugin Manager)
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create tmux config with some useful plugins
RUN echo ' \
set -g @plugin "tmux-plugins/tpm" \n\
set -g @plugin "tmux-plugins/tmux-sensible" \n\
set -g @plugin "tmux-plugins/tmux-resurrect" \n\
run "~/.tmux/plugins/tpm/tpm"' > ~/.tmux.conf

# Configure git line endings
RUN git config --system core.autocrlf input

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
WORKDIR /workspace
ENTRYPOINT ["/bin/bash"]
