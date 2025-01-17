; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

declare i128 @llvm.bswap.i128(i128)
declare i64 @llvm.bswap.i64(i64)
declare i32 @llvm.bswap.i32(i32)
declare i16 @llvm.bswap.i16(i16)

define i128 @func128(i128 %p) {
; CHECK-LABEL: func128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    bswp %s2, %s1, 0
; CHECK-NEXT:    bswp %s1, %s0, 0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.bswap.i128(i128 %p)
  ret i128 %r
}

define i64 @func64(i64 %p) {
; CHECK-LABEL: func64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    bswp %s0, %s0, 0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.bswap.i64(i64 %p)
  ret i64 %r
}

define i32 @func32(i32 %p) {
; CHECK-LABEL: func32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    bswp %s0, %s0, 1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bswap.i32(i32 %p)
  ret i32 %r
}

define signext i16 @func16s(i16 signext %p) {
; CHECK-LABEL: func16s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    bswp %s0, %s0, 1
; CHECK-NEXT:    sra.w.sx %s0, %s0, 16
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bswap.i16(i16 %p)
  ret i16 %r
}

define zeroext i16 @func16z(i16 zeroext %p) {
; CHECK-LABEL: func16z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    bswp %s0, %s0, 1
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    srl %s0, %s0, 16
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bswap.i16(i16 %p)
  ret i16 %r
}

define i128 @func128i() {
; CHECK-LABEL: func128i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    lea.sl %s1, -16777216
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i128 @llvm.bswap.i128(i128 255)
  ret i128 %r
}

define i64 @func64i() {
; CHECK-LABEL: func64i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, -16777216
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i64 @llvm.bswap.i64(i64 255)
  ret i64 %r
}

define signext i32 @func32si() {
; CHECK-LABEL: func32si:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -16777216
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bswap.i32(i32 255)
  ret i32 %r
}

define zeroext i32 @func32zi() {
; CHECK-LABEL: func32zi:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -16777216
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i32 @llvm.bswap.i32(i32 255)
  ret i32 %r
}

define signext i16 @func16si() {
; CHECK-LABEL: func16si:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, -256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bswap.i16(i16 255)
  ret i16 %r
}

define zeroext i16 @func16zi() {
; CHECK-LABEL: func16zi:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 65280
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = tail call i16 @llvm.bswap.i16(i16 255)
  ret i16 %r
}
