## Custom languages support

Custom languages support can be added in the languages directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/languages`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/languages`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\languages`

ecode will read each file located at that directory with `json` extension. Each file can contain one or several language definitions.

*   **Single Language:** If the root element of the JSON file is an object, it defines a single language.
*   **Multiple Languages / Sub-Grammars:** If the root element is an array, it can define multiple independent languages *or* a main language along with **sub-language definitions** used for nesting within the main language (see Nested Syntaxes below). Each object in the array must be a complete language definition with at least a unique `"name"`.

Language definitions can override any currently supported definition. ecode will prioritize user defined definitions. Sub-language definitions used only for nesting might not need fields like `"files"` or `"headers"` if they aren't intended to be selectable top-level languages.

### Language definition format

```json
{
	"name": "language_name",            // (Required) The display name of the language. Must be unique, especially if referenced by other definitions for nesting.
	"files": [                          // (Required if `visible` is `true`) An array of Lua patterns matching filenames for this language.
		"%.ext$",                       // Example: Matches files ending in .ext
		"^Makefile$"                    // Example: Matches the exact filename Makefile
	],
	"comment": "//",                    // (Optional) Sets the single-line comment string used for auto-comment functionality.
	"patterns": [                       // (Required) An array defining syntax highlighting rules.
		// Rule using Lua patterns:
		{ "pattern": "lua_pattern", "type": "type_name" },
		// Rule using Lua patterns with capture groups mapping to different types:
		{ "pattern": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },
		// Rule defining a multi-line block using Lua patterns (start, end, escape character):
		{ "pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], "type": "type_name" }, // This rule highlights the entire block, including delimiters, with the specified `type_name`.
		// Rule using Perl-compatible regular expressions (PCRE):
		{ "regex": "perl_regex", "type": "type_name" },
		// Rule using PCRE with capture groups mapping to different types:
		{ "regex": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },
		// Rule defining a multi-line block using PCRE (start, end, escape character):
		{ "regex": ["regex_start", "regex_end", "escape_character"], "type": "type_name" }, // Similar to the Lua pattern block, highlights the entire block with `type_name`.
		// Rule using a custom parser implemented in native code for performance (e.g., number parsing):
		{ "parser": "custom_parser_name", "type": "type_name" } // Currently available: "cpp_number_parser", "c_number_parser", "js_number_parser", "common_number_parser" (matches decimal and hexa), "common_number_parser_o" (matches the same as "common_number_parser" plus octal numbers), "common_number_parser_ob" (matches the same as "common_number_parser_o" plus binary numbers)

		// Rule assigning the "symbol" type:
		{ "pattern": "[%a_][%w_]*", "type": "symbol" },
		// When this pattern matches text (e.g., the word "if"), instead of directly applying a "symbol" style,
		// ecode performs a lookup. It takes the matched text ("if") and searches for it within the language's "symbols" definition.
		// If "if" is found in "symbols" (e.g., { "if": "keyword" }), the type specified there ("keyword") is applied.
		// If the matched text is not found in "symbols", it typically defaults to the "normal" type (or the editor's default).
		// This allows generic patterns to capture potential keywords, literals, etc., which are then specifically typed via the "symbols" map.

		// Rule using "symbol" within capture groups:
		{ "pattern": "(%s%-%a[%w_%-]*%s+)(%a[%a%-_:=]+)", "type": [ "normal", "function", "symbol" ] },
		// Here, the pattern has three capture groups.
		//   - The first capture (whitespace, hyphen, word, whitespace) is typed as "normal".
		//   - The second capture (word) is typed as "function".
		//   - The third capture (word with extra allowed chars) is typed as "symbol".
		// Similar to the above, when the third group matches text (e.g., "true"), ecode looks up "true" in the "symbols" definition.
		// If { "true": "literal" } exists, the matched text "true" will be highlighted as "literal". Otherwise, it defaults to "normal".

		// --- NESTED SYNTAX RULE ---
		// Rule defining a multi-line block that switches to a DIFFERENT language syntax inside:
		{
			"pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], // Can also use "regex"
			"syntax": "NestedLanguageName",                                          // (Optional) The 'name' of another language definition to use for highlighting *within* this block.
			"type": "type_name" // OR ["type_for_start_capture1", "type_for_start_capture2", ...] // (Optional) Defines the type(s) for the text matched by the START and END patterns themselves (using capture groups if needed). If omitted, delimiters usually get 'normal' type.
		},
		// How nesting works:
		// 1. The `pattern` (or `regex`) defines the start and end delimiters of the block.
		// 2. The `syntax` key specifies the `name` of another language definition (which must be loaded, often defined in the same JSON file using an array).
		// 3. The text *between* the start and end delimiters will be highlighted using the rules defined in the "NestedLanguageName" language definition.
		// 4. The `type` key here applies ONLY to the text matched by the start and end patterns themselves. If the start/end patterns have capture groups, you can provide an array of types matching those captures.
		// 5. Nesting can occur up to 4 levels deep (e.g., Language A contains Language B, which contains Language C, etc.).
		// Use Case: Essential for languages embedding other languages, like HTML containing CSS and JavaScript.

		// Example of a nested syntax rule (C++ raw string containing XML):
		{
			"pattern": [ "R%\"(xml)%(", "%)(xml)%\"" ], // Start: R"(xml)(, End: )(xml)"
			"syntax": "XML",                           // Use the "XML" language definition inside.
			"type": [ "string", "keyword2", "string", "keyword2" ] // Types for captures in start/end: "R\"(" + "xml" + ")(" and ")(" + "xml" + ")\"". Needs adjustment based on exact captures. Assumes captures are (xml) in start and (xml) in end. Often, the delimiters are just styled as 'string' or 'keyword2'. Example simplification: "type": "string" might apply to the whole delimiter match if no captures are typed.
		},
	],
	"symbols": [                        // (Optional) An array defining specific types for exact words, primarily used in conjunction with patterns having `type: "symbol"`.
		// Structure: An array where each element is an object containing exactly one key-value pair.
		//   - The key is the literal word (symbol) to match.
		//   - The value is the `type_name` to apply when that word is matched via a `type: "symbol"` pattern rule.

		// How it works:
		// When a pattern rule results in a `type: "symbol"` match (either for the whole pattern or a capture group),
		// the actual text matched by that pattern/group is looked up within this `symbols` array.
		// The editor iterates through the array, checking if the key of any object matches the text.
		// If a match is found (e.g., the text is "if" and an object `{ "if": "keyword" }` exists),
		// the corresponding value ("keyword") is used for highlighting.
		// If the matched text is not found as a key in any object within this array, the highlighting typically falls back to the "normal" type.
		// This mechanism is essential for highlighting keywords, built-in constants/literals, and other reserved words
		// that might otherwise be matched by more general patterns (like a pattern for all words).

		// Example:
		{ "if": "keyword" },            // If a `type: "symbol"` pattern matches "if", it will be highlighted as "keyword".
		{ "else": "keyword" },
		{ "true": "literal" },          // If a `type: "symbol"` pattern matches "true", it will be highlighted as "literal".
		{ "false": "literal" },
		{ "MyClass": "keyword2" },      // If a `type: "symbol"` pattern matches "MyClass", it will be highlighted as "keyword2".
		{ "begin": "keyword" },
		{ "end": "keyword" }
		// ... add other specific words and their types as needed ...
	],
	"headers": [                        // (Optional) Array of Lua Patterns to identify file type by reading the first few lines (header).
		"^#!.*[ /]bash"                 // Example: Identifies bash scripts like '#!/bin/bash'
	],
	"visible": true,                    // (Optional) If true (default), language appears in main selection menus. Set to false for internal/helper languages.
	"case_insensitive": false,          // (Optional) If true, pattern matching ignores case. Default is false (case-sensitive).
	"auto_close_xml_tag": false,        // (Optional) If true, enables auto-closing of XML/HTML tags (e.g., typing `<div>` automatically adds `</div>`). Default is false.
	"extension_priority": false,        // (Optional) If true, this language definition takes priority if multiple languages define the same file extension. Default is false.
	"lsp_name": "language_server_name", // (Optional) Specifies the name recognized by Language Servers (LSP). Defaults to the 'name' field in lowercase if omitted.

	"fold_range_type": "braces",        // (Optional) Specifies the strategy used to detect foldable code regions. Default behavior if omitted might be no folding or a global default. Possible values:
	                                    //   - "braces": Folding is determined by matching pairs of characters (defined in `fold_braces`). Suitable for languages like C, C++, Java, JavaScript, JSON.
	                                    //   - "indentation": Folding is determined by changes in indentation level. Suitable for languages like Python, YAML, Nim.
	                                    //   - "tag": Folding is based on matching HTML/XML tags (e.g., `<div>...</div>`). Suitable for HTML, XML, SVG.
	                                    //   - "markdown": Folding is based on Markdown header levels (e.g., `## Section Title`). Suitable for Markdown.
	"fold_braces": [                    // (Required *only if* `fold_range_type` is "braces") Defines the pairs of characters used for brace-based folding.
	                                    // This is an array of objects, where each object specifies a starting and ending character pair.
		{ "start": "{", "end": "}" },   // Example: Standard curly braces
		{ "start": "[", "end": "]" },   // Example: Square brackets
		{ "start": "(", "end": ")" }    // Example: Parentheses
	]
}
```
### Nested Syntaxes (Sub-Grammars)

ecode supports **nested syntaxes**, allowing a block of code within one language to be highlighted according to the rules of another language. This is crucial for accurately representing modern languages that often embed other languages or domain-specific languages.

**How it works:**

1.  **Define Sub-Languages:** Define the syntax for the language to be embedded (e.g., "CSS", "JavaScript", "XML", "SQL") as a separate language definition. Often, these are defined within the *same JSON file* as the main language, using a JSON array as the root element (see [Custom languages support](#custom-languages-support)). The sub-language definition needs a unique `"name"`.
2.  **Reference in Patterns:** In the main language's `"patterns"`, use a multi-line block rule (`pattern` or `regex` array). Add the `"syntax"` key to this rule, setting its value to the `"name"` of the sub-language definition you want to use inside the block.
3.  **Highlighting:** When ecode encounters this block, it applies the highlighting rules from the specified sub-language to the content *between* the start and end delimiters. The delimiters themselves are styled according to the `type` specified in the *outer* rule.

**Example Use Cases:**

*   HTML files containing `<style>` blocks (CSS) and `<script>` blocks (JavaScript).
*   Markdown files with fenced code blocks (e.g., ```python ... ```).
*   Templating languages embedding HTML and code.

**Nesting Depth:** Syntax nesting is supported up to 4 levels deep.

See the description of the `syntax` key under the [`patterns`](#language-definition-format) section for the exact rule format.

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
