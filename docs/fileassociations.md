# File Associations in ecode Projects

ecode supports project-specific file associations, allowing you to map file patterns or names to specific programming languages for syntax highlighting, autocompletion, and other language-specific features. This is configured via the `.ecode/settings.json` file in your project root, using the same format as VS Code for easy compatibility.

## Setup

1. **Create the configuration file**: In your project's root directory, create a folder named `.ecode` if it doesn't exist, and inside it, add a `settings.json` file.

2. **Add file associations**: In `settings.json`, include a `"files.associations"` object. Keys are glob patterns or file names, and values are the target [language ID](https://github.com/SpartanJ/ecode/?tab=readme-ov-file#language-support-table) (e.g., "cpp" for C++).

   Example ` .ecode/settings.json`:
   ```json
   {
       "files.associations": {
           "glob_pattern": "language_name",
           "functional": "cpp",
           "map": "cpp",
           "**/c++/**": "cpp"
       }
   }
   ```

   - **Simple file name**: `"functional": "cpp"` associates files named "functional" with C++.
   - **Glob pattern**: `"**/c++/**": "cpp"` matches any file in a subdirectory named "c++".
   - Language IDs follow standard conventions (e.g., "javascript", "python", "json"). Check ecode's [supported languages for exact IDs](https://github.com/SpartanJ/ecode/?tab=readme-ov-file#language-support-table).

3. **Reload the project**: Open or reload your project in ecode. The associations will apply automatically to matching files.

## VS Code Fallback

If `.ecode/settings.json` does not exist, ecode will automatically fall back to `.vscode/settings.json` (if present) and read the `"files.associations"` from there. This ensures compatibility with VS Code workspaces. You can migrate by copying the relevant section to `.ecode/settings.json` for ecode-specific overrides.
