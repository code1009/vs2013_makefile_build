# ===========================================================================
.DEFAULT_GOAL = all



# ===========================================================================
.PHONY: clean
clean:
	make -f Test.StaticLibrary.Debug.Makefile clean
	make -f Test.Application.Debug.Makefile   clean



# ===========================================================================
.PHONY: build
build:
	make -f Test.StaticLibrary.Debug.Makefile build
	make -f Test.Application.Debug.Makefile   build



# ===========================================================================
.PHONY: all
all: clean build


