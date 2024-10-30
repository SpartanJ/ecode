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

For more screenshots checkout [running on macOS](https://github.com/SpartanJ/ecode/assets/650416/9e8e00a7-fbcc-479b-8588-0023d8f86a9a), [running on Windows](https://user-images.githubusercontent.com/650416/172760308-30d5335c-d5f7-4dbe-94ce-2e556d858909.png), [running on Haiku](https://user-images.githubusercontent.com/650416/172760331-799b7d16-104b-4cac-ba34-c0cf60ba4374.png), [low dpi](https://user-images.githubusercontent.com/650416/172519582-1aab1e94-8d69-4c2c-b4ba-de9f2d8729cf.png), [code completion](https://user-images.githubusercontent.com/650416/172521557-f68aa855-0534-49c9-b33e-8f9f8b47b9d2.png), [terminal](https://user-images.githubusercontent.com/650416/180109676-a1f9dbc6-d170-4e67-a19c-611cff9f04dd.png), [file locator](https://user-images.githubusercontent.com/650416/172521593-bb8fde13-2600-44e5-87d2-3fc41370fc77.png), [file formats](https://user-images.githubusercontent.com/650416/172521619-ac1aeb82-80e5-49fd-894e-afc780d4c0fd.png), [global find](https://user-images.githubusercontent.com/650416/172523164-2ca9b988-7d2d-4b8c-b6d2-10e593d7fc14.png), [global replace](https://user-images.githubusercontent.com/650416/172523195-00451552-2a56-4595-8b3a-cf8071b36dc6.png), [linter](https://user-images.githubusercontent.com/650416/172523272-45c267af-2585-4c54-86e0-739b5202569e.png).

## Notable Features

* Lightweight
* Portable
* Minimalist GUI
* Syntax Highlighting (including nested syntax highlighting, supporting over 90 languages and LSP semantic highlighting)
* Multi-cursor support
* Terminal support
* Command Palette
* [LSP](https://microsoft.github.io/language-server-protocol/) support
* [Git](https://git-scm.com/) integration
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
* Linter, Formatter and LSP plugins won't work since both work running other processes (except for the native formatters that are available)
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
|         Language        | Highlight |                                                  LSP                                                 |                      Linter                     |                           Formatter                          |
|          :---:          |   :---:   |                                                 :---:                                                |                      :---:                      |                             :---:                            |
| .htaccess               | ✓       | None                                                                                                 | None                                            | None                                                         |
| .ignore file            | ✓       | None                                                                                                 | None                                            | None                                                         |
| [x]it!                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| adept                   | ✓       | [AdeptLSP](https://github.com/AdeptLanguage/AdeptLSP)                                                | None                                            | None                                                         |
| angelscript             | ✓       | None                                                                                                 | None                                            | None                                                         |
| awk script              | ✓       | None                                                                                                 | None                                            | None                                                         |
| bat                     | ✓       | None                                                                                                 | None                                            | None                                                         |
| bend                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| blueprint               | ✓       | None                                                                                                 | None                                            | None                                                         |
| brainfuck               | ✓       | None                                                                                                 | None                                            | None                                                         |
| buzz                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| c                       | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | [cppcheck](https://github.com/danmar/cppcheck)  | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) |
| carbon                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| clojure                 | ✓       | [clojure-lsp](https://github.com/clojure-lsp/clojure-lsp)                                            | None                                            | None                                                         |
| cmake                   | ✓       | [cmake-language-server](https://github.com/regen100/cmake-language-server)                           | None                                            | None                                                         |
| cpp                     | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | [cppcheck](https://github.com/danmar/cppcheck)  | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) |
| crystal                 | ✓       | [crystalline](https://github.com/elbywan/crystalline)                                                | None                                            | None                                                         |
| csharp                  | ✓       | [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn)                                           | None                                            | None                                                         |
| css                     | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | [native](#native)                                            |
| d                       | ✓       | [serve-d](https://github.com/Pure-D/serve-d)                                                         | None                                            | None                                                         |
| dart                    | ✓       | [dart language-server](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/tool/lsp_spec) | None                                            | None                                                         |
| diff                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| dockerfile              | ✓       | [docker-langserver](https://github.com/rcjsuen/dockerfile-language-server-nodejs)                    | None                                            | None                                                         |
| elixir                  | ✓       | [elixir-ls](https://github.com/elixir-lsp/elixir-ls)                                                 | None                                            | None                                                         |
| elm                     | ✓       | [elm-language-server](https://github.com/elm-tooling/elm-language-server)                            | None                                            | None                                                         |
| environment file        | ✓       | None                                                                                                 | None                                            | None                                                         |
| fantom                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| fortran                 | ✓       | None                                                                                                 | None                                            | None                                                         |
| fstab                   | ✓       | None                                                                                                 | None                                            | None                                                         |
| gdscript                | ✓       | None                                                                                                 | None                                            | None                                                         |
| glsl                    | ✓       | [glsl_analyzer](https://github.com/nolanderc/glsl_analyzer)                                          | None                                            | None                                                         |
| go                      | ✓       | [gopls](https://golang.org/x/tools/gopls)                                                            | None                                            | [gopls](https://pkg.go.dev/golang.org/x/tools/gopls)         |
| graphql                 | ✓       | None                                                                                                 | None                                            | None                                                         |
| groovy                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| hare                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| haskell                 | ✓       | [haskell-language-server](https://github.com/haskell/haskell-language-server)                        | [hlint](https://github.com/ndmitchell/hlint)    | [ormolu](https://github.com/tweag/ormolu)                    |
| haxe                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| haxe compiler arguments | ✓       | None                                                                                                 | None                                            | None                                                         |
| hlsl                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| html                    | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | [prettier](https://prettier.io)                              |
| ini                     | ✓       | None                                                                                                 | None                                            | None                                                         |
| jai                     | ✓       | None                                                                                                 | None                                            | None                                                         |
| java                    | ✓       | [jdtls](https://github.com/eclipse/eclipse.jdt.ls)                                                   | None                                            | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) |
| javascript              | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | [eslint](https://eslint.org)                    | [prettier](https://prettier.io)                              |
| javascriptreact         | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | None                                            | None                                                         |
| json                    | ✓       | None                                                                                                 | [jq](https://stedolan.github.io/jq/)            | [native](#native)                                            |
| julia                   | ✓       | None                                                                                                 | None                                            | None                                                         |
| kotlin                  | ✓       | [kotlin-language-server](https://github.com/fwcd/kotlin-language-server)                             | [ktlint](https://pinterest.github.io/ktlint/)   | [ktlint](https://pinterest.github.io/ktlint/)                |
| latex                   | ✓       | [texlab](https://github.com/latex-lsp)                                                               | None                                            | None                                                         |
| lobster                 | ✓       | None                                                                                                 | None                                            | None                                                         |
| lua                     | ✓       | [lua-language-server](https://github.com/sumneko/lua-language-server)                                | [luacheck](https://github.com/mpeterv/luacheck) | None                                                         |
| makefile                | ✓       | None                                                                                                 | None                                            | None                                                         |
| markdown                | ✓       | None                                                                                                 | None                                            | None                                                         |
| meson                   | ✓       | None                                                                                                 | None                                            | None                                                         |
| moonscript              | ✓       | None                                                                                                 | None                                            | None                                                         |
| nelua                   | ✓       | None                                                                                                 | [nelua](https://nelua.io)                       | None                                                         |
| nim                     | ✓       | [nimlsp](https://github.com/PMunch/nimlsp)                                                           | [nim](https://nim-lang.org)                     | None                                                         |
| objeck                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| objective-c             | ✓       | [clangd](https://clangd.llvm.org/)                                                                   | None                                            | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) |
| odin                    | ✓       | [ols](https://github.com/DanielGavin/ols)                                                            | None                                            | None                                                         |
| pascal                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| perl                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| php                     | ✓       | [phpactor](https://phpactor.readthedocs.io)                                                          | [php](https://www.php.net)                      | None                                                         |
| pico-8                  | ✓       | None                                                                                                 | None                                            | None                                                         |
| plaintext               | ✓       | None                                                                                                 | None                                            | None                                                         |
| po                      | ✓       | None                                                                                                 | None                                            | None                                                         |
| pony                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| postgresql              | ✓       | None                                                                                                 | None                                            | None                                                         |
| powershell              | ✓       | None                                                                                                 | None                                            | None                                                         |
| python                  | ✓       | [pylsp](https://github.com/python-lsp/python-lsp-server)                                             | [ruff](https://ruff.rs)                         | [black](https://black.readthedocs.io/en/stable/)             |
| r                       | ✓       | [r languageserver](https://github.com/REditorSupport/languageserver)                                 | None                                            | None                                                         |
| ruby                    | ✓       | [solargraph](https://solargraph.org)                                                                 | None                                            | None                                                         |
| rust                    | ✓       | [rust-analyzer](https://rust-analyzer.github.io)                                                     | None                                            | [rustfmt](https://rust-lang.github.io/rustfmt/)              |
| sass                    | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | None                                            | None                                                         |
| scala                   | ✓       | [metals](https://github.com/scalameta/metals)                                                        | None                                            | None                                                         |
| shellscript             | ✓       | [bash-language-server](https://github.com/bash-lsp/bash-language-server)                             | None                                            | None                                                         |
| smallbasic              | ✓       | None                                                                                                 | None                                            | None                                                         |
| solidity                | ✓       | [solc](https://soliditylang.org)                                                                     | [solhint](https://protofire.github.io/solhint/) | None                                                         |
| sql                     | ✓       | None                                                                                                 | None                                            | None                                                         |
| swift                   | ✓       | [sourcekit-lsp](https://github.com/apple/sourcekit-lsp)                                              | None                                            | None                                                         |
| teal                    | ✓       | None                                                                                                 | [tl](https://github.com/teal-language/tl)       | None                                                         |
| toml                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| typescript              | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | [eslint](https://eslint.org)                    | [prettier](https://prettier.io)                              |
| typescriptreact         | ✓       | [typescript-language-server](https://github.com/theia-ide/typescript-language-server)                | None                                            | None                                                         |
| v                       | ✓       | [v-analyzer](https://github.com/v-analyzer/v-analyzer)                                               | None                                            | [v](https://vlang.io)                                        |
| vala                    | ✓       | [vala-language-server](https://github.com/vala-lang/vala-language-server)                            | None                                            | None                                                         |
| verilog                 | ✓       | None                                                                                                 | None                                            | None                                                         |
| visual basic            | ✓       | None                                                                                                 | None                                            | None                                                         |
| vue                     | ✓       | [vls](https://github.com/vuejs/vetur/tree/master/server)                                             | None                                            | None                                                         |
| wren                    | ✓       | None                                                                                                 | None                                            | None                                                         |
| x86 assembly            | ✓       | None                                                                                                 | None                                            | None                                                         |
| xml                     | ✓       | [emmet-language-server](https://github.com/olrtg/emmet-language-server)                              | [native](#native)                               | [native](#native)                                            |
| xtend                   | ✓       | None                                                                                                 | None                                            | None                                                         |
| yaml                    | ✓       | [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)                     | None                                            | None                                                         |
| zig                     | ✓       | [zls](https://github.com/zigtools/zls)                                                               | [zig](https://ziglang.org)                      | [zig](https://ziglang.org)                                   |

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

### Linter

Linter support is provided by executing already stablished linters from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`linters.json` configuration. `linters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/linters.json).
To configure new linters you can create a new `linters.json` file in the [default configuration path](#plugins-configuration-files-location) of *ecode*.

#### `linters.json` format

The format is a very simple JSON object with a config object and array of objects containing the file
formats supported, the [Lua pattern](https://www.lua.org/manual/5.4/manual.html#6.4.1) to find any error printed by the linter to the stdout, the position
of each group of the pattern, and the command to execute. It also supports some optional extra object keys.

JavaScript linter example (using [eslint](https://eslint.org/))

```json
{
    "config": {
        "delay_time": "0.5s"
    },
    "linters": [
      {
        "file_patterns": ["%.js$", "%.ts$"],
        "warning_pattern": "[^:]:(%d+):(%d+): ([^%[]+)%[([^\n]+)",
        "warning_pattern_order": { "line": 1, "col": 2, "message": 3, "type": 4 },
        "command": "eslint --no-ignore --format unix $FILENAME"
      }
    ]
}
```

That's all we need to have a working linter in *ecode*. Linters executables must be installed manually
by the user, linters will not come with the editor, and they also need to be visible to the executable.
This means that it must be on `PATH` environment variable or the path to the binary must be absolute.

#### Currently supported linters

Please check the [language support table](#language-support-table)

#### Linter config object keys

* **delay_time**: Delay to run the linter after editing a document
* **enable_error_lens**: Enables error lens (prints the message inline)
* **enable_lsp_diagnostics**: Boolean that enable/disable LSP diagnostics as part of the linting. Enabled by default.
* **disable_lsp_languages**: Array of LSP languages disabled for LSP diagnostics. For example: `"disable_lsp_languages": ["lua", "python"]`, disables lua and python.
* **disable_languages**: Array of linters disabled from external linter application diagnostics. For example: `"disable_languages": ["lua", "python"]`, disables luacheck and ruff respectively.
* **goto_ignore_warnings**: Defines the behavior of the "linter-go-to-next-error" and "linter-go-to-previous-error" keybindings. If ignore warnings is true it will jump only between errors.

#### Linter JSON object keys

* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the linter
* **warning_pattern**: [Lua Pattern](https://www.lua.org/manual/5.4/manual.html#6.4.1) to be parsed from the executable stdout
* **warning_pattern_order**: The order where the line, column, error/warning/notice message, and the type of the message (warning, error, notice, info) are read. The pattern must have at least 3 groups (line, message, and type). The error type is auto-detected from its name.
* **command**: The command to execute to run the linter. $FILENAME represents the file path.
* **url** (optional): The web page URL of the linter
* **expected_exitcodes**: Array of integer numbers accepted as parseable exit codes (optional)
* **no_errors_exit_code**: Integer number representing the exit code that means that no errors were found (optional).
* **deduplicate**: In case the linter outputs duplicated errors, this boolean will ignore duplicated errors (optional, boolean true/false)
* **use_tmp_folder**: Temporal files (files representing the current status of the modified file) will be written in the default temporal folder of the operating system, otherwise it will be written in the same folder path of the modified file (optional, boolean true/false).

### Formatter

The formatter plugin works exactly like the linter plugin, but it will execute tools that auto-format code.
*ecode* provides support for several languages by default with can be extended easily by expanding the
`formatters.json` configuration. `formatters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/formatters.json).
It also supports some formatters natively, this means that the formatter comes with ecode without requiring any external dependency.
And also supports LSP text document formatting, meaning that if you're running an LSP that supports formatting documents, formatting will be available too.
To configure new formatters you can create a new `formatters.json` file in the [default configuration path](#plugins-configuration-files-location) of *ecode*.

#### `formatters.json` format

```json
{
    "config": {
        "auto_format_on_save": false
    },
    "keybindings": {
        "format-doc": "alt+f"
    },
    "formatters": [
        {
            "file_patterns": ["%.js$", "%.ts$"],
            "command": "prettier $FILENAME"
        }
    ]
}
```

#### Currently supported formatters

Please check the [language support table](#language-support-table)

#### Formatter config object keys

* **auto_format_on_save**: Indicates if after saving the file it should be auto-formatted

#### Formatter keybindings object keys

* **format-doc**: Keybinding to format the doc with the configured language formatter

#### Formatter JSON object keys

* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the formatter
* **command**: The command to execute to run the formatter. $FILENAME represents the file path
* **type**: Indicates the mode that which the formatter outputs the results. Supported two possible options: "inplace" (file is replaced with the formatted version), "output" (newly formatted file is the stdout of the program, default option) or "native" (uses the formatter provided by ecode)
* **url** (optional): The web page URL of the formatter

### LSP Client

LSP support is provided by executing already stablished LSP from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`lspclient.json` configuration. `lspclient.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/lspclient.json).
To configure new LSPs you can create a new `lspclient.json` file in the [default configuration path](#plugins-configuration-files-location) of *ecode*.

Important note: LSP servers can be very resource intensive and might not be always the best option for simple projects.

Implementation details: LSP servers are only loaded when needed, no process will be opened until a
supported file is opened in the project.

#### `lspclient.json` format

The format follows the same pattern that all previous configuration files. Configuration is represented
in a JSON file with three main keys: `config`, `keybindings`, `servers`.

C and C++ LSP server example (using [clangd](https://clangd.llvm.org/))

```json
{
    "config": {
        "hover_delay": "0.5s"
    },
    "servers": [
        {
          "language": "c",
          "name": "clangd",
          "url": "https://clangd.llvm.org/",
          "command": "clangd -log=error --background-index --limit-results=500 --completion-style=bundled",
          "file_patterns": ["%.c$", "%.h$", "%.C$", "%.H$", "%.objc$"]
        },
        {
          "language": "cpp",
          "use": "clangd",
          "file_patterns": ["%.inl$", "%.cpp$", "%.hpp$", "%.cc$", "%.cxx$", "%.c++$", "%.hh$", "%.hxx$", "%.h++$", "%.objcpp$"]
        }
    ]
}
```

That's all we need to have a working LSP in *ecode*. LSPs executables must be installed manually
by the user, LSPs will not come with the editor, and they also need to be visible to the executable.
This means that it must be on `PATH` environment variable or the path to the binary must be absolute.

#### Currently supported LSPs

Please check the [language support table](#language-support-table)

#### LSP Client config object keys

* **hover_delay**: The time the editor must wait to show symbol information when hovering any piece of code.
* **server_close_after_idle_time**: The time the LSP Server will keep alive after all documents that consumes that LSP Server were closed. LSP Servers are spawned and killed on demand.
* **semantic_highlighting**: Enable/Disable semantic highlighting (disabled by default, boolean)
* **disable_semantic_highlighting_lang**: An array of languages where semantic highlighting should be disabled
* **silent**: Enable/Disable non-critical LSP logs
* **trim_logs**: If logs are enabled and trim_logs is enabled it will trim the line log size at maximum 1 KiB per line (useful for debugging)
* **breadcrumb_navigation**: Enable/Disable the breadcrumb (enabled by default)
* **breadcrumb_height**: Defines the height of the breadcrumb in [CSS length](https://eepp.ensoft.dev/page_cssspecification.html#length-data-type)

#### LSP Client keybindings object keys

* **lsp-symbol-info**: Keybinding to request symbol information
* **lsp-go-to-definition**: Keybinding to "Go to Definition"
* **lsp-go-to-declaration**: Keybinding to "Go to Declaration"
* **lsp-go-to-implementation**: Keybinding to "Go to Implementation"
* **lsp-go-to-type-definition**: Keybinding to "Go to Type Definition"
* **lsp-symbol-references**: Keybinding to "Find References to Symbol Under Cursor"
* **lsp-symbol-code-action**: Keybinding to "Code Action"
* **lsp-switch-header-source**: Keybinding to "Switch Header/Source" (only available for C and C++)

#### LSP Client JSON object keys

* **language**: The LSP language identifier. Some identifiers can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocumentItem)
* **name**: The name of the language server
* **url** (optional): The web page URL of the language server
* **use** (optional): A server can be inherit the configuration from other server. This must be the name of the server configuration that inherits (useful for LSPs that support several languages like clang and typescript-language-server).
* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the LSP client
* **command**: The command to execute to run the LSP. It's possible to override the default LSP command by declaring the server in the `lspclient.json` config. It's also possible to specify a different command for each platform, given that it might change in some ocassions per-platform. In that case an object should be used, with each key being a platform, and there's also a wildcard platform "other" to specify any other platform that does not match the platform definition. For example, `sourcekit-lsp` uses: `"command": {"macos": "xcrun sourcekit-lsp","other": "sourcekit-lsp"}`
* **command_parameters** (optional): The command parameters. Parameters can be set from the **command** also, unless the command needs to run a binary with name with spaces. Also command_parameters can be used to add more parameters to the original command. The lsp configuration can be overriden from the lspclient.json in the user configuration. For example: a user trying to append some command line arguments to clang would need to do something like: `{"name": "clangd","command_parameters": "--background-index-priority=background --malloc-trim"}`
* **rootIndicationFileNames** (optional): Some languages need to indicate the project root path to the LSP work correctly. This is an array of files that might indicate where the root path is. Usually this is resolver by the LSP itself, but it might help in some situations.
* **initializationOptions** (optional): These are custom initialization options that can be passed to the LSP. Usually not required, but it will allow the user to configure the LSP. More information can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#initialize).
* **host** (optional): It's possible to connect to LSP servers via TCP. This is the host location of the LSP. When using TCP connections *command* can be empty or can be used to initialize the LSP server. And then use the LSP through a TCP connection.
* **port** (optional): It's possible to connect to LSP servers via TCP. This is the post location of the LSP.
* **env** (optional): Array of strings with environment variables added to the process environment.

### Git integration

*ecode* provides some basic Git integration (more features will come in the future). Its main purpose
is to help the user to do the most basics operations with Git. Some of the current features supported:
git status and stats visualization (files states), commit, push, checkout, pull, fetch, fast-forward
merge, creating+renaming+deleting branches, managing stashes. All stats will be automatically
updated/refreshed in real time. There's also some basic configuration available.
The plugin requires the user to have a `git` binary installed and available in `PATH` environment variable.

#### `git.json` format

The format follows the same pattern that all previous configuration files. Configuration is represented
in a JSON file with three main keys: `config`, `keybindings`, `servers`.

C and C++ LSP server example (using [clangd](https://clangd.llvm.org/))

```json
{
  "config": {
    "silent": false,
    "status_recurse_submodules": true,
    "statusbar_display_branch": true,
    "statusbar_display_modifications": true,
    "ui_refresh_frequency": "5s"
  },
  "keybindings": {
    "git-blame": "alt+shift+b"
  }
}
```

#### Git config object keys

* **silent**: Enable/Disable non-critical Git logs.
* **status_recurse_submodules**: Enables/disables recursing sub-modules for the file status report.
* **statusbar_display_branch**: Enables/disables an always visible status on the bottom statusbar.
* **statusbar_display_modifications**: Enables/disables if the number of lines affected is displayed in the statusbar.
* **ui_refresh_frequency**: Indicates the frequency in which the status is updated (it will only trigger updates if changes are detected inside the `.git` directory).
* **filetree_highlight_changes**: Enables/disables the highlighting of changes on the file-tree.
* **filetree_highlight_style_color**: Allows to change the highlight color in the file-tree.

#### Git keybindings object keys

* **git-blame**: Keybinding to display the a git blame summary over the current positioned line.

### Auto Complete

The auto-complete plugin is in charge of providing suggestions for code-completion and signature help.

#### Auto Complete config object keys

* **max_label_characters**: Maximum characters displayed in the suggestion box.
* **suggestions_syntax_highlight**: Enables/disables syntax highlighting in suggestions.

### XML Tools

The XML Tools plugin (disabled by default) provides some nice to have improvements when editing XML
content.

#### XML Tools config object keys

* **auto_edit_match**: Automatically edits the open/close tag when the user edits the element tag name (syncs open and close element names).
* **highlight_match**: When the user moves the cursor to an open or close tag it will highlight the matched open/close tag.

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

## Customizations

### Custom editor color schemes

Custom editor color schemes can be added in the user color schemes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/editor/colorschemes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/editor/colorschemes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\editor\colorschemes`

Any file written in the directory will be treated as an editor color scheme file. Each file can contain
any number of color schemes.

The format of a color scheme can be read from [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/colorschemes/colorschemes.conf).

### Custom terminal color schemes

Custom terminal color schemes can be added in the user terminal color schemes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/terminal/colorschemes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/terminal/colorschemes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\terminal\colorschemes`

Any file written in the directory will be treated as a terminal color scheme file. Each file can contain
any number of color schemes.

The format of a color scheme can be read from [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/colorschemes/terminalcolorschemes.conf).

### Custom UI themes

Custom UI schemes can be added in the user UI themes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/themes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/themes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\themes`

A custom UI theme file must have the extension `.css`, ecode will look for all the files with `.css`
extension in the directory, the UI theme name is the file name without the extension. The new theme
will appear in `Settings -> Window -> UI Theme`.

Custom UI themes allow customizing the editor at the user's will. Since ecode uses CSS to style all the
elements of the UI, creating new themes is quite easy. It's possible to customize only the color palette
but it's also possible to customize all the UI elements if desired. Customizing the whole UI theme can
be extensive, but customizing the colors is as simple as changing the values of the CSS variables used
to color the UI. For reference, the complete base UI theme used by ecode can be seen [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/ui/breeze.css).
The most important selector would be the `:root` selector, where all the variables are defined. Color
variables can be easily extracted from that file.

A simple example of a custom UI theme that changes only the tint colors, let's call it `Breeze Light Red.css`:

```css
:root {
	--inherit-base-theme: true;
	--primary: #e93d66;
	--scrollbar-button: #a94074;
	--item-hover: #502834;
	--tab-hover: #5e3347;
}
```

That effectively would create/add a new UI theme with light red colors.
A very important detail is that if the UI theme must inherit the complete definition of the default theme,
we must add `--inherit-base-theme: true` to the `:root` element, otherwise the UI theme must be defined
completely, which means, every widget must be styled from scratch (not recommended given its complexity).
It's also possible to override the style of the different widgets redefining their properties with the
usual rules that apply to the well-known CSS specification (A.K.A. using adequate
[specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity) and probably abusing the
[!important](https://developer.mozilla.org/en-US/docs/Web/CSS/important) flag).

## Custom languages support

Custom languages support can be added in the languages directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/languages`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/languages`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\languages`

ecode will read each file located at that directory with `json` extension. Each file can contain one
or several languages. In order to set several languages the root element of the json file should be
an array, containing one object for each language, otherwise if the root element is an object, it
should contain the language definition. Language definitions can override any currently supported
definition. ecode will prioritize user defined definitions.

### Language definition format

```json
{
	"name": "language_name",
	"files": [ "Array of file extensions supported" ],
	"comment": "Sets the comment string used for auto-comment functionality.",
	"patterns": [
		{ "pattern": "lua_pattern", "type": "type_name" },
		{ "pattern": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": { "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" } },
		{ "pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], "type": "type_name" }
	],
	"symbols": [
		{ "symbol_name": "type_name" }
	],
	"visible": true, /* sets if the language is visible as a main language in the editor, optional parameter, true by default */
	"auto_close_xml_tag": false, /* sets if the language defined supports auto close XML tags, optional parameter, false by default */
	"lsp_name": "sets the LSP name assigned for the language, optional parameter, it will use the _name_ in lowercase if not set"
}
```

### Porting language definitions

ecode uses the same format for language definition as [lite](https://github.com/rxi/lite) and [lite-xl](https://github.com/lite-xl/lite-xl) editors.
This makes much easier to add new languages to ecode. There's also a helper tool that can be download from
ecode repository located [here](https://github.com/SpartanJ/ecode/tree/develop/tools/data-migration/lite/language)
that allows to directly export a lite language definition to the JSON file format used in ecode.

### Extending language definitions

It's possible to easily extend any language definition by exporting it using the CLI arguments provided:
`--export-lang` and `--export-lang-path`. A user wanting to extend or improve a language definition can
export it, modify it and install the definition with a `.json` extension in the [custom languages path](#custom-languages-support).
For example, to extend the language `vue` you will need to run:
`ecode --export-lang=vue --export-lang-path=./vue.json`, exit the exported file and move it to the
[custom languages path](#custom-languages-support).

### Language definition example

```json
{
  "name": "Elixir",
  "files": [ "%.ex$", "%.exs$" ],
  "comment": "#",
  "patterns": [
    { "pattern": "#.*\n",                "type": "comment"  },
    { "pattern": [ ":\"", "\"", "\\" ],    "type": "number"   },
    { "pattern": [ "\"\"\"", "\"\"\"", "\\" ], "type": "string"   },
    { "pattern": [ "\"", "\"", "\\" ],     "type": "string"   },
    { "pattern": [ "'", "'", "\\" ],     "type": "string"   },
    { "pattern": [ "~%a[/\"|'%(%[%{<]", "[/\"|'%)%]%}>]", "\\" ], "type": "string"},
    { "pattern": "-?0x%x+",              "type": "number"   },
    { "pattern": "-?%d+[%d%.eE]*f?",     "type": "number"   },
    { "pattern": "-?%.?%d+f?",           "type": "number"   },
    { "pattern": ":\"?[%a_][%w_]*\"?",     "type": "number"   },
    { "pattern": "[%a][%w_!?]*%f[(]",    "type": "function" },
    { "pattern": "%u%w+",                "type": "normal"   },
    { "pattern": "@[%a_][%w_]*",         "type": "keyword2" },
    { "pattern": "_%a[%w_]*",            "type": "keyword2" },
    { "pattern": "[%+%-=/%*<>!|&]",      "type": "operator" },
    { "pattern": "[%a_][%w_]*",          "type": "symbol"   }
  ],
  "symbols": [
    {"def": "keyword"},
    {"defp": "keyword"},
    {"defguard": "keyword"},
    {"defguardp": "keyword"},
    {"defmodule": "keyword"},
    {"defprotocol": "keyword"},
    {"defimpl": "keyword"},
    {"defrecord": "keyword"},
    {"defrecordp": "keyword"},
    {"defmacro": "keyword"},
    {"defmacrop": "keyword"},
    {"defdelegate": "keyword"},
    {"defoverridable": "keyword"},
    {"defexception": "keyword"},
    {"defcallback": "keyword"},
    {"defstruct": "keyword"},
    {"for": "keyword"},
    {"case": "keyword"},
    {"when": "keyword"},
    {"with": "keyword"},
    {"cond": "keyword"},
    {"if": "keyword"},
    {"unless": "keyword"},
    {"try": "keyword"},
    {"receive": "keyword"},
    {"after": "keyword"},
    {"raise": "keyword"},
    {"rescue": "keyword"},
    {"catch": "keyword"},
    {"else": "keyword"},
    {"quote": "keyword"},
    {"unquote": "keyword"},
    {"super": "keyword"},
    {"unquote_splicing": "keyword"},
    {"do": "keyword"},
    {"end": "keyword"},
    {"fn": "keyword"},
    {"import": "keyword2"},
    {"alias": "keyword2"},
    {"use": "keyword2"},
    {"require": "keyword2"},
    {"and": "operator"},
    {"or": "operator"},
    {"true": "literal"},
    {"false": "literal"},
    {"nil": "literal"}
  ]
}
```

For more complex syntax definitions please see the definition of all the native languages supported
by ecode [here](https://github.com/SpartanJ/eepp/tree/develop/src/eepp/ui/doc/languages).

## Planned Features

Listed in no particular order:

* [DAP](https://microsoft.github.io/debug-adapter-protocol/) support
* Improved plugin system (visual configuration, more flexibility/features)

### Long Term Planned Features

* Remote development support
* Modal editing
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
* No VIM-mode / modal editing \*4
* No [text-shaping](https://harfbuzz.github.io/why-do-i-need-a-shaping-engine.html) support. \*1 \*5
* No ligatures support (requires text-shaping) \*1 \*3
* No BiDi support (requires text-shaping) \*1

_\*1_ Current eepp feature limitations.

_\*2_ I'm not a fan of sub-pixel hinting. But I'm more than willing to implement it, I'm not very versed in the matter, so any help will be appreciated.

_\*3_ I don't really like ligatures. I'm open to PRs implementing them.

_\*4_ I'm not a VIM user, and I'm not qualified to implement the VIM mode or any modal editing. PRs are welcome to support this.

_\*5_ Better text-shaping support will come with time, but with no rush for the moment. eepp architecture is ready to add HarfBuzz support.

## Author comments

This editor has a deeply rooted inspiration from the lite, lite-xl, QtCreator, and Sublime Text
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
