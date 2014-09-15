# /dev/null/make

# Disable built-in implicit rules.
.SUFFIXES:

# Init path variables.
BINDIR  ?= $(HOME)/Library/Application Support/Microsoft/Office/Outlook Script Menu Items

# Init commands.
INSTALL  = install -vp
RM       = rm -vf
PH       = printf '\n%s\n'
P0       = printf '%s\n'
P1       = printf '  %s\n'
P2       = printf '    %s\n'

# By default, show help.
.DEFAULT_GOAL	:=	help

# HELP
.PHONY:		help usage
help:
	@$(P0) "USAGE:"
	@$(P2) "make compile"
	@$(P2) "make clean"
	@$(P2) "make install"
	@$(P2) "make uninstall"
	@$(P0) "ALTERNATE:"
	@$(P2) "make BINDIR='/Library/Application Support/Microsoft/Office/Outlook Script Menu Items'"
usage:	help

.PHONY:		compile install uninstall clean

compile:
	@$(PH) "Compile applescripts to 'scpt'."
	@for I in *.applescript; do osacompile -o "$${I%.applescript}.scpt"  "$${I}"; done
	@$(PH) "Compile applescripts to 'scptd'."
	@for I in *.applescript; do osacompile -o "$${I%.applescript}.scptd" "$${I}"; done

install:	compile
	@$(PH) "Install compiled scripts to ( $(BINDIR) )."
	@for I in *.applescript; do $(INSTALL) "$${I%.applescript}.scpt"  "$(BINDIR)/"; done
	@$(PH) "Install compiled script bundles to ( $(BINDIR) )."
	@for I in *.applescript; do rsync -ai  "$${I%.applescript}.scptd" "$(BINDIR)/"; done

uninstall:
	@$(PH) "Uninstall compiled scripts from ( $(BINDIR) )."
	@for I in *.applescript; do $(RM)    "$(BINDIR)/$${I%.applescript}.scpt";  done
	@$(PH) "Uninstall compiled script bundles from ( $(BINDIR) )."
	@for I in *.applescript; do $(RM) -r "$(BINDIR)/$${I%.applescript}.scptd"; done

clean:
	@$(PH) "Remove compiled scripts."
	@for I in *.applescript; do $(RM)    "$${I%.applescript}.scpt";  done
	@$(PH) "Remove compiled script bundles."
	@for I in *.applescript; do $(RM) -r "$${I%.applescript}.scptd"; done
