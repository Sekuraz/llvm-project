; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define double @selectccsgti8(i8, i8, double, double) {
; CHECK-LABEL: selectccsgti8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s1, %s1, 24
; CHECK-NEXT:    sra.w.sx %s1, %s1, 24
; CHECK-NEXT:    sla.w.sx %s0, %s0, 24
; CHECK-NEXT:    sra.w.sx %s0, %s0, 24
; CHECK-NEXT:    cmps.w.sx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i8 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccsgti16(i16, i16, double, double) {
; CHECK-LABEL: selectccsgti16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    sla.w.sx %s1, %s1, 16
; CHECK-NEXT:    sra.w.sx %s1, %s1, 16
; CHECK-NEXT:    sla.w.sx %s0, %s0, 16
; CHECK-NEXT:    sra.w.sx %s0, %s0, 16
; CHECK-NEXT:    cmps.w.sx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i16 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccsgti32(i32, i32, double, double) {
; CHECK-LABEL: selectccsgti32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccsgti64(i64, i64, double, double) {
; CHECK-LABEL: selectccsgti64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s0, %s0, %s1
; CHECK-NEXT:    cmov.l.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i64 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccsgti128(i128, i128, double, double) {
; CHECK-LABEL: selectccsgti128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.l %s6, %s1, %s3
; CHECK-NEXT:    cmps.l %s1, %s3, %s1
; CHECK-NEXT:    srl %s1, %s1, 63
; CHECK-NEXT:    cmpu.l %s0, %s2, %s0
; CHECK-NEXT:    srl %s0, %s0, 63
; CHECK-NEXT:    cmov.l.eq %s1, %s0, %s6
; CHECK-NEXT:    cmov.w.ne %s5, %s4, %s1
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i128 %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccogtf32(float, float, double, double) {
; CHECK-LABEL: selectccogtf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.s %s0, %s0, %s1
; CHECK-NEXT:    cmov.s.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt float %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

define double @selectccogtf64(double, double, double, double) {
; CHECK-LABEL: selectccogtf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s0, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s3, %s2, %s0
; CHECK-NEXT:    or %s0, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, double %2, double %3
  ret double %6
}

