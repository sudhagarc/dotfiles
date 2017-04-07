# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH:.";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_colors,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set vim for everything
export EDITOR=vim
export VISUAL=vim
export SVN_EDITOR=vim

# Platform settings
export PLATFORM_NAME=`uname -s`
export PLATFORM_HW=`uname -m`
export PLATFORM=$PLATFORM_HW-$PLATFORM_NAME
export PREFIX=$HOME/$PLATFORM

# Python settings
export PYTHONPATH=

# History settings
# Unlimited history
export HISTFILESIZE=

# Tell the history builtin command to display history with a timestamp
export HISTTIMEFORMAT='%F %T  '

# But only keep a certain number of lines in memory
export HISTSIZE=10000

# Don't clutter the file with trivial one and two character commands
export HISTIGNORE="?:??:history*:"

# Don't clutter the file with consecutively repeated commands
export HISTCONTROL=ignoredups

# Disable ^S for stop
stty stop undef

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
shopt -s cdable_vars;

# Lets you cd to these directories from any directory
# by using the last node only (e.g. 'cd projects')
CDPATH='.:~:~/work:~/bin:~/projects'

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Set vi(m) mode
set -o vi

# Proxies
export http_proxy=
export https_proxy=
export no_proxy=
