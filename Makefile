SHELL := /bin/bash
BUNDLE := bundle
JEKYLL := $(BUNDLE) exec jekyll
HTMLPROOF := $(BUNDLE) exec htmlproofer
PROJECT_DEPS := Gemfile

.PHONY: all check install update build serve

all: install serve

check:
	$(JEKYLL) doctor
	$(HTMLPROOF) --check-html \
		--http-status-ignore 999 \
		--assume-extension \
		--allow-hash-href \
		--check-favicon \
		--empty-alt-ignore \
		_site

install: $(PROJECT_DEPS)
	$(BUNDLE) install --path _vendor/bundle

update: $(PROJECT_DEPS)
	$(BUNDLE) update

build:
	$(JEKYLL) build

serve:
	$(JEKYLL) serve
