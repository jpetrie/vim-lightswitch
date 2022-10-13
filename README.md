# lightswitch.vim

Lightswitch automatically adjusts the value of `background` based on the macOS appearance theme. It has no effect on
non-macOS systems, and supports both vim and neovim.

Lightswitch polls once at startup, and then regularly in the background at an interval of milliseconds defined by
`g:lightswitch_interval`. If the interval is 0 or negative, the periodic background checks are disabled.

During a poll, if Lightswitch detects that the OS appearance theme is different from the value of `background`, it will
set `background` accordingly.


## Installation

Lightswitch has no special installation requirements. Use your preferred plugin management method to install it.


## Customization

`g:lightswitch_interval` can be set at startup (in your `.vimrc` or similar) to control the time in milliseconds between
updates.
