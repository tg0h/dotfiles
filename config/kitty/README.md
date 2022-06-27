# README

Run kitty as kitty --config=NONE
add homebrew to path so that kitty launch scripts can use homebrew packages
exe_search_path /opt/homebrew/bin

- globinclude does not work nicely

```zsh
  globinclude **/*.conf # will include the kitty.conf file recursively :(
  globinclude [!kitty]*.conf - does not exclude kitty.conf
```

## todo

- pretty status bar
- shortcuts to go to tab
- send command to next pane
