#
# ~/.bash_profile: The personal initialization file, executed for login shells.
#
# Login shells are those you login from another host, or login at the text
# console of a local unix machine.

# .bashrc is only read by a shell that's both interactive and non-login
# so I tell .bash_profile to also read .bashrc.
# http://stackoverflow.com/questions/415403/whats--difference-between-bashrc-bash-profile-and-environment
[[ -r ~/.bashrc ]] && . ~/.bashrc

