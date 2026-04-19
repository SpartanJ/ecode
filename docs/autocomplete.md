## Auto Complete

The auto-complete plugin is in charge of providing suggestions for code-completion and signature help.

### Auto Complete config object keys

* **max_label_characters**: Maximum characters displayed in the suggestion box.
* **suggestions_syntax_highlight**: Enables/disables syntax highlighting in suggestions.
* **max_signature_helper_width**: The maximum width in stylesheet length of the signature helper (default value: "90%").
* **max_suggestion_documentation_width**:  The maximum width in stylesheet length of the currently selected suggestion item documentation (default value: "100%").
* **signature_help_multi_line**: Enables the signature help to be rendered in multiple lines if needed (wraps text), otherwise it will render in a single line and ensure the current parameter is visible.
* **suggestion_documentation**:  Enables the suggestion item documentation.

### Auto Complete keybindings object keys

* **autocomplete-close-signature-help**: Closes the signature help
* **autocomplete-close-suggestion**: Closes the suggestions
* **autocomplete-first-suggestion**: Moves to the first suggestion in the auto complete list
* **autocomplete-last-suggestion**: Moves to the last suggestion in the auto complete list
* **autocomplete-next-signature-help**: Moves to the next signature help
* **autocomplete-next-suggestion**: Moves to the next suggestion
* **autocomplete-next-suggestion-page**: Moves to the next page of suggestions
* **autocomplete-pick-suggestion**: Picks a suggestion
* **autocomplete-pick-suggestion-alt**: Picks a suggestion (alternative keybinding)
* **autocomplete-pick-suggestion-alt-2**: Picks a suggestion (alternative keybinding)
* **autocomplete-prev-signature-help**: Moves to the previous signature help
* **autocomplete-prev-suggestion**: Moves to the previous suggestion
* **autocomplete-prev-suggestion-page**: Moves to the previous suggestion page
* **autocomplete-update-suggestions**: Request to display or update currently displayed suggestions (if possible)
