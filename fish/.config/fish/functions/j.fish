function j
	# cd (fd --full-path --search-path $HOME --color never --type directory -E Library -E Applications | fzf --reverse --height 10 --prompt "Jump to Dir: ")
	cd (fd --full-path --search-path $HOME --color never --type directory -E Library -E Applications | fzy)
end
