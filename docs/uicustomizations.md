## UI Customizations

### Custom editor color schemes

Custom editor color schemes can be added in the user color schemes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/editor/colorschemes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/editor/colorschemes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\editor\colorschemes`

Any file written in the directory will be treated as an editor color scheme file. Each file can contain
any number of color schemes.

The format of a color scheme can be read from [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/colorschemes/colorschemes.conf).

### Custom terminal color schemes

Custom terminal color schemes can be added in the user terminal color schemes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/terminal/colorschemes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/terminal/colorschemes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\terminal\colorschemes`

Any file written in the directory will be treated as a terminal color scheme file. Each file can contain
any number of color schemes.

The format of a color scheme can be read from [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/colorschemes/terminalcolorschemes.conf).

### Custom UI themes

Custom UI schemes can be added in the user UI themes directory found at:

* *Linux*: uses `XDG_CONFIG_HOME`, usually translates to `~/.config/ecode/themes`
* *macOS*: uses `Application Support` folder in `HOME`, usually translates to `~/Library/Application Support/ecode/themes`
* *Windows*: uses `APPDATA`, usually translates to `C:\Users\{username}\AppData\Roaming\ecode\themes`

A custom UI theme file must have the extension `.css`, ecode will look for all the files with `.css`
extension in the directory, the UI theme name is the file name without the extension. The new theme
will appear in `Settings -> Window -> UI Theme`.

