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
	"name": "language_name",            // (Required) The display name of the language. Must be unique, especially if referenced by other definitions for nesting or includes.
	"files": [                          // (Required if `visible` is `true`) An array of Lua patterns matching filenames for this language.
		"%.ext$",                       // Example: Matches files ending in .ext
		"^Makefile$"                    // Example: Matches the exact filename Makefile
	],
	"comment": "//",                    // (Optional) Sets the single-line comment string used for auto-comment functionality.
	"patterns": [                       // (Required) An array defining syntax highlighting rules. See "Pattern Rule Types" below for details.
		// ... pattern rules defined here ...
	],
	"repository": {                     // (Optional) A collection of named pattern sets for reuse within this language definition.
	                                    // Keys are repository item names (e.g., "comments", "strings", "expressions").
	                                    // Values are arrays of pattern rules, following the same format as the main "patterns" array.
	                                    // These items can be referenced in any "patterns" array using an "include" rule (e.g., { "include": "#comments" }).
		"my_reusable_rules": [
			{ "pattern": "foo", "type": "keyword" },
			{ "pattern": ["bar_start", "bar_end"], "type": "string" }
		]
	},
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

#### Pattern Rule Types

The `"patterns"` array is the core of syntax highlighting. It contains an ordered list of rules that ecode attempts to match against the text. Each rule is an object. Here are the types of rules you can define:

```json
"patterns": [
	// --- Simple Rules ---
	// Rule using Lua patterns:
	{ "pattern": "lua_pattern", "type": "type_name" },
	// Rule using Lua patterns with capture groups mapping to different types:
	{ "pattern": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },
	// Rule using Perl-compatible regular expressions (PCRE):
	{ "regex": "perl_regex", "type": "type_name" },
	// Rule using PCRE with capture groups mapping to different types:
	{ "regex": "no_capture(pattern_capture_1)(pattern_capture_2)", "type": [ "no_capture_type_name", "capture_1_type_name", "capture_2_type_name" ] },

	// --- Multi-line Block Rules (Lua Patterns or PCRE) ---
	// Defines a block spanning multiple lines using start/end patterns and an optional escape character.
	// These rules can use either "pattern": ["start", "end", "escape?"] for Lua patterns
	// or "regex": ["start_regex", "end_regex", "escape_char?"] for PCRE.
	// They support the same "type" and "end_type" combinations for styling delimiters as detailed previously.
	//
	// Basic usage (same type for start and end delimiters):
	{ "pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], "type": "type_name" },
	// Using different types for start and end delimiters:
	{ "regex": ["regex_start", "regex_end"], "type": "start_type_name", "end_type": "end_type_name" },
	// Using capture groups with different types for start and end delimiters:
	{ "pattern": ["start_nocap(scap1)", "end_nocap(ecap1)(ecap2)", "escape"], "type": ["start_nocap_type", "start_cap1_type"], "end_type": ["end_nocap_type", "end_cap1_type", "end_cap2_type"] },

	// --- Contextual Patterns within Blocks (Inner Patterns) ---
	// Multi-line block rules can define their own "patterns" array to apply specific rules
	// to the content *between* their start and end delimiters. This allows for more granular
	// highlighting within a block without needing to define a full sub-language via the "syntax" key.
	{
		"regex": ["<section>", "</section>"], // Defines the block
		"type": "keyword",                     // Type for "<section>" delimiter
		"end_type": "keyword",                 // Type for "</section>" delimiter
		"patterns": [                          // (Optional) Inner patterns for content *inside* <section>...</section>
			{ "regex": "highlight_this_inside", "type": "function" },
			{ "include": "#common_section_rules" } // Can also include repository items
			// These inner patterns are matched only against the text between "<section>" and "</section>".
			// Inner patterns can themselves be block rules with their own inner patterns, allowing for nested contextual highlighting.
		]
	},
	// Note: If a block rule includes both inner "patterns" and a "syntax" key (for nested languages),
	// the "syntax" key typically takes precedence, causing the content to be highlighted by the
	// specified sub-language. Inner "patterns" are primarily for applying rules from the
	// *current* language's context or ad-hoc rules specifically to the content of this block.

	// --- Custom Parser Rule ---
	// Rule using a custom parser implemented in native code (as previously described):
	{ "parser": "custom_parser_name", "type": "type_name" },

	// --- Symbol Lookup Rule ---
	// Rule assigning the "symbol" type, for lookup in the language's "symbols" definition (as previously described):
	{ "pattern": "[%a_][%w_]*", "type": "symbol" },
	// Rule using "symbol" within capture groups (as previously described):
	{ "pattern": "(%s%-%a[%w_%-]*%s+)(%a[%a%-_:=]+)", "type": [ "normal", "function", "symbol" ] },

	// --- Include Rules ---
	// Allows reusing sets of patterns defined elsewhere in the grammar.
	// This helps in organizing complex grammars and avoiding repetition.
	{
		"include": "#repository_item_name" // Includes rules from the 'repository_item_name' entry
		                                   // in the top-level "repository" object of this language definition.
		                                   // The '#' prefix is mandatory for repository items.
	},
	{
		"include": "$self"                 // Includes all rules from the main top-level "patterns" array
		                                   // of the *current* language definition. This is useful for
		                                   // recursive definitions, such as nested expressions or blocks.
	},
	// Example using "include" with a "repository":
	// "repository": {
	//   "comments_and_strings": [
	//     { "pattern": "//.*", "type": "comment" },
	//     { "pattern": ["\"", "\"", "\\\\"], "type": "string" }
	//   ]
	// },
	// "patterns": [
	//   { "include": "#comments_and_strings" },
	//   // ... other rules ...
	// ]

	// --- NESTED SYNTAX RULE ---
	// Defines a multi-line block that switches to a DIFFERENT language syntax inside.
	// Uses the same multi-line pattern/regex format and delimiter styling options ("type", "end_type").
	{
		"pattern": ["lua_pattern_start", "lua_pattern_end", "escape_character"], // Can also use "regex"
		"syntax": "NestedLanguageName",                                          // (Required for nesting) The 'name' of another language definition.
		"type": "start_delimiter_type",                                          // (Optional) Type(s) for the START delimiter.
		"end_type": "end_delimiter_type"                                         // (Optional) Type(s) for the END delimiter.
	}
	// This is distinct from "Contextual Patterns within Blocks (Inner Patterns)".
	// The "syntax" key switches highlighting to a completely different, pre-defined language
	// for the content within the delimiters. Inner "patterns", on the other hand, apply a
	// specific set of rules from the *current* language's context or ad-hoc rules to the block's content.
]
```

