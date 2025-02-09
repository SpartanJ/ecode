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
		{ "regex": "perl_regex", "type": "type_name" },
		{ "regex": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": { "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" } },
		{ "regex": ["regex_start", "regex_end", "escape_character"], "type": "type_name" }
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
by ecode [here](https://github.com/SpartanJ/eepp/tree/develop/src/eepp/ui/doc/languages) and
[here](https://github.com/SpartanJ/eepp/tree/develop/src/modules/languages-syntax-highlighting/src/eepp/ui/doc/languages).
