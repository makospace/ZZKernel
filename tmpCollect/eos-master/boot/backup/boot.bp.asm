%include    "pm.inc.asm"
%ifdef _BUILD_COM_
    org     0100h 
%else
    org     07c00h
%endif
    jmp     LABEL_BEGIN

PDEBase             equ     200000h
PTEBase             equ     201000h

[SECTION .gdt]
;                                   段基址      段界限      属性
LABEL_GDT:              Descriptor       0,             0,      0
LABEL_DESC_NORMAL:      Descriptor       0,        0ffffh, DA_DRW
LABEL_DESC_PDE:         Descriptor PDEBase,          4095, DA_DRW
LABEL_DESC_PTE:         Descriptor PTEBase,          1023, DA_DRW|DA_LIMIT_4K
LABEL_DESC_TSS:         Descriptor       0,    TSSLen - 1, DA_386TSS
LABEL_DESC_CODE32:      Descriptor       0,SegCode32Len-1, DA_C + DA_32
LABEL_DESC_CODE16:      Descriptor       0,        0ffffh, DA_C
LABEL_DESC_CODE_DEST:   Descriptor       0,SegCodeDestLen-1, DA_C + DA_32
LABEL_DESC_CODE_R3:     Descriptor       0,SegCodeR3Len-1, DA_C + DA_32 + DA_DPL3
LABEL_DESC_DATA:        Descriptor       0,     DataLen-1, DA_DRW
LABEL_DESC_STACK:       Descriptor       0,    TopOfStack, DA_DRWA+DA_32
LABEL_DESC_STACK3:      Descriptor       0,   TopOfStack3, DA_DRWA+DA_32+DA_DPL3
LABEL_DESC_LDT:         Descriptor       0,    LDTLen - 1, DA_LDT
LABEL_DESC_VIDEO:       Descriptor 0B8000h,        0ffffh, DA_DRW+DA_DPL3
;                               选择子          偏移  DCount      属性
LABEL_CALL_GATE_TEST:   Gate SelectorCodeDest,    0,      0, DA_386CGate+DA_DPL3
GdtLen      equ     $ - LABEL_GDT
GdtPtr      dw      GdtLen - 1
            dd      0
SelectorNormal      equ     LABEL_DESC_NORMAL       - LABEL_GDT
SelectorTss         equ     LABEL_DESC_TSS          - LABEL_GDT
SelectorPDE         equ     LABEL_DESC_PDE          - LABEL_GDT
SelectorPTE         equ     LABEL_DESC_PTE          - LABEL_GDT
SelectorCode32      equ     LABEL_DESC_CODE32       - LABEL_GDT
SelectorCode16      equ     LABEL_DESC_CODE16       - LABEL_GDT
SelectorCodeDest    equ     LABEL_DESC_CODE_DEST    - LABEL_GDT
SelectorCodeR3      equ     LABEL_DESC_CODE_R3      - LABEL_GDT
SelectorData        equ     LABEL_DESC_DATA         - LABEL_GDT
SelectorStack       equ     LABEL_DESC_STACK        - LABEL_GDT
SelectorStack3      equ     LABEL_DESC_STACK3       - LABEL_GDT
SelectorLDT         equ     LABEL_DESC_LDT          - LABEL_GDT
SelectorVideo       equ     LABEL_DESC_VIDEO        - LABEL_GDT
SelectorCallGateTest    equ LABEL_CALL_GATE_TEST    - LABEL_GDT + SA_RPL3

; tss
[SECTION .tss]
ALIGN   32
[BITS   32]
LABEL_TSS:
    dd  0
    dd  TopOfStack              ; ring 0
    dd  SelectorStack
    dd  0                       ; ring 1
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dd  0
    dw  0
    dw  $ - LABEL_TSS + 2
    db  0ffh
TSSLen  equ     $ - LABEL_TSS

; data section
[SECTION .data1]
ALIGN   32
[BITS   32]
LABEL_DATA:
SPValueInRealMode       dw      0
; strings
PMMessage:              db      "In_Protect_Mode_now.1236", 0
OffsetPMMessage         equ     PMMessage - $$
StrTest:                db      "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
OffsetStrTest           equ     StrTest - $$
DataLen                 equ     $ - LABEL_DATA

; global stack
[SECTION .gs]
ALIGN   32
[BITS   32]
LABEL_STACK:
    times   512     db      0
TopOfStack      equ     $ - LABEL_STACK

[SECTION .s3]
ALIGN   32
[BITS   32]
LABEL_STACK3:
    times   512     db      0
TopOfStack3     equ     $ - LABEL_STACK3

