; nasm elf.asm -f bin -o elf

bits 32
org 0x08048000

ehdr:
    db 0x7F, "ELFy Christmas!"
    dw 2            ; e_type
    dw 3            ; e_machine
    dd 1            ; e_version
    dd _start       ; e_entry
    dd phdr - $$    ; e_phoff
    dd 0            ; e_shoff
    dd 0            ; e_flags
    dw ehdrsize     ; e_ehsize
    dw phdrsize     ; e_phentsize
    dw 1            ; e_phnum
    dw 0            ; e_shentsize
    dw 0            ; e_shnum
    dw 0            ; e_shstrndx
ehdrsize equ  $ - ehdr

phdr:
    dd 1            ; p_type
    dd 0            ; p_offset
    dd $$           ; p_vaddr
    dd $$           ; p_paddr
    dd filesize     ; p_filesz
    dd filesize     ; p_memsz
    dd 7            ; p_flags
    dd 0x1000       ; p_align
phdrsize equ  $ - phdr

_start:
    mov dword [ehdr], 'Merr'
    mov al, 4
    mov bl, 1
    lea ecx, [ehdr]
    mov dl, 16
    int 0x80
    mov al, 1
    mov bl, 0
    int 0x80

filesize      equ     $ - $$