; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -mattr=+fp64 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32R2-FP64
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -mattr=+soft-float -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32R2-SF
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r3 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32R3R5
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r5 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32R3R5
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r6 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M32R6
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips3 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M64
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M64
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r2 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M64
; RUN: llc < %s -mtriple=mips64-linux-gnu -mcpu=mips64r6 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=M64R6
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -mattr=+micromips -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=MMR2-FP32
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -mattr=+micromips,fp64 -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=MMR2-FP64
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r2 -mattr=+micromips,soft-float -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=MMR2-SF
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r6 -mattr=+micromips -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=MMR6
; RUN: llc < %s -mtriple=mips-linux-gnu -mcpu=mips32r6 -mattr=+micromips,soft-float -asm-show-inst |\
; RUN:   FileCheck %s -check-prefixes=MMR6-SF

; Test that fptosi can be matched for MIPS targets for various FPU
; configurations

define i32 @test1(float %t) {
; M32-LABEL: test1:
; M32:       # %bb.0: # %entry
; M32-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M32-NEXT:    # <MCOperand Reg:147>
; M32-NEXT:    # <MCOperand Reg:159>>
; M32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32-NEXT:    # <MCOperand Reg:19>>
; M32-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32-NEXT:    # <MCOperand Reg:321>
; M32-NEXT:    # <MCOperand Reg:147>>
;
; M32R2-FP64-LABEL: test1:
; M32R2-FP64:       # %bb.0: # %entry
; M32R2-FP64-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M32R2-FP64-NEXT:    # <MCOperand Reg:147>
; M32R2-FP64-NEXT:    # <MCOperand Reg:159>>
; M32R2-FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R2-FP64-NEXT:    # <MCOperand Reg:19>>
; M32R2-FP64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R2-FP64-NEXT:    # <MCOperand Reg:321>
; M32R2-FP64-NEXT:    # <MCOperand Reg:147>>
;
; M32R2-SF-LABEL: test1:
; M32R2-SF:       # %bb.0: # %entry
; M32R2-SF-NEXT:    addiu $sp, $sp, -24 # <MCInst #{{[0-9]+}} ADDiu
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:-24>>
; M32R2-SF-NEXT:    .cfi_def_cfa_offset 24
; M32R2-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; M32R2-SF-NEXT:    # <MCInst #{{[0-9]+}} SW
; M32R2-SF-NEXT:    # <MCOperand Reg:19>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:20>>
; M32R2-SF-NEXT:    .cfi_offset 31, -4
; M32R2-SF-NEXT:    jal __fixsfsi # <MCInst #{{[0-9]+}} JAL
; M32R2-SF-NEXT:    # <MCOperand Expr:(__fixsfsi)>>
; M32R2-SF-NEXT:    nop # <MCInst #{{[0-9]+}} SLL
; M32R2-SF-NEXT:    # <MCOperand Reg:21>
; M32R2-SF-NEXT:    # <MCOperand Reg:21>
; M32R2-SF-NEXT:    # <MCOperand Imm:0>>
; M32R2-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; M32R2-SF-NEXT:    # <MCInst #{{[0-9]+}} LW
; M32R2-SF-NEXT:    # <MCOperand Reg:19>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:20>>
; M32R2-SF-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R2-SF-NEXT:    # <MCOperand Reg:19>>
; M32R2-SF-NEXT:    addiu $sp, $sp, 24 # <MCInst #{{[0-9]+}} ADDiu
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:24>>
;
; M32R3R5-LABEL: test1:
; M32R3R5:       # %bb.0: # %entry
; M32R3R5-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M32R3R5-NEXT:    # <MCOperand Reg:147>
; M32R3R5-NEXT:    # <MCOperand Reg:159>>
; M32R3R5-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R3R5-NEXT:    # <MCOperand Reg:19>>
; M32R3R5-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R3R5-NEXT:    # <MCOperand Reg:321>
; M32R3R5-NEXT:    # <MCOperand Reg:147>>
;
; M32R6-LABEL: test1:
; M32R6:       # %bb.0: # %entry
; M32R6-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M32R6-NEXT:    # <MCOperand Reg:147>
; M32R6-NEXT:    # <MCOperand Reg:159>>
; M32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; M32R6-NEXT:    # <MCOperand Reg:21>
; M32R6-NEXT:    # <MCOperand Reg:19>>
; M32R6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R6-NEXT:    # <MCOperand Reg:321>
; M32R6-NEXT:    # <MCOperand Reg:147>>
;
; M64-LABEL: test1:
; M64:       # %bb.0: # %entry
; M64-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M64-NEXT:    # <MCOperand Reg:147>
; M64-NEXT:    # <MCOperand Reg:159>>
; M64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M64-NEXT:    # <MCOperand Reg:301>>
; M64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M64-NEXT:    # <MCOperand Reg:321>
; M64-NEXT:    # <MCOperand Reg:147>>
;
; M64R6-LABEL: test1:
; M64R6:       # %bb.0: # %entry
; M64R6-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S
; M64R6-NEXT:    # <MCOperand Reg:147>
; M64R6-NEXT:    # <MCOperand Reg:159>>
; M64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; M64R6-NEXT:    # <MCOperand Reg:355>
; M64R6-NEXT:    # <MCOperand Reg:301>>
; M64R6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M64R6-NEXT:    # <MCOperand Reg:321>
; M64R6-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-FP32-LABEL: test1:
; MMR2-FP32:       # %bb.0: # %entry
; MMR2-FP32-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:147>
; MMR2-FP32-NEXT:    # <MCOperand Reg:159>>
; MMR2-FP32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:19>>
; MMR2-FP32-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:321>
; MMR2-FP32-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-FP64-LABEL: test1:
; MMR2-FP64:       # %bb.0: # %entry
; MMR2-FP64-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:147>
; MMR2-FP64-NEXT:    # <MCOperand Reg:159>>
; MMR2-FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:19>>
; MMR2-FP64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:321>
; MMR2-FP64-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-SF-LABEL: test1:
; MMR2-SF:       # %bb.0: # %entry
; MMR2-SF-NEXT:    addiusp -24 # <MCInst #{{[0-9]+}} ADDIUSP_MM
; MMR2-SF-NEXT:    # <MCOperand Imm:-24>>
; MMR2-SF-NEXT:    .cfi_def_cfa_offset 24
; MMR2-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MMR2-SF-NEXT:    # <MCInst #{{[0-9]+}} SWSP_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>
; MMR2-SF-NEXT:    # <MCOperand Reg:20>
; MMR2-SF-NEXT:    # <MCOperand Imm:20>>
; MMR2-SF-NEXT:    .cfi_offset 31, -4
; MMR2-SF-NEXT:    jal __fixsfsi # <MCInst #{{[0-9]+}} JAL_MM
; MMR2-SF-NEXT:    # <MCOperand Expr:(__fixsfsi)>>
; MMR2-SF-NEXT:    nop # <MCInst #{{[0-9]+}} SLL
; MMR2-SF-NEXT:    # <MCOperand Reg:21>
; MMR2-SF-NEXT:    # <MCOperand Reg:21>
; MMR2-SF-NEXT:    # <MCOperand Imm:0>>
; MMR2-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MMR2-SF-NEXT:    # <MCInst #{{[0-9]+}} LWSP_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>
; MMR2-SF-NEXT:    # <MCOperand Reg:20>
; MMR2-SF-NEXT:    # <MCOperand Imm:20>>
; MMR2-SF-NEXT:    addiusp 24 # <MCInst #{{[0-9]+}} ADDIUSP_MM
; MMR2-SF-NEXT:    # <MCOperand Imm:24>>
; MMR2-SF-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>>
;
; MMR6-LABEL: test1:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    trunc.w.s $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_S_MMR6
; MMR6-NEXT:    # <MCOperand Reg:147>
; MMR6-NEXT:    # <MCOperand Reg:159>>
; MMR6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR6-NEXT:    # <MCOperand Reg:321>
; MMR6-NEXT:    # <MCOperand Reg:147>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:19>>
;
; MMR6-SF-LABEL: test1:
; MMR6-SF:       # %bb.0: # %entry
; MMR6-SF-NEXT:    addiu $sp, $sp, -24 # <MCInst #{{[0-9]+}} ADDiu
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:-24>>
; MMR6-SF-NEXT:    .cfi_def_cfa_offset 24
; MMR6-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MMR6-SF-NEXT:    # <MCInst #{{[0-9]+}} SW
; MMR6-SF-NEXT:    # <MCOperand Reg:19>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:20>>
; MMR6-SF-NEXT:    .cfi_offset 31, -4
; MMR6-SF-NEXT:    jalr __fixsfsi # <MCInst #{{[0-9]+}} JALRC16_MMR6
; MMR6-SF-NEXT:    # <MCOperand Expr:(__fixsfsi)>>
; MMR6-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MMR6-SF-NEXT:    # <MCInst #{{[0-9]+}} LW
; MMR6-SF-NEXT:    # <MCOperand Reg:19>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:20>>
; MMR6-SF-NEXT:    addiu $sp, $sp, 24 # <MCInst #{{[0-9]+}} ADDiu
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:24>>
; MMR6-SF-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-SF-NEXT:    # <MCOperand Reg:19>>
entry:
  %conv = fptosi float %t to i32
  ret i32 %conv
}

