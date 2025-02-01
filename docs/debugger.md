## Debugger

*ecode* implements the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol) for its debugger support.
This facilitates debugging integration with various languages thanks to the usage of a common protocol. This protocol it's
being used by vscode and other major editors and it has been implemented for a great range if programming languages, see
[implementors list](https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/).
Initially ecode provides support for some of the most common debug adapters implementation, and it will continue adding
more languages by default.

### How it works?

Initially there are to ways of using the debugger: the first option is by using the default ecode
configurations provided. These configurations are designed to work in conjunction with the build
settings. This means that the executable used for the default options is the `Run Target` of your
currently selected `Build Configuration`. The second option is by consuming a custom launch
configuration that the user must provide inside the project folder. The configuration must be located
at `.ecode/launch.json` or at `.vscode/launch.json`. *ecode* uses the same *vscode* `launch.json` format
and it will always read and try to consume those configurations, this is to ease users migrating from
the most common DAP implementation.

#### Using ecode default configurations

Once you have a `Build Configuration` with a `Run Target` selected, this will be used for the `Launch`
configuration corresponding for your language. All languages will provide a `Launch` type of `Debugger Configuration`.
`Launch` means that an executable will be executed / launched from your local, based on your `Run Target` configuration.
This is the most common configuration for most users. So, after the `Run Target` is ready user must
go to the `Debugger` tab at the Side Panel and pick the debugger that wants to use based on the language
that needs to be debugged. For example a binary compiled from C or C++ can be debugged with `gdb` or `lldb-dap`
(this will also depend on the platform). So user must pick one of the two, let's say `lldb-dap` and
select the appropiate `Debugger Configuration`, for our use example that would be `Launch binary`, and
just click `Debug`.


Any `Attach` option refers to the action for attaching the debugger to an already running binary (locally or remote).
There is also the option to attach to a binary via its process ID or via its binary name (already running
or about to be executed, in that case it will `(wait)` for the process).

There are also some language specific configurations like loading core dumps. Each debugger and language
will provided different configurations depending on the capabilities of the debugger and language.
