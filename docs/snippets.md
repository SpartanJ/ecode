# User-defined snippets

ecode supports user-defined code snippets through the auto-complete plugin. Snippets are reusable
templates that can insert text, create editable placeholders, keep repeated values synchronized,
offer choices, and move the cursor through fields with Tab.

The file format is compatible with the core of the
[Visual Studio Code snippet format](https://code.visualstudio.com/docs/editing/userdefinedsnippets),
which is based on TextMate snippet syntax. Existing VS Code project snippet files can normally be
used without modification. The [Differences from VS Code](#differences-from-vs-code) section lists
the features that ecode does not currently implement.

## Where snippet files are loaded from

ecode loads user snippets from its configuration directory:

| Platform | User snippet directory |
| --- | --- |
| Linux | `${XDG_CONFIG_HOME}/ecode/snippets`, usually `~/.config/ecode/snippets` |
| macOS | `~/Library/Application Support/ecode/snippets` |
| Windows | `%APPDATA%\ecode\snippets` |

The directory is created automatically. Files directly inside it can be either:

- `<language-id>.json`, for snippets belonging to one language; or
- `*.code-snippets`, for global or explicitly scoped snippets.

For example, `cpp.json` contains C++ snippets, while `web.code-snippets` can contain snippets for
HTML, CSS, JavaScript, or multiple languages.

ecode also loads project snippets from the current workspace:

| Location | Purpose |
| --- | --- |
| `<workspace>/.vscode/*.code-snippets` | Existing VS Code-compatible project snippets |
| `<workspace>/.ecode/*.code-snippets` | Native ecode project snippets |

Project files are convenient for snippets that should be shared with the repository. User files
are better for personal snippets that should be available across projects.

Loading snippets from `.vscode` is enabled by default. To disable it, set
`config.load_vscode_snippets` to `false` in the autocomplete plugin's `autocomplete.json` file.
Snippets from `.ecode` and the user snippet directory remain enabled.

When equally good user snippets conflict, `.ecode` project snippets take precedence over
`.vscode` project snippets, which take precedence over user snippets. This priority only resolves
ties between user-defined snippets; it does not automatically place snippets above normal code
completion proposals.

## Quick start

Create `cpp.json` in the user snippet directory:

```jsonc
{
	"Indexed For Loop": {
		"prefix": ["fori", "for-index"],
		"body": [
			"for (${1:size_t} ${2:i} = 0; $2 < ${3:count}; ++$2) {",
			"\t$0",
			"}"
		],
		"description": "Insert an indexed loop"
	}
}
```

Open a C++ file, type `fori`, and select the snippet from auto-completion. You can also press the
`autocomplete-update-suggestions` shortcut, which is `Mod+Space` by default, to request suggestions
explicitly.

After insertion:

1. `${1:size_t}` is selected first.
2. Tab moves to `${2:i}`. Both `$2` occurrences remain linked while it is edited.
3. Tab moves to `${3:count}`.
4. Tab moves to `$0` and finishes the snippet session.

Shift+Tab moves to the previous placeholder while a snippet session is active. Tab and Shift+Tab
are reserved for snippet navigation only while that session is active.

## File format

Snippet files are JSON with support for C-style comments and trailing commas. The root must be an
object. Each root property defines one snippet and is used as its display name:

```jsonc
{
	// A language or project snippet
	"Print value": {
		"prefix": "print",
		"body": "printf(\"%s\\n\", ${1:value});$0",
		"description": "Print a string",
	},
}
```

### Supported properties

| Property | Type | Meaning |
| --- | --- | --- |
| `prefix` | String or array of strings | Text used to find and activate the snippet. Required. |
| `body` | String or array of strings | Inserted text. Required. Array entries are joined with newlines. |
| `description` | String | Optional description shown in auto-completion. |
| `scope` | Comma-separated string | Language identifiers for a `.code-snippets` file. |

An unscoped `.code-snippets` definition is available in every language. In a language-specific
file such as `python.json`, all definitions automatically use the language identifier from the
filename.

Scopes use ecode's LSP language identifiers. Common examples include `c`, `cpp`, `python`,
`javascript`, `typescript`, `html`, and `css`:

```jsonc
{
	"Debug value": {
		"scope": "c,cpp",
		"prefix": "debug-value",
		"body": "fprintf(stderr, \"${1:name}=%${2|d,u,f,s|}\\n\", $1);$0"
	}
}
```

Definitions with an invalid or empty `prefix`, an invalid `body`, or an invalid `scope` are
skipped without preventing valid siblings in the same file from loading. Unknown properties are
ignored for forward compatibility.

### File pattern scopes

The optional `include` and `exclude` properties accept a glob or an array of globs. They restrict a
snippet beyond its language scope:

```jsonc
{
	"Test Case": {
		"scope": "cpp",
		"prefix": "testcase",
		"include": ["*_test.cpp", "tests/**/*.cpp"],
		"exclude": "generated/**",
		"body": "TEST(${1:Suite}, ${2:Name}) {\n\t$0\n}"
	}
}
```

Filename-only patterns such as `*_test.cpp` match the filename regardless of its directory.
Patterns containing `/` match the normalized path relative to the workspace root, consistently
with ecode's other glob-based filters. Use `**/tests/**/*.cpp` instead of `tests/**/*.cpp` when the
directory may occur below any workspace subdirectory. A snippet must match at least one `include`
pattern when `include` is present, and any matching `exclude` pattern hides it. `exclude` therefore
wins when both properties match.

## Matching and insertion

Snippet prefixes participate in normal auto-completion ranking. Matching is fuzzy and can use
abbreviated input; for example, `fc` can match `for-const`. Prefixes are not restricted to normal
programming-language words, so triggers such as `for-const`, `log!`, and markup-like punctuation
can be used.

When a snippet is selected, ecode replaces the exact matched prefix instead of deleting the
previous programming-language word. Multiple snippets may intentionally share the same prefix and
remain separate entries in the completion list.

Snippets are also available when no language server is running. When an LSP server supplies
completion results, user snippets are merged with those results rather than disappearing when the
asynchronous response arrives.

## Browsing snippets in the Universal Locator

Open the Universal Locator and choose **Insert Snippet**, or enter its `sn ` provider prefix. The
provider lists snippets applicable to the current language and file. Search matches snippet names,
prefixes, and descriptions. The list also identifies whether a snippet comes from the user
directory, `.vscode`, or `.ecode`.

Selecting a result inserts it directly at the current selections without requiring or deleting a
typed prefix. Insertion uses the same variables, indentation, choices, multi-cursor behavior, and
tab-stop navigation as snippets selected from auto-completion.

## Snippet body syntax

### Tab stops

Use `$1`, `$2`, and so on to define cursor positions. Tab stops are visited in ascending numeric
order. `$0` is the final position and always comes last:

```json
"body": "${1:type} ${2:name} = ${3:value};$0"
```

Repeated occurrences of the same tab stop are linked:

```json
"body": "for (size_t ${1:i} = 0; $1 < ${2:count}; ++$1) {\n\t$0\n}"
```

Editing the selected `i` updates the other `$1` occurrences.

### Placeholders

A placeholder gives a tab stop default text:

```json
"body": "if (${1:condition}) {\n\t${2:return;}\n}$0"
```

Placeholders can be nested:

```json
"body": "${1:outer ${2:inner}}$0"
```

### Choices

A choice offers a list when its tab stop is selected:

```json
"body": "${1|public,protected,private|}:$0"
```

Escape commas and pipe characters inside an option as `\,` and `\|`. Because the snippet body is
inside JSON, the backslash itself must also be escaped in the file:

```json
"body": "${1|one,two\\, too,three\\|four|}$0"
```

### Escaping literal snippet characters

Use a backslash in snippet syntax to escape `$`, `}`, and `\`. The backslash must be escaped again
by JSON. To insert a literal `$name`, write:

```json
"body": "\\$name = ${1:value};$0"
```

## Supported variables

ecode currently defines these variables for both LSP and user snippets:

| Variable | Value |
| --- | --- |
| `TM_SELECTED_TEXT` | Selected text, or an empty string when there is no selection |
| `TM_CURRENT_LINE` | Current line without its newline |
| `TM_CURRENT_WORD` | Word at the insertion position |
| `TM_LINE_INDEX` | Zero-based line number |
| `TM_LINE_NUMBER` | One-based line number |
| `TM_FILENAME` | Current filename |
| `TM_FILENAME_BASE` | Filename without its extension |
| `TM_DIRECTORY` | Directory containing the current file |
| `TM_FILEPATH` | Full path of the current file |
| `RELATIVE_FILEPATH` | File path relative to the current workspace |
| `WORKSPACE_NAME` | Name of the current workspace folder |
| `WORKSPACE_FOLDER` | Path of the current workspace folder |
| `CLIPBOARD` | Current clipboard text |
| `CURSOR_INDEX` | Zero-based insertion cursor number |
| `CURSOR_NUMBER` | One-based insertion cursor number |
| `CURRENT_YEAR` | Four-digit year |
| `CURRENT_YEAR_SHORT` | Two-digit year |
| `CURRENT_MONTH` | Two-digit month |
| `CURRENT_MONTH_NAME` | Full localized month name |
| `CURRENT_MONTH_NAME_SHORT` | Abbreviated localized month name |
| `CURRENT_DATE` | Two-digit day of the month |
| `CURRENT_DAY_NAME` | Full localized weekday name |
| `CURRENT_DAY_NAME_SHORT` | Abbreviated localized weekday name |
| `CURRENT_HOUR` | Two-digit hour in 24-hour format |
| `CURRENT_MINUTE` | Two-digit minute |
| `CURRENT_SECOND` | Two-digit second |
| `CURRENT_MILLISECOND` | Three-digit millisecond |
| `CURRENT_SECONDS_UNIX` | Seconds since the Unix epoch |
| `CURRENT_MILLISECONDS_UNIX` | Milliseconds since the Unix epoch |
| `CURRENT_TIMEZONE_OFFSET` | Current UTC offset in `+HH:MM` or `-HH:MM` form |
| `CURRENT_TIMEZONE_NAME` | Platform-provided current time-zone name |
| `RANDOM` | Six random decimal digits |
| `RANDOM_HEX` | Six random hexadecimal digits |
| `UUID` | Random version 4 UUID |
| `LINE_COMMENT` | Current language's line-comment marker |
| `BLOCK_COMMENT_START` | Current language's opening block-comment marker |
| `BLOCK_COMMENT_END` | Current language's closing block-comment marker |

Use `$TM_FILENAME`, `${TM_FILENAME}`, or a fallback such as
`${TM_SELECTED_TEXT:fallback text}`.

An unknown variable becomes an editable placeholder containing its name. A fallback is used when
the variable is empty or cannot be resolved:

```json
"body": "${TM_SELECTED_TEXT:${1:value}}$0"
```

## Variable transforms

ecode supports variable transforms using the familiar
`${VARIABLE/regular-expression/replacement/options}` form:

```json
"body": "${TM_FILENAME/(.*)\\..+$/$1/}"
```

Supported transform behavior includes:

- capture references such as `$1` and `${1}`;
- global (`g`), case-insensitive (`i`), multiline (`m`), and dot-all (`s`) options;
- `${1:/upcase}`, `${1:/downcase}`, `${1:/capitalize}`, `${1:/camelcase}`,
  `${1:/pascalcase}`, `${1:/snakecase}`, and `${1:/kebabcase}`;
- conditional formats such as `${1:+if}`, `${1:?if:else}`, `${1:-else}`, and `${1:else}`.

Transforms use ecode/eepp regular expressions rather than JavaScript regular expressions. Common
expressions work as expected, but unusual JavaScript-specific constructs can behave differently.

Placeholder transforms such as `${1/(.*)/${1:/upcase}/}` are not currently implemented. Variable
transforms are evaluated once when the snippet is inserted; ecode does not yet reevaluate a
transformed mirror after its source placeholder is edited.

## Indentation and multiple cursors

Multiline snippet bodies are adapted to the insertion context. ecode:

- applies the current line's base indentation to subsequent lines;
- translates leading snippet tabs to the document's indentation style and width;
- preserves non-leading whitespace inside the snippet; and
- calculates tab-stop ranges after indentation has been prepared.

The same snippet can be inserted at multiple cursors. The body, variables, selected text, and
indentation are evaluated independently for each cursor. Equivalent tab stops are navigated as a
group across all insertions.

The primary cursor drives snippet matching. At each additional cursor, ecode replaces the same
prefix when it is present, replaces an existing selection when there is one, or inserts without
deleting unrelated text.

## Reloading and errors

Snippet directories are watched for file creation, modification, rename, move, and deletion.
Changes normally become available without restarting ecode or reopening the workspace.

Loading, file reads, JSON parsing, and index rebuilding happen on worker threads. If a previously
valid file becomes temporarily invalid while it is being edited, ecode keeps the last valid
definitions from that file. Once the file becomes valid again, the definitions are replaced.
Useful diagnostics are written to the log without including snippet bodies.

When the workspace changes, snippets from the old `.vscode` and `.ecode` directories are removed
and the new workspace is loaded. Personal snippets remain available.

## Differences from VS Code

The following table compares the current ecode implementation with the behavior documented in
[VS Code's user-defined snippets guide](https://code.visualstudio.com/docs/editing/userdefinedsnippets).

| Feature | ecode | VS Code |
| --- | --- | --- |
| Language `<id>.json` files | Supported in ecode's user snippet directory | Supported in VS Code's user snippet directory |
| Global/scoped `.code-snippets` files | Supported | Supported |
| Project `.vscode/*.code-snippets` | Loaded directly | Supported |
| Project `.ecode/*.code-snippets` | Supported as an ecode-native location | Not applicable |
| JSON comments and trailing commas | Supported | Supported by the snippet configuration workflow |
| String/array `prefix` and `body` | Supported | Supported |
| `description` and language `scope` | Supported | Supported |
| Tab stops, placeholders, nested placeholders, mirrors, and choices | Supported | Supported |
| Contextual indentation | Supported for common layouts | Supported, with VS Code-specific formatting behavior |
| Multiple cursors | Supported | Supported |
| Variable transforms | Supported with ecode/eepp regex differences described above | Supported with JavaScript regular expressions |
| Placeholder transforms updated from edited tab stops | Not supported | Supported |
| Variables | Workspace, clipboard, cursor, date/time, random, UUID, comment, and `TM_*` variables supported | Supported |
| `include` / `exclude` file-pattern scopes | Supported with ecode's glob matcher | Supported |
| `isFileTemplate` and Fill File with Snippet | Not supported; ignored and shown as an ordinary snippet | Supported |
| Insert Snippet searchable command | Supported through the Universal Locator | Supported |
| Configure Snippets command | Not yet available; edit files directly | Supported |
| Exact-prefix Tab completion without suggestions | Not yet available | Optional through `editor.tabCompletion` |
| Placement above/below normal suggestions | Not configurable; normal match ranking is used | Configurable through `editor.snippetSuggestions` |
| Hide individual snippets from completion | Not supported | Supported |
| Snippet extension/Marketplace packages | Not automatically discovered or imported | Supported through extensions |
| Per-snippet keybindings and context expressions | Not supported | Supported |
| Sublime or TextMate container-file import | Not supported | Available through VS Code tooling/extensions |
| Interpolated shell commands | Intentionally unsupported | Also unsupported by VS Code snippet syntax |

ecode does not automatically scan VS Code's personal configuration or installed extensions. Copy
personal snippet files into ecode's user snippet directory when migrating. Project files under
`.vscode` require no migration.

The format should therefore be described as **VS Code JSON/JSONC snippet-file compatible**, not as
complete VS Code snippet feature parity.

## Troubleshooting

### A snippet does not appear

- Confirm that the file is directly inside a supported snippet directory.
- Confirm that a language-specific filename uses ecode's LSP language identifier.
- Check the `scope` in a `.code-snippets` file.
- Verify that `prefix` and `body` are present and have supported types.
- Use `Mod+Space` to request suggestions explicitly.
- Check the ecode log for a parsing or definition diagnostic.

### The wrong text is replaced

User snippets replace the exact prefix matched before each cursor. If the snippet was selected
after typing unrelated text, request suggestions immediately after the intended prefix.

### A VS Code snippet inserts an unresolved variable name

The variable is not currently provided by ecode. Add a fallback or replace it with one of the
supported variables listed above.

### Changes are not visible

Save the snippet file and request completion again. For project snippets, confirm that the folder
containing `.vscode` or `.ecode` is the workspace currently opened by ecode.
