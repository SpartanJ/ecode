<h1 align="center">
  <img src="https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/icon/ecode-icon-web.svg" width=128 height=128/><br>
  ecode
</h1>

*ecode* is a lightweight multi-platform code editor designed for modern hardware with a focus on
responsiveness and performance. It has been developed with the hardware-accelerated [eepp GUI](https://github.com/SpartanJ/eepp/),
which provides the core technology for the editor. The project comes as the first serious project using
the [eepp GUI](https://github.com/SpartanJ/eepp/), and it's currently being developed to improve the
eepp GUI library as part of one of its main objectives.

## Screenshots

![ecode - Code Editor](https://github.com/SpartanJ/ecode/assets/650416/7926c3f3-1b3b-4fe5-859a-3099df73b7e8)

For more screenshots checkout
[running on macOS](https://github.com/SpartanJ/ecode/assets/650416/9e8e00a7-fbcc-479b-8588-0023d8f86a9a),
[running on Windows](https://user-images.githubusercontent.com/650416/172760308-30d5335c-d5f7-4dbe-94ce-2e556d858909.png),
[running on Haiku](https://user-images.githubusercontent.com/650416/172760331-799b7d16-104b-4cac-ba34-c0cf60ba4374.png),
[low dpi](https://user-images.githubusercontent.com/650416/172519582-1aab1e94-8d69-4c2c-b4ba-de9f2d8729cf.png),
[code completion](https://user-images.githubusercontent.com/650416/172521557-f68aa855-0534-49c9-b33e-8f9f8b47b9d2.png), [terminal](https://user-images.githubusercontent.com/650416/180109676-a1f9dbc6-d170-4e67-a19c-611cff9f04dd.png),
[file locator](https://user-images.githubusercontent.com/650416/172521593-bb8fde13-2600-44e5-87d2-3fc41370fc77.png),
[file formats](https://user-images.githubusercontent.com/650416/172521619-ac1aeb82-80e5-49fd-894e-afc780d4c0fd.png),
[global find](https://user-images.githubusercontent.com/650416/172523164-2ca9b988-7d2d-4b8c-b6d2-10e593d7fc14.png),
[global replace](https://user-images.githubusercontent.com/650416/172523195-00451552-2a56-4595-8b3a-cf8071b36dc6.png),
[linter](https://user-images.githubusercontent.com/650416/172523272-45c267af-2585-4c54-86e0-739b5202569e.png).

## Notable Features

* Lightweight
* Portable
* Uncluttered GUI
* Syntax Highlighting (including nested syntax highlighting, supporting over 90 languages and LSP semantic highlighting)
* Multi-cursor support
* [LSP](https://microsoft.github.io/language-server-protocol/) support
* Debugger support via [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol)
* [Git](https://git-scm.com/) integration
* Terminal support
* Command Palette
* Auto-Completion
* Customizable Linter support
* Customizable Formatter support
* Customizable Color-Schemes
* Customizable keyboard bindings
* Configurable build pipelines
* Fast global search (and replace)
* Minimap
* Unlimited editor splitting
* Easily extendable language support
* Customizable and scalable (non-integer) GUI (thanks to [eepp GUI](https://github.com/SpartanJ/eepp/))
* Dark & Light Mode
* File system Tree View (with real-time file system changes)
* Smart hot-reload of files
* Folders as Projects with `.gitignore` support \*
* Per Project Settings
* Smart and fast project file locator
* Multiline search and replace
* Project/Folder state persist between sessions
* Soft-wrap
* Code-folding
* Session Snapshot & Periodic Backup
* Perl Regular Expressions and [Lua pattern searches](https://www.lua.org/manual/5.4/manual.html#6.4.1) support
* Plugins support.

### Folder / Project Settings (\*)

*ecode* treats folders as projects, like many other editors. The main difference is that it also tries
to automatically sanitize the project files by filtering out any file that it's filtered in the repository
`.gitignore` files. The idea is to use the `.gitignore` file as a project setting.
The project files will be the ones used to find files in the project and do global searches.
Usually, this translates into much better results for any project-related search.
There's also a very simple mechanism to allow visibility of filtered files by the `.gitignore`, by
adding a file with the allowed filtered patterns in a subfolder over the folder loaded, creating a file
in `.ecode/.prjallowed` with the necessary glob patterns allowing the filtered patterns to be "unfiltered".
ecode will only add files that are supported by the editor, the editor won't try to do anything
with files that are not officially supported.

## Philosophy

Some points to illustrate the project philosophy:

* Extendable functionality but in a controlled environment. New features and new plugins are accepted, but the author will supervise any new content that might affect the application quality and performance.
* Load as few files and resources as possible and load asynchronously as many resources as possible. Startup time of the application is considered critical.
* Use the machine resources but not abuse them.
* The editor implementation will try to prioritize performance and memory usage over simplicity.
* Developed with modern hardware in mind: expected hardware should have low file system latency (SSD), high cores count and decent GPU acceleration.
* Plugins and non-main functionality should never lock the main thread (GUI thread) or at least should block it as little as possible.
* Terminals are part of the developer workflow.

## Live Demo

ecode can be compiled to WASM and run in any modern browser. There are no plans to focus the
development on the web version (at least for the moment) since there are plenty of good solutions out
there. But you can give it a try:

[*Demo here*](https://cdn.ensoft.dev/eepp-demos/demo-fs.html?run=ecode.js)

### Demo Clarifications

* You'll need a modern browser with [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#browser_compatibility) support
* Linter, Formatter,, LSP Client and Debugger plugins won't work since they work by running other processes (except for the native formatters that are available)
* WebGL renderer isn't optimized, so it's not as fast as it could/should be (still, performance is good in chromium based browsers)
* Demo is designed for desktop resolutions (mobile is unusable, IME keyboard won't show up due to an emscripten limitation)

## Source Code

Currently, the source code is located at the [eepp](https://github.com/SpartanJ/eepp/) project repository.
*ecode* editor source is located at [src/tools/ecode](https://github.com/SpartanJ/eepp/tree/develop/src/tools/ecode).
ecode is being used to actively improve and iterate the eepp GUI library. At some point, it will be
migrated to this repository. The ecode repository should be used for issues and documentation.
PRs for ecode will be accepted at the eepp repository.

### Build from Source

There are scripts for each supported platform ready to build the application.
For *Linux* and *macOS* it is trivial to build the project, you'll just need to have GCC/Clang installed
and also the development library from libSDL2. Windows build script is currently a cross-compiling script and it uses mingw64.
But it also can be easily built with Visual Studio and [libSDL2 development libraries](https://www.libsdl.org/release/SDL2-devel-2.30.7-VC.zip) installed.
For more information on how to build manually a project please follow the [eepp build instructions](https://github.com/SpartanJ/eepp/#how-to-build-it).
The project name is always *ecode* (so if you are building with make, you'll need to run `make ecode`).

* *Linux* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/linux/ecode). Running `build.app.sh` will try to build the `AppImage` package and `tar.gz` with the compressed application. `ecode` folder will contain the uncompressed application.
* *macOS* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/macos/ecode). Running `build.app.sh` will create `ecode.app`. Run `create.dmg.sh` to create the `dmg` file. `ecode.app` folder will contain the uncompressed application.
* *Windows* cross-compiling build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/mingw32/ecode). Running `build.app.sh` will create a `zip` file with the zipped application package. `ecode` folder will contain the uncompressed application. To build from Windows follow the instructions [here](https://github.com/SpartanJ/eepp/?tab=readme-ov-file#windows).
* *FreeBSD* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/freebsd/ecode). Running `build.app.sh` will try to build a `tar.gz` with the compressed application. `ecode.app` folder will contain the uncompressed application.
* *Haiku* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/haiku/ecode). Running `build.app.sh` will try to build a `tar.gz` with the compressed application. `ecode.app` folder will contain the uncompressed application.

## Nightly Builds

Nightly builds are being distributed [here](https://github.com/SpartanJ/eepp/releases/tag/nightly) for the more impatient users. ecode is being developed actively, nightly builds may not be stable for daily usage unless there's a pending unreleased fix required for the user.

## Language support

ecode is constantly adding more languages support and also supports extending it's language support
via configuration files (for every feature: syntax highlighting, LSP, linter and formatter).

### Language support table
|         Language        | Highlight |                                                  LSP                                                 |                      Linter                     |                           Formatter                          |                                                              Debugger                                                              |
|          :---:          |   :---:   |                                                 :---:                                                |                      :---:                      |                             :---:                            |                                                                :---:                                                               |
| .htaccess               | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| .ignore file            | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| [x]it!                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| ada                     | ✓       | [ada_language_server](https://github.com/AdaCore/ada_language_server)                                | None                                            | None                                                         | None                                                                                                                               |
| adept                   | ✓       | [AdeptLSP](https://github.com/AdeptLanguage/AdeptLSP)                                                | None                                            | None                                                         | None                                                                                                                               |
| angelscript             | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| awk script              | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| bat                     | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| bazel                   | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| bend                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| blueprint               | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| brainfuck               | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| buzz                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| c                       | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | [cppcheck](https://github.com/danmar/cppcheck)  | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) | [gdb](https://www.gnu.org/software/gdb) / [lldb-dap](https://github.com/llvm/llvm-project/blob/main/lldb/tools/lldb-dap/README.md) |
| carbon                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| clojure                 | ✓       | [clojure-lsp](https://github.com/clojure-lsp/clojure-lsp)                                            | None                                            | None                                                         | None                                                                                                                               |
| cmake                   | ✓       | [cmake-language-server](https://github.com/regen100/cmake-language-server)                           | None                                            | None                                                         | None                                                                                                                               |
| cpp                     | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | [cppcheck](https://github.com/danmar/cppcheck)  | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) | [gdb](https://www.gnu.org/software/gdb) / [lldb-dap](https://github.com/llvm/llvm-project/blob/main/lldb/tools/lldb-dap/README.md) |
| crystal                 | ✓       | [crystalline](https://github.com/elbywan/crystalline)                                                | None                                            | None                                                         | None                                                                                                                               |
| csharp                  | ✓       | [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn)                                           | None                                            | None                                                         | None                                                                                                                               |
| css                     | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | [native](#native)                                            | None                                                                                                                               |
| d                       | ✓       | [serve-d](https://github.com/Pure-D/serve-d)                                                         | None                                            | None                                                         | [gdb](https://www.gnu.org/software/gdb)                                                                                            |
| dart                    | ✓       | [dart language-server](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/tool/lsp_spec) | None                                            | None                                                         | [dart](https://github.com/dart-lang/sdk/blob/main/third_party/pkg/dap/tool/README.md)                                              |
| diff                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| dockerfile              | ✓       | [docker-langserver](https://github.com/rcjsuen/dockerfile-language-server-nodejs)                    | None                                            | None                                                         | None                                                                                                                               |
| elixir                  | ✓       | [elixir-ls](https://github.com/elixir-lsp/elixir-ls)                                                 | None                                            | None                                                         | None                                                                                                                               |
| elm                     | ✓       | [elm-language-server](https://github.com/elm-tooling/elm-language-server)                            | None                                            | None                                                         | None                                                                                                                               |
| environment file        | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| fantom                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| fortran                 | ✓       | [fortls](https://github.com/fortran-lang/fortls)                                                     | None                                            | None                                                         | [gdb](https://www.gnu.org/software/gdb)                                                                                            |
| fstab                   | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| gdscript                | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| glsl                    | ✓       | [glsl_analyzer](https://github.com/nolanderc/glsl_analyzer)                                          | None                                            | None                                                         | None                                                                                                                               |
| go                      | ✓       | [gopls](https://golang.org/x/tools/gopls)                                                            | None                                            | [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)         | [gdb](https://www.gnu.org/software/gdb) / [delve](https://github.com/go-delve/delve)                                               |
| graphql                 | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| groovy                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| hare                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| haskell                 | ✓       | [haskell-language-server](https://github.com/haskell/haskell-language-server)                        | [hlint](https://github.com/ndmitchell/hlint)    | [ormolu](https://github.com/tweag/ormolu)                    | None                                                                                                                               |
| haxe                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| haxe compiler arguments | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| hlsl                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| html                    | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | [prettier](https://prettier.io)                              | None                                                                                                                               |
| ini                     | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| jai                     | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| java                    | ✓       | [jdtls](https://github.com/eclipse/eclipse.jdt.ls)                                                   | None                                            | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) | None                                                                                                                               |
| javascript              | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | [eslint](https://eslint.org)                    | [prettier](https://prettier.io)                              | None                                                                                                                               |
| javascriptreact         | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | None                                            | None                                                         | None                                                                                                                               |
| json                    | ✓       | None                                                                                                 | [jq](https://stedolan.github.io/jq/)            | [native](#native)                                            | None                                                                                                                               |
| julia                   | ✓       | [LanguageServer.jl](https://github.com/julia-vscode/LanguageServer.jl)                               | None                                            | None                                                         | None                                                                                                                               |
| kotlin                  | ✓       | [kotlin-language-server](https://github.com/fwcd/kotlin-language-server)                             | [ktlint](https://pinterest.github.io/ktlint/)   | [ktlint](https://pinterest.github.io/ktlint/)                | None                                                                                                                               |
| latex                   | ✓       | [texlab](https://github.com/latex-lsp)                                                               | None                                            | None                                                         | None                                                                                                                               |
| lobster                 | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| lua                     | ✓       | [lua-language-server](https://github.com/sumneko/lua-language-server)                                | [luacheck](https://github.com/mpeterv/luacheck) | None                                                         | None                                                                                                                               |
| makefile                | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| markdown                | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| meson                   | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| moonscript              | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| nelua                   | ✓       | None                                                                                                 | [nelua](https://nelua.io)                       | None                                                         | None                                                                                                                               |
| nim                     | ✓       | [nimlsp](https://github.com/PMunch/nimlsp)                                                           | [nim](https://nim-lang.org)                     | None                                                         | None                                                                                                                               |
| objeck                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| objective-c             | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | None                                            | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) | None                                                                                                                               |
| ocaml                   | ✓       | [OCaml-LSP](https://github.com/ocaml/ocaml-lsp)                                                      | None                                            | None                                                         | None                                                                                                                               |
| odin                    | ✓       | [ols](https://github.com/DanielGavin/ols)                                                            | None                                            | None                                                         | [lldb-dap](https://github.com/llvm/llvm-project/blob/main/lldb/tools/lldb-dap/README.md)                                           |
| openscad                | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| pascal                  | ✓       | None                                                                                                 | None                                            | None                                                         | [gdb](https://www.gnu.org/software/gdb)                                                                                            |
| perl                    | ✓       | [PerlNavigator](https://github.com/bscan/PerlNavigator)                                              | None                                            | None                                                         | [perl-ls](https://github.com/richterger/Perl-LanguageServer)                                                                       |
| php                     | ✓       | [phpactor](https://phpactor.readthedocs.io)                                                          | [php](https://www.php.net)                      | None                                                         | None                                                                                                                               |
| pico-8                  | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| plaintext               | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| po                      | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| pony                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| postgresql              | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| powershell              | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| python                  | ✓       | [pylsp](https://github.com/python-lsp/python-lsp-server)                                             | [ruff](https://ruff.rs)                         | [black](https://black.readthedocs.io/en/stable/)             | [debugpy](https://github.com/microsoft/debugpy)                                                                                    |
| r                       | ✓       | [r languageserver](https://github.com/REditorSupport/languageserver)                                 | None                                            | None                                                         | None                                                                                                                               |
| ring                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| ruby                    | ✓       | [solargraph](https://solargraph.org)                                                                 | None                                            | None                                                         | None                                                                                                                               |
| rust                    | ✓       | [rust-analyzer](https://rust-analyzer.github.io)                                                     | None                                            | [rustfmt](https://rust-lang.github.io/rustfmt/)              | [gdb](https://www.gnu.org/software/gdb) / [lldb-dap](https://github.com/llvm/llvm-project/blob/main/lldb/tools/lldb-dap/README.md) |
| sass                    | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | None                                                         | None                                                                                                                               |
| scala                   | ✓       | [metals](https://github.com/scalameta/metals)                                                        | None                                            | None                                                         | None                                                                                                                               |
| shellscript             | ✓       | [bash-language-server](https://github.com/bash-lsp/bash-language-server)                             | None                                            | None                                                         | None                                                                                                                               |
| smallbasic              | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| solidity                | ✓       | [solc](https://soliditylang.org)                                                                     | [solhint](https://protofire.github.io/solhint/) | None                                                         | None                                                                                                                               |
| sql                     | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| swift                   | ✓       | [sourcekit-lsp](https://github.com/apple/sourcekit-lsp)                                              | None                                            | None                                                         | None                                                                                                                               |
| tcl                     | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| teal                    | ✓       | None                                                                                                 | [tl](https://github.com/teal-language/tl)       | None                                                         | None                                                                                                                               |
| toml                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| typescript              | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | [eslint](https://eslint.org)                    | [prettier](https://prettier.io)                              | None                                                                                                                               |
| typescriptreact         | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | None                                            | None                                                         | None                                                                                                                               |
| v                       | ✓       | [v-analyzer](https://github.com/v-analyzer/v-analyzer)                                               | None                                            | [v](https://vlang.io)                                        | None                                                                                                                               |
| vala                    | ✓       | [vala-language-server](https://github.com/vala-lang/vala-language-server)                            | None                                            | None                                                         | None                                                                                                                               |
| verilog                 | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| visual basic            | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| vue                     | ✓       | [vls](https://github.com/vuejs/vetur/tree/master/server)                                             | None                                            | None                                                         | None                                                                                                                               |
| wren                    | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| x86 assembly            | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| xml                     | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | [native](#native)                               | [native](#native)                                            | None                                                                                                                               |
| xtend                   | ✓       | None                                                                                                 | None                                            | None                                                         | None                                                                                                                               |
| yaml                    | ✓       | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)                     | None                                            | None                                                         | None                                                                                                                               |
| zig                     | ✓       | [zls](https://github.com/zigtools/zls)                                                               | [zig](https://ziglang.org)                      | [zig](https://ziglang.org)                                   | [lldb-dap](https://github.com/llvm/llvm-project/blob/main/lldb/tools/lldb-dap/README.md)                                           |

#### native

Native tag means that the feature is supported natively by ecode and it doesn't need any external tool
to function.

### Language support health

ecode brings a tool to display the current language support health. From ecode you can check its health
status from `Settings -> Tools -> Check Language Health`, and from CLI you can use the `--health` flag: `ecode --health`.
Use the health check flag to troubleshoot missing language servers, linters and formatters.

Check the health of all languages with `ecode --health` or ask for details about a specific language
with `ecode --health-lang=<lang>`.

## Plugins

Plugins extend the base code editor functionality. Currently all plugins are enabled by default, but
they are optional and they can be disabled at any time. *ecode* implements an internal protocol that
allow plugins to communicate with each other. The LSP protocol is going to be used as a base to implement
the plugin communication. And, for example, the Linter plugin will consume the LSP to improve its diagnostics.
Also the Auto Complete module will request assistance from the LSP, if available, to improve the
completions and to provide signature help.

#### Linter

Linter support is provided by executing already stablished linters from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`linters.json` configuration.

For more information [read the linter documentation](docs/linter.md).

#### LSP Client

LSP support is provided by executing already stablished LSP from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`lspclient.json` configuration.

For more information [read the lsp client documentation](docs/lsp.md).

#### Debugger

Debugger support is provided by the implementation the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol).
ecode is able to debug any language implementing this protocol, although the protocol is generic sometimes
requires to support some of the languages some specific adaptation is needed, so initially the support
is limited to the languages mentoined in the support list.

For more information on how to use the debugger [read the debugger documentation](docs/debugger.md).

#### Git integration

*ecode* provides some basic Git integration (more features will come in the future). Its main purpose
is to help the user to do the most basics operations with Git. Some of the current features supported:
git status and stats visualization (files states), commit, push, checkout, pull, fetch, fast-forward
merge, creating+renaming+deleting branches, managing stashes. All stats will be automatically
updated/refreshed in real time. There's also some basic configuration available.

For more information [read the git integration documentation](docs/git.md).

#### Auto Formatter

The formatter plugin works exactly like the linter plugin, but it will execute tools that auto-format code.
*ecode* provides support for several languages by default with can be extended easily by expanding the
`formatters.json` configuration.

For more information [read the formatter documentation](docs/formatter.md).

#### Auto Complete

The auto-complete plugin is in charge of providing suggestions for code-completion and signature help.

For more information [read the auto-complete documentation](docs/autocomplete.md).

#### XML Tools

The XML Tools plugin (disabled by default) provides some nice to have improvements when editing XML
content.

For more information [read the xml tools documentation](docs/xmltools.md).

### Plugins configuration files location

*ecode* respects the standard configuration paths on each OS:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/plugins`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/plugins`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\plugins`

### Plugins important behaviors

All plugin configurations are designed to be overwriteable by the user. This means that the default
configuration can be replaced with custom configurations from the user. For example, if the user
wants to use a different linter, it just needs to declare a new linter definition in its own linter
configuration file. The same applies to formatters and LSPs servers.
Plugins will always implement a "config" for plugins customization, and will always implement a
"keybindings" key to configure custom keybindings.

## UI Customizations

*ecode* is highly customizable and extendable thanks to its several configuration files.
If you're interested in creating new color schemes for the editor or terminal, or in creating new
UI themes please check our documentation:

For more information [read the UI Customization documentation](docs/uicustomizations.md).

## Custom languages support

Users can add support for new languages with a very simple JSON file format.

For more information [read the custom languages documentation](docs/customlanguages.md).

## Planned Features

Listed in no particular order:

* General polishing
* Improved plugin system (visual configuration, more flexibility/features)
* AI assistant plugin
* Snippets support
* Macros support
* Better integration with OSes

### Long Term Planned Features

* Modal editing
* Maybe Remote development support
* Maybe [Tree-sitter](https://github.com/tree-sitter/tree-sitter) support

## Collaborate

The author is more than open to collaborations. Any person interested in the project is invited to
participate. Many features are still pending, and the project will grow much more over time. Please,
collaborate. =)

## FAQ

## Why some characters are not being rendered correctly inside the editor?

Some Unicode characters won't be rendered in the editor out of the box. You'll need to change the
default monospace font in favor of a font that supports the characters you want to see that are not
being rendered. You could also change the default fallback font in the case you want to use a
traditional monospaced font. The default fallback font should cover a wide range of languages but
you could need some special font (currently covers CJK languages).

## Current Limitations

* No font sub-pixel hinting \*1 \*2
* No VIM-mode / modal editing \*3
* No [text-shaping](https://harfbuzz.github.io/why-do-i-need-a-shaping-engine.html) support. \*1 \*4
* No ligatures support (requires text-shaping) \*1
* No BiDi support (requires text-shaping) \*1

_\*1_ Current eepp feature limitations.

_\*2_ I'm not a fan of sub-pixel hinting. But I'm more than willing to implement it, I'm not very versed in the matter, so any help will be appreciated.

_\*3_ I'm not a VIM user, and I'm not qualified to implement the VIM mode or any modal editing. PRs are welcome to support this.

_\*4_ Some work has been done to support text-shaping but it's not ready for general usage. So it's a work in progress.

## Author comments

This editor has a deeply rooted inspiration from the lite, lite-xl, QtCreator and Sublime Text
editors. Several features were developed based on the lite/lite-xl implementations. Some features can be ported
directly from lite: color-schemes and syntax-highlighting patterns (eepp implementation expands original
lite implementation to add many more features).

*ecode* is being used mostly in Linux and macOS, it's not well tested in Windows.
If you find any issues with the editor please report it [here](https://github.com/SpartanJ/ecode/issues).

This is a work in progress, stability is not guaranteed. Please don't use it for critical tasks. I'm
using the editor daily and is stable enough for me, but use it at your own risk.

## Acknowledgements

### Special thanks to

* Niels Lohmann for [JSON for Modern C++](https://github.com/nlohmann/json)

* Neil Henning for [subprocess.h](https://github.com/sheredom/subprocess.h)

* All the authors of the [suckless terminal emulator](https://st.suckless.org/)

* Fredrik Aleksander for [Hexe Terminal](https://github.com/FredrikAleksander/HexeTerminal)

* rxi for [lite](https://github.com/rxi/lite)

* franko and all the collaborators for [lite-xl](https://github.com/lite-xl/lite-xl)

* Andreas Kling for [SerenityOS](https://github.com/SerenityOS/serenity)

* And a **lot** more people!

## Code License

[MIT License](http://www.opensource.org/licenses/mit-license.php)
