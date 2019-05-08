PREFIX=/usr/local
INSTALL_DIR=$(PREFIX)/bin
TEST_CLI_SYSTEM=$(INSTALL_DIR)/test_cli

OUT_DIR=./bin
TEST_CLI=$(OUT_DIR)/test_cli
TEST_CLI_SOURCES=$(shell find src/ -type f -name '*.cr')

all: build

build: lib $(TEST_CLI)

lib:
	@shards install --production

$(TEST_CLI): $(TEST_CLI_SOURCES) | $(OUT_DIR)
	@echo "Building test_cli in $@"
	@crystal build -o $@ src/test_cli.cr -p --no-debug

$(OUT_DIR) $(INSTALL_DIR):
	 @mkdir -p $@

run:
	$(TEST_CLI)

install: build | $(INSTALL_DIR)
	@rm -f $(TEST_CLI_SYSTEM)
	@cp $(TEST_CLI) $(TEST_CLI_SYSTEM)

link: build | $(INSTALL_DIR)
	@echo "Symlinking $(TEST_CLI) to $(TEST_CLI_SYSTEM)"
	@ln -s $(TEST_CLI) $(TEST_CLI_SYSTEM)

force_link: build | $(INSTALL_DIR)
	@echo "Symlinking $(TEST_CLI) to $(TEST_CLI_SYSTEM)"
	@ln -sf $(TEST_CLI) $(TEST_CLI_SYSTEM)

clean:
	rm -rf $(TEST_CLI)

distclean:
rm -rf $(TEST_CLI) .crystal .shards libs lib
