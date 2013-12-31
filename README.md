dircolors-jellybeans
====================

Dircolors suitable for use with
[jellybeans.vim](https://github.com/nanotech/jellybeans.vim)

## Installation

Download the latest
[dircolors.jellybeans](https://raw.github.com/peterhellberg/dircolors-jellybeans/master/dircolors.jellybeans)
and put it in `$HOME/.dircolors` (which under Ubuntu will be loaded on login,
probably true for other distros as well)

## iTerm2 Configuration

This is how I have configured Colors and Text rendering in
[iTerm2](http://www.iterm2.com/)

### Colors
![Colors](http://assets.c7.se/skitch/iterm2_colors-131231.png)

### Text rendering
![Text rendering](http://assets.c7.se/skitch/iterm2_text_rendering-131231.png)

## Testing

Clone the repo to a machine running some kind of Linux, then `./run_test.sh`

It will then proceed to install (if missing) and use
[rerun](https://github.com/alexch/rerun/) in order to reload
`test.sh` each time `dircolors.jellybeans` or `test.sh` is saved.

#### Arguments passed to rerun
```bash
rerun -x -b -p "**/{dircolors.jellybeans,test.sh}" -- ./test.sh
```

## test.sh

A simple Bash script that generates a bunch of files
and then lists them using the colors from `dircolors.jellybeans`