### Nested Syntaxes (Sub-Grammars)

ecode supports **nested syntaxes**, allowing a block of code within one language to be highlighted according to the rules of another language. This is crucial for accurately representing modern languages that often embed other languages or domain-specific languages.

**How it works:**

1.  **Define Sub-Languages:** Define the syntax for the language to be embedded (e.g., "CSS", "JavaScript", "XML", "SQL") as a separate language definition. Often, these are defined within the *same JSON file* as the main language, using a JSON array as the root element (see [Custom languages support](#custom-languages-support)). The sub-language definition needs a unique `"name"`.
2.  **Reference in Patterns:** In the main language's `"patterns"`, use a multi-line block rule (`pattern` or `regex` array). Add the `"syntax"` key to this rule, setting its value to the `"name"` of the sub-language definition you want to use inside the block.
3.  **Highlighting:** When ecode encounters this block, it applies the highlighting rules from the specified sub-language to the content *between* the start and end delimiters. The delimiters themselves are styled according to the `type` (and `end_type`) specified in the *outer* rule.

**Contrast with Inner Patterns:**
While the `syntax` key is used to embed an *entirely different language* within a block, multi-line block rules can also contain their own `patterns` array (see "Contextual Patterns within Blocks" under [Pattern Rule Types](#pattern-rule-types)). This inner `patterns` array allows for defining specific highlighting rules for the content *within* the block using rules from the current language's context or ad-hoc rules. This is useful when a full language switch isn't necessary but more granular control over the block's content highlighting is desired (e.g., highlighting specific keywords differently only within a certain type of block in the parent language).

**Example Use Cases for `syntax` key:**

*   HTML files containing `<style>` blocks (CSS) and `<script>` blocks (JavaScript).
*   Markdown files with fenced code blocks (e.g., ```python ... ```).
*   Templating languages embedding HTML and code.

**Nesting Depth:** Syntax nesting (using the `syntax` key) is supported up to 8 levels deep. The nesting capabilities of inner `patterns` within block rules depend on the parser's implementation but also allow for complex hierarchical structures.

See the description of the `syntax` key and inner `patterns` under the [`patterns`](#language-definition-format) section for the exact rule format.

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

ecode uses the same format for language definition as [lite](https://github.com/rxi/lite) and [lite-xl](https://github.com/lite-xl/lite-xl) editors for its original features. The newly added features like `repository`, `include`, and inner `patterns` for block rules are inspired by TextMate grammars, extending ecode's capabilities beyond the traditional lite/lite-xl format while maintaining compatibility with the core structure.
This makes it easier to add new languages to ecode. There's also a helper tool that can be download from
ecode repository located [here](https://github.com/SpartanJ/ecode/tree/develop/tools/data-migration/lite/language)
that allows to directly export a lite language definition to the JSON file format used in ecode.

The advanced features (`repository`, `include`, and inner `patterns` within block rules) detailed in this documentation allow for the creation of complex and accurate syntax highlighting in ecode's native format.

#### Using TextMate Grammars (`.tmLanguage.json`)

In addition to its native format, ecode offers support for directly loading TextMate grammar files (typically ending with `.tmLanguage.json`). This can be a convenient way to leverage existing TextMate grammars.

*   **Direct Loading:**
    *   To use a TextMate grammar, simply place the `.tmLanguage.json` file into your custom languages directory (e.g., `~/.config/ecode/languages`). ecode will attempt to load it.

*   **`fileTypes` Array Requirement:**
    *   For ecode to correctly associate the TextMate grammar with specific file extensions, the grammar file **must** contain a `fileTypes` (or `filetypes`) array at its root level. This array lists the file extensions (without the leading dot) that the grammar should handle.
    *   **Example:**
        ```json
        // Inside your .tmLanguage.json file
        {
          "name": "MyTextMateLanguage",
          "scopeName": "source.mylang",
          "fileTypes": [ // Or "filetypes"
            "mylang_ext1",
            "mylang_ext2"
          ],
          // ... rest of the TextMate grammar ...
        }
        ```
        Without this `fileTypes` array, ecode will not know which files to apply the grammar to.

*   **Limitations:**
    *   **Sub-syntaxes / Embedded Grammars:** A key limitation when directly loading TextMate grammars is that **sub-syntaxes or embedded languages that are defined by referencing external grammar scopes (e.g., `include: 'source.js'` where `source.js` is expected to be another grammar file) are not currently supported.** ecode's native mechanism for nested syntaxes (using the `"syntax"` key to refer to a language `"name"` defined within the same JSON file or another loaded ecode definition) operates differently. Therefore, complex embeddings common in TextMate grammars might not render correctly when loaded directly.

*   **Conversion to ecode's Native Format:**
    *   To overcome limitations or to fully integrate a TextMate grammar into ecode's feature set (including potentially adapting its sub-syntax definitions), you can convert it to ecode's native JSON format.
    *   First, ensure the TextMate grammar file (e.g., `MyLanguage.tmLanguage.json`) is in the languages directory so ecode can load it. Make sure it includes the `fileTypes` array.
    *   Then, use the `--export-lang` CLI argument. The `name` you use to refer to the language should match the `name` field within the TextMate grammar (or how ecode lists it after loading).
        ```bash
        ecode --export-lang=MyTextMateLanguage --export-lang-path=./my_language_ecode_format.json
        ```
    *   This command will process the loaded TextMate grammar and output its structure in ecode's native JSON format to `my_language_ecode_format.json`. You can then further edit this file, adapt its structure (especially for sub-syntaxes if needed), and use it as a standard ecode custom language definition.

This approach allows users to leverage the vast library of existing TextMate grammars, either directly with some limitations, or by converting them into ecode's more feature-rich native format for deeper integration.

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
