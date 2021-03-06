set -x COLORSCHEME onedark
set -x SYNCDIR "$HOME/Sync"
set -x SCRIPTSDIR "$SYNCDIR/scripts"
set -x SSHOTDIR "$SYNCDIR/screenshots"
set -x PRIVATEDIR "$SYNCDIR/private"

set PATH ""
set PATH $PATH /Applications/Alacritty.app/Contents/MacOS
set PATH $PATH /Applications/Firefox.app/Contents/MacOS
set PATH $PATH /usr/local/opt/coreutils/libexec/gnubin
set PATH $PATH /usr/local/opt/findutils/libexec/gnubin
set PATH $PATH /usr/local/opt/gnu-sed/libexec/gnubin
set PATH $PATH /Library/TeX/texbin
set PATH $PATH $HOME/.cargo/bin
set PATH $PATH /usr/local/sbin
set PATH $PATH /usr/local/bin
set PATH $PATH /usr/sbin
set PATH $PATH /usr/bin
set PATH $PATH /sbin
set PATH $PATH /bin
set PATH $PATH $SCRIPTSDIR/peek
set PATH $PATH $SCRIPTSDIR/pfetch
set PATH $PATH $SCRIPTSDIR/vimv
set -x PATH $PATH

set -x VISUAL nvim
set -x EDITOR $VISUAL
set -x MANPAGER "nvim -c 'set ft=man' -"

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

set -x STARSHIP_CONFIG "$HOME/.config/starship/config.toml"
set -x IPYTHONDIR "$HOME/.local/share/ipython"
set -x MPLCONFIGDIR "$HOME/.local/share/matplotlib"
set -x LESSHISTFILE "$HOME/.cache/less/lesshst"
set -x HISTFILE "$HOME/.cache/bash/bash_history"
set -x npm_config_cache "$HOME/.cache/npm"

set -x HOMEBREW_NO_AUTO_UPDATE 1

set -x FZF_DEFAULT_COMMAND \
"fd --base-directory ~ --hidden --type f --color always"

# The following colors are taken from https://hexcolorcodes.org/lighten-color,
# taking a colorscheme's terminal background color and choosing a "Lighten
# amount" of 10.

switch $COLORSCHEME
  case afterglow
      set fzf_bgplus_color "#242424"
  case gruvbox
    set fzf_bgplus_color "#323232"
  case onedark
    set fzf_bgplus_color "#32363e"
end

set -x FZF_DEFAULT_OPTS \
"--reverse --no-bold --info=inline --hscroll-off=50 --ansi \
--color='hl:-1:underline,fg+:-1:regular:italic,bg+:$fzf_bgplus_color' \
--color='hl+:-1:underline:italic,prompt:4:regular,pointer:1'"

set -x FZF_ONLYDIR_COMMAND \
(echo $FZF_DEFAULT_COMMAND | sed 's/--type f/--type d/')

set -x LS_COLORS (vivid generate ~/.config/vivid/colorschemes/$COLORSCHEME)

set dircolor (echo $LS_COLORS | sed 's/\(^\|.*:\)di=\([^:]*\).*/\2/')
set fgodcolor (echo $LS_COLORS | sed 's/\(^\|.*:\)\*\.fgod=\([^:]*\).*/\2/')

# Make directories gray when using fzf

set -x FZF_DEFAULT_COMMAND $FZF_DEFAULT_COMMAND "|
sed 's/\x1b\["$dircolor"m/\x1b\["$fgodcolor"m/g'"

set -x FZF_ONLYDIR_COMMAND $FZF_ONLYDIR_COMMAND "|
sed 's/\x1b\["$dircolor"m/\x1b\["$fgodcolor"m/g' |
sed 's/\(.*\)\x1b\["$fgodcolor"m/\1\x1b\["$dircolor"m/'"
