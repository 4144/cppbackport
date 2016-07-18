# Sources are located relative to Makefile
MAKEFILE_DIR := $(shell readlink -f $(dir $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))))

# The path of the invoking module
vpath %.cpp $(MAKEFILE_DIR)

default: lib

include $(MAKEFILE_DIR)/make.inc

CXXFLAGS += -pthread
LDFLAGS += -pthread

LIBNAME = cppbackport
LIBFILE = lib$(LIBNAME).a
SRCDIRS = lib lib/fs
LIBSRC = $(wildcard $(SRCDIRS:%=$(MAKEFILE_DIR)/%/*.cpp))
LIBOBJS = $(LIBSRC:$(MAKEFILE_DIR)/%.cpp=%.o)

.PHONY: lib clean

$(LIBFILE): $(LIBOBJS)

lib: $(LIBFILE)

clean: clean_objects
	@$(RM) $(LIBFILE)
