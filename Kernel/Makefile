ASM      = nasm
LD       = ld
ASMFLAGS = -f elf32
LDFLAGS  = -m elf_i386 -T linker.ld

all: os-image.img

boot.bin: boot.asm
	$(ASM) -f bin $< -o $@

kernel.o: kernel.asm
	$(ASM) $(ASMFLAGS) $< -o $@

kernel.bin: kernel.o
	$(LD) $(LDFLAGS) $< -o $@

os-image.img: boot.bin kernel.bin
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=boot.bin   of=$@ conv=notrunc
	dd if=kernel.bin of=$@ conv=notrunc bs=512 seek=1

run: os-image.img
	qemu-system-i386 -drive format=raw,file=$<

clean:
	rm -f *.bin *.o *.img
