# disable greeting
set fish_greeting

# prompt
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
function fish_prompt
     printf '\n%s%s%s%s%s%s' (set_color $fish_color_cwd) (prompt_pwd) (set_color red) (fish_git_prompt) (set_color normal)\n'-> '
end

# add brew stuff to path
fish_add_path /opt/homebrew/bin

# set alias
alias ll="ls -lah"

