# CrossOpenCV-FPC

> Cross-platform OpenCV wrapper for **Delphi** and **FreePascal** with fully dynamic library loading

## Overview
This project is a fork of [Laex/Delphi-OpenCV](https://github.com/Laex/Delphi-OpenCV), re-engineered to work on both **Windows** and **Ubuntu Linux**.  
All OpenCV functions are bound **dynamically** at run-time (LoadLibrary / `dlopen`), so you can replace or remove the native libraries without recompiling the Pascal code.

## Key differences from the original

1. **Delphi + FreePascal** – one code-base, works with both compilers.  
2. **Windows + Linux** – tested on Windows x86 / x64 and Ubuntu x64.  
3. **Dynamic loading** – no static linking; pointers are resolved at run-time.  
4. **Graceful fallback** – if a `.dll`/`.so` is missing, function pointers stay `nil` and the application keeps running.  
5. **Self-contained Linux libs** – every OpenCV `.so` is built/patched with an internal RPATH (`$ORIGIN`), so the libraries inside the same folder can see each other without `LD_LIBRARY_PATH`.

---

## Building from source

1. **Clone the repo**

   ```bash
   git clone https://github.com/pisarev/CrossOpenCV-FPC.git
   cd CrossOpenCV-FPC
   ```

2. **Fetch the native libraries**  
   Download the correct archive from the *Releases* page (see below) **or** just run the helper script:

   ```bash
   # Linux
   ./scripts/download_binaries.sh
   # Windows (PowerShell)
   scripts\download_binaries.ps1
   ```

3. **Compile**

   *Delphi* – open the project file and press **Build**.  
   *FreePascal* – for example:

   ```bash
   fpc src/examples/example.pas
   ```

---

## OpenCV library placement and packaging

> The wrapper already contains the logic that calls `LoadLibrary` / `dlopen` with **hard-coded paths**.  
> Just place the libraries exactly as described below – no extra environment variables or RPATH tweaks are needed.

### Windows (32-bit & 64-bit)

| Archive | Architecture |
|---------|--------------|
| `opencv_2.4.13-win32.zip` | Win 32-bit |
| `opencv_2.4.13-win64.zip` | Win 64-bit |

1. Unzip next to your executable so the layout becomes

   ```text
   MyApp.exe
   └── opencv_2.4.13/
       ├── opencv_core2413.dll
       ├── opencv_imgproc2413.dll
       └── … other DLLs
   ```

2. **Do not rename or move** the `opencv_2.4.13` folder – the Pascal code loads DLLs from  
   `<exe_dir>/opencv_2.4.13/...`.

### Ubuntu Linux (64-bit only)

| Archive | Architecture |
|---------|--------------|
| `opencv_2.4.13-linux-x86_64.tar.xz` | Linux x86-64 |

1. Extract the archive next to the executable so the layout becomes

   ```text
   /path/to/myapp               (ELF executable)
   └── bin/
       └── opencv_2.4.13/
           ├── libopencv_core.so.2.4.13
           ├── libopencv_core.so -> ./libopencv_core.so.2.4.13
           └── … other .so + relative symlinks
   ```

2. The wrapper calls

   ```text
   dlopen(<exe_dir>/bin/opencv_2.4.13/libopencv_*.so.2.4.13)
   ```

   so **do not move** the folder.  
   The archive is packed with **tar.xz** to preserve symbolic links, and every `.so` already contains an `$ORIGIN` RPATH, allowing the libraries in the same folder to resolve their mutual dependencies automatically.

3. 32-bit Linux is **not supported** in this fork.

---

## Quick examples

### Linux

```bash
cd /home/user
tar xJf opencv_2.4.13-linux-x86_64.tar.xz
./myapp        # the program now loads all .so files from bin/opencv_2.4.13
```

### Windows

```powershell
Expand-Archive opencv_2.4.13-win64.zip -DestinationPath 'C:\Projects\MyApp\opencv_2.4.13'
C:\Projects\MyApp\MyApp.exe   # DLLs are loaded from .\opencv_2.4.13
```

---

## Releases

All native libraries live in the **Releases** section so the git repository stays small.  
Direct download links (always point to the latest release):

| Platform | Asset |
|----------|-------|
| Windows 32-bit | `https://github.com/pisarev/CrossOpenCV-FPC/releases/download/v1.0.0/opencv_2.4.13-win32.zip` |
| Windows 64-bit | `https://github.com/pisarev/CrossOpenCV-FPC/releases/download/v1.0.0/opencv_2.4.13-win64.zip` |
| Linux 64-bit   | `https://github.com/pisarev/CrossOpenCV-FPC/releases/download/v1.0.0/opencv_2.4.13-linux-x86_64.tar.xz` |

---

## License
Distributed under the MPL 1.1. See the `LICENSE` file for details.

## Contact
Create issues or pull requests on GitHub if you encounter problems or have improvements.