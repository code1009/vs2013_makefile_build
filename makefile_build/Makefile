# ===========================================================================
.DEFAULT_GOAL = all



# ===========================================================================
# debug
# ===========================================================================
# ---------------------------------------------------------------------------
.PHONY: debug_clean
debug_clean:
	make -f Project.Makefile.Debug.StaticLibrary.Test clean
	make -f Project.Makefile.Debug.Application.Test   clean



# ---------------------------------------------------------------------------
.PHONY: debug_build
debug_build:
	make -f Project.Makefile.Debug.StaticLibrary.Test build
	make -f Project.Makefile.Debug.Application.Test   build



# ---------------------------------------------------------------------------
.PHONY: debug_rebuild
debug_rebuild: debug_clean debug_build





# ===========================================================================
# release
# ===========================================================================
# ---------------------------------------------------------------------------
.PHONY: release_clean
release_clean:
	make -f Project.Makefile.Release.StaticLibrary.Test clean
	make -f Project.Makefile.Release.Application.Test   clean



# ---------------------------------------------------------------------------
.PHONY: release_build
release_build:
	make -f Project.Makefile.Release.StaticLibrary.Test build
	make -f Project.Makefile.Release.Application.Test   build



# ---------------------------------------------------------------------------
.PHONY: release_rebuild
release_rebuild: release_clean release_build





# ===========================================================================
# all
# ===========================================================================
.PHONY: all
all: debug_rebuild release_rebuild




