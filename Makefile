# Path variables
SRC 					= lib
BIN 					= bin
BUILD 					= build

# File variables
SCRIPT_HEAD				= sg2o.meta.js
BUILD_PROJECT 			= $(BUILD)/main.dart.js
RELEASE_TARGET			= sg2o.user.js
DART_TOOL				= .dart-tool

# Executables
WEBDEV					= webdev
CAT						= cat
BUMP					= ./bumpVersion.sh
RM						= rm -rf
CP						= cp

# Program variables

default: all

all: clean release

release: clean build make-user-js

make-user-js:
	@$(CAT) $(SCRIPT_HEAD) > $(RELEASE_TARGET)
	@$(CAT) $(BUILD_PROJECT) >> $(RELEASE_TARGET)
	@$(CP) .dart_tool/build/generated/sg2o/bin/main.dart.js.map sg2o.user.js.map

build:
	@$(WEBDEV) build -o $(BIN):$(BUILD)

major:
	@$(BUMP) --major

minor:
	@$(BUMP) --minor

patch:
	@$(BUMP) --patch

clean:
	@echo 'Removing build files.'
	@$(RM) $(BUILD) $(DART-TOOL)

.PHONY: clean build
