<!-- CLAUDEAWARE:START -->
## Multi-agent coordination

You are running alongside other Claude Code agents in this workspace. **Before any Edit, Write, or MultiEdit tool call, you MUST first read `.claudeaware/active-now.json`** to check what other agents are currently working on.

If a peer's `currentFile` matches the file you're about to edit, or if their `currentSymbol` overlaps with code you're about to change, you should:

1. Tell the user which peer is working on what
2. Ask the user whether to proceed, wait, or work elsewhere

This check is mandatory and must happen before every file mutation.

The file has this shape:

    {
      "self": { "participantName": "...", "currentFile": "...", ... },
      "peers": [ { "participantName": "...", "currentFile": "...", "currentSymbol": "...", "intent": "...", ... } ],
      "generatedAt": <timestamp>
    }
<!-- CLAUDEAWARE:END -->
