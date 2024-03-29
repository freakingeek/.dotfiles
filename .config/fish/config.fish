# Remove fish default greeting
set fish_greeting

# Add some custom command
echo

pfetch

echo && echo

# Change the propmt
function fish_prompt -d "Write out the prompt"
    # printf '%s@%s %s%s%s > ' $USER $hostname \ (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish

    printf ' %s%s%s ' \ (set_color $fish_color_cwd) (prompt_pwd) (set_color $fish_color_cwd)
end

# Set volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Set deno
set -gx DENO_INSTALL "$HOME/.deno"
set -gx PATH "$DENO_INSTALL/bin" $PATH

#
set -gx PATH "$HOME/.local/bin" $PATH

# Aliases
alias vim="nvim"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
