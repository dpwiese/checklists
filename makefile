# Project directories
CWD := $(abspath $(shell pwd))
SRC := $(CWD)/src
OUT := $(CWD)/out
SRC_DIRS := $(wildcard $(SRC)/*)

# Define one output file name for each directory in src
TARGETS := $(addsuffix .pdf,$(subst src,out,$(SRC_DIRS)))

# External directories
PANDOC=/opt/homebrew/bin/pandoc
PANDOC_OPTIONS=--defaults ./pandoc/defaults.yaml
RM=/bin/rm -f

.PHONY: all clean
.SILENT: all clean

list:
	@echo $(TARGETS)

all: $(TARGETS)

.SECONDEXPANSION:
$(OUT)/%.pdf: $(CWD)/css/checklist.css $$(wildcard $(SRC)/%/*.html) | outdir
	@echo $@
	@$(PANDOC) $(PANDOC_OPTIONS) $(filter-out $<,$^) -o $@

outdir:
	@mkdir -p out

clean:
	- $(RM) $(TARGETS)
