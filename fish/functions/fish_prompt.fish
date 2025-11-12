function fish_prompt --description 'Write out the prompt'
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

        set color_cwd $fish_color_cwd
        set suffix ' $'

        # Battery warning
        echo -n (fish_bat_prompt)

        # PWD
        set_color $color_cwd
        echo -n (prompt_pwd)
        set_color normal

        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
        echo -n $prompt_status
        set_color normal

        echo -n "$suffix "
end

function fish_right_prompt --description 'My custom prompt, right side'
        set -g __fish_git_prompt_show_informative_status 1
        set -g __fish_git_prompt_hide_untrackedfiles 1
        set -g __fish_git_prompt_color_branch magenta --bold
        set -g __fish_git_prompt_showupstream informative
        set -g __fish_git_prompt_color_dirtystate blue
        set -g __fish_git_prompt_color_stagedstate yellow
        set -g __fish_git_prompt_color_invalidstate red
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        set -g __fish_git_prompt_color_cleanstate green --bold

        printf '%s ' (fish_vcs_prompt)
end
