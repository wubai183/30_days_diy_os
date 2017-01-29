default:img

img:ipl.bin
	cp ipl.bin boot.img

ipl.bin: 
	@yasm ipl.asm -fbin -o ipl --objext=bin

install:img
	cp boot.img d:\boot.img

clean:
	@-rm ipl.bin
	@-rm boot.img