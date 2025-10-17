# Spell Checker

The spell checker provides real-time spell checking for source code across your project, helping you catch typos and maintain consistent spelling in comments, strings, and identifiers.

## Installation

### Prerequisites

The spell checker requires the [typos](https://github.com/crate-ci/typos) tool to be installed and available in your system `PATH`.

**Installation options:**

- **Cargo:** `cargo install typos-cli`
- **Homebrew (macOS):** `brew install typos-cli`
- **Pre-built binaries:** Download from the [releases page](https://github.com/crate-ci/typos/releases)

To verify installation, run:
```bash
typos --version
```

## Configuration

Configuration is managed through ecode's settings file (JSON format) using the `config` and `keybindings` sections.

### Basic Structure

```json
{
  "config": {
    "delay_time": "500ms"
  },
  "keybindings": {
    "spellchecker-fix-typo": "alt+shift+return",
    "spellchecker-go-to-next-error": "",
    "spellchecker-go-to-previous-error": ""
  }
}
```

### Configuration Options

#### `config`

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `delay_time` | integer | 500 | Delay in milliseconds before running spell check after document changes |

#### Keybindings

| Command | Description |
|---------|-------------|
| `spellchecker-fix-typo` | Display suggestions for the current typo |
| `spellchecker-go-to-next-error` | Navigate to the next spelling error |
| `spellchecker-go-to-previous-error` | Navigate to the previous spelling error |

## Usage

### Basic Workflow

1. **Automatic Detection**: Spelling errors are highlighted automatically as you type
2. **Navigate Errors**: Use the navigation keybindings to jump between errors
3. **Fix Typos**: Position your cursor on a highlighted error and use the fix-typo command to see suggestions or right click the typo -> Spell Checker and pick the replacement word

## Troubleshooting

### Common Issues

**Spell checker not working**
- Verify `typos` is installed and in your PATH
- Check the ecode console/logs for error messages
- Ensure your configuration syntax is valid JSON

**Too many false positives**
- Consider configuring a custom `typos` configuration file (`.typos.toml`) in your project root
- Refer to the [typos documentation](https://github.com/crate-ci/typos/blob/master/docs/reference.md) for advanced filtering options

**Performance issues**
- Increase the `delay_time` value to reduce frequency of checks
- Consider excluding large files or directories via typos configuration

## Integration with typos

This plugin leverages the `typos` tool's configuration system. You can create a `.typos.toml` file in your project root to:

- Add custom dictionaries
- Ignore specific files or patterns
- Configure language-specific rules
- Define project-specific corrections

Example `.typos.toml`:
```toml
[default.extend-words]
# Add custom corrections
teh = "the"
recieve = "receive"

[files]
# Ignore certain file types
extend-exclude = ["*.min.js", "*.lock"]
```

For complete configuration options, see the [typos documentation](https://github.com/crate-ci/typos/blob/master/docs/reference.md).
