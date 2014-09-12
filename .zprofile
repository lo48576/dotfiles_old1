# .zprofile is loaded only from login shell.
:<<'#COMMENT_OUT_SSH_AGENT'
# FIXME: Error sometimes occurs.
#        Is this bug of ps than zsh?
#        Below is the error message.
#   Signal 18 (CONT) caught by ps (procps-ng version 3.3.9).
#   ps:display.c:66: please report this bug
PPPID="`ps h -o ppid -p $PPID`"
PNAME="`ps h -o cmd -p $PPID | cut -d' ' -f 1`"

# Run ssh-agent only when the shell is runned as (truly) login shell.
# tmux runs shell as login shell but I don't want to run ssh-agent then.
if [ "$PPPID" -eq 1 ] && [ "$PNAME" '!=' "tmux" ] ; then
	echo -n "SSH "
	eval `ssh-agent`
fi
#COMMENT_OUT_SSH_AGENT

# Run ssh-agent if SSH_AGENT_PID is not set (i.e. ssh-agent is not running).
if [ -z "$SSH_AGENT_PID" ] ; then
	echo -n "SSH "
	eval `ssh-agent`
fi

if [ -z "$TMUX" ] ; then
	# maybe running in virtual console such as getty or agetty.
	# 16 colors only available, but blue is so dark and hard to read blue characters.
	# change color code of blue to #003eff.
	# my favorite setting is in ~/.mlterm/color
	echo -en '\e]P0000000'
	echo -en '\e]P1cc0000'
	#echo -en '\e]P200aa00'
	# it is also hard to distinguish #00aa00 (dark green) and #00aaaa (dark cyan).
	echo -en '\e]P255bb00'
	echo -en '\e]P3fcaf3e'
	#echo -en '\e]P4003eff'
	echo -en '\e]P40055ff'
	echo -en '\e]P5aa00aa'
	echo -en '\e]P600aaaa'
	echo -en '\e]P7bbbbbb'
	echo -en '\e]P8555555'
	echo -en '\e]P9ff5555'
	echo -en '\e]Pa55ff55'
	echo -en '\e]Pbffff55'
	echo -en '\e]Pc6985f4'
	echo -en '\e]Pdff55ff'
	echo -en '\e]Pe55ffff'
	echo -en '\e]Pfffffff'
fi

export PATH="/usr/libexec:$PATH"
