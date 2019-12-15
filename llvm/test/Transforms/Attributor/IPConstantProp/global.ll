; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -S -passes=attributor -aa-pipeline='basic-aa' -attributor-disable=false -attributor-max-iterations-verify -attributor-max-iterations=1 < %s | FileCheck %s

@_ZL6test1g = internal global i32 42, align 4

define void @_Z7test1f1v() nounwind {
; CHECK-LABEL: define {{[^@]+}}@_Z7test1f1v()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[TMP]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i32 0, i32* @_ZL6test1g, align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %tmp = load i32, i32* @_ZL6test1g, align 4
  %cmp = icmp eq i32 %tmp, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32* @_ZL6test1g, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define i32 @_Z7test1f2v() nounwind {
; CHECK-LABEL: define {{[^@]+}}@_Z7test1f2v()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load i32, i32* @_ZL6test1g, align 4
; CHECK-NEXT:    ret i32 [[TMP]]
;
entry:
  %tmp = load i32, i32* @_ZL6test1g, align 4
  ret i32 %tmp
}