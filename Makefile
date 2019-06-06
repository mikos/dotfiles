XDG_CONFIG_HOME := "$(HOME)/.config"

.PHONY: all
all: dotfiles doom pop_os base16_shell vim

.PHONY: base16_shell
base16_shell: | $(XDG_CONFIG_HOME)
	git clone https://github.com/chriskempson/base16-shell.git "$(XDG_CONFIG_HOME)/base16-shell"

.PHONY: docker
docker:
	sudo apt-get remove docker docker-engine docker.io containerd runc;
	sudo apt-get update;
	sudo apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common;
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) test";
	sudo apt-get update;
	sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose;

.PHONY: doom
doom: | $(XDG_CONFIG_HOME)
	ln -sfn "$(CURDIR)/.doom" "$(XDG_CONFIG_HOME)/doom";
	git clone https://github.com/hlissner/doom-emacs ~/.emacs.d;
	mkdir -p ~/.emacs.d/modules/private;
	ln -sfn "$(CURDIR)/.doom/custom" ~/.emacs.d/modules/private/custom;
	~/.emacs.d/bin/doom -y install;

.PHONY: dotfiles
dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -type f -name ".*" -not -name ".gitignore"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -fn "$(CURDIR)/gitignore" "$(HOME)/.gitignore";

.PHONY: fonts
fonts:
	git clone https://github.com/powerline/fonts.git --depth=1 /tmp/powerline_fonts
	cd /tmp/powerline_fonts && ./install.sh
	rm -rf /tmp/powerline_fonts

.PHONY: nodejs
nodejs:
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs

.PHONY: pop_os
pop_os:
	sudo apt update
	sudo apt install -y \
		dconf-editor \
		emacs \
		filezilla \
		gnome-tweaks \
		htop \
		mpv \
		neovim \
		openssh-server \
		ranger \
		ripgrep \
		tmux \
		xcape

.PHONY: vim
vim: | $(XDG_CONFIG_HOME)
	ln -snf "$(CURDIR)/.vimrc" "$(HOME)/.vimrc"
	ln -snf "$(CURDIR)/.vim" "$(HOME)/.vim"
	ln -snf "$(HOME)/.vim" "$(XDG_CONFIG_HOME)/nvim"
	ln -snf "$(HOME)/.vimrc" "$(XDG_CONFIG_HOME)/nvim/init.vim"
	sudo ln -sfn "$(HOME)/.vim" /root/.vim
	sudo ln -sfn "$(HOME)/.vimrc" /root/.vimrc
	sudo mkdir -p /root/.config
	sudo ln -snf "$(HOME)/.vim" /root/.config/nvim
	sudo ln -snf "$(HOME)/.vimrc" /root/.config/nvim/init.vim

$(XDG_CONFIG_HOME):
	mkdir -p $(XDG_CONFIG_HOME)