Custom UI themes allow customizing the editor at the user's will. Since ecode uses CSS to style all the
elements of the UI, creating new themes is quite easy. It's possible to customize only the color palette
but it's also possible to customize all the UI elements if desired. Customizing the whole UI theme can
be extensive, but customizing the colors is as simple as changing the values of the CSS variables used
to color the UI. For reference, the complete base UI theme used by ecode can be seen [here](https://github.com/SpartanJ/eepp/blob/develop/bin/assets/ui/breeze.css).
The most important selector would be the `:root` selector, where all the variables are defined. Color
variables can be easily extracted from that file.

A simple example of a custom UI theme that changes only the tint colors, let's call it `Breeze Light Red.css`:

```css
:root {
	--inherit-base-theme: true;
	--primary: #e93d66;
	--scrollbar-button: #a94074;
	--item-hover: #502834;
	--tab-hover: #5e3347;
}
```

That effectively would create/add a new UI theme with light red colors.
A very important detail is that if the UI theme must inherit the complete definition of the default theme,
we must add `--inherit-base-theme: true` to the `:root` element, otherwise the UI theme must be defined
completely, which means, every widget must be styled from scratch (not recommended given its complexity).
It's also possible to override the style of the different widgets redefining their properties with the
usual rules that apply to the well-known CSS specification (A.K.A. using adequate
[specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity) and probably abusing the
[!important](https://developer.mozilla.org/en-US/docs/Web/CSS/important) flag).

### Customizing the User Interface with `style.css`

The `style.css` file is a powerful tool for customizing the user interface (UI) of ecode, allowing users to tailor the look and feel of the editor to their preferences. Inspired by Firefox's `userChrome.css`, this stylesheet enables you to override nearly all built-in UI style rules, providing extensive flexibility to personalize the editor's appearance. Whether you want to adjust colors, fonts, layouts, or other visual elements, `style.css` gives you fine-grained control over the UI.

#### CSS Engine in ecode

ecode's UI customization is powered by a custom CSS engine based on the eepp GUI framework, which closely aligns with the CSS3 specification. While it adheres to standard CSS3 conventions, the eepp CSS engine includes some unique properties and behaviors specific to ecode's rendering system. For a complete reference of supported properties, syntax, and eepp-specific extensions, consult the [eepp CSS specification](https://eepp.ensoft.dev/page_cssspecification.html).

This CSS3-based engine ensures compatibility with familiar CSS syntax, making it easy for users with web development experience to customize the UI. However, some eepp-specific rules may require additional learning for optimal use. The specification documentation provides detailed guidance on these extensions, including examples and best practices.

#### Location of `style.css`

By default, ecode looks for the `style.css` file in a platform-specific configuration directory. If the file does not exist, you can create it in the appropriate location to start customizing the UI. The default paths are:

- **Linux**: Uses the `XDG_CONFIG_HOME` environment variable, typically resolving to `~/.config/ecode/style.css`.
- **macOS**: Stored in the `Application Support` folder within the user's home directory, typically `~/Library/Application Support/ecode/style.css`.
- **Windows**: Located in the `APPDATA` directory, typically `C:\Users\{username}\AppData\Roaming\ecode\style.css`.

If you prefer to store `style.css` in a custom location, you can specify an alternative file path using the `--css` command-line parameter when launching ecode. For example:

```bash
ecode --css /path/to/custom/style.css
```

This flexibility allows you to maintain multiple stylesheets for different workflows or share them across systems.

#### How Customization Works

The `style.css` file operates similarly to Firefox's `userChrome.css`. It is loaded after ecode's default styles, meaning your custom rules take precedence and can override built-in styles for most UI elements. This includes, but is not limited to:

- **Editor components**: Customize the appearance of the code editor, such as background colors, font sizes, or line spacing.
- **UI elements**: Modify toolbars, menus, side panels, or status bars to match your preferred aesthetic or workflow.

To get started, create or edit the `style.css` file in the appropriate directory and add standard CSS3 rules. For example, to add some padding to the PopUpMenu buttons, you might add:

```css
PopUpMenu > *
{
	padding-top: 4dp;
	padding-bottom: 4dp;
}
```

For eepp-specific properties or advanced customization, refer to the [eepp CSS specification](https://eepp.ensoft.dev/page_cssspecification.html). Always test your changes to ensure compatibility, as some properties may behave differently due to ecode's custom rendering engine.

#### Tips for Effective Customization

- **Start small**: Begin with simple changes, such as adjusting colors or fonts, before tackling complex layout modifications.
- **Use the Inspect Widgets tool**: If you're familiar with web development, you can inspect ecode's UI elements using its built-in widget inspector tool to identify class names or IDs for targeting specific components. Inspector can be found at `Settings -> Tools -> Inspect Widgets` .
- **Backup your styles**: Save a copy of your `style.css` file before making significant changes to avoid losing your customizations.
- **Leverage the community**: Explore online forums or the ecode community for shared `style.css` examples to inspire your customizations.

#### Troubleshooting

If your custom styles are not applied as expected:

- Verify that the `style.css` file is in the correct directory or properly specified via the `--css` parameter.
- Check for syntax errors in your CSS, as invalid rules may prevent the stylesheet from loading correctly.
- Ensure that your selectors are specific enough to override ecode's default styles, as some built-in rules may have higher specificity. You can always rely on [!important](https://developer.mozilla.org/en-US/docs/Web/CSS/important) if needed.
- Consult the [eepp CSS specification](https://eepp.ensoft.dev/page_cssspecification.html) to confirm that your properties are supported by the eepp CSS engine.

By leveraging `style.css`, you can transform ecode's UI to suit your unique needs, creating a personalized and productive coding environment.

### GUI Color Schemes Spec Map

```css
:root {
	--primary: #3daee9; /* primary color used to highlight things. buttons and select/hover (selected) + checkbox, etc */
	--back: #31363b; /* default window background color */
	--font: #eff0f1; /* default font color */
	--font-highlight: #8bdcfd; /* color used to highlight that something changed */
	--font-hint: #898b8d; /* font color of the hints in text inputs. The hint is the text that explains or suggest what to complete to the user, it's commonly also known as the placeholder in HTML */
	--button-back: #30353a; /* background color of button elements */
	--button-border: #6b6f73; /* background border color of button elements */
	--button-radius: 2dp; /* border radius of button elements */
	--base-horizontal-padding: 5dp; /** base horizontal padding of most clickable elements (e.g. buttons) */
	--base-vertical-padding: 5dp; /** base vertical padding of most clickable elements (e.g. buttons) */
	--border-width: 1dp; /** default border width used in GUI elements with borders */
	--list-back: #232629; /* background color of list elements (listbox, listview, treeview, tableview, etc) */
	--separator: #383a3d; /* separator line color */
	--item-hover: #284150; /* listbox and listview mouse hover background color */
	--slider-back: #676a6e; /* slider background color */
	--slider-button: #31363b; /* sliding rail button color */
	--slider-border: #787b80; /* slider rail button border color */
	--scrollbar-border: #373a3d; /* scrollbar border color */
	--scrollbar-button: #4085a9; /* scrollbar button color */
	--scrollbar-hback-hover: #606365; /* scrollbar background color when hovered / active */
	--list-row-active: #eff0f1; /* elements in active list rows text and icon color */
	--tab-back: #2b3034; /* inactive / not selected tab background color */
	--tab-line: #616569; /* tab widget separator line color */
	--tab-active: #31363b; /* active / selected tab background color */
	--tab-hover: #334e5e; /* intactive / not selected tab background color when hovered */
	--tab-close: #909396; /* tab close button background color */
	--tab-close-hover: #863d47; /* tab close button hover background color */
	--tab-font-active: white; /* active / selected tab text and icon color */
	--tab-font-inactive: #c0c5cc; /* inactive / not selected tab text color */
	--icon: #b6bbc2; /* default icon color */
	--icon-active: white; /* active icon color */
	--icon-back-hover: #eff0f1; /* icon hover background color (window action like maximize, minimize and close icons) */
	--icon-line: #dbdbdd; /* in vectorial icons with line primitives this is the line color */
	--icon-line-hover: #3d4246; /* in vectorial icons with line primitives this is the line color when hovered */
	--icon-back-alert: #e49aa2;/* icons with alert state background color (this is usually used for close button in tab widget, it's the background color when hovered) */
	--menu-back: #2d3136; /* menu item background color (menu as in popup menu) */
	--menu-font: #eff0f1; /* menu item font color (menu as in popup menu) */
	--menu-border: #616569; /* menu border color (menu as in popup menu) */
	--menu-font-active: white; /* current menu active item font color (hovered item) */
	--menu-font-disabled: #6e7275; /* disabled menu item font color (hovered item) */
	--floating-icon: #96999c; /* this is literally the icon color used for floating icons (which are treated separately from regular icons) */
	--term-back-color: #1e2127; /* terminal background color (this is for the console element, which is not an actually terminal but a console) */
	--term-font-color: #abb2bf; /* terminal font color (this is for the console element, which is not an actually terminal but a console) */
	--highlight-primary: #FFFFFF7A; /* this is only used for the border highlight of selected elements, currently only used for CheckBox, it's literally the underline color of it. */
	--disabled-color: #727679; /* font color of disabled elements with borders */
	--disabled-border: #43474c; /* border color of disabled elements with borders */
	--theme-error: #ff4040; /* font or background color of visual errors */
	--theme-warning: #ffff40; /* font or background color of visual warnings */
	--theme-success: #40ff40; /* font or background color of visual success */
	droppable-hovering-color: #FFFFFF20; /* the foreground color drawn over an item that accepts widgets drop */
}
```
