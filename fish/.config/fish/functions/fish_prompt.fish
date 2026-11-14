function fish_prompt
    set --local last_status $status

    if test $last_status -ne 0
        set_color red
    else
        set_color normal
    end

    set --local git_prompt $(fish_git_prompt | string trim --chars '( )')

    set --local venv_prompt $(path basename "$VIRTUAL_ENV")

    string join ' ' -- $(path basename "$PWD") $git_prompt $venv_prompt \u276f $(set_color normal)
end
