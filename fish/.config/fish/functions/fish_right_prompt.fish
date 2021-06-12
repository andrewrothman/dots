function fish_right_prompt
    set -g __fish_git_prompt_showupstream auto
	set -g __fish_git_prompt_show_informative_status true
	set -g __fish_git_prompt_char_stateseparator " "
    echo (fish_git_prompt %s)
end
