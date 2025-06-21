# CrossOpenCV-FPC

> Cross-platform OpenCV wrapper for Delphi and FreePascal with dynamic library loading

## Overview
This is a fork of [Laex/Delphi-OpenCV](https://github.com/Laex/Delphi-OpenCV), reworked to support Delphi and FreePascal on Windows and Linux, with fully dynamic binding to OpenCV libraries.

## Key Differences from the Original
1. **Delphi + FreePascal**  
   - Single codebase works with both Delphi and FreePascal compilers.
2. **Windows + Linux Support**  
   - Builds and runs on Windows and on Ubuntu/Linux under FPC.
3. **Dynamic Function Loading**  
   - Uses LoadLibrary / dlopen at runtime instead of static linking.
   - Functions are bound to pointers, allowing different OpenCV versions without recompilation.
4. **Safe Behavior if Libraries Are Missing**  
   - If a required `.dll` or `.so` is not found, the application does not crash; function pointers remain `nil`.
   - You can check loading status (e.g., `IsOpenCvLoaded`) and handle missing functionality gracefully.
5. **RPATH Configuration on Linux**  
   - Linux binaries are built or patched so that `.so` libraries placed alongside the executable see each other without needing `LD_LIBRARY_PATH`.
   - Simplifies deployment: just place the needed `.so` files next to the ELF binary.

## Installation & Building from Source
1. **Clone the repo**  
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO
