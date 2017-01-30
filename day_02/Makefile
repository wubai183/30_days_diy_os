default:img

img:ipl_bin
	cp ipl.bin boot.img

ipl_bin: 
	@yasm ipl.asm -fbin -o ipl --objext=bin

install:img
	cp boot.img d:\boot.img

clean:
	@-rm ipl.bin
	@-rm boot.img
	
commit:clean
	git add .
	git commit -a
	