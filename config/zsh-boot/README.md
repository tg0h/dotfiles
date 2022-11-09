# ZSH env, rc Setup

## compiling functions

instead of autoloading functions via

```bash
setopt EXTENDED_GLOB # use ~ to exclude patterns in file globbing
fpath=($HOME/.local/lib/zsh/***/*~*/archive*(/) $fpath) # / matches directories, exclude archive/
for func in $HOME/.local/lib/zsh/***/*~(*/archive/*|*.zsh)(.); do
  autoload $func
done
unsetopt EXTENDED_GLOB
```

I compile my functions into a single directory and then source this directory

```bash
export ZSH_FUNCTIONS_PATH="$HOME/.local/lib/zsh-functions"
export ZSH_FUNCTIONS_COMPILED_PATH="$HOME/.local/lib/zsh-functions-compiled"

# autoload zsh functions - loading from a single directory provides a speedup of up to 0.05
fpath=($ZSH_FUNCTIONS_PATH $ZSH_FUNCTIONS_COMPILED_PATH $fpath)
autoload $ZSH_FUNCTIONS_PATH/*
autoload $ZSH_FUNCTIONS_COMPILED_PATH/*
```

this is faster

## ZSH rc file load order

zsh rc load order
https://scriptingosx.com/2019/06/moving-to-zsh-part-2-configuration-files/
https://www.reddit.com/r/zsh/comments/dwwq6l/trying_to_move_my_z_dotfiles_into_configzsh_but/f7m8z3h/
login vs non-login
interactive vs non-interactive

The files in /etc/ will be launched (when present) for all users.
etc zprofile, zshrc, and zlogin
The .z\* files only for the individual user

before every .zsh file, the corresponding /etc/zsh file is run
eg
/etc/zshenv is run before .zshenv
/etc/zprofile is run before .zprofile
/etc/zshrc is run before .zshrc

zprofile is an analog of bash's and sh's profile
zlogin is an analog for ksh's login files

### zsh login interactive

(apart from the /etc/zshenv file, the other etc files are not shown for brevity)
/etc/zshenv > zshenv > zprofile > zshrc > zlogin ... > zlogout

### zsh login non-interactive

/etc/zshenv > zshenv > zprofile > zlogin ... > zlogout

- rare -

### zsh non-login interactive

/etc/zshenv > zshenv > zshrc

### zsh non-login non-interactive

/etc/zshenv > zshenv

- when running script or command ?

### References

- https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell

## ZSH Files

### zshrc

- aws completion

enable aws completion - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html

- fonts - https://github.com/powerline/fonts.git
- iterm2 color scheme - aurora with black background

- oh-my-zsh

note that custom plugins and themes are stored in the
$XDG_DATA_HOME/oh-my-zsh/custom dir

- zshenv

source functions here so they are available to a non-interactive shell?
eg zsh -c <function name> will work

```bash
# the **/* glob is peculiar to zsh, allows zsh to search recursively
# *** glob follows symlinks
for f in ~/.local/lib/zsh/***/*; do [[ -f $f ]] && . $f; done
```

- zsh functions

```zsh
fpath+=~/.local/lib/zsh_functions #add our own zsh functions directory to fpath
# https://stackoverflow.com/questions/30840651/what-does-autoload-do-in-zsh
# use functions modify your shell environment
# whereas scripts get their copy of the shell process
# autoload tells zsh where to find the function
autoload -Uz ~/.local/lib/zsh_functions/*(.) #-U supress alias expansion, -z zsh style function loading. (.) - glob qualifier. dot means show regular files only
autoload -U zmv # add the zsh zmv extension
# . ~/.local/lib/zsh_funcs.zsh #get all my functions
```

- zsh
  zsh vim mode settings
  see http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html for the docs on the -v option

```zsh
bindkey -v
```

## XDG

References:

- https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
- https://wiki.archlinux.org/title/XDG_Base_Directoryhttps://wiki.archlinux.org/title/XDG_Base_Directory

### CONFIG

### DATA

https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s11.html
analogous to /usr/share
what is /usr
single user (safe mode ...) mode vs multi-user mode (/usr)
what is /usr vs /usr/local
historically, when disk space was expensive, /usr was shared over nfs while
whatever was particular to a computer was in /usr/local
software in / or /usr may be overwritten by system upgrades, let the sysadmin
have full reign over /usr/local
Any program or package which contains or requires data that doesn't need to be
modified should store that data in /usr/share (or /usr/local/share, if installed
locally).

export XDG_DATA_HOME=$HOME/.local/share

### STATE

state data that should persist between (application) restarts, but that is not
important or portable enough to the user that it should be stored in
$XDG_DATA_HOME. It may contain:
actions history (logs, history, recently used files)
current state of the application that can be reused on a restart (view, layout, 
open files, undo history) analogous to /var/lib
export XDG_STATE_HOME=$HOME/.local/state

### CACHE

### RUNTIME

not currently in use

## Android

my phones
android 11 wireless debugging changes the port and turns off wireless debugging
when you restart the wifi
not convenient!
store the handphone ip and serial numbers an env variables
