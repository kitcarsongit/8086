%include "defines.nasm"

;---------------------------------
; NASM DIRECTIVES
;---------------------------------

[bits 16]
[cpu 8086]
[org BOOT_OFF] ;this is where the BIOS load the bootloader at startup

;---------------------------------
; BOOT
;---------------------------------
init:
  cli                              ; disable interrupts
  mov [DEVICE], dl

  xor ax, ax                       ; clear registers 
  mov bx, ax
  mov cx, ax
  mov dx, ax
  
  mov si, ax                       ; setup index registers
  mov di, ax

  mov ds, ax                       ; setup ds and es segments
  mov es, ax

  mov ax, STACK_SEG                ; setup stack segment
  mov ss, ax

  mov ax, STACK_OFF                ; setup base pointer and stack pointer
  mov bp, ax
  mov sp, ax

  cld                              ; clear df flag

  mov ah, 0x00                     ; set video mode 
  mov al, 0x03                     ; set 80x25 teletype
  int 0x10

  mov ah, 0x05                     ; set active page
  mov al, 0x00                     ; set current page number 
  int 0x10

  sti                              ; re enable interrupt 

  hlt


;---------------------------------
; FUNCTIONS
;---------------------------------



;---------------------------------
; CONSTANTS
;---------------------------------

DEVICE: db 0x00

;---------------------------------
; BOOTLOADER SIGNATURE
;---------------------------------

times 510 - ($-$$), db 0x00
dw  0xaa55
