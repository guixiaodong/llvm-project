@ RUN: llvm-mc -triple armv7-elf -filetype asm -o - %s | FileCheck %s
@ RUN: llvm-mc -triple armv7-eabi -filetype obj -o - %s \
@ RUN:   | llvm-readobj --arm-attributes - | FileCheck %s --check-prefix=CHECK-OBJ
.eabi_attribute  Tag_CPU_arch, 11
@CHECK:   .eabi_attribute 6, 11
@CHECK-OBJ: Tag: 6
@CHECK-OBJ-NEXT: Value: 11
@CHECK-OBJ-NEXT: TagName: CPU_arch
@CHECK-OBJ-NEXT: Description: ARM v6-M

.eabi_attribute  Tag_ABI_align_needed, 11
@CHECK:   .eabi_attribute 24, 11
@CHECK-OBJ: Tag: 24
@CHECK-OBJ-NEXT: Value: 11
@CHECK-OBJ-NEXT: TagName: ABI_align_needed
@CHECK-OBJ-NEXT: Description: 8-byte alignment, 2048-byte extended alignment

.eabi_attribute  Tag_ABI_align_preserved, 11
@CHECK:   .eabi_attribute 25, 11
@CHECK-OBJ: Tag: 25
@CHECK-OBJ-NEXT: Value: 11
@CHECK-OBJ-NEXT: TagName: ABI_align_preserved
@CHECK-OBJ-NEXT: Description: 8-byte stack alignment, 2048-byte data alignment

