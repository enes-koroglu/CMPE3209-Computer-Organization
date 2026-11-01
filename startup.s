.section .text.start
.globl _start
_start:
    la sp, _stack_top
    call main

stop:
    j stop

.section .bss
.balign 16
stack:
    .space 4096
_stack_top: