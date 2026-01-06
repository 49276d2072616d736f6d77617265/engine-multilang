# ===== Config =====

ADA_SRC := ada
ZIG_SRC := zig

BUILD    := build
ADA_OBJ  := $(BUILD)/ada
LIBDIR   := $(BUILD)/lib
ZIG_BIN  := $(BUILD)/zig

GNATCC   := gnatgcc
GNATBIND := gnatbind
AR       := ar
ZIG      := zig

# ===== Ada sources =====

ADA_ADB := \
	$(ADA_SRC)/core.adb \
	$(ADA_SRC)/core_c.adb \
	$(ADA_SRC)/runtime_init.adb

ADA_OBJECTS := \
	$(ADA_OBJ)/core.o \
	$(ADA_OBJ)/core_c.o \
	$(ADA_OBJ)/runtime_init.o

ADA_MAIN := runtime_init
ADA_BIND_ADB := $(ADA_OBJ)/b~$(ADA_MAIN).adb
ADA_BIND_OBJ := $(ADA_OBJ)/b~$(ADA_MAIN).o

# ===== Outputs =====

LIB := $(LIBDIR)/libengine.a
ZIG_EXE := $(ZIG_BIN)/engine

# ===== Default =====

all: $(LIB) $(ZIG_EXE)

# ===== Directories =====

$(ADA_OBJ) $(LIBDIR) $(ZIG_BIN):
	mkdir -p $@

# ===== Ada compilation =====

$(ADA_OBJ)/%.o: $(ADA_SRC)/%.adb | $(ADA_OBJ)
	$(GNATCC) -c -gnata -gnatE $< -o $@

# ===== Ada binder =====

$(ADA_BIND_ADB): $(ADA_OBJECTS)
	cd $(ADA_OBJ) && $(GNATBIND) -n $(ADA_MAIN)

$(ADA_BIND_OBJ): $(ADA_BIND_ADB)
	$(GNATCC) -c $< -o $@

# ===== Static library =====

$(LIB): $(ADA_OBJECTS) $(ADA_BIND_OBJ) | $(LIBDIR)
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