[SECTION .s16]
[BITS 16]
LABEL_BEGIN:
    mov     ax, cs
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, 0100h

    mov     [LABEL_GO_BACT_TO_REAL + 3], ax     ; 这里是通过动态的修改下文中的指令的参数 来实现
                                                ; 跳转回实模式的 修改的地方 请搜索 'caution'
                                                ; 指令格式具体请参考原书

    ; init descriptor tss
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_TSS
    mov     word [LABEL_DESC_TSS + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_TSS + 4], al
    mov     byte [LABEL_DESC_TSS + 7], ah

    ; init descriptor code32
    xor     eax, eax                            ; 清空eax
    mov     ax, cs                              ; eax = 段基址
    shl     eax, 4                              ; 段基址 * 16
    add     eax, LABEL_SEG_CODE32               ; 加上偏移量
    mov     word [LABEL_DESC_CODE32 + 2], ax    ; 将计算好的32位代码段地址赋给代码段的描述符
    shr     eax, 16
    mov     byte [LABEL_DESC_CODE32 + 4], al
    mov     byte [LABEL_DESC_CODE32 + 7], ah

    ; init descriptor code16
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_SEG_CODE16
    mov     word [LABEL_DESC_CODE16 + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_CODE16 + 4], al
    mov     byte [LABEL_DESC_CODE16 + 7], ah

    ; init descriptor code dest
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_SEG_CODE_DEST
    mov     word [LABEL_DESC_CODE_DEST + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_CODE_DEST + 4], al
    mov     byte [LABEL_DESC_CODE_DEST + 7], ah

    ; init descriptor code ring3
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_SEG_CODE_R3
    mov     word [LABEL_DESC_CODE_R3 + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_CODE_R3 + 4], al
    mov     byte [LABEL_DESC_CODE_R3 + 7], ah

    ; init descriptor data
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_DATA
    mov     word [LABEL_DESC_DATA + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_DATA + 4], al
    mov     byte [LABEL_DESC_DATA + 7], ah

    ; init descriptor stack
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_STACK
    mov     word [LABEL_DESC_STACK + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_STACK + 4], al
    mov     byte [LABEL_DESC_STACK + 7], ah

    ; init descriptor stack ring3
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_STACK3
    mov     word [LABEL_DESC_STACK3 + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_STACK3 + 4], al
    mov     byte [LABEL_DESC_STACK3 + 7], ah

    ; init descriptor ldt
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_LDT
    mov     word [LABEL_DESC_LDT + 2], ax
    shr     eax, 16
    mov     byte [LABEL_DESC_LDT + 4], al
    mov     byte [LABEL_DESC_LDT + 7], ah

    ; init descriptor code in ldt
    xor     eax, eax
    mov     ax, cs
    shl     eax, 4
    add     eax, LABEL_LDT_CODE_A
    mov     word [LABEL_LDT_DESC_CODEA + 2], ax
    shr     eax, 16
    mov     byte [LABEL_LDT_DESC_CODEA + 4], al
    mov     byte [LABEL_LDT_DESC_CODEA + 7], ah

    xor     eax, eax
    mov     ax, ds
    shl     eax, 4
    add     eax, LABEL_GDT
    mov     dword [GdtPtr + 2], eax

    lgdt    [GdtPtr]

    cli

    in      al, 92h
    or      al, 00000010b
    out     92h, al

    mov     eax, cr0
    or      eax, 1
    mov     cr0, eax

    jmp     dword SelectorCode32:0

LABEL_REAL_ENTRY:
    mov     ax, cs
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    
    mov     sp, [SPValueInRealMode]

    in      al, 92h
    and     al, 1111101b
    out     92h, al

    sti

    mov     ax, 4c00h           ; return
    int     21h                 ; dos

[SECTION .s16code]
ALIGN   32
[BITS   32]
LABEL_SEG_CODE16:
    ; return real mode
    mov     ax, SelectorNormal
    mov     ds, ax
    mov     es, ax
    mov     fs, ax
    mov     gs, ax
    mov     ss, ax

    mov     eax, cr0
    and     al, 11111110b
    mov     cr0, eax

LABEL_GO_BACT_TO_REAL:
    ; 这里的段地址0将会被上文中的代码修改掉 指向应有的段地址
    jmp     0:LABEL_REAL_ENTRY          ; [caution] where the value will be revised by code
Code16Len   equ     $ - LABEL_SEG_CODE16

[SECTION .s32]
[BITS   32]
LABEL_SEG_CODE32:
    mov     ax, SelectorData
    mov     ds, ax
    ; mov     ax, SelectorTest
    mov     es, ax
    mov     ax, SelectorVideo
    mov     gs, ax

    mov     ax, SelectorStack
    mov     ss, ax
    mov     esp, TopOfStack

    ; to show a string
    mov     ah, 0ch
    xor     esi, esi
    xor     edi, edi
    mov     esi, OffsetPMMessage
    mov     edi, (80 * 10 + 0) * 2
    cld
.1:
    lodsb
    test    al, al
    jz      .2
    mov     [gs:edi], ax
    add     edi, 2
    jmp     .1
.2:
    call    DispReturn

    call    SetupPaging

    ; call    TestRead
    ; call    TestWrite
    ; call    TestRead

    ; call Call-Gate
    ; call    SelectorCallGateTest:0
    
    ; load tss
    mov     ax, SelectorTss
    ltr     ax

    ; enter ring3
    ; 构建堆栈中的数据 模拟call的返回 来完成到ring3的跳转
    ; prepare stack
    push    SelectorStack3
    push    TopOfStack3
    push    SelectorCodeR3
    push    0
    retf

