PREFIX ?= $(HOME)/.local

BINDIR := $(PREFIX)/bin
DATADIR := $(PREFIX)/share

COMPDIR := $(DATADIR)/bash-completion/completions
ZSHDIR  := $(DATADIR)/zsh/site-functions

BIN := bin/nip
BASHCOMP := completions/nip.bash
ZSHCOMP  := completions/_nip

TARGET_BIN  := $(DESTDIR)$(BINDIR)/nip
TARGET_BASH := $(DESTDIR)$(COMPDIR)/nip
TARGET_ZSH  := $(DESTDIR)$(ZSHDIR)/_nip

.PHONY: all install uninstall

all:
	@echo "Nothing to build"

install:
	@echo "Installing nip to $(PREFIX)..."
	install -Dm755 "$(BIN)" "$(TARGET_BIN)"
	install -Dm644 "$(BASHCOMP)" "$(TARGET_BASH)"
	install -Dm644 "$(ZSHCOMP)" "$(TARGET_ZSH)"
	@echo ""
	@echo "If zsh completions are not working, add this to your .zshrc:"
	@echo '  fpath=("$$(HOME)/.local/share/zsh/site-functions" $$fpath)'
	@echo '  autoload -Uz compinit && compinit'

uninstall:
	@echo "Uninstalling nip..."
	rm -f "$(TARGET_BIN)"
	rm -f "$(TARGET_BASH)"
	rm -f "$(TARGET_ZSH)"
