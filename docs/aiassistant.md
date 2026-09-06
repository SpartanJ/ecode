# AI Assistant

This feature allows you to interact directly with various AI models from different providers within the editor.

## Overview

The LLM Chat UI provides a dedicated panel where you can:

*   Start multiple chat conversations.
*   Interact with different LLM providers and models (like OpenAI, Anthropic, Google AI, Mistral, DeepSeek, XAI, and local models via Ollama/LMStudio).
*   Manage chat history (save, rename, clone, lock).
*   Use AI assistance directly related to your code or general queries without leaving the editor.

## Configuration

Configuration is managed through `ecode`'s settings file (a JSON file). The relevant sections are `config`, `keybindings`, and `providers`.

```json
// Example structure in your ecode settings file
{
  "config": {
    // API Keys go here
  },
  "keybindings": {
    // Chat UI keybindings
  },
  "providers": {
    // LLM Provider definitions
  }
}
```

### API Keys (`config` section)

To use cloud-based LLM providers, you need to configure their API keys. Providers with a
resolved API key are shown before unconfigured providers in the model selector, while the
remaining providers stay searchable.

You can configure API keys in two ways:

1.  **Via the `config.api_keys` object in settings:**

    Add an entry whose key is the provider ID and whose value is its API key. Provider IDs
    are the identifiers used by [models.dev](https://models.dev/), such as `openai`,
    `anthropic`, `openrouter`, `deepseek`, or `groq`.

    ```json
    {
      "config": {
        "api_keys": {
          "anthropic": "YOUR_ANTHROPIC_API_KEY",
          "deepseek": "YOUR_DEEPSEEK_API_KEY",
          "google": "YOUR_GOOGLE_AI_API_KEY",
          "groq": "YOUR_GROQ_API_KEY",
          "openai": "YOUR_OPENAI_API_KEY",
          "openrouter": "YOUR_OPENROUTER_API_KEY",
          "xai": "YOUR_XAI_API_KEY"
        }
      }
    }
    ```

    Only add providers you intend to use. The generic `api_keys` object supports catalog
    providers without requiring a dedicated ecode release whenever models.dev adds one.

    The older provider-specific fields remain supported for compatibility:
    `openai_api_key`, `anthropic_api_key`, `google_ai_api_key`, `deepseek_api_key`,
    `mistral_api_key`, `xai_api_key`, `github_api_key`, `perplexity_api_key`,
    `openrouter_api_key`, `moonshot_api_key`, `nvidia_api_key`, `together_api_key`, and
    `mimo_api_key`. When both forms configure the same provider, the value in `api_keys`
    takes precedence.

2.  **Via Environment Variables:**

    The application reads the environment-variable names published for each provider by
    models.dev. This is often safer than storing secrets in the settings file. A resolved
    environment variable takes precedence over values in both `api_keys` and the legacy
    provider-specific fields.

    Common examples include:

    *   `ANTHROPIC_API_KEY`
    *   `DEEPSEEK_API_KEY`
    *   `GOOGLE_AI_API_KEY` (or `GEMINI_API_KEY`)
    *   `MISTRAL_API_KEY`
    *   `OPENAI_API_KEY`
    *   `OPENROUTER_API_KEY`
    *   `XAI_API_KEY` (or `GROK_API_KEY`)

    Other catalog providers use the environment variables specified in their models.dev
    metadata. Environment variables must be present in the environment from which ecode is
    launched.

### Keybindings (`keybindings` section)

The following default keybindings are provided for interacting with the LLM Chat UI. You can customize these in the `keybindings` section of your settings file.

*(Note: `mod` typically refers to `Ctrl` on Windows/Linux and `Cmd` on macOS)*

| Action                       | Default Keybinding | Description                                                                                                                                                              |
| :--------------------------- | :----------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Add New Chat                 | `mod+shift+return` | Adds a new, empty chat tab to the UI.                                                                                                                                    |
| Show Chat History            | `mod+h`            | Displays a chat history panel.                                                                                                                                           |
| Toggle Message Role          | `mod+shift+r`      | Changes the role [user/assistant] of a selected message                                                                                                                  |
| Clone Current Chat           | `mod+shift+c`      | Creates a duplicate of the current chat conversation in a new tab.                                                                                                       |
| Send Prompt / Submit Message | `mod+return`       | Sends the message currently typed in the input box to the selected LLM.                                                                                                  |
| Refresh Local Models         | `mod+shift+l`      | Re-fetches the list of available models from local providers like Ollama or LMStudio.                                                                                    |
| Rename Current Chat          | `f2`               | Allows you to rename the currently active chat tab.                                                                                                                      |
| Save Current Chat            | `mod+s`            | Saves the current chat conversation state.                                                                                                                               |
| Open AI Settings             | `mod+shift+s`      | Opens the settings file                                                                                                                                                  |
| Show Chat Menu               | `mod+m`            | Displays a context menu with common chat actions: New Chat, Save Chat, Rename Chat, Clone Chat, Lock Chat Memory (prevents removal during batch clear operations).       |
| Toggle Private Chat          | `mod+shift+p`      | Toggles if chat must be persisted or no in the chat history (incognito mode)                                                                                             |
| Open New AI Assistant Tab    | `mod+shift+m`      | Opens a new LLM Chat UI                                                                                                                                                  |
| Attach a source file         | `mod+shift+a`      | Attaches a source file to the current message, allowing the AI to analyze, review, or reference the file's contents in its response.                                     |

## LLM Providers (`providers` section)

### Overview

The `providers` object defines the different LLM services available in the chat UI. `ecode` comes pre-configured with several popular providers (Anthropic, DeepSeek, Google, Mistral, OpenAI, XAI) and local providers (Ollama, LMStudio).

You generally don't need to modify the default providers unless you want to disable one or add/adjust model parameters. However, you can add definitions for new or custom LLM providers and models.

### Adding Custom Providers

To add a new provider, you need to add a new key-value pair to the `providers` object in your settings file. The key should be a unique identifier for your provider (e.g., `"my_custom_ollama"`), and the value should be an object describing the provider and its models.

**Provider Object Structure:**

```json
"your_provider_id": {
  "api_url": "string", // Required: The base URL endpoint for the chat completion API.
  "display_name": "string", // Optional: User-friendly name shown in the UI. Defaults to the provider ID if missing.
  "enabled": boolean, // Optional: Set to `false` to disable this provider. Defaults to `true`.
  "version": number, // Optional: Identifier for the API version if the provider requires it (e.g., 1 for Anthropic).
  "open_api": boolean, // Optional: Set to `true` if the provider uses an OpenAI-compatible API schema (common for local models like Ollama, LMStudio).
  "fetch_models_url": "string", // Optional: URL to dynamically fetch the list of available models (e.g., from Ollama or LMStudio). If provided, the static `models` array below might be ignored or populated dynamically.
  "models": [ // Required (unless `fetch_models_url` is used and sufficient): An array of model objects available from this provider.
    // Model Object structure described below
  ]
}
```

**Model Object Structure (within the `models` array):**

```json
{
  "name": "string", // Required: The internal model identifier used in API requests (e.g., "claude-3-5-sonnet-latest").
  "display_name": "string", // Optional: User-friendly name shown in the model selection dropdown. Defaults to `name` if missing.
  "max_tokens": number, // Optional: The maximum context window size (input tokens + output tokens) supported by the model.
  "max_output_tokens": number, // Optional: The maximum number of tokens the model can generate in a single response.
  "default_temperature": number, // Optional: Default sampling temperature (controls randomness/creativity). Typically between 0.0 and 2.0. Defaults might vary per provider or model. (e.g., 1.0)
  "cheapest": boolean, // Optional: Flag to indicate if this model is considered a cheaper option. It's usually used to generate the summary of the chat when the specific provider is being used.
  "cache_configuration": { // Optional: Configuration for potential internal caching or speculative execution features. May not apply to all providers or setups.
    "max_cache_anchors": number, // Specific caching parameter.
    "min_total_token": number, // Specific caching parameter.
    "should_speculate": boolean // Specific caching parameter.
  }
  // or "cache_configuration": null if not applicable/used for this model.
}
```

**Example: Adding a hypothetical local provider**

```json
{
  "providers": {
    // ... other existing providers ...
    "my_local_llm": {
      "api_url": "http://localhost:8080/v1/chat/completions",
      "display_name": "My Local LLM",
      "open_api": true, // Assuming it uses an OpenAI-compatible API
      "models": [
        {
          "name": "local-model-v1",
          "display_name": "Local Model V1",
          "max_tokens": 4096
        },
        {
          "name": "local-model-v2-experimental",
          "display_name": "Local Model V2 (Experimental)",
          "max_tokens": 8192
        }
      ]
    }
  }
}
```
