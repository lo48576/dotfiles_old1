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

export PATH="/usr/libexec:$PATH"
