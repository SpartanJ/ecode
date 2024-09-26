# Small script to migrate lite and lite-xl language definitions to ecode language definitions.

There are currently some limitations but this can be used as a starting point to create a new language definition.
Most of the languages can be migrated without any changes, but ecode currently does not support regex
for syntax highlighting, those patterns won't be migrated (this is a feature of lite-xl, normal lite
does not support regex's).

## Usage

You'll need to have installed lua binary, then run:

`lua lite2ecode.lua lite_language_definition.lua > language_name.json`

Then you can copy the language definition to the [ecode languages folder](https://github.com/SpartanJ/ecode/#custom-languages-support).

If you want to ecode support the language that you're porting in the base install please [open an issue](https://github.com/SpartanJ/ecode/issues)
and share the language definiton JSON.
