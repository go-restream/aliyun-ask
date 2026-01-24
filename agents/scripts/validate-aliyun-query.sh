#!/bin/bash
# Validates aliyun CLI commands to only allow read-only query operations
# This script blocks write/modification operations to ensure query-only access

# Read JSON input from stdin
INPUT=$(cat)

# Extract the command field from tool_input using jq
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
    exit 0
fi

# Check if this is an aliyun command
if ! echo "$COMMAND" | grep -qE '^\s*aliyun'; then
    # Not an aliyun command, allow it
    exit 0
fi

# Block write operations in aliyun CLI
# Common write operations include: create, delete, update, modify, attach, detach, start, stop, restart, etc.
if echo "$COMMAND" | grep -iE '\b(aliyun\s+\w+\s+(create|delete|update|modify|attach|detach|start|stop|restart|remove|add|set|enable|disable|allocate|release|bind|unbind|authorize|revoke|import|export|push|pull|deploy|undeploy|activate|deactivate|upgrade|downgrade|resize|scale|migrate|clone|copy|move|rename|replace|swap|tag|untag))\b' > /dev/null; then
    echo "Blocked: Write operations are not allowed. This subagent only supports read-only queries for Aliyun resources." >&2
    echo "Blocked command: $COMMAND" >&2
    exit 2
fi

# Additional check for common modification patterns
# Block operations with specific flags that indicate modification
if echo "$COMMAND" | grep -iE '\s--?(force|confirm|auto-approve|yes-assume)\b' > /dev/null; then
    echo "Blocked: Auto-confirmation flags are not allowed for safety reasons." >&2
    echo "Blocked command: $COMMAND" >&2
    exit 2
fi

exit 0
