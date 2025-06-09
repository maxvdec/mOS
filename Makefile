
.PHONY: all clean run disk

BUILDIR = $(shell pwd)

all: mOS.iso

mOS.iso: avery.iso
	@echo "Creating the final ISO image..."
	cp avery.iso mOS.iso
	rm avery.iso

avery.iso:
	cd avery && make OUTDIR=$(BUILDIR)

clean:
	rm -f avery.iso mOS.iso
	cd avery && make OUTDIR=$(BUILDIR) clean

disk:
	@echo "Creating disk image..."
	dd if=/dev/zero of=disk.img bs=1M count=64

run: mOS.iso
	@clear
	@qemu-system-x86_64 -drive file=disk.img,format=raw -cdrom mOS.iso -m 128M -boot d -serial stdio 