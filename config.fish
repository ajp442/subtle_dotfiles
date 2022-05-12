set -x FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude '.git'"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x FZF_DEFAULT_OPTS --info=inline \
--layout=reverse \
"--preview 'bat --style changes --color=always --line-range :60 {}'" \
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

source ~/.config/gitlint/gitlintrc.fish

set fish_prompt_pwd_dir_length 0

set -x FORGIT_COPY_CMD 'xclip -selection clipboard'
set -x FORGIT_LOG_GRAPH_ENABLE true
# This is from:
# https://github.com/bigH/git-fuzzy
# I'm not a huge fan so far, I might remove it.
#set -x PATH /home/ajp/repos"/git-fuzzy/bin:$PATH"

# This is from:
# https://brettterpstra.com/2021/11/25/git-better-with-fzf-and-fish/
# if status is-interactive && test -f ~/.config/fish/custom/git_fzf.fish
# 	source ~/.config/fish/custom/git_fzf.fish
# 	git_fzf_key_bindings
# end
