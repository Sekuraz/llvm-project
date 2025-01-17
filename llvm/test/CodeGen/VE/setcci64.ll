; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define zeroext i1 @setcceq(i64, i64) {
; CHECK-LABEL: setcceq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp eq i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccne(i64, i64) {
; CHECK-LABEL: setccne:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    cmpu.l %s0, 0, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ne i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccugt(i64, i64) {
; CHECK-LABEL: setccugt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ugt i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccuge(i64, i64) {
; CHECK-LABEL: setccuge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.l %s0, %s0, %s1
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp uge i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccult(i64, i64) {
; CHECK-LABEL: setccult:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.l %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ult i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccule(i64, i64) {
; CHECK-LABEL: setccule:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ule i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsgt(i64, i64) {
; CHECK-LABEL: setccsgt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sgt i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsge(i64, i64) {
; CHECK-LABEL: setccsge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sge i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccslt(i64, i64) {
; CHECK-LABEL: setccslt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp slt i64 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsle(i64, i64) {
; CHECK-LABEL: setccsle:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s1, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sle i64 %0, %1
  ret i1 %3
}
