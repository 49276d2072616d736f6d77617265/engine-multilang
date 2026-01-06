# ========================
# Config
# ========================

ADA_SRC   := ada
ZIG_SRC   := zig
JULIA_SRC := julia

BUILD   := build
ADA_OBJ := $(BUILD)/ada
LIBDIR  := $(BUILD)/lib

GNATCC   := gnatgcc
GNATBIND := gnatbind
AR       := ar
ZIG      := zig
JULIA    := julia

# ========================
# Ada flags (PIC É O PONTO-CHAVE)
# ========================

ADA_CFLAGS := -fPIC -gnata -gnatE

# ========================
# Ada sources
# ========================

ADA_ADB := \
	$(ADA_SRC)/core.adb \
	$(ADA_SRC)/core_c.adb \
	$(ADA_SRC)/runtime_init.adb

ADA_OBJECTS := \
	$(ADA_OBJ)/core.o \
	$(ADA_OBJ)/core_c.o \
	$(ADA_OBJ)/runtime_init.o

ADA_MAIN      := runtime_init
ADA_BIND_ADB  := $(ADA_OBJ)/b~$(ADA_MAIN).adb
ADA_BIND_OBJ  := $(ADA_OBJ)/b~$(ADA_MAIN).o

# ========================
# Outputs
# ========================

ADA_LIB := $(LIBDIR)/libengine_ada.a
ZIG_LIB := $(LIBDIR)/libengine.so

# ========================
# Default target
# ========================

all: $(ZIG_LIB)

# ========================
# Directories
# ========================

$(ADA_OBJ) $(LIBDIR):
	mkdir -p $@

# ========================
# Ada compilation (PIC!)
# ========================

$(ADA_OBJ)/%.o: $(ADA_SRC)/%.adb | $(ADA_OBJ)
	$(GNATCC) -c $(ADA_CFLAGS) $< -o $@

# ========================
# Ada binder
# ========================

$(ADA_BIND_ADB): $(ADA_OBJECTS)
	cd $(ADA_OBJ) && $(GNATBIND) -n $(ADA_MAIN)

# ⚠️ binder TAMBÉM precisa de PIC
$(ADA_BIND_OBJ): $(ADA_BIND_ADB)
	$(GNATCC) -c -fPIC $< -o $@

# ========================
# Ada static library (PIC-safe)
# ========================

$(ADA_LIB): $(ADA_OBJECTS) $(ADA_BIND_OBJ) | $(LIBDIR)
	$(AR) rcs $@ $^

# ========================
# Zig shared library (FINAL ABI)
# ========================

$(ZIG_LIB): $(ZIG_SRC)/engine.zig $(ADA_LIB) | $(LIBDIR)
	$(ZIG) build-lib $(ZIG_SRC)/engine.zig \
		-O ReleaseSafe \
		-dynamic \
		$(ADA_LIB) \
		-lgnat \
		-lgnarl \
		-lgcc_s \
		--name engine \
		-femit-bin=$@

# ========================
# Run Julia (consumer)
# ========================

run-julia: all
	LD_LIBRARY_PATH=$(LIBDIR) $(JULIA) $(JULIA_SRC)/main.jl

# ========================
# Clean
# ========================

clean:
	rm -rf $(BUILD)

.PHONY: all clean run-julia
