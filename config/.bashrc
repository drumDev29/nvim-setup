
#  ╔═════════════════════════════════════╗
#  ║          Custom Configuration       ║
#  ╚═════════════════════════════════════╝

alias n='nvim'
alias lg='lazygit'
alias ld='lazydocker'

# Add value to file at home if it doesn't exist, used to store values for other commands
# Usage examples:
#   add "dirhistory" "/home/user/projects"  # Adds path to .dirhistory file
#   add "customfile" "some text"            # Adds text to .customfile

add() {
	local file="$HOME/.$1"
	local value="$2"
	# Create file if it doesn't exist
	touch "$file"
	# Check if value exists in file
	if ! grep -Fxq "$value" "$file"; then
		# Prepend value to file
		echo "$value" | cat - "$file" >"$file.tmp" && mv "$file.tmp" "$file"
	fi
	# Display contents
	cat "$file"
}

get() {
	file="$HOME/.$1"
	cat "$file"
}

# Usage examples:
#   cdf          # default: depth=2, no save
#   cdf 3        # depth=3, no save
#   cdf -s       # depth=2, save to history
#   cdf -s 3     # depth=3, save to history
cdf() {
	local depth=50
	# Simple flag check
	if [ "$1" = "-s" ]; then
		local save=true
	fi

	dir=$(find . -maxdepth "$depth" -type d | fzf)
	if [ -n "$dir" ]; then
		if [ "$save" = true ]; then
			abs_dir=$(realpath "$dir")
			add "dirhistory" "$abs_dir"
		fi
		cd "$dir"
	fi
}

# Usage examples:
#   cdh          # fuzzy find through saved directory history
cdh() {
	selected=$(get "dirhistory" | fzf)
	if [ -n "$selected" ]; then
		cd "$selected"
	fi
}
