; HELLO-OS
; TAB=4

	ORG 0X7C00			;指明程序的装载地址

; 以下这段是标准FAT12格式软盘专用的代码
	JMP entry
	DB 0x90				
	DB "HELLOIPL"		; 启动盘名称/厂商名（8字节）
	DW 512				; 每扇区(sector)字节数(必须是512)(2字节)
	DB 1				; 每簇(cluster)扇区数(必须是1)(1字节)
	DW 1				; FAT的起始位置(一般是第一个扇区)(2字节)
	DB 2				; FAT的个数
	DW 224				; 根目录的大小(一般设成224)
	DW 2880				; 该磁盘的大小(必须是2880扇区)
	DB 0XF0				; 磁盘的种类(必须是0xf0)
	DW 9				; FAT的长度(必须是9扇区)
	DW 18				; 1个磁道(track)有几个扇区(必须是18)
	DW 2				; 磁头数(必须是2)
	DD 0				; 不使用分区,必须是0
	DD 2880				; 重写一次磁盘大小,扇区数
	DB 0,0,0X29			; 中断13的驱动器号, 未用字段, 扩展引用标记(必须是29h)
	DD 0XFFFFFFFF		; 卷序列号
	DB "HELLO-OS   "	; 卷标名称
	DB "FAT12   "		; 文件系统类型

;以下是引导代码、数据及其他填充字符
; 先空出18字节
TIMES 18 DB 0x0

;程序主体
entry:
	MOV AX, 0			;初始化寄存器
	MOV SS, AX
	MOV SP, 0x7c00
	MOV DS, AX
	MOV ES, AX
	
	MOV SI, msg			;加载msg段的第一个字节内容到SI中

;以下这段代码翻译为C语言如下
; while(1){
; 	AL = *SI;
;	SI += 1;
;	if(AL == 0)
;		goto fin;
;	
;	//AL保存要显示的字符
;	AH = 0x0e;
;	BX = 15;	//设置显示颜色
;	INT(0x10,	//中断号
;		AX,		//低位为要显示的字符，高位为0x0e
;		BX);	//显示颜色
; }
putloop:
	MOV AL, [SI]
	ADD SI, 1			;给SI累加
	CMP AL, 0
	JE fin
	
	MOV AH, 0x0e		;显示一个文字
	MOV BX, 15			;指定字符颜色
	INT 0x10			;调用显卡BIOS
	
	JMP putloop;
	
;以下这段代码翻译为C语言如下
; while (1){
; 	HLT();
; }
fin:
	HLT					;让CPU停止，等待指令
	JMP fin				;无限循环
	
msg:
	;显示信息
	DB 0X0A, 0X0A		; 2个换行
	DB "hello, world"	; 显示信息
	DB 0X0A				; 换行
	DB 0

;填充0，nop
TIMES 0x1fe-($-$$) DB 0

;引导区结束标志
DB 0X55, 0XAA

;以下是启动区以外部分的输出
DB 0XF0, 0XFF, 0XFF, 0X00, 0X00, 0X00, 0X00, 0X00
TIMES 4600 DB 0
DB 0XF0, 0XFF, 0XFF, 0X00, 0X00, 0X00, 0X00, 0X00
TIMES 1469432 DB 0
