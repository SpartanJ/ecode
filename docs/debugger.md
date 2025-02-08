## Debugger

*ecode* implements the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol) (DAP) for debugger support. This enables seamless debugging integration with various languages through a common protocol. DAP is used by VS Code and other major editors and has been implemented for a wide range of programming languages. For more information, see the [list of implementations](https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/).

Initially, *ecode* provides support for some of the most common debug adapter implementations, with plans to add support for more languages in future updates.

### How It Works

There are two ways to use the debugger in *ecode*:

1. **Using Default *ecode* Configurations:** These configurations are designed to work seamlessly with your build settings. The executable used in these default options is the `Run Target` of your currently selected `Build Configuration`.

2. **Using Custom Launch Configurations:** Users can provide custom launch configurations within the project folder. These configurations should be located at `.ecode/launch.json` or `.vscode/launch.json`. *ecode* uses the same `launch.json` format as VS Code, ensuring compatibility for users migrating from other DAP-based editors. However, *ecode* will only recognize currently supported debuggers, as DAP implementations can vary significantly in configuration details.

### Using *ecode* Default Configurations

Once you have a `Build Configuration` with a selected `Run Target`, this will be used for the default `Launch` and `Attach` configurations for your language.

- **Launch Configurations:** These configurations start an executable from your local environment, with the process managed by the debugger. This is the most common setup for most users. To use it:

  - Ensure your `Run Target` is ready.
  - Go to the `Debugger` tab in the Side Panel.
  - Select the debugger based on the language you want to debug. For example, C or C++ binaries can be debugged using `gdb` or `lldb-dap` (also known as `lldb-vscode`), depending on your platform.
  - Choose the appropriate `Debugger Configuration`, such as `Launch Binary`.
  - Click `Debug` or press `Ctrl/Cmd + F5` to start debugging.

- **Attach Configurations:** These configurations allow the debugger to attach to an already running process, either locally or remotely. You can attach to a process via its process ID or its binary name/path. Some configurations include a `(wait)` option, which waits for the process to start before attaching.

  The default `Attach to Binary` option will also use the current `Run Target` to execute the binary. Unlike the `Launch` configuration, here the process is managed by *ecode* instead of the debugger. This feature is particularly useful for debugging CLI programs from the terminal if the `Run Target` is configured with `Run in Terminal`.

### Using Custom Launch Configurations

*ecode* supports custom launch configurations through the `launch.json` file, which can be placed in either the `.ecode/` or `.vscode/` folder within your project directory. This format is fully compatible with VS Code, making it easy for users transitioning from other editors.

#### Creating a `launch.json` File

The `launch.json` file defines how debugging sessions are launched or attached. A basic configuration looks like this:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Program",
      "type": "lldb",
      "request": "launch",
      "program": "${workspaceFolder}/bin/myapp",
      "args": ["--verbose"],
      "cwd": "${workspaceFolder}",
      "stopOnEntry": false
    }
  ]
}
```

#### Key Fields Explained

- **`name`**: The display name for the configuration in the *ecode* debugger interface.
- **`type`**: The debugger type, such as `gdb`, `lldb`, or any supported DAP adapter.
- **`request`**: Specifies whether to `launch` a new process or `attach` to an existing one.
- **`program`**: The path to the executable you want to debug.
- **`args`**: Optional. Command-line arguments passed to the program.
- **`cwd`**: The working directory for the program.
- **`stopOnEntry`**: Optional. If `true`, the debugger will pause at the program's entry point.

#### Advanced Customization

You can create multiple configurations for different scenarios, such as:

- Attaching to a remote process:

```json
{
  "name": "Attach to Remote",
  "type": "gdb",
  "request": "attach",
  "host": "192.168.1.100",
  "port": 1234
}
```

- Debugging with environment variables:

```json
{
  "name": "Launch with Env Vars",
  "type": "lldb",
  "request": "launch",
  "program": "${workspaceFolder}/bin/myapp",
  "env": {
    "DEBUG": "1",
    "LOG_LEVEL": "verbose"
  }
}
```

*ecode* will automatically detect and load configurations from `launch.json`, prioritizing `.ecode/launch.json` if both are present. This approach ensures flexibility and consistency across projects, whether you're starting fresh or migrating from VS Code.

*ecode* supports the same `launch.json` schema as VS Code, including standard input types such as:

- **`pickProcess`**: Prompts the user to select a running process from a list. This is useful for attaching the debugger to an already running application.
- **`pickString`**: Allows the user to select from a predefined list of string options.
- **`promptString`**: Prompts the user to manually enter a string value, useful for dynamic input during debugging sessions.

In addition to these standard inputs, *ecode* extends functionality with an extra input type:

- **`pickFile`**: This *ecode*-specific input allows users to select a binary file directly from the file system. It is particularly useful when you need to choose an executable to be run and debugged without hardcoding the path in your `launch.json`.

These input options make custom configurations flexible and dynamic, adapting to different debugging workflows and environments.

#### Variables Reference

ecode supports all vscode variable substitution in debugger configuration files. Variable substitution is supported inside some key and value strings in `launch.json` files using **${variableName}** syntax.

##### Predefined variables

The following predefined variables are supported:

- **${userHome}** - the path of the user's home folder
- **${workspaceFolder}** - the path of the folder opened in VS Code
- **${workspaceFolderBasename}** - the name of the folder opened in VS Code without any slashes (/)
- **${file}** - the current opened file
- **${fileWorkspaceFolder}** - the current opened file's workspace folder
- **${relativeFile}** - the current opened file relative to `workspaceFolder`
- **${relativeFileDirname}** - the current opened file's dirname relative to `workspaceFolder`
- **${fileBasename}** - the current opened file's basename
- **${fileBasenameNoExtension}** - the current opened file's basename with no file extension
- **${fileExtname}** - the current opened file's extension
- **${fileDirname}** - the current opened file's folder path
- **${fileDirnameBasename}** - the current opened file's folder name
- **${cwd}** - the task runner's current working directory upon the startup of VS Code
- **${lineNumber}** - the current selected line number in the active file
- **${selectedText}** - the current selected text in the active file
- **${execPath}** - the path to the running VS Code executable
- **${defaultBuildTask}** - the name of the default build task
- **${pathSeparator}** - the character used by the operating system to separate components in file paths
- **${/}** - shorthand for **${pathSeparator}**

### Language-Specific Configurations

In addition to general configurations, *ecode* offers language-specific settings, such as loading core dumps. Each debugger and language may provide different configurations based on the debugger's capabilities and the language's characteristics.

### Debugger keybindings object keys

* **debugger-breakpoint-enable-toggle**: Toggles enable/disable current line breakpoint (if any)
* **debugger-breakpoint-toggle**: Toggles breakpoint in current line
* **debugger-continue-interrupt**: If debugger is running: continues or interrupt the current execution. If debugger is not running builds and run the debugger.
* **debugger-start**: Starts the debugger
* **debugger-start-stop**: Starts or stops the debugger (depending on its current status)
* **debugger-step-into**: Steps into the current debugged line
* **debugger-step-out**: Steps out the current debugged line
* **debugger-step-over**: Steps over the current debugged line
* **debugger-stop**: Stops the debugger
* **toggle-status-app-debugger**: Opens/hides the debugger status bar panel

### Debugger config object keys

* **fetch_globals**: Enable/Disable if global variables should be fetched automatically (when available)
* **fetch_registers**: Enable/Disable if registers should be fetched automatically (when available)
* **silent**: Enable/Disable non-critical Debugger logs
