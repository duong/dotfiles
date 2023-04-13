# disable greeting
set fish_greeting

# add brew stuff to path
fish_add_path /opt/homebrew/bin

# set alias
alias ll="ls -lah"
alias vim="nvim"

# set default editor
set -gx EDITOR nvim

# prompt
# set -g __fish_git_prompt_show_informative_status true
# set -g __fish_git_prompt_use_informative_chars
# set -g __fish_git_prompt_showcolorhints true
# set -g __fish_git_prompt_char_upstream_ahead "↑"
# set -g __fish_git_prompt_char_upstream_behind "↓"
# set -g __fish_git_prompt_color_branch grey
# function fish_prompt
#      set_color $fish_color_cwd
#      printf \n'%s' (prompt_pwd)
#      set_color normal
#      printf '%s ' (fish_git_prompt)
#      echo \n'-> '
# end

# starship prompt
starship init fish | source

# activate direnv
direnv hook fish | source

