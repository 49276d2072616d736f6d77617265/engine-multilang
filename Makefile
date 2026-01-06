# ===== Config =====

ADA_SRC := ada
ZIG_SRC := zig

BUILD    := build
ADA_OBJ  := $(BUILD)/ada
LIBDIR   := $(BUILD)/lib
ZIG_BIN  := $(BUILD)/zig

GNATCC := gnatgcc
AR     := ar
ZIG    := zig

# ===== Ada sources =====

ADA_ADB := \
	$(ADA_SRC)/core.adb \
	$(ADA_SRC)/core_c.adb

ADA_OBJECTS := \
	$(ADA_OBJ)/core.o \
	$(ADA_OBJ)/core_c.o

# ===== Outputs =====

LIB := $(LIBDIR)/libengine.a
ZIG_EXE := $(ZIG_BIN)/engine

# ===== Default =====

all: $(LIB) $(ZIG_EXE)

# ===== Directories =====

$(ADA_OBJ):
	mkdir -p $(ADA_OBJ)

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(ZIG_BIN):
	mkdir -p $(ZIG_BIN)

# ===== Ada compilation =====

$(ADA_OBJ)/%.o: $(ADA_SRC)/%.adb | $(ADA_OBJ)
	$(GNATCC) -c -gnatp $< -o $@

# ===== Static library =====

$(LIB): $(ADA_OBJECTS) | $(LIBDIR)
	$(AR) rcs $@ $^

# ===== Zig build =====

$(ZIG_EXE): $(ZIG_SRC)/engine.zig $(LIB) | $(ZIG_BIN)
	$(ZIG) build-exe $< \
		-O ReleaseSafe \
		$(LIB) \
		-lgnat \
		-lgnarl \
		-lgcc_s \
		-femit-bin=$@

# ===== Clean =====

clean:
	rm -rf $(BUILD)

.PHONY: all clean
