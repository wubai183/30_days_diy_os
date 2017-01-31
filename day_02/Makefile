DEBUG_FLAG = @

default:img

img:ipl_bin hlt_sys
	@cp ipl.bin boot.img
	@echo "尚未实现将hlt.sys写入软盘镜像的功能"
	@echo "目前是通过UltraISO工具添加hlt.sys文件到boot.img,保存镜像文件"

ipl_bin: 
	@yasm ipl.asm -fbin -o ipl --objext=bin
	
hlt_sys:
	@yasm hlt.asm -fbin -o hlt --objext=sys

install:img
	@cp boot.img d:\boot.img

clean:
	-rm ipl.bin
	-rm boot.img
	-rm hlt.sys
	
commit:clean
	git add .
	git commit -a
	