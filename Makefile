XDG_CONFIG_HOME := $(HOME)/.config

.PHONY: all
all: vim pop_os base16_shell

.PHONY: base16_shell
base16_shell:
	git clone https://github.com/chriskempson/base16-shell.git "$(XDG_CONFIG_HOME)/base16-shell"

.PHONY: dotfiles
dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -type f -name ".*" -not -name ".gitignore"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	mkdir -p $(HOME)/.config;

.PHONY: pop_os
pop_os:
	sudo apt update
	sudo apt install -y \
		dconf-editor \
		emacs \
		gnome-tweaks \
		htop \
		mpv \
		neovim \
		openssh-server \
		ranger \
		tmux \
		xcape

.PHONY: vim
vim:
	ln -snf "$(CURDIR)/.vimrc" "$(HOME)/.vimrc"
	ln -snf "$(CURDIR)/.vim" "$(HOME)/.vim"
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -snf "$(HOME)/.vim" "$(XDG_CONFIG_HOME)/nvim"
	ln -snf "$(HOME)/.vimrc" "$(XDG_CONFIG_HOME)/nvim/init.vim"
	sudo ln -sfn "$(HOME)/.vim" /root/.vim
	sudo ln -sfn "$(HOME)/.vimrc" /root/.vimrc
	sudo mkdir -p /root/.config
	sudo ln -snf "$(HOME)/.vim" /root/.config/nvim
	sudo ln -snf "$(HOME)/.vimrc" /root/.config/nvim/init.vim
