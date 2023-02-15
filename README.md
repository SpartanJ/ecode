# ecode

*ecode* is a lightweight multi-platform code editor designed for modern hardware with a focus on
responsiveness and performance. It has been developed with the hardware-accelerated [eepp GUI](https://github.com/SpartanJ/eepp/),
which provides the core technology for the editor. The project comes as the first serious project using
the [eepp GUI](https://github.com/SpartanJ/eepp/), and it's currently being developed to improve the
eepp GUI library as part of one of its main objectives.

## Screenshots

![ecode - Code Editor](https://user-images.githubusercontent.com/650416/211463167-03ca716c-2049-4614-b874-446a03adb78f.png)

For more screenshots checkout [running on macOS](https://user-images.githubusercontent.com/650416/172517957-c28d23a5-ee6b-4e96-a0a3-b7252a2b23bb.png), [running on Windows](https://user-images.githubusercontent.com/650416/172760308-30d5335c-d5f7-4dbe-94ce-2e556d858909.png), [running on Haiku](https://user-images.githubusercontent.com/650416/172760331-799b7d16-104b-4cac-ba34-c0cf60ba4374.png), [low dpi](https://user-images.githubusercontent.com/650416/172519582-1aab1e94-8d69-4c2c-b4ba-de9f2d8729cf.png), [code completion](https://user-images.githubusercontent.com/650416/172521557-f68aa855-0534-49c9-b33e-8f9f8b47b9d2.png), [terminal](https://user-images.githubusercontent.com/650416/180109676-a1f9dbc6-d170-4e67-a19c-611cff9f04dd.png), [file locator](https://user-images.githubusercontent.com/650416/172521593-bb8fde13-2600-44e5-87d2-3fc41370fc77.png), [file formats](https://user-images.githubusercontent.com/650416/172521619-ac1aeb82-80e5-49fd-894e-afc780d4c0fd.png), [global find](https://user-images.githubusercontent.com/650416/172523164-2ca9b988-7d2d-4b8c-b6d2-10e593d7fc14.png), [global replace](https://user-images.githubusercontent.com/650416/172523195-00451552-2a56-4595-8b3a-cf8071b36dc6.png), [linter](https://user-images.githubusercontent.com/650416/172523272-45c267af-2585-4c54-86e0-739b5202569e.png).

## Notable Features

* Lightweight
* Portable
* Minimalist GUI
* Syntax Highlighting (including nested syntax highlighting, supporting over 50 languages)
* Multi-cursor support
* Terminal support
* Command Palette
* [LSP](https://microsoft.github.io/language-server-protocol/) support
* Auto-Completion
* Customizable Linter support
* Customizable Formatter support
* Customizable Color-Schemes
* Customizable keyboard bindings
* Unlimited editor splitting
* Minimap
* Fast global search (and replace)
* Customizable and scalable (non-integer) GUI (thanks to [eepp GUI](https://github.com/SpartanJ/eepp/))
* Dark & Light Mode
* File system Tree View (with real-time file system changes)
* Smart hot-reload of files
* Folders as Projects with `.gitignore` support \*
* Per Project Settings
* Smart and fast project file locator
* Multiline search and replace
* Project/Folder state persist between sessions
* [Lua pattern searches](https://www.lua.org/manual/5.4/manual.html#6.4.1) support
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

* Extendable functionality but in a controlled environment. New features and new plugins are accepted, but the author will supervise any new content that might affect the product quality and performance.
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
But it also can be easily built with Visual Studio and [libSDL2 development libraries](https://www.libsdl.org/release/SDL2-devel-2.0.22-VC.zip) installed.
For more information on how to build manually a project please follow the [eepp build instructions](https://github.com/SpartanJ/eepp/#how-to-build-it).
The project name is always *ecode* (so if you are building with make, you'll need to run `make ecode`).

* *Linux* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/linux/ecode). Running `build.app.sh` will try to build the `AppImage` package.
* *macOS* build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/macos/ecode). Running `build.app.sh` will create `ecode.app`.
* *Windows* cross-compiling build script can be found [here](https://github.com/SpartanJ/eepp/tree/develop/projects/mingw32/ecode). Running `build.app.sh` will create a `zip` file with the zipped application package.

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
formats supported, the Lua pattern to find any error printed by the linter to the stdout, the position
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

#### Currently supported linters and languages supported

* **C++**: uses [cppcheck](https://github.com/danmar/cppcheck/)
* **JavaScript and TypeScript**: [eslint](https://eslint.org/)
* **JSON**: linted with [jq](https://stedolan.github.io/jq/)
* **Kotlin**: uses [ktlint](https://ktlint.github.io/)
* **Lua**: uses [luacheck](https://github.com/mpeterv/luacheck)
* **PHP**: uses the [php](https://php.net) official binary
* **Python**: uses [pycodestyle](https://github.com/pycqa/pycodestyle)
* **sh**: uses [shellcheck](https://github.com/koalaman/shellcheck)
* **Solidity**: uses [solhint](https://protofire.github.io/solhint/)
* **Nelua**: uses the [nelua](https://nelua.io/installing/) official binary
* **Nim**: uses the [nim](https://nim-lang.org/install.html) official binary
* **Zig**: uses the [zig](https://ziglang.org/download/) official binary

#### Linter config object keys

* **delay_time**: Delay to run the linter after editing a document
* **enable_error_lens**: Enables error lens (prints the message inline)
* **enable_lsp_diagnostics**: Boolean that enable/disable LSP diagnostics as part of the linting. Enabled by default.
* **disable_lsp_languages**: Array of LSP languages disabled for LSP diagnostics. For example: `"disable_lsp_languages": ["lua", "python"]`, disables lua and python.

#### Linter JSON object keys

* **file_patterns**: Array of Lua Patterns representing the file extensions that must use the linter
* **warning_pattern**: Lua Pattern to be parsed from the executable stdout
* **warning_pattern_order**: The order where the line, column, error/warning/notice message, and the type of the message (warning, error, notice, info) are read. The pattern must have at least 3 groups (line, message, and type). The error type is auto-detected from its name.
* **command**: The command to execute to run the linter. $FILENAME represents the file path.
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

#### Currently supported formatters and languages supported

* **C++**: uses [clang-format](https://clang.llvm.org/docs/ClangFormat.html) formatter
* **CSS**: uses the eepp CSS native formatter (no external formatter required).
* **Go**: uses [gopls](https://github.com/golang/tools/blob/master/gopls/README.md) formatter
* **JavaScript and TypeScript**: uses [prettier](https://prettier.io) formatter
* **JSON**: uses [JSON for Modern C++](https://github.com/nlohmann/json) native formatter (no external formatter required).
* **Kotlin**: uses [ktlint](https://ktlint.github.io/) formatter
* **Python**: uses [black](https://github.com/psf/black) formatter
* **XML**: uses [pugixml](https://github.com/zeux/pugixml/) native formatter (no external formatter required).

Plus the LSP formatters available.

#### Formatter config object keys

* **auto_format_on_save**: Indicates if after saving the file it should be auto-formatted

#### Formatter keybindings object keys

* **format-doc**: Keybinding to format the doc with the configured language formatter

#### Formatter JSON object keys

* **file_patterns**: Array of Lua Patterns representing the file extensions that must use the formatter
* **command**: The command to execute to run the formatter. $FILENAME represents the file path
* **type**: Indicates the mode that which the formatter outputs the results. Supported two possible options: "inplace" (file is replaced with the formatted version), "output" (newly formatted file is the stdout of the program, default option) or "native" (uses the formatter provided by ecode)

### LSP Client

LSP support is provided by executing already stablished LSP from each language. It's currently being
developed and many features aren't present at the moment.
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

#### Currently supported LSPs and languages supported

* **C and C++**: uses [clangd](https://clangd.llvm.org/)
* **C#**: uses [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn)
* **D**: uses [serve-d](https://github.com/Pure-D/serve-d)
* **Dart**: uses [dart native LSP](https://github.com/dart-lang/sdk/blob/main/pkg/analysis_server/tool/lsp_spec)
* **Go**: uses [gopls](https://golang.org/x/tools/gopls)
* **Java**: uses [eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls)
* **JavaScript and TypeScript**: [typescript-language-server](https://github.com/theia-ide/typescript-language-server)
* **Kotlin**: uses [kotlin-language-server](https://github.com/fwcd/kotlin-language-server)
* **Lua**: uses [lua-language-server](https://github.com/sumneko/lua-language-server)
* **nim**: uses [nimlsp](https://github.com/PMunch/nimlsp)
* **Odin**: uses [ols](https://github.com/DanielGavin/ols)
* **PHP**: uses [intelephense](https://intelephense.com)
* **Python**: uses [pylsp](https://github.com/python-lsp/python-lsp-server)
* **Ruby**: uses [solargraph](https://solargraph.org/)
* **Rust**: uses the [rust-analyzer](https://rust-analyzer.github.io)
* **Vue**: uses [vls](https://github.com/vuejs/vetur/tree/master/server)
* **YAML**: uses [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
* **Zig**: uses [zls](https://github.com/zigtools/zls)

#### LSP Client config object keys

* **hover_delay**: The time the editor must wait to show symbol information when hovering any piece of code.
* **server_close_after_idle_time**: The time the LSP Server will keep alive after all documents that consumes that LSP Server were closed. LSP Servers are spawned and killed on demand.

#### LSP Client keybindings object keys

* **lsp-symbol-info**: Keybinding to request symbol information
* **lsp-go-to-definition**: Keybinding to "Go to Definition"
* **lsp-go-to-declaration**: Keybinding to "Go to Declaration"
* **lsp-go-to-implementation**: Keybinding to "Go to Implementation"
* **lsp-go-to-type-definition**: Keybinding to "Go to Type Definition"
* **lsp-switch-header-source**: Keybinding to "Switch Header/Source" (only available for C and C++)

#### LSP Client JSON object keys

* **language**: The LSP language identifier. Some identifiers can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocumentItem)
* **name**: The name of the language server
* **url** (optional): The web page URL of the language server
* **use** (optional): A server can be inherit the configuration from other server. This must be the name of the server configuration that inherits (useful for LSPs that support several languages like clang and typescript-language-server).
* **file_patterns**: Array of Lua Patterns representing the file extensions that must use the LSP client
* **command**: The command to execute to run the LSP. It's possible to override the default LSP command by declaring the server in the `lspclient.json` config.
* **rootIndicationFileNames** (optional): Some languages need to indicate the project root path to the LSP work correctly. This is an array of files that might indicate where the root path is. Usually this is resolver by the LSP itself, but it might help in some situations.
* **initializationOptions** (optional): These are custom initialization options that can be passed to the LSP. Usually not required, but it will allow the user to configure the LSP. More information can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#initialize).

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

Custom terminal color schemes can be added in the user color schemes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/terminal/colorschemes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/terminal/colorschemes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\terminal\colorschemes`

Any file written in the directory will be treated as a terminal color scheme file. Each file can contain
any number of color schemes.

The format of a color scheme can be read from [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/colorschemes/terminalcolorschemes.conf).

## Custom languages support

Custom languages support can be added in the languages directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/terminal/languages`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/terminal/languages`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\terminal\languages`

ecode will read each file located at that directory with `json` extension. Each file can contain one
or several languages. In order to set several languages the root element of the json file should be
an array, containing one object for each language, otherwise if the root element is an object, it
should contain the language definition.

### Language definition format

```json
{
	"name": "language_name",
	"files": [ "Array of file extensions supported" ],
	"comment": "Sets the comment string used for auto-comment functionality.",
	"patterns": [
		{ "pattern": "lua_pattern", "type": "type_name" },
		{ "pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], "type": "type_name" },
	},
	"symbols": [
		{ "symbol_name": "type_name" }
	],
	"visible": true, /* sets if the language is visible as a main language in the editor, optional parameter, true by default */
	"auto_close_xml_tag": false, /* sets if the language defined supports auto close XML tags, optional parameter, false by default */
	"lsp_name": "sets the LSP name assigned for the language, optional parameter, it will use the _name_ in lowercase if not set"
}
```

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
by ecode [here](https://github.com/SpartanJ/eepp/blob/develop/src/eepp/ui/doc/syntaxdefinitionmanager.cpp).

## Planned Features

Listed in no particular order:

* Git integration (visual git diff, git blame, git status, etc)
* Improved LSP integration (semantic highlighting, code actions, symbol viewer)
* Improved plugin system (visual configuration, more flexibility/features)
* Custom languages support (load language definition from files)
* [DAP](https://microsoft.github.io/debug-adapter-protocol/) support
* Code-folding
* Configurable build pipelines

### Long Term Features

* Remote development support
* Modal editing

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
you could need some special font.

## Current Limitations

* UTF-8 files only support (with BOM included) \*1
* No font sub-pixel hinting \*2 \*3
* No BiDi support \*2
* No ligatures support \*4
* No VIM-mode / modal editing \*5
* English only (internationalization pending). It should be implemented soon.
* Limited Unicode support. No [text-shaping](https://harfbuzz.github.io/why-do-i-need-a-shaping-engine.html). Limited support for non-romance languages (Arabic, Chinese, Korean, Hebrew, Hindi, Japanese, etc) in editor (supported in the UI elements and terminal). Emojis are supported. \*2 \*6
* No tree-sitter support \*7

_\*1_ I don't see the point of supporting more encodings for the moment. UTF8 is kind of the defacto industry standard.

_\*2_ Current eepp feature limitations.

_\*3_ I'm not a fan of sub-pixel hinting. But I'm more than willing to implement it, I'm not very versed in the matter, so any help will be appreciated.

_\*4_ I don't really like ligatures. I'm open to PRs implementing them.

_\*5_ I'm not a VIM user, si I'm not qualified to implement the VIM mode or any modal editing. PRs are welcome to support this.

_\*6_ Better Unicode support will come with time, but with no rush for the moment. eepp architecture is ready to add HarfBuzz support.

_\*7_ Tree-sitters might be implemented at some point, but I'm still not 100% sure if it's worth it (yes, I know many of you might think the contrary)

## Author comments

This editor has a deeply rooted inspiration from the lite, lite-xl, and sublime_text editors. It also
takes some inspiration from QtCreator (the current IDE used to develop eepp and ecode).
Several features were developed based on the lite/lite-xl implementations. Some features can be ported
directly from lite: color-schemes and syntax-highlighting patterns (eepp implementation expands original
lite implementation to add many more features).

*ecode* is being used almost exclusively in Linux, it's not well tested in macOS and Windows OS.
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
