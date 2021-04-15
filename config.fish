set -x FZF_DEFAULT_COMMAND "fdfind --hidden --follow --exclude '.git'"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x FZF_DEFAULT_OPTS --info=inline \
--layout=reverse \
--preview-window=:hidden \
"--preview 'batcat --style changes --color=always --line-range :60 {}'" \
--bind='F2:toggle-preview'

# Need how to figure out the best way to add $HOME/.local/bin to PATH
#set -la PATH /home/ajp/.local/bin
#set -Ua fish_user_paths $HOME/.local/bin
#contains $HOME/.local/bin $fish_user_paths; or set -Ua fish_user_paths $HOME/.local/bin

# Starting tmux from fish, got this from:
# https://www.markhansen.co.nz/auto-start-tmux/
# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
# only run in interactive (not automated SSH for example)
if status is-interactive
# don't nest inside another tmux
and not set -q TMUX
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  #tmux new-session -A -s main
  tmux
end

abbr setclip "xclip -selection c"
abbr getclip "xclip -selection c -o"

fish_vi_key_bindings
