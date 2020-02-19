# ===========================================================================
# ===========================================================================
# input directory
# ===========================================================================
SOURCE_BASE_DIRECTORY   = ../source
RESOURCE_BASE_DIRECTORY = ../resource

# ===========================================================================
# output directory
# ===========================================================================
OUTPUT_BASE_DIRECTORY          = build_DEBUG_app_output
OBJECT_BASE_DIRECTORY          = build_DEBUG_app_object
RESOURCE_OBJECT_BASE_DIRECTORY = build_DEBUG_app_object

# ===========================================================================
# output file
# ===========================================================================
OUTPUT_FILE = $(OUTPUT_BASE_DIRECTORY)/Test.exe

# ===========================================================================
# input file
# ===========================================================================
SOURCE_FILE = \
	$(SOURCE_BASE_DIRECTORY)/TestApplication.cpp

RESOURCE_FILE = \
	$(RESOURCE_BASE_DIRECTORY)/Project1.rc

LIBRARY_FILE = \
	build_DEBUG_lib_output/Test.lib



# ===========================================================================
# ===========================================================================
# intermedia file
# ===========================================================================
RESOURCE_OBJECT_FILE_0 = $(subst $(RESOURCE_BASE_DIRECTORY),$(RESOURCE_OBJECT_BASE_DIRECTORY),$(RESOURCE_FILE))
RESOURCE_OBJECT_FILE_1 = $(subst .rc,.res,$(RESOURCE_OBJECT_FILE_0))
RESOURCE_OBJECT_FILE   = $(RESOURCE_OBJECT_FILE_1)

OBJECT_FILE_0 = $(subst $(SOURCE_BASE_DIRECTORY),$(OBJECT_BASE_DIRECTORY),$(SOURCE_FILE))
OBJECT_FILE_1 = $(subst .cpp,.obj,$(OBJECT_FILE_0))
OBJECT_FILE_2 = $(subst .c,.obj,$(OBJECT_FILE_1))
OBJECT_FILE   = $(OBJECT_FILE_2)



# ===========================================================================
# ===========================================================================
# tool
# ===========================================================================
COMPILER = @cl
COMPILER_FLAGS_CPP = \
	/nologo \
	/GS \
	/analyze- \
	/W3 \
	/Zc:wchar_t \
	/ZI \
	/Gm \
	/Od \
	/fp:precise \
	/errorReport:prompt \
	/WX- \
	/Zc:forScope \
	/RTC1 \
	/Gd \
	/Oy- \
	/MTd \
	/EHsc \
	/D "WIN32" /D "_WINDOWS" /D "STRICT" /D "_DEBUG" /D "_CRT_SECURE_NO_WARNINGS" /D "_WINSOCK_DEPRECATED_NO_WARNINGS" /D "_MBCS" 


# ===========================================================================
RESOURCE_COMPILER = @rc
RESOURCE_COMPILER_FLAGS = \
	/nologo \
	/l 0x412 \
	/D "_DEBUG"


# ===========================================================================
MANIFEST_TOOL = @mt
MANIFEST_TOOL_FLAGS = \
	/nologo \
	/verbose


# ===========================================================================
LINKER = @link
LINKER_FLAGS = \
	/NOLOGO \
	/DYNAMICBASE "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" \
	/DEBUG \
	/MACHINE:X86 \
	/INCREMENTAL \
	/NXCOMPAT \
	/SUBSYSTEM:WINDOWS \
	/ERRORREPORT:PROMPT \
	/TLBID:1 \
	/MANIFEST \
	/MANIFESTUAC:"level='asInvoker' uiAccess='false'" \
	/ManifestFile:"$(RESOURCE_OBJECT_BASE_DIRECTORY)/exe.intermediate.manifest"


# ===========================================================================
SHELL_COMMAND = @MakefileShellCommand.bat



# ===========================================================================
# ===========================================================================
#.DEFAULT_GOAL = all



# ===========================================================================
# ===========================================================================
ifeq '$(MAKECMDGOALS)' ''
prepared_error:
	@echo NO TARGET!
endif



# ===========================================================================
# ===========================================================================
# intermedia file creation
# ===========================================================================
#%.obj: %.cpp
#$(OBJECT_BASE_DIRECTORY)/%.obj: $(SOURCE_BASE_DIRECTORY)/%.cpp
$(OBJECT_BASE_DIRECTORY)/%.obj: $(SOURCE_BASE_DIRECTORY)/%.cpp
#	@echo INPUT=$^ OUTPUT=$@ 
	$(SHELL_COMMAND) mkdir $(@D)
	$(COMPILER) $(COMPILER_FLAGS_CPP) /Fa$(subst .obj,.asm,$@) /Fd$(subst .obj,.pdb,$@) /Fo$@ /c $<

