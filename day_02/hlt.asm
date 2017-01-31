; HELLO-OS
; TAB=4

	ORG 0xC200			;指明程序的装载地址

	MOV AL, 0x13			;VGA显卡,320x200x8位彩色
	MOV AH, 0x00
	INT 0x10
	
	MOV SI, msg
	JMP display_msg
	


;以下这段代码翻译为C语言如下
; while (1){
; 	HLT();
; }
fin:
	HLT					;让CPU停止，等待指令
	JMP fin				;无限循环
	
display_msg:
	MOV AL, [SI]
	ADD SI, 1			;给SI累加
	CMP AL, 0
	JE fin
	
	MOV AH, 0x0e		;显示一个文字
	MOV BX, 15			;指定字符颜色
	INT 0x10			;调用显卡BIOS
	
	JMP display_msg;
	
msg:
	;显示信息
	DB 0X0A, 0X0A		; 2个换行
	DB "AAAAAAAAAAAAAAAAAAAAAAAAAA!!"	; 显示信息
	DB 0X0A				; 换行
	DB 0