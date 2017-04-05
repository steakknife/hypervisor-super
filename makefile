.PHONY: clean multicompiler hypervisor test

#export CUSTOM_FETCH_CLANG=$(realpath scripts/fetch_multicompiler.sh)
#export CUSTOM_BUILD_CLANG=$(realpath scripts/build_multicompiler.sh)
#export CUSTOM_FETCH_BINUTILS=$(realpath scripts/fetch_gold.sh)
#export CUSTOM_BUILD_BINUTILS=$(realpath scripts/build_gold.sh)

TOOL_PATH=$(realpath multicompiler/tools)

export CROSS_CXXFLAGS="-stdlib=libc++ -nostdinc++ -I $(TOOL_PATH)/include/c++/v1 -L $(TOOL_PATH)/lib -Wl,-rpath,$(TOOL_PATH)/lib -fvtable-rando"
export CROSS_CCFLAGS:=${CROSS_CXXFLAGS}
export CROSS_LDFLAGS:=${CROSS_CXXFLAGS}


all: hypervisor

hypervisor/.hypervisor_configured:
	./configure_hypervisor.sh

multicompiler:
	$(MAKE) -C multicompiler install

hypervisor: hypervisor/.hypervisor_configured
	$(MAKE) -C hypervisor

test:
	$(MAKE) -C hypervisor test

# Clean targets
clean_hypervisor_configured:
	rm -rf hypervisor/.hypervisor_configured

clean:
	$(MAKE) -C hypervisor clean