#%.res: %.rc
#$(RESOURCE_OBJECT_BASE_DIRECTORY)/%.res: $(RESOURCE_BASE_DIRECTORY)/%.rc
$(RESOURCE_OBJECT_BASE_DIRECTORY)/%.res: $(RESOURCE_BASE_DIRECTORY)/%.rc
#	@echo INPUT=$^ OUTPUT=$@ 
	$(SHELL_COMMAND) mkdir $(@D)
	$(RESOURCE_COMPILER) $(RESOURCE_COMPILER_FLAGS) /fo"$@" $<



# ===========================================================================
# ===========================================================================
# output file creation
# ===========================================================================
$(OUTPUT_FILE): $(OBJECT_FILE) $(RESOURCE_OBJECT_FILE)
#	@echo INPUT=$^ OUTPUT=$@ 
	$(SHELL_COMMAND) mkdir $(@D)
	$(LINKER) $(LINKER_FLAGS) /PDB:"$(subst .exe,.pdb,$@)" /OUT:"$@" $(OBJECT_FILE) $(LIBRARY_FILE) $(RESOURCE_OBJECT_FILE)
	$(MANIFEST_TOOL) $(MANIFEST_TOOL_FLAGS) -manifest $(RESOURCE_OBJECT_BASE_DIRECTORY)/exe.intermediate.manifest -outputresource:$(OUTPUT_FILE);1
#	$(MANIFEST_TOOL) $(MANIFEST_TOOL_FLAGS) /out:"$(RESOURCE_OBJECT_BASE_DIRECTORY)/exe.embed.manifest" "$(RESOURCE_OBJECT_BASE_DIRECTORY)/exe.embed.manifest.res"



# ===========================================================================
# compile
# ===========================================================================
.PHONY: compile_begin
compile_begin: 
	@echo -----------------------------------------------------------------------------
	@echo - COMPILE
	@echo -----------------------------------------------------------------------------

.PHONY: compile_end
compile_end: 
#	@echo -----------------------------------------------------------------------------
#	@echo THE END OF COMPILING.
	@echo .

.PHONY: compile_run
compile_run: $(OBJECT_FILE) $(RESOURCE_OBJECT_FILE)

.PHONY: compile
compile: compile_begin compile_run compile_end



# ===========================================================================
# link
# ===========================================================================
.PHONY: link_begin
link_begin:
	@echo -----------------------------------------------------------------------------
	@echo - LINK
	@echo -----------------------------------------------------------------------------

.PHONY: link_end
link_end:
#	@echo -----------------------------------------------------------------------------
#	@echo THE END OF LINKING.
	@echo .

.PHONY: link_run
link_run: $(OUTPUT_FILE)

.PHONY: link
link: link_begin link_run link_end



# ===========================================================================
# clean
# ===========================================================================
.PHONY: clean
clean:
	@echo -----------------------------------------------------------------------------
	@echo - CLEAN
	@echo -----------------------------------------------------------------------------
	$(SHELL_COMMAND) rmdir $(OBJECT_BASE_DIRECTORY)
	$(SHELL_COMMAND) rm $(OUTPUT_FILE)
	$(SHELL_COMMAND) rm $(subst .exe,.pdb,$(OUTPUT_FILE))
#	@echo -----------------------------------------------------------------------------
#	@echo THE END OF CLEANING.
	@echo .



# ===========================================================================
# logo
# ===========================================================================
.PHONY: logo
logo:
	@echo *****************************************************************************
	@echo * Makefile : $(OUTPUT_FILE)
	@echo *****************************************************************************



# ===========================================================================
# check
# ===========================================================================
.PHONY: check
check:
	@echo OUTPUT_BASE_DIRECTORY   = $(OUTPUT_BASE_DIRECTORY)
	@echo OUTPUT_FILE             = $(OUTPUT_FILE)
	@echo OBJECT_BASE_DIRECTORY   = $(OBJECT_BASE_DIRECTORY)
	@echo OBJECT_FILE             = $(OBJECT_FILE)
	@echo RESOURCE_BASE_DIRECTORY = $(RESOURCE_BASE_DIRECTORY)
	@echo RESOURCE_OBJECT_FILE    = $(RESOURCE_OBJECT_FILE)
	@echo RESOURCE_FILE           = $(RESOURCE_FILE)
	@echo SOURCE_BASE_DIRECTORY   = $(SOURCE_BASE_DIRECTORY)
	@echo SOURCE_FILE             = $(SOURCE_FILE)



# ===========================================================================
# rebuild
# ===========================================================================
.PHONY: rebuild
rebuild: logo clean compile link



# ===========================================================================
# build
# ===========================================================================
.PHONY: build
build: logo compile link



# ===========================================================================
# all
# ===========================================================================
.PHONY: all
all: rebuild




