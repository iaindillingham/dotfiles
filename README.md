# Dotfiles

Various configuration files.

Add the following to `.bashrc`:

    [ -z "$TMUX" ] && export TERM=xterm-256color

## Credits

Pretty much all of `tmux.conf` comes from Brian Hogan's [_tmux: Productive
Mouse-Free Development_][0].

Configuration files by [David Brewer][1] and [John Goerzen][2] helped with
`xmonad/*`.

[0]: https://pragprog.com/book/bhtmux/tmux
[1]: https://github.com/davidbrewer/xmonad-ubuntu-conf
[2]: https://wiki.haskell.org/Xmonad/Config_archive/John_Goerzen's_Configuration