; 用于启动分页机制
SetupPaging:
    mov     ax, SelectorPDE
    mov     es, ax
    mov     ecx, 1024
    xor     edi, edi                        ; es:edi 指向PDE的开头
    xor     eax, eax
    mov     eax, PTEBase | PG_P | PG_USU | PG_RWW     ; 对应页表基址 | 存在 | 用户级别 | 可读可写
.1:
    ; 初始化PDE
    stosd                                   ; mov [es:edi], eax; edi = edi + 4
    add     eax, 4096                       ; 每次循环页目录表记录的页表地址增加4096 (4KB)
    ; 循环ecx 1024次
    loop    .1
    ; 初始化所有的页表
    mov     ax, SelectorPTE
    mov     es, ax
    mov     ecx, 1024 * 1024                ; 初始化1024 * 1024个页表
    xor     edi, edi
    xor     eax, eax
    mov     eax, PG_P | PG_USU | PG_RWW     ; 存在 | 用户级别 | 可读可写
.2:
    stosd
    add     eax, 4096                       ; 每次循环 页表大小为4096（4KB）
    loop    .2

    mov     eax, PDEBase                    ; 加载页目录表
    mov     cr3, eax
    mov     eax, cr0
    or      eax, 8000000h
    mov     cr0, eax
    jmp     short .3
.3:
    nop

    ret

;;;;;;;;;;;;;;;;;32bit func
; 读大地址的内存的数据
TestRead:
    xor     esi, esi
    mov     ecx, 8
.loop:
    mov     al, [es:esi]
    call    DispAL
    inc     esi
    loop    .loop

    call    DispReturn

    ret
; 写大地址的内存的数据
TestWrite:
    push    esi
    push    edi
    xor     esi, esi
    xor     edi, edi
    mov     esi, OffsetStrTest
    cld
.1:
    lodsb
    test    al, al
    jz      .2
    mov     [es:edi], al
    inc     edi
    jmp     .1
.2:
    pop     edi
    pop     esi

    ret

; 输出寄存器AL的值
DispAL:
    push    ecx
    push    edx

    mov     ah, 0ch
    mov     dl, al
    shr     al, 4
    mov     ecx, 2
.begin:
    and     al, 01111b
    cmp     al, 9
    ja      .1
    add     al, '0'
    jmp     .2
.1:
    sub     al, 0ah         ; 当值超过了9 就要去添加基于A的值 就和ascii字符转成数字一个意思
    add     al, 'A'
.2:
    mov     [gs:edi], ax
    add     edi, 2

    mov     al, dl
    loop    .begin
    add     edi, 2

    pop     edx
    pop     ecx
    ret

; 输出一个换行
DispReturn:
    push    eax
    push    ebx
    mov     eax, edi
    mov     bl, 160
    div     bl
    and     eax, 0ffh
    inc     eax
    mov     bl, 160
    mul     bl
    mov     edi, eax
    pop     ebx
    pop     eax

    ret
SegCode32Len    equ     $ - LABEL_SEG_CODE32

[SECTION .sdest]
[BITS   32]
LABEL_SEG_CODE_DEST:
    mov     ax, SelectorVideo
    mov     gs, ax

    mov     edi, (80 * 0 + 1) * 2
    mov     ah, 0Ch
    mov     al, 'c'
    mov     [gs:edi], ax

    ; load ldt
    mov     ax, SelectorLDT
    lldt    ax
    
    ; go into ldt code
    jmp     SelectorLDTCodeA:0
SegCodeDestLen      equ     $ - LABEL_SEG_CODE_DEST

[SECTION .ring3]
ALIGN   32
[BITS   32]
LABEL_SEG_CODE_R3:
    mov     ax, SelectorVideo
    mov     gs, ax

    mov     edi, (80 * 0 + 0) * 2
    mov     ah, 0Ch
    mov     al, '3'
    mov     [gs:edi], ax

    ; 通过调用门进入ring0的代码段
    call    SelectorCallGateTest:0
SegCodeR3Len    equ     $ - LABEL_SEG_CODE_R3

[SECTION .ldt]
ALIGN   32
LABEL_LDT:
;                                       段基址    段界限         属性
LABEL_LDT_DESC_CODEA:       Descriptor      0,  LdtCodeALen-1, DA_C + DA_32

LDTLen          equ     $ - LABEL_LDT

SelectorLDTCodeA     equ     LABEL_LDT_DESC_CODEA    - LABEL_LDT + SA_TIL

[SECTION .la]
ALIGN   32
[BITS   32]
LABEL_LDT_CODE_A:
    mov     ax, SelectorVideo
    mov     gs, ax

    ; 14行
    mov     edi, (80 * 0 + 2) * 2
    mov     ah, 0Ch
    mov     al, 'L'
    mov     [gs:edi], ax

    ; 跳出保护模式
    jmp     SelectorCode16:0
LdtCodeALen     equ     $ - LABEL_LDT_CODE_A