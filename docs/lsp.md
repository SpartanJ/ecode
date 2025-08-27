## LSP Client

LSP support is provided by executing already stablished LSP from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`lspclient.json` configuration. `lspclient.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/lspclient.json).
To configure new LSPs you can create a new `lspclient.json` file in the [default configuration path](../README.md##plugins-configuration-files-location) of *ecode*.

Important note: LSP servers can be very resource intensive and might not be always the best option for simple projects.

Implementation details: LSP servers are only loaded when needed, no process will be opened until a
supported file is opened in the project.

### `lspclient.json` format

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

### Currently supported LSPs

Please check the [language support table](#language-support-table)

### LSP Client config object keys

* **hover_delay**: The time the editor must wait to show symbol information when hovering any piece of code.
* **server_close_after_idle_time**: The time the LSP Server will keep alive after all documents that consumes that LSP Server were closed. LSP Servers are spawned and killed on demand.
* **semantic_highlighting**: Enable/Disable semantic highlighting (disabled by default, boolean)
* **disable_semantic_highlighting_lang**: An array of languages where semantic highlighting should be disabled
* **silent**: Enable/Disable non-critical LSP logs
* **trim_logs**: If logs are enabled and trim_logs is enabled it will trim the line log size at maximum 1 KiB per line (useful for debugging)
* **breadcrumb_navigation**: Enable/Disable the breadcrumb (enabled by default)
* **breadcrumb_height**: Defines the height of the breadcrumb in [CSS length](https://eepp.ensoft.dev/page_cssspecification.html#length-data-type)

### LSP Client keybindings object keys

* **lsp-symbol-info**: Keybinding to request symbol information
* **lsp-go-to-definition**: Keybinding to "Go to Definition"
* **lsp-go-to-declaration**: Keybinding to "Go to Declaration"
* **lsp-go-to-implementation**: Keybinding to "Go to Implementation"
* **lsp-go-to-type-definition**: Keybinding to "Go to Type Definition"
* **lsp-symbol-references**: Keybinding to "Find References to Symbol Under Cursor"
* **lsp-symbol-code-action**: Keybinding to "Code Action"
* **lsp-switch-header-source**: Keybinding to "Switch Header/Source" (only available for C and C++)

### LSP Client JSON object keys

* **language**: The LSP language identifier. Some identifiers can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocumentItem)
* **name**: The name of the language server
* **url** (optional): The web page URL of the language server
* **use** (optional): A server can be inherit the configuration from other server. This must be the name of the server configuration that inherits (useful for LSPs that support several languages like clang and typescript-language-server).
* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the LSP client
* **command**: The command to execute to run the LSP. It's possible to override the default LSP command by declaring the server in the `lspclient.json` config. It's also possible to specify a different command for each platform, given that it might change in some occasions per-platform. In that case an object should be used, with each key being a platform, and there's also a wildcard platform "other" to specify any other platform that does not match the platform definition. For example, `sourcekit-lsp` uses: `"command": {"macos": "xcrun sourcekit-lsp","other": "sourcekit-lsp"}`
* **command_parameters** (optional): The command parameters. Parameters can be set from the **command** also, unless the command needs to run a binary with name with spaces. Also command_parameters can be used to add more parameters to the original command. The lsp configuration can be overridden from the lspclient.json in the user configuration. For example: a user trying to append some command line arguments to clang would need to do something like: `{"name": "clangd","command_parameters": "--background-index-priority=background --malloc-trim"}`
* **rootIndicationFileNames** (optional): Some languages need to indicate the project root path to the LSP work correctly. This is an array of files that might indicate where the root path is. Usually this is resolver by the LSP itself, but it might help in some situations.
* **initializationOptions** (optional): These are custom initialization options that can be passed to the LSP. Usually not required, but it will allow the user to configure the LSP. More information can be found [here](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#initialize).
* **host** (optional): It's possible to connect to LSP servers via TCP. This is the host location of the LSP. When using TCP connections *command* can be empty or can be used to initialize the LSP server. And then use the LSP through a TCP connection.
* **port** (optional): It's possible to connect to LSP servers via TCP. This is the post location of the LSP.
* **env** (optional): Array of strings with environment variables added to the process environment.
