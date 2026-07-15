if status is-interactive
end

# Added by OrbStack
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

set -g fish_greeting

set -x LANG en_US.UTF-8
set -gx GOBIN $HOME/go/bin; set -gx GOPATH $HOME/go; set -gx PATH $GOPATH/bin $PATH
set -gx EDITOR nvim
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by Antigravity
fish_add_path /Users/makifdb/.antigravity/antigravity/bin

# grok
fish_add_path $HOME/.grok/bin

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
