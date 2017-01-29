; HELLO-OS
; TAB=4

; 以下这段是标准FAT12格式软盘专用的代码
DB 0xeb, 0x4e, 0x90	; 跳转指令
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
;RESB 18
times 18 db 0

;程序主体
DB 0XB8, 0X00, 0X00, 0X8E, 0XD0, 0XBC, 0X00, 0X7C
DB 0X8E, 0XD8, 0X8E, 0XC0, 0XBE, 0X74, 0X7C, 0X8A
DB 0X04, 0X83, 0XC6, 0X01, 0X3C, 0X00, 0X74, 0X09
DB 0XB4, 0X0E, 0XBB, 0X0F, 0X00, 0XCD, 0X10, 0XEB
DB 0XEE, 0XF4, 0XEB, 0XFD

;显示信息
DB 0X0A, 0X0A		; 2个换行
DB "hello, world"	; 显示信息
DB 0X0A				; 换行
DB 0

;填充0，nop
;RESB 0X1fe-$
times 0x1fe-($-$$) db 0

;引导区结束标志
DB 0X55, 0XAA

;以下是启动区以外部分的输出
DB 0XF0, 0XFF, 0XFF, 0X00, 0X00, 0X00, 0X00, 0X00
;RESB 4600
times 4600 db 0
DB 0XF0, 0XFF, 0XFF, 0X00, 0X00, 0X00, 0X00, 0X00
;RESB 1469432
times 1469432 db 0
