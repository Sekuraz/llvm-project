; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i8 @func8s(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: func8s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i8 %a, -1
  %res = and i8 %not, %b
  ret i8 %res
}

define zeroext i8 @func8z(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: func8z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i8 %a, -1
  %res = and i8 %b, %not
  ret i8 %res
}

define signext i8 @funci8s(i8 signext %a) {
; CHECK-LABEL: funci8s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, 5, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i8 %a, -1
  %res = and i8 %not, 5
  ret i8 %res
}

define zeroext i8 @funci8z(i8 zeroext %a) {
; CHECK-LABEL: funci8z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    lea %s1, 251
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i8 %a, -1
  %res = and i8 -5, %not
  ret i8 %res
}

define signext i16 @func16s(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: func16s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i16 %a, -1
  %res = and i16 %not, %b
  ret i16 %res
}

define zeroext i16 @func16z(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: func16z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i16 %a, -1
  %res = and i16 %b, %not
  ret i16 %res
}

define signext i16 @funci16s(i16 signext %a) {
; CHECK-LABEL: funci16s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i16 %a, -1
  %res = and i16 %not, 65535
  ret i16 %res
}

define zeroext i16 @funci16z(i16 zeroext %a) {
; CHECK-LABEL: funci16z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, (52)0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i16 %a, -1
  %res = and i16 4095, %not
  ret i16 %res
}

define signext i32 @func32s(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: func32s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i32 %a, -1
  %res = and i32 %not, %b
  ret i32 %res
}

define zeroext i32 @func32z(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: func32z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i32 %a, -1
  %res = and i32 %not, %b
  ret i32 %res
}

define signext i32 @funci32s(i32 signext %a) {
; CHECK-LABEL: funci32s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, (36)0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i32 %a, -1
  %res = and i32 %not, 268435455
  ret i32 %res
}

define zeroext i32 @funci32z(i32 zeroext %a) {
; CHECK-LABEL: funci32z:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    and %s0, %s0, (36)0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i32 %a, -1
  %res = and i32 %not, 268435455
  ret i32 %res
}

define i64 @func64(i64 %a, i64 %b) {
; CHECK-LABEL: func64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    nnd %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i64 %a, -1
  %res = and i64 %not, %b
  ret i64 %res
}

define i64 @func64i(i64 %a) {
; CHECK-LABEL: func64i:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    nnd %s0, %s0, (24)0
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i64 %a, -1
  %res = and i64 %not, 1099511627775
  ret i64 %res
}

define i128 @func128(i128 %a, i128 %b) {
; CHECK-LABEL: func128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    nnd %s0, %s0, %s2
; CHECK-NEXT:    nnd %s1, %s1, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i128 %a, -1
  %res = and i128 %b, %not
  ret i128 %res
}

define i128 @funci128(i128 %a) {
; CHECK-LABEL: funci128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 5, (0)1
; CHECK-NEXT:    nnd %s0, %s0, %s1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %not = xor i128 %a, -1
  %res = and i128 %not, 5
  ret i128 %res
}
