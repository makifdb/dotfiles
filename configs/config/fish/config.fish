# don't show any greetings
set -g fish_greeting

set -gxp PATH /usr/local/opt/python@3.9/libexec/bin /usr/local/sbin $HOME/go/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR vim

# https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# alias
alias ls 'exa'
alias vim 'nvim'

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

