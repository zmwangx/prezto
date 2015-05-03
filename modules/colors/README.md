Prezto's `spectrum` module is an overkill, plus it is not easy to use: for instance, to get red foreground color you need to say `${FG[red]}`, and to reset you need to say `${FG[none]}`. In practice, however, few bells and whistles are ever used other than the eight foreground colors, the bold attribute, and the none attribute (for reset), especially if one appreciates the aesthetics of Solarized. Therefore, in this module, we load the [`colors` function](https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors) so that one can access the bells and whistles if necessary, but at the same time exports the following intuitive environment variables for scripting:

* `BLACK`, `RED`, `GREEN`, `YELLOW`, `BLUE`, `MAGENTA`, `CYAN`, `WHITE`;
* `BRBLACK`, `BRRED`, `BRGREEN`, `BRYELLOW`, `BRBLUE`, `BRMAGENTA`, `BRCYAN`, `BRWHITE` (bright colors);
* `BOLD` (note that some terminals print bold text in bright color instead of using a bold font — for instance, in iTerm2 you need to select "Draw bold text in bold font" in Preferences->Profiles->Text->Text Rendering);
* `RESET` (clear all effects, including foreground and background colors).
