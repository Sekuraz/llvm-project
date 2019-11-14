//===--- VE.cpp - Tools Implementations -------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/Option/ArgList.h"

using namespace clang::driver;
using namespace clang::driver::tools;
using namespace clang;
using namespace llvm::opt;

const char *ve::getVEAsmModeForCPU(StringRef Name,
                                         const llvm::Triple &Triple) {
  return llvm::StringSwitch<const char *>(Name)
      .Default("");
}

ve::FloatABI ve::getVEFloatABI(const Driver &D,
                                        const ArgList &Args) {
  ve::FloatABI ABI = ve::FloatABI::Invalid;
  if (Arg *A = Args.getLastArg(clang::driver::options::OPT_msoft_float,
                               options::OPT_mhard_float,
                               options::OPT_mfloat_abi_EQ)) {
    if (A->getOption().matches(clang::driver::options::OPT_msoft_float))
      ABI = ve::FloatABI::Soft;
    else if (A->getOption().matches(options::OPT_mhard_float))
      ABI = ve::FloatABI::Hard;
    else {
      ABI = llvm::StringSwitch<ve::FloatABI>(A->getValue())
                .Case("soft", ve::FloatABI::Soft)
                .Case("hard", ve::FloatABI::Hard)
                .Default(ve::FloatABI::Invalid);
      if (ABI == ve::FloatABI::Invalid &&
          !StringRef(A->getValue()).empty()) {
        D.Diag(clang::diag::err_drv_invalid_mfloat_abi) << A->getAsString(Args);
        ABI = ve::FloatABI::Hard;
      }
    }
  }

  // If unspecified, choose the default based on the platform.
  // Only the hard-float ABI on VE is standardized, and it is the
  // default. GCC also supports a nonstandard soft-float ABI mode, also
  // implemented in LLVM. However as this is not standard we set the default
  // to be hard-float.
  if (ABI == ve::FloatABI::Invalid) {
    ABI = ve::FloatABI::Hard;
  }

  return ABI;
}

void ve::getVETargetFeatures(const Driver &D, const ArgList &Args,
                                   std::vector<StringRef> &Features) {
  ve::FloatABI FloatABI = ve::getVEFloatABI(D, Args);
  if (FloatABI == ve::FloatABI::Soft)
    Features.push_back("+soft-float");

  // -mno-vevec is default, unless -mvevec is specified.
  bool VEVec = false;
  if (auto *A = Args.getLastArg(options::OPT_mvevec, options::OPT_mno_vevec)) {
    if (A->getOption().matches(options::OPT_mvevec)) {
      VEVec = true;
      Features.push_back("+vec");
    }
  }

  if (!VEVec) {
    Features.push_back("-vec");
  }
}
