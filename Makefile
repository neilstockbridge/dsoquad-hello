
# Skeleton Makefile for DSO Quad applications

NAME = HELLO

PARTS = main.o

# NOTE: Comment out APP4.HEX if this app is larger than 32kB
DELIVERABLES = APP1.HEX  APP2.HEX  APP3.HEX  APP4.HEX

# Options for the linker.  "-L support" helps the linker find the .lds files
LFLAGS = -L support

#LIBS = -lm

# "-I support" is so that make can find the DSO Quad platform files
CFLAGS = -I support

# Processor type
CFLAGS += -mcpu=cortex-m3 -mthumb -mno-thumb-interwork

# Optimization & debug settings
CFLAGS += -fno-common -Os -std=gnu99

# Compiler warnings
CFLAGS += -Wall -Wno-unused

# Default linker arguments (disables GCC-provided startup.c, creates .map file)
LFLAGS += -nostartfiles -Wl,-Map=$(TDIR)/$(NAME).map -eReset_Handler

.SILENT:

# The directory for .o files and such.  Keep it in RAM for speed and to reduce
# flash disc wear
TDIR = /tmp/$(NAME)

# Add the support files to the list of objects to build:
PARTS += startup.o BIOS.o Interrupt.o

# Names of the toolchain programs
CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

# Tell make where to find transitional files:
VPATH = support:$(TDIR)

# How to make .HEX files from .elf files:
%.HEX: %.elf
	$(OBJCOPY) -O ihex $< $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.elf: %.lds $(PARTS)
	$(CC) $(CFLAGS) -o $@ $(PARTS) ${LFLAGS} ${LIBS} -T $<

# Rebuild all parts if any header or the Makefile changes:
.c.o: *.h Makefile
	$(CC) $(CFLAGS) -c -o $@ $<

.S.o: | $(TDIR)
	$(CC) $(AFLAGS) -c -o $@ $<

all: $(DELIVERABLES)
	$(SIZE) APP1.elf

$(TDIR):
	mkdir $(TDIR)

clean:
	rm -f $(TDIR)/*.o $(TDIR)/*.map $(DELIVERABLES)
