XDG_CONFIG_HOME := "$(HOME)/.config"

.PHONY: all
all: docker dotfiles doom fonts nodejs pop_os base16_shell vim

.PHONY: base16_shell
base16_shell: | $(XDG_CONFIG_HOME)
	git clone https://github.com/chriskempson/base16-shell.git "$(XDG_CONFIG_HOME)/base16-shell"

.PHONY: docker
docker:
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) test"
	sudo apt-get update
	sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose

.PHONY: doom
doom: | $(XDG_CONFIG_HOME) nodejs
	ln -sfn "$(CURDIR)/.doom" "$(XDG_CONFIG_HOME)/doom"
	git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
	mkdir -p ~/.emacs.d/modules/private
	ln -sfn "$(CURDIR)/.doom/custom" ~/.emacs.d/modules/private/custom
	~/.emacs.d/bin/doom -y install

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

.PHONY: golang
golang: | dotfiles
	sudo apt update
	sudo apt install -y golang-1.12
	go get -u -v github.com/mdempsky/gocode
	go get -u -v golang.org/x/lint/golint
	go get -u -v golang.org/x/tools/cmd/guru
	go get -u -v golang.org/x/tools/cmd/goimports
	go get -u -v golang.org/x/tools/cmd/gorename
	go get -u -v github.com/motemen/gore/cmd/gore

.PHONY: node_modules
node_modules: | dotfiles nodejs
	npm -g i \
		js-beautify \
		marked \
		pandoc \
		stylelint

.PHONY: nodejs
nodejs:
ifeq (, $(shell which node))
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs
else
	@echo "Skipping nodejs target, node already installed."
endif

.PHONY: pop_os
pop_os:
	sudo apt update
	sudo apt install -y \
		dconf-editor \
		editorconfig \
		emacs \
		fd-find \
		filezilla \
		fzf \
		gnome-tweaks \
		htop \
		markdown \
		mpv \
		neovim \
		openssh-server \
		pandoc \
		ranger \
		ruby \
		ripgrep \
		shellcheck \
		tmux \
		xcape
ifeq (, $(wildcard /usr/local/bin/fd))
	sudo ln -s $(shell which fdfind) /usr/local/bin/fd
endif


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
