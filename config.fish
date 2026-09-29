set -x FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude '.git'"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x FZF_DEFAULT_OPTS --info=inline \
--layout=reverse \
"--preview 'bat --style changes --color=always --line-range :60 {}'" \
--preview-window hidden \
--bind='F2:toggle-preview'


# Automatically starting tmux from fish
# I no longer use this in favor of using kitty terminal
# which has most of this functionality built in.
#
# Got this from:
# https://www.markhansen.co.nz/auto-start-tmux/
# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369

## only run in interactive (not automated SSH for example)
#if status is-interactive
## don't nest inside another tmux
#and not set -q TMUX
#  # Adapted from https://unix.stackexchange.com/a/176885/347104
#  # Create session 'main' or attach to 'main' if already exists.
#  #tmux new-session -A -s main
#  #tmux
#end

abbr setclip "xclip -selection c"
abbr getclip "xclip -selection c -o"

fish_vi_key_bindings

source ~/.config/gitlint/gitlintrc.fish

set fish_prompt_pwd_dir_length 0
set __fish_git_prompt_use_informative_chars yes

set -x FORGIT_COPY_CMD 'xclip -selection clipboard'
set -x FORGIT_LOG_GRAPH_ENABLE true

# Python venv that gets activated automatically.
# But only if it is not already activated.
#test -z "$VIRTUAL_ENV" && source "$HOME/.venv/default/bin/activate.fish"

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
#set -x PATH "/home/ajp/swdev/bitbake-docker:/home/ajp/repos/git-fuzzy/bin:$PATH"
#set -x PATH "/home/ajp/bitbakestuff/bitbake-docker:/home/ajp/repos/git-fuzzy/bin:$PATH"
