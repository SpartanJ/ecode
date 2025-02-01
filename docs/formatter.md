## Auto Formatter

The formatter plugin works exactly like the linter plugin, but it will execute tools that auto-format code.
*ecode* provides support for several languages by default with can be extended easily by expanding the
`formatters.json` configuration. `formatters.json` default configuration can be obtained from [here](https://raw.githubusercontent.com/SpartanJ/eepp/develop/bin/assets/plugins/formatters.json).
It also supports some formatters natively, this means that the formatter comes with ecode without requiring any external dependency.
And also supports LSP text document formatting, meaning that if you're running an LSP that supports formatting documents, formatting will be available too.
To configure new formatters you can create a new `formatters.json` file in the [default configuration path](#plugins-configuration-files-location) of *ecode*.

### `formatters.json` format

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

### Currently supported formatters

Please check the [language support table](#language-support-table)

### Formatter config object keys

* **auto_format_on_save**: Indicates if after saving the file it should be auto-formatted

### Formatter keybindings object keys

* **format-doc**: Keybinding to format the doc with the configured language formatter

### Formatter JSON object keys

* **file_patterns**: Array of [Lua Patterns](https://www.lua.org/manual/5.4/manual.html#6.4.1) representing the file extensions that must use the formatter
* **command**: The command to execute to run the formatter. $FILENAME represents the file path
* **type**: Indicates the mode that which the formatter outputs the results. Supported two possible options: "inplace" (file is replaced with the formatted version), "output" (newly formatted file is the stdout of the program, default option) or "native" (uses the formatter provided by ecode)
* **url** (optional): The web page URL of the formatter
