; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

declare i128 @llvm.bitreverse.i128(i128)
declare i64 @llvm.bitreverse.i64(i64)
declare i32 @llvm.bitreverse.i32(i32)
declare i16 @llvm.bitreverse.i16(i16)
declare i8 @llvm.bitreverse.i8(i8)

define i128 @func128(i128 %p) {
; CHECK-LABEL: func128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s2, %s1
; CHECK-NEXT:    brv %s1, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.bitreverse.i128(i128 %p)
  ret i128 %r
}

define i64 @func64(i64 %p) {
; CHECK-LABEL: func64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.bitreverse.i64(i64 %p)
  ret i64 %r
}

define signext i32 @func32s(i32 signext %p) {
; CHECK-LABEL: func32s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bitreverse.i32(i32 %p)
  ret i32 %r
}

define zeroext i32 @func32z(i32 zeroext %p) {
; CHECK-LABEL: func32z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bitreverse.i32(i32 %p)
  ret i32 %r
}

define signext i16 @func16s(i16 signext %p) {
; CHECK-LABEL: func16s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bitreverse.i16(i16 %p)
  ret i16 %r
}

define zeroext i16 @func16z(i16 zeroext %p) {
; CHECK-LABEL: func16z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 48
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bitreverse.i16(i16 %p)
  ret i16 %r
}

define signext i8 @func8s(i8 signext %p) {
; CHECK-LABEL: func8s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.bitreverse.i8(i8 %p)
  ret i8 %r
}

define zeroext i8 @func8z(i8 zeroext %p) {
; CHECK-LABEL: func8z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    brv %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 56
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.bitreverse.i8(i8 %p)
  ret i8 %r
}

define i128 @func128i() {
; CHECK-LABEL: func128i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    lea.sl %s1, -65536
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.bitreverse.i128(i128 65535)
  ret i128 %r
}

define i64 @func64i() {
; CHECK-LABEL: func64i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -65536
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.bitreverse.i64(i64 65535)
  ret i64 %r
}

define signext i32 @func32is() {
; CHECK-LABEL: func32is:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -65536
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bitreverse.i32(i32 65535)
  ret i32 %r
}

define zeroext i32 @func32iz() {
; CHECK-LABEL: func32iz:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -65536
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bitreverse.i32(i32 65535)
  ret i32 %r
}

define signext i16 @func16is() {
; CHECK-LABEL: func16is:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bitreverse.i16(i16 255)
  ret i16 %r
}

define zeroext i16 @func16iz() {
; CHECK-LABEL: func16iz:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 65280
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bitreverse.i16(i16 255)
  ret i16 %r
}

define signext i8 @func8is() {
; CHECK-LABEL: func8is:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 15, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.bitreverse.i8(i8 240)
  ret i8 %r
}

define zeroext i8 @func8iz() {
; CHECK-LABEL: func8iz:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 15, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i8 @llvm.bitreverse.i8(i8 240)
  ret i8 %r
}
