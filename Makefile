VERSIONS := latest
BUILD_ALL_VERSIONS := $(addprefix build-, $(VERSIONS))
TEST_ALL_VERSIONS := $(addprefix test-, $(VERSIONS))

all: test

.PHONY: build build-base $(BUILD_ALL_VERSIONS)
build-base:
    docker build -t norberttech/md-link-linter:base base

$(BUILD_ALL_VERSIONS): build-%: build-base
    docker build -t norberttech/md-link-linter:$* $*

build: $(BUILD_ALL_VERSIONS)

.PHONY: test $(TEST_ALL_VERSIONS)
$(TEST_ALL_VERSIONS): test-%:
    @echo "Test $*"
    @docker run --rm norberttech/md-link-linter:$* --help

test: build $(TEST_ALL_VERSIONS)