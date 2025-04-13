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

To use cloud-based LLM providers, you need to add your API keys. You can do this in two ways:

1.  **Via the `config` object in settings:**

    Add your keys directly into the `config` section of your `ecode` settings file.

    ```json
    {
      "config": {
        "anthropic_api_key": "YOUR_ANTHROPIC_API_KEY",
        "deepseek_api_key": "YOUR_DEEPSEEK_API_KEY",
        "google_ai_api_key": "YOUR_GOOGLE_AI_API_KEY", // For Google AI / Gemini models
        "mistral_api_key": "YOUR_MISTRAL_API_KEY",
        "openai_api_key": "YOUR_OPENAI_API_KEY",
        "xai_api_key": "YOUR_XAI_API_KEY" // For xAI / Grok models
      }
    }
    ```
    Leave the string empty (`""`) for services you don't intend to use.

2.  **Via Environment Variables:**

    The application can also read API keys from environment variables. This is often a more secure method, especially in shared environments or when committing configuration files. If an environment variable is set, it will  override the corresponding key in the `config` object.

    The supported environment variables are:

    *   `ANTHROPIC_API_KEY`
    *   `DEEPSEEK_API_KEY`
    *   `GOOGLE_AI_API_KEY` (or `GEMINI_API_KEY`)
    *   `MISTRAL_API_KEY`
    *   `OPENAI_API_KEY`
    *   `XAI_API_KEY` (or `GROK_API_KEY`)

### Keybindings (`keybindings` section)

The following default keybindings are provided for interacting with the LLM Chat UI. You can customize these in the `keybindings` section of your settings file.

*(Note: `mod` typically refers to `Cmd` on macOS and `Ctrl` on Windows/Linux)*

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
