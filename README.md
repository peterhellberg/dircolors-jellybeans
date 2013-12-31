dircolors-jellybeans
====================

Dircolors suitable for use with
[jellybeans.vim](https://github.com/nanotech/jellybeans.vim)

## Installation

```
curl https://raw.github.com/peterhellberg\
/dircolors-jellybeans/master/dircolors.jellybeans -o ~/.dircolors.jellybeans
```

You probably want to symlink `.dircolors.jellybeans` to `.dircolors`

## iTerm2 Configuration

This is how I have configured Colors and Text rendering in
[iTerm2](http://www.iterm2.com/)

### Colors
![Colors](http://assets.c7.se/skitch/iterm2_colors-131231.png)

### Text rendering
![Text rendering](http://assets.c7.se/skitch/iterm2_text_rendering-131231.png)

## Testing

I’ve written a simple Bash script that generates a bunch of files and then lists
them using the colors from `dircolors.jellybeans`.

`./run_test.sh` will install and use [rerun](https://github.com/alexch/rerun/)
in order to reload `test.sh` each time
`dircolors.jellybeans` or `test.sh` is saved.

### Arguments passed to rerun:

```bash
rerun -x -b -p "**/{dircolors.jellybeans,test.sh}" -- ./test.sh
```
