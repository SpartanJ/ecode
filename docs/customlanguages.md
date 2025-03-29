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
	"files": [ "Array of file extensions supported represented as lua patterns" ],
	"comment": "Sets the comment string used for auto-comment functionality.",
	"patterns": [
		{ "pattern": "lua_pattern", "type": "type_name" },
		{ "pattern": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },
		{ "pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], "type": "type_name" }
		{ "regex": "perl_regex", "type": "type_name" },
		{ "regex": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },
		{ "regex": ["regex_start", "regex_end", "escape_character"], "type": "type_name" },
		{ "parser": "custom_parser_name", "type": "type_name" } /* ecode allows to implement custom parsers in native code for improved performance (ex: "cpp_number_parser" and "c_number_parser") */
	],
	"symbols": [ /* symbols are accesed when the type is set as "symbol" in a matched pattern */
		{ "symbol_name": "type_name" }
	],
	"headers": [
		"Optional array of Lua Patterns to identify the file type by reading the headers of the document",
		"For example a bash script can be identified with the following pattern: '^#!.*[ /]bash' that searches for thinks like '#!/bin/bash'"
	],
	"visible": true, /* sets if the language is visible as a main language in the editor, optional parameter, true by default */
	"case_insensitive": false, /* sets if the language is a case insensitive language, false by default */
	"auto_close_xml_tag": false, /* sets if the language defined supports auto close XML tags, optional parameter, false by default */
	"extension_priority": false, /* sets if any shared extension with other language should have priority over any other language, false by default */
	"lsp_name": "sets the LSP name assigned for the language, optional parameter, it will use the _name_ in lowercase if not set"
}
```

### Type Names

Type names are used to define the color of the tokenized pattern.

These are the currently supported type names:

* *normal*: Used for non-highlighted words. This is the default color.
* *comment*: Code comments color.
* *keyword*: Usually used for language reserved words (if, else, class, struct, then, enum, etc).
* *keyword2*: Usually used for type names.
* *keyword3*: Currently used for coloring parameters but can be used for anything.
* *number*: Number colors
* *literal*: Word literals colors (usually things like NULL, true, false, undefined, etc). Can be used also for any particular reserved symbol.
* *string*: String colors.
* *operator*: Operators colors (+, -, =, <, >, etc).
* *function*: Function name color.
* *link*: Links color.
* *link_hover*: Hovered Links color.

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
  "comment": "#",
  "files": [
    "%.sh$",
    "%.bash$",
    "^%.bashrc$",
    "^%.bash_profile$",
    "^%.profile$",
    "%.zsh$",
    "%.fish$",
    "^PKGBUILD$",
    "%.winlib$"
  ],
  "headers": [
    "^#!.*[ /]bash",
    "^#!.*[ /]sh"
  ],
  "lsp_name": "shellscript",
  "name": "Shell script",
  "patterns": [
    { "pattern": "$[%a_@*#][%w_]*", "type": "keyword2" },
    { "pattern": "#.*\n", "type": "comment" },
    { "pattern": [ "<<%-?%s*EOF", "EOF" ], "type": "string" },
    { "pattern": [ "\"", "\"", "\\" ], "type": "string" },
    { "pattern": [ "'", "'", "\\" ], "type": "string" },
    { "pattern": [ "`", "`", "\\" ], "type": "string" },
    { "pattern": "%f[%w_%.%/]%d[%d%.]*%f[^%w_%.]", "type": "number" },
    { "pattern": "[!<>|&%[%]:=*]", "type": "operator" },
    { "pattern": "%f[%S][%+%-][%w%-_:]+", "type": "function" },
    { "pattern": "%f[%S][%+%-][%w%-_]+%f[=]", "type": "function" },
    { "pattern": "(%s%-%a[%w_%-]*%s+)(%d[%d%.]+)", "type": [ "normal", "function", "number" ] },
    { "pattern": "(%s%-%a[%w_%-]*%s+)(%a[%a%-_:=]+)", "type": [ "normal", "function", "symbol" ] },
    { "pattern": "[_%a][%w_]+%f[%+=]", "type": "keyword2" },
    { "pattern": "${.-}", "type": "keyword2" },
    { "pattern": "$[%d$%a_@*][%w_]*", "type": "keyword2" },
    { "pattern": "[%a_%-][%w_%-]*[%s]*%f[(]", "type": "function" },
    { "pattern": "[%a_][%w_]*", "type": "symbol" }
  ],
  "symbols": [
    { "in": "keyword" },
    { "then": "keyword" },
    { "exit": "keyword" },
    { "alias": "keyword" },
    { "continue": "keyword" },
    { "getopts": "keyword" },
    { "set": "keyword" },
    { "return": "keyword" },
    { "unalias": "keyword" },
    { "pwd": "keyword" },
    { "fi": "keyword" },
    { "printf": "keyword" },
    { "unset": "keyword" },
    { "cd": "keyword" },
    { "echo": "keyword" },
    { "false": "literal" },
    { "help": "keyword" },
    { "for": "keyword" },
    { "test": "keyword" },
    { "mapfile": "keyword" },
    { "shift": "keyword" },
    { "while": "keyword" },
    { "readarray": "keyword" },
    { "eval": "keyword" },
    { "select": "keyword" },
    { "elif": "keyword" },
    { "function": "keyword" },
    { "true": "literal" },
    { "else": "keyword" },
    { "exec": "keyword" },
    { "enable": "keyword" },
    { "local": "keyword" },
    { "jobs": "keyword" },
    { "source": "keyword" },
    { "break": "keyword" },
    { "declare": "keyword" },
    { "history": "keyword" },
    { "case": "keyword" },
    { "until": "keyword" },
    { "if": "keyword" },
    { "esac": "keyword" },
    { "hash": "keyword" },
    { "kill": "keyword" },
    { "time": "keyword" },
    { "let": "keyword" },
    { "export": "keyword" },
    { "do": "keyword" },
    { "done": "keyword" },
    { "read": "keyword" },
    { "type": "keyword" }
  ]
}
```

For more complex syntax definitions please see the definition of all the native languages supported
by ecode [here](https://github.com/SpartanJ/eepp/tree/develop/src/eepp/ui/doc/languages) and
[here](https://github.com/SpartanJ/eepp/tree/develop/src/modules/languages-syntax-highlighting/src/eepp/ui/doc/languages).
