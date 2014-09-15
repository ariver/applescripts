# /dev/null/make

# Disable built-in implicit rules.
.SUFFIXES:

# What to compile
BINSRCS  = $(wildcard *.applescript)

# Init path variables.
BINDIR  ?= $(HOME)/Library/Application Support/Microsoft/Office/Outlook Script Menu Items

# Init commands.
INSTALL  = install -vp
RM       = rm -vf

# By default, show help.
.DEFAULT_GOAL	:=	help

# HELP
.PHONY:		help usage
help:
	@echo "USAGE:"
	@echo "    make compile"
	@echo "    make install"
	@echo "    make uninstall"
	@echo "ALTERNATE:"
	@echo "    make BINDIR='/Library/Application Support/Microsoft/Office/Outlook Script Menu Items'"
usage:	help

.PHONY:		compile install uninstall

compile:
	for I in *.applescript; do osacompile -o "$${I%.applescript}.scptd" "$${I}"; done

install:	compile
	for I in *.applescript; do rsync -ai "$${I%.applescript}.scptd" "$(BINDIR)/."; done

uninstall:
	for I in *.applescript; do $(RM) -r "$(BINDIR)/$${I%.applescript}.scptd"; done
