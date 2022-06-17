# README

the fuzzy switcher provides quick navigation throughout the terminal

define shortcut keys for any folder, compile and then go to or search these folders quickly.

it uses fzf and fd

- the files are [here](/lib/zsh/utilities/dir-switcher)

- config

  - configuration stored in config.yml
    - bindkey - the shortcut key to use
    - dir - the directory to search
    - depth - how many sub directories to show in the preview
    - to only show git folders, add
      - glob: \\.git$
      - show-hidden: true
      - show-ignore: true
      - xargs: dirname

- compilation
  - the \_fsc function reads the config file and generates the following shortcuts for each bindkey
    - o\<bindkey\> - search both directories and files
    - u\<bindkey\> - search files only
    - e\<bindkey\> - search directories only
    - .\<bindkey\> - search filename and content
    - :\<bindkey\> - cd to directory

After editing the config file, compile the shortcuts with `_fsc` (fuzzy switcher compile) and restart the terminal
