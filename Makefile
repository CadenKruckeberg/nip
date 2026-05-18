PREFIX ?= $(HOME)/.local

BINDIR := $(PREFIX)/bin
DATADIR := $(PREFIX)/share
COMPDIR := $(DATADIR)/bash-completion/completions

BIN := bin/nip
COMP := completions/nip.bash

.PHONY: all install uninstall

all:
	@echo "Nothing to build"

install:
	@echo "Installing nip to $(PREFIX)..."
	install -Dm755 "$(BIN)" "$(DESTDIR)$(BINDIR)/nip"
	install -Dm644 "$(COMP)" "$(DESTDIR)$(COMPDIR)/nip"

uninstall:
	@echo "Uninstalling nip..."
	rm -f "$(DESTDIR)$(BINDIR)/nip"
	rm -f "$(DESTDIR)$(COMPDIR)/nip"
