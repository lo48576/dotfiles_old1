# .zprofile is loaded only from login shell.

# Run ssh-agent if SSH_AGENT_PID is not set (i.e. ssh-agent is not running).
if [ -z "$SSH_AGENT_PID" ] ; then
	echo -n "SSH "
	eval `ssh-agent`
fi

export PATH="/usr/libexec:$PATH"
