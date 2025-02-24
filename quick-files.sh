#!/bin/bash


_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/quick-files.txt"

readarray -t quick_files < <( envsubst < "$_FILE")

# TODO: fix what happens if you want to open a file that needs a terminal based program
# TODO: Fix what happens if you add a file that doesnt exist
find_icon(){
  # doesnt have to be full path
  desktop_file=$1
  awk_args=(-F= '/^Icon=/ && !found {print $2; found=1}')
  dirs_to_search=${XDG_DATA_DIRS//://applications }
  if [[ $(command -v fd) ]]; then
    fd -u "$desktop_file" $dirs_to_search -x awk "${awk_args[@]}" 2>/dev/null
    exit
  fi

  find $dirs_to_search -name "$desktop_file" -exec awk "${awk_args[@]}" {} \; 2>/dev/null
}


formatted=""

for idx in "${!quick_files[@]}"; do
  filename=${quick_files[$idx]}
  _desktop_file=$(xdg-mime query default $(xdg-mime query filetype $filename))
  icon=$(find_icon $_desktop_file)
  formatted_name="$idx. $(basename $filename)"
  formatted="$formatted$formatted_name\0icon\x1f${icon:-libreoffice}\n"
done

selected=$(echo -ne "$formatted" | rofi -i -dmenu -show-icons -mesg "Open your most recent files. Intended for files that are not opened with terminal based programs" -p "Quick Open")

[ -z "$selected" ] && exit 1

# extract selected index
selected_idx=${selected%%.*}


xdg-open ${quick_files[$selected_idx]}
