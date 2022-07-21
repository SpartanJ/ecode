# ecode

*ecode* is a lightweight multi-platform C++ code editor designed for modern hardware with a focus on
responsiveness and performance. It has been developed with the new hardware-accelerated [eepp GUI](https://github.com/SpartanJ/eepp/),
which provides the core technology for the editor. The project comes as the first serious project using
the [eepp GUI](https://github.com/SpartanJ/eepp/), and it's currently being developed to improve the
eepp GUI library as part of one of its main objectives.

## Screenshots

![ecode - Code Editor](https://user-images.githubusercontent.com/650416/172517863-e8a477dd-a560-460c-9a6e-4557efe1c2cd.png)

For more screenshots checkout [running on macOS](https://user-images.githubusercontent.com/650416/172517957-c28d23a5-ee6b-4e96-a0a3-b7252a2b23bb.png), [running on Windows](https://user-images.githubusercontent.com/650416/172760308-30d5335c-d5f7-4dbe-94ce-2e556d858909.png), [running on Haiku](https://user-images.githubusercontent.com/650416/172760331-799b7d16-104b-4cac-ba34-c0cf60ba4374.png), [low dpi](https://user-images.githubusercontent.com/650416/172519582-1aab1e94-8d69-4c2c-b4ba-de9f2d8729cf.png), [code completion](https://user-images.githubusercontent.com/650416/172521557-f68aa855-0534-49c9-b33e-8f9f8b47b9d2.png), [terminal](https://user-images.githubusercontent.com/650416/180109676-a1f9dbc6-d170-4e67-a19c-611cff9f04dd.png), [file locator](https://user-images.githubusercontent.com/650416/172521593-bb8fde13-2600-44e5-87d2-3fc41370fc77.png), [file formats](https://user-images.githubusercontent.com/650416/172521619-ac1aeb82-80e5-49fd-894e-afc780d4c0fd.png), [global find](https://user-images.githubusercontent.com/650416/172523164-2ca9b988-7d2d-4b8c-b6d2-10e593d7fc14.png), [global replace](https://user-images.githubusercontent.com/650416/172523195-00451552-2a56-4595-8b3a-cf8071b36dc6.png), [linter](https://user-images.githubusercontent.com/650416/172523272-45c267af-2585-4c54-86e0-739b5202569e.png).

## Philosophy

Some points to illustrate the project philosophy:

* Plugins and non-main functionality should never lock the main thread (GUI thread) or at least should block it as little as possible
* Extendable functionality but in a controlled environment
* Load as few files and resources as possible
* Load asynchronously as many resources as possible
* Use the machine resources but not abuse them
* Developed with modern hardware in mind: expected hardware should have low file system latency (SSD), high cores count and decent GPU acceleration
* Terminals are part of the developer workflow

## Notable Features

* Lightweight
* Portable
* Minimalist GUI
* Syntax Highlighting (including nested syntax highlighting)
* Terminal support
* Auto-Completion
* Customizable Linter support
* Customizable Formatter support
* Customizable Color-Schemes
* Minimap
* Unlimited editor splitting
* Customizable keyboard bindings
* Blazing fast global search (and replace)
* Customizable and scalable (non-integer) GUI (thanks to [eepp GUI](https://github.com/SpartanJ/eepp/))
* Dark & Light Mode
* Tree View (with real-time file system changes)
* Smart hot-reload of files
* Folders as Projects with `.gitignore` support \*
* Per Project Settings
* Smart and fast project file locator
* Multiline search and replace
* Project/Folder state persist between sessions
* [Lua pattern searches](https://www.lua.org/manual/5.4/manual.html#6.4.1) support.

### Folder / Project Settings (\*)

*ecode* treats folders as projects, like many other editors. The main difference is that it also tries
to automatically sanitize the project files by filtering out any file that it's filtered in the repository
`.gitignore` files. The idea is to use the `.gitignore` file as a project setting.
The remaining project files will be the ones used to: find files in the project and do global searches.
Usually, this translates into much better results for any project-related search.
Currently there's no way to "unfilter" files filtered by the `.gitignore` configuration, but I plan
to add the functionality soon.
Also, ecode will only add files that are supported by the editor, the editor won't try to do anything
with files that are not officially supported.

## Planned Features

Listed in no particular order:

* LSP support
* Configurable build pipeline
* Multi-cursor support
* Code-folding

## Live Demo

ecode can be compiled to WASM and run in any modern browser. There are no plans to focus the
development on the web version (at least for the moment) since there are plenty of good solutions out
there.

[*Demo here*](https://web.ensoft.dev/eepp/demo-fs.html?run=ecode.js)

### Demo Clarifications

* You'll need a modern browser with [SharedArrayBuffer](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#browser_compatibility) support
* Current hosting isn't very fast, it could take some seconds to load (gzipped file are arround 2.5MB)
* Linter and formatter plugins won't work since both work running other processes
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

### Linter

Linter support is provided by executing already stablished linters from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`linters.json` configuration. `linters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/linters/linters.json).
To configure new linters you can create a new `linters.json` file in the default configuration path of *ecode*.

#### `linters.json` format

The format is a very simple JSON array of objects containing the file formats supported, the
Lua pattern to find any error printed by the linter to the stdout, the position of each group of the
pattern, and the command to execute. It also supports some optional extra object keys.

JavaScript linter example (using [eslint](https://eslint.org/))

```json
[
  {
	"file_patterns": ["%.js$", "%.ts$"],
	"warning_pattern": "[^:]:(%d+):(%d+): ([^%[]+)%[([^\n]+)",
	"warning_pattern_order": { "line": 1, "col": 2, "message": 3, "type": 4 },
	"command": "eslint --no-ignore --format unix $FILENAME"
  }
]
```

That's all we need to have a working linter in *ecode*. Linters executables must be installed manually
by the user, linters will not come with the editor, and they also need to be visible to the executable.
This means that it must be on `PATH` environment variable or the path to the binary must be absolute.

#### Currently supported linters and languages supported

* **JavaScript and TypeScript**: [eslint](https://eslint.org/)
* **PHP**: uses the [php](https://php.net) official binary
* **JSON**: linted with [jq](https://stedolan.github.io/jq/)
* **Lua**: uses [luacheck](https://github.com/mpeterv/luacheck)
* **Python**: uses [pycodestyle](https://github.com/pycqa/pycodestyle)
* **sh**: uses [shellcheck](https://github.com/koalaman/shellcheck)
* **Solidity**: uses [solhint](https://protofire.github.io/solhint/)
* **cpp**: uses [cppcheck](https://github.com/danmar/cppcheck/)
* **Kotlin**: uses [ktlint](https://ktlint.github.io/)
* **Zig**: uses the [zig](https://ziglang.org/download/) official binary
* **Nim**: uses the [nim](https://nim-lang.org/install.html) official binary

#### JSON object keys

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
`formatters.json` configuration. `formatters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/formatters/formatters.json).
To configure new linters you can create a new `formatters.json` file in the default configuration path of *ecode*.

#### `formatters.json` format

```json
[
  {
    "file_patterns": ["%.js$", "%.ts$"],
    "command": "prettier $FILENAME"
  }
]
```

#### Currently supported formatters and languages supported

* **JavaScript and TypeScript**: uses [prettier](https://prettier.io) formatter
* **JSON**: uses [jq](https://stedolan.github.io/jq/) formatter
* **cpp**: uses [clang-format](https://clang.llvm.org/docs/ClangFormat.html) formatter
* **Python**: uses [black](https://github.com/psf/black) formatter
* **Kotlin**: uses [ktlint](https://ktlint.github.io/) formatter

#### JSON object keys

* **file_patterns**: Array of Lua Patterns representing the file extensions that must use the formatter
* **command**: The command to execute to run the formatter. $FILENAME represents the file path
* **type**: Indicates the mode that which the formatter outputs the results. Supported two possible options: "inplace" (file is replaced with the formatted version) and "output" (newly formatted file is the stdout of the program, default option)

#### Plugins configuration files location

*ecode* respects the standard configuration paths on each OS:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/plugins`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/plugins`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\ecode\plugins`

## Current Limitations

* UTF-8 files only support (with BOM included) \*1
* No font sub-pixel hinting \*2 \*3
* No BiDi support \*2
* No ligatures support \*4
* No VIM-mode \*5
* English only (internationalization pending). It should be implemented soon.
* Limited Unicode support. No [text-shaping](https://harfbuzz.github.io/why-do-i-need-a-shaping-engine.html), and no support or at least limited for non-romance languages (Arabic, Chinese, Korean, Hebrew, Hindi, Japanese, etc). Emojis are supported. \*2 \*6

_\*1_ I don't see the point of supporting more encodings for the moment. UTF8 is kind of the defacto industry standard.

_\*2_ Current eepp feature limitations.

_\*3_ I'm not a fan of sub-pixel hinting. But I'm more than willing to implement it, I'm not very versed in the matter, so any help will be appreciated.

_\*4_ I don't really like ligatures. I'm open to PRs implementing them.

_\*5_ I'm not a VIM user, si I'm not qualified to implement the VIM mode. PRs are welcome to support this.

_\*6_ Better Unicode support will come with time, but with no rush for the moment. eepp architecture is ready to add HarfBuzz support.

## Collaborate

The author is more than open to collaborations. Any person interested in the project is invited to
participate. Many features are still pending, and the project will grow much more over time. Please,
collaborate. =)

## Author comments

This editor has a deeply rooted inspiration from the lite, lite-xl, and sublime_text editors. It also
takes some inspiration from QtCreator (the current IDE used to develop eepp and ecode).
Several features were developed based on the lite/lite-xl implementations. Some features can be ported
directly from lite: color-schemes and syntax-highlighting patterns (eepp implementation expands original
lite implementation to add many more features).

*ecode* it's being used almost exclusively in Linux, it's not well tested in macOS and Windows OS.
If you find any issues with the editor please report it [here](https://github.com/SpartanJ/ecode/issues).

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