define i32 @test2(double %t) {
; M32-LABEL: test2:
; M32:       # %bb.0: # %entry
; M32-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D32
; M32-NEXT:    # <MCOperand Reg:147>
; M32-NEXT:    # <MCOperand Reg:133>>
; M32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32-NEXT:    # <MCOperand Reg:19>>
; M32-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32-NEXT:    # <MCOperand Reg:321>
; M32-NEXT:    # <MCOperand Reg:147>>
;
; M32R2-FP64-LABEL: test2:
; M32R2-FP64:       # %bb.0: # %entry
; M32R2-FP64-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D64
; M32R2-FP64-NEXT:    # <MCOperand Reg:147>
; M32R2-FP64-NEXT:    # <MCOperand Reg:373>>
; M32R2-FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R2-FP64-NEXT:    # <MCOperand Reg:19>>
; M32R2-FP64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R2-FP64-NEXT:    # <MCOperand Reg:321>
; M32R2-FP64-NEXT:    # <MCOperand Reg:147>>
;
; M32R2-SF-LABEL: test2:
; M32R2-SF:       # %bb.0: # %entry
; M32R2-SF-NEXT:    addiu $sp, $sp, -24 # <MCInst #{{[0-9]+}} ADDiu
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:-24>>
; M32R2-SF-NEXT:    .cfi_def_cfa_offset 24
; M32R2-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; M32R2-SF-NEXT:    # <MCInst #{{[0-9]+}} SW
; M32R2-SF-NEXT:    # <MCOperand Reg:19>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:20>>
; M32R2-SF-NEXT:    .cfi_offset 31, -4
; M32R2-SF-NEXT:    jal __fixdfsi # <MCInst #{{[0-9]+}} JAL
; M32R2-SF-NEXT:    # <MCOperand Expr:(__fixdfsi)>>
; M32R2-SF-NEXT:    nop # <MCInst #{{[0-9]+}} SLL
; M32R2-SF-NEXT:    # <MCOperand Reg:21>
; M32R2-SF-NEXT:    # <MCOperand Reg:21>
; M32R2-SF-NEXT:    # <MCOperand Imm:0>>
; M32R2-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; M32R2-SF-NEXT:    # <MCInst #{{[0-9]+}} LW
; M32R2-SF-NEXT:    # <MCOperand Reg:19>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:20>>
; M32R2-SF-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R2-SF-NEXT:    # <MCOperand Reg:19>>
; M32R2-SF-NEXT:    addiu $sp, $sp, 24 # <MCInst #{{[0-9]+}} ADDiu
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Reg:20>
; M32R2-SF-NEXT:    # <MCOperand Imm:24>>
;
; M32R3R5-LABEL: test2:
; M32R3R5:       # %bb.0: # %entry
; M32R3R5-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D32
; M32R3R5-NEXT:    # <MCOperand Reg:147>
; M32R3R5-NEXT:    # <MCOperand Reg:133>>
; M32R3R5-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M32R3R5-NEXT:    # <MCOperand Reg:19>>
; M32R3R5-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R3R5-NEXT:    # <MCOperand Reg:321>
; M32R3R5-NEXT:    # <MCOperand Reg:147>>
;
; M32R6-LABEL: test2:
; M32R6:       # %bb.0: # %entry
; M32R6-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D64
; M32R6-NEXT:    # <MCOperand Reg:147>
; M32R6-NEXT:    # <MCOperand Reg:373>>
; M32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; M32R6-NEXT:    # <MCOperand Reg:21>
; M32R6-NEXT:    # <MCOperand Reg:19>>
; M32R6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M32R6-NEXT:    # <MCOperand Reg:321>
; M32R6-NEXT:    # <MCOperand Reg:147>>
;
; M64-LABEL: test2:
; M64:       # %bb.0: # %entry
; M64-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D64
; M64-NEXT:    # <MCOperand Reg:147>
; M64-NEXT:    # <MCOperand Reg:373>>
; M64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; M64-NEXT:    # <MCOperand Reg:301>>
; M64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M64-NEXT:    # <MCOperand Reg:321>
; M64-NEXT:    # <MCOperand Reg:147>>
;
; M64R6-LABEL: test2:
; M64R6:       # %bb.0: # %entry
; M64R6-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D64
; M64R6-NEXT:    # <MCOperand Reg:147>
; M64R6-NEXT:    # <MCOperand Reg:373>>
; M64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; M64R6-NEXT:    # <MCOperand Reg:355>
; M64R6-NEXT:    # <MCOperand Reg:301>>
; M64R6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1
; M64R6-NEXT:    # <MCOperand Reg:321>
; M64R6-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-FP32-LABEL: test2:
; MMR2-FP32:       # %bb.0: # %entry
; MMR2-FP32-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:147>
; MMR2-FP32-NEXT:    # <MCOperand Reg:133>>
; MMR2-FP32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:19>>
; MMR2-FP32-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR2-FP32-NEXT:    # <MCOperand Reg:321>
; MMR2-FP32-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-FP64-LABEL: test2:
; MMR2-FP64:       # %bb.0: # %entry
; MMR2-FP64-NEXT:    cvt.w.d $f0, $f12 # <MCInst #{{[0-9]+}} CVT_W_D64_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:147>
; MMR2-FP64-NEXT:    # <MCOperand Reg:373>>
; MMR2-FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:19>>
; MMR2-FP64-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR2-FP64-NEXT:    # <MCOperand Reg:321>
; MMR2-FP64-NEXT:    # <MCOperand Reg:147>>
;
; MMR2-SF-LABEL: test2:
; MMR2-SF:       # %bb.0: # %entry
; MMR2-SF-NEXT:    addiusp -24 # <MCInst #{{[0-9]+}} ADDIUSP_MM
; MMR2-SF-NEXT:    # <MCOperand Imm:-24>>
; MMR2-SF-NEXT:    .cfi_def_cfa_offset 24
; MMR2-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MMR2-SF-NEXT:    # <MCInst #{{[0-9]+}} SWSP_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>
; MMR2-SF-NEXT:    # <MCOperand Reg:20>
; MMR2-SF-NEXT:    # <MCOperand Imm:20>>
; MMR2-SF-NEXT:    .cfi_offset 31, -4
; MMR2-SF-NEXT:    jal __fixdfsi # <MCInst #{{[0-9]+}} JAL_MM
; MMR2-SF-NEXT:    # <MCOperand Expr:(__fixdfsi)>>
; MMR2-SF-NEXT:    nop # <MCInst #{{[0-9]+}} SLL
; MMR2-SF-NEXT:    # <MCOperand Reg:21>
; MMR2-SF-NEXT:    # <MCOperand Reg:21>
; MMR2-SF-NEXT:    # <MCOperand Imm:0>>
; MMR2-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MMR2-SF-NEXT:    # <MCInst #{{[0-9]+}} LWSP_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>
; MMR2-SF-NEXT:    # <MCOperand Reg:20>
; MMR2-SF-NEXT:    # <MCOperand Imm:20>>
; MMR2-SF-NEXT:    addiusp 24 # <MCInst #{{[0-9]+}} ADDIUSP_MM
; MMR2-SF-NEXT:    # <MCOperand Imm:24>>
; MMR2-SF-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR2-SF-NEXT:    # <MCOperand Reg:19>>
;
; MMR6-LABEL: test2:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    trunc.w.d $f0, $f12 # <MCInst #{{[0-9]+}} TRUNC_W_D_MMR6
; MMR6-NEXT:    # <MCOperand Reg:147>
; MMR6-NEXT:    # <MCOperand Reg:373>>
; MMR6-NEXT:    mfc1 $2, $f0 # <MCInst #{{[0-9]+}} MFC1_MM
; MMR6-NEXT:    # <MCOperand Reg:321>
; MMR6-NEXT:    # <MCOperand Reg:147>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:19>>
;
; MMR6-SF-LABEL: test2:
; MMR6-SF:       # %bb.0: # %entry
; MMR6-SF-NEXT:    addiu $sp, $sp, -24 # <MCInst #{{[0-9]+}} ADDiu
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:-24>>
; MMR6-SF-NEXT:    .cfi_def_cfa_offset 24
; MMR6-SF-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; MMR6-SF-NEXT:    # <MCInst #{{[0-9]+}} SW
; MMR6-SF-NEXT:    # <MCOperand Reg:19>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:20>>
; MMR6-SF-NEXT:    .cfi_offset 31, -4
; MMR6-SF-NEXT:    jalr __fixdfsi # <MCInst #{{[0-9]+}} JALRC16_MMR6
; MMR6-SF-NEXT:    # <MCOperand Expr:(__fixdfsi)>>
; MMR6-SF-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; MMR6-SF-NEXT:    # <MCInst #{{[0-9]+}} LW
; MMR6-SF-NEXT:    # <MCOperand Reg:19>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:20>>
; MMR6-SF-NEXT:    addiu $sp, $sp, 24 # <MCInst #{{[0-9]+}} ADDiu
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Reg:20>
; MMR6-SF-NEXT:    # <MCOperand Imm:24>>
; MMR6-SF-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-SF-NEXT:    # <MCOperand Reg:19>>
entry:
  %conv = fptosi double %t to i32
  ret i32 %conv
}
