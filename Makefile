# Path variables
SRC 						= lib
BIN 						= bin
BUILD 					= build

# File variables
SCRIPT_HEAD			= sg2o.meta.js
BUILD_PROJECT 	= $(BUILD)/bin/main.dart.js
RELEASE_TARGET	= sg2o.user.js

# Executables
PUB						= pub
CAT						= cat

# Program variables

default: all

all: clean release

release: clean build make-user-js

make-user-js:
	@$(CAT) $(SCRIPT_HEAD) > $(RELEASE_TARGET)
	@$(CAT) $(BUILD_PROJECT) >> $(RELEASE_TARGET)

build:
	@$(PUB) build --all

clean:
	@echo 'Nothing to clean.'

.PHONY: clean build
