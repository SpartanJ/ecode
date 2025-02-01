## Linter

Linter support is provided by executing already stablished linters from each language.
*ecode* provides support for several languages by default and can be extended easily by expanding the
`linters.json` configuration. `linters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/linters.json).
To configure new linters you can create a new `linters.json` file in the [default configuration path](#plugins-configuration-files-location) of *ecode*.

### `linters.json` format

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

### Currently supported linters

Please check the [language support table](#language-support-table)

### Linter config object keys

* **delay_time**: Delay to run the linter after editing a document
* **enable_error_lens**: Enables error lens (prints the message inline)
* **enable_lsp_diagnostics**: Boolean that enable/disable LSP diagnostics as part of the linting. Enabled by default.
* **disable_lsp_languages**: Array of LSP languages disabled for LSP diagnostics. For example: `"disable_lsp_languages": ["lua", "python"]`, disables lua and python.
* **disable_languages**: Array of linters disabled from external linter application diagnostics. For example: `"disable_languages": ["lua", "python"]`, disables luacheck and ruff respectively.
* **goto_ignore_warnings**: Defines the behavior of the "linter-go-to-next-error" and "linter-go-to-previous-error" keybindings. If ignore warnings is true it will jump only between errors.

### Linter JSON object keys

* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the linter
* **warning_pattern**: [Lua Pattern](https://www.lua.org/manual/5.4/manual.html#6.4.1) to be parsed from the executable stdout
* **warning_pattern_order**: The order where the line, column, error/warning/notice message, and the type of the message (warning, error, notice, info) are read. The pattern must have at least 3 groups (line, message, and type). The error type is auto-detected from its name.
* **command**: The command to execute to run the linter. $FILENAME represents the file path.
* **url** (optional): The web page URL of the linter
* **expected_exitcodes**: Array of integer numbers accepted as parseable exit codes (optional)
* **no_errors_exit_code**: Integer number representing the exit code that means that no errors were found (optional).
* **deduplicate**: In case the linter outputs duplicated errors, this boolean will ignore duplicated errors (optional, boolean true/false)
* **use_tmp_folder**: Temporal files (files representing the current status of the modified file) will be written in the default temporal folder of the operating system, otherwise it will be written in the same folder path of the modified file (optional, boolean true/false).
