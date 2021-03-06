set(LLVM_LINK_COMPONENTS
  Core
  ExecutionEngine
  Interpreter
  MC
  Support
  )

add_llvm_unittest(ExecutionEngineTests
  ExecutionEngineTest.cpp
  )

# Include JIT/MCJIT tests only if native arch is a built JIT target.
list(FIND LLVM_TARGETS_TO_BUILD "${LLVM_NATIVE_ARCH}" build_idx)
list(FIND LLVM_TARGETS_WITH_JIT "${LLVM_NATIVE_ARCH}" jit_idx)
if (NOT build_idx LESS 0 AND NOT jit_idx LESS 0)
  add_subdirectory(JIT)
  add_subdirectory(MCJIT)
endif()
