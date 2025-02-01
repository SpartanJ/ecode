## Git integration

*ecode* provides some basic Git integration (more features will come in the future). Its main purpose
is to help the user to do the most basics operations with Git. Some of the current features supported:
git status and stats visualization (files states), commit, push, checkout, pull, fetch, fast-forward
merge, creating+renaming+deleting branches, managing stashes. All stats will be automatically
updated/refreshed in real time. There's also some basic configuration available.
The plugin requires the user to have a `git` binary installed and available in `PATH` environment variable.

### `git.json` format

The format follows the same pattern that all previous configuration files. Configuration is represented
in a JSON file with three main keys: `config`, `keybindings`, `servers`.

C and C++ LSP server example (using [clangd](https://clangd.llvm.org/))

```json
{
  "config": {
    "silent": false,
    "status_recurse_submodules": true,
    "statusbar_display_branch": true,
    "statusbar_display_modifications": true,
    "ui_refresh_frequency": "5s"
  },
  "keybindings": {
    "git-blame": "alt+shift+b"
  }
}
```

### Git config object keys

* **silent**: Enable/Disable non-critical Git logs.
* **status_recurse_submodules**: Enables/disables recursing sub-modules for the file status report.
* **statusbar_display_branch**: Enables/disables an always visible status on the bottom statusbar.
* **statusbar_display_modifications**: Enables/disables if the number of lines affected is displayed in the statusbar.
* **ui_refresh_frequency**: Indicates the frequency in which the status is updated (it will only trigger updates if changes are detected inside the `.git` directory).
* **filetree_highlight_changes**: Enables/disables the highlighting of changes on the file-tree.
* **filetree_highlight_style_color**: Allows to change the highlight color in the file-tree.

### Git keybindings object keys

* **git-blame**: Keybinding to display the a git blame summary over the current positioned line.
