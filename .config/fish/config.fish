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

    printf ' 🔩 %s%s%s > ' \ (set_color $fish_color_cwd) (prompt_pwd) (set_color $fish_color_cwd)
end
