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
