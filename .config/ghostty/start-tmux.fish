#!/usr/bin/env fish

set SESSION_NAME "ghostty"

# Check if tmux server is running
if not tmux list-sessions 2>/dev/null
    # No tmux server running, start one and try to restore
    tmux new-session -d -s $SESSION_NAME

    # Give tmux a moment to initialize
    sleep 0.5

    # Try to restore saved sessions
    if test -e ~/.local/share/tmux/resurrect/last
        tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
    end

    tmux attach-session -t $SESSION_NAME
else
    # Tmux server is running, check for our session
    if tmux has-session -t $SESSION_NAME 2>/dev/null
        # Session exists, just attach
        tmux attach-session -t $SESSION_NAME
    else
        # No ghostty session but tmux is running (probably restored sessions)
        # Either attach to first available or create new
        set sessions (tmux list-sessions -F "#{session_name}" 2>/dev/null)

        if test (count $sessions) -gt 0
            # Attach to first available session
            tmux attach-session -t $sessions[1]
        else
            # No sessions at all, create one
            tmux new-session -s $SESSION_NAME
        end
    end
end
