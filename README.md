# QuickFiles - Rofi Script


https://github.com/user-attachments/assets/46dfc55d-3fcc-4e32-b618-543230311cb4


## quick-files.sh

This script provides a quick way to open recently used files using a menu interface.
 It reads a list of file paths from a specified text file, displays them in a menu
 using `rofi`, and allows the user to select a file to open with the default application.

### Features:

* Reads file paths from `quick-files.txt` and substitutes environment variables.
* Finds and displays icons associated with the file types using desktop entries, if there is no associated icon it uses the default libreoffice icon
* Utilizes `fd` for faster file searching if available, otherwise falls back to `find`.
* Presents a formatted list of files with icons in a `rofi` menu.
* Opens the selected file using `xdg-open`.


### Dependencies:

* `rofi` for displaying the menu.
* `xdg-mime` and `xdg-open` for handling file types and opening files.
* `fd` (optional) for faster file searching.

### Usage:

Run the script to display a menu of recent files and select one to open.

### TODO:

I have tested this with `.ods` and `.docx` files only. Ultimately, this will depend on your configuration of default applications you have in your system.

- [ ] Handle unexisting files
- [ ] Handle files that require opening a terminal-based program
