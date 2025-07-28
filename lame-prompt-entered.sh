#!/bin/bash

# OPENCODE_PROMPT_ENTERED hook for jujutsu workflow
# Automatically commits changes after each prompt/change

# Check for modifications using jj status
jj_output=$(jj status 2>/dev/null)
jj_exit_code=$?

# If jj command fails, exit silently (not a jj repo or jj not installed)
if [ $jj_exit_code -ne 0 ]; then
    exit 0
fi

# Check if there are changes to commit
if echo "$jj_output" | grep -q "Working copy changes:"; then
    # Extract a simple description from the changes or use a default
    # Use conventional commit format when possible
    commit_msg="feat: opencode changes"
    
    # Try to create a more descriptive message based on file types
    if echo "$jj_output" | grep -q "\.ts\|\.js\|\.tsx\|\.jsx"; then
        commit_msg="feat: update TypeScript/JavaScript code"
    elif echo "$jj_output" | grep -q "\.py"; then
        commit_msg="feat: update Python code"
    elif echo "$jj_output" | grep -q "\.go"; then
        commit_msg="feat: update Go code"
    elif echo "$jj_output" | grep -q "\.md\|\.txt"; then
        commit_msg="docs: update documentation"
    elif echo "$jj_output" | grep -q "\.json\|\.yaml\|\.yml\|\.toml"; then
        commit_msg="config: update configuration files"
    elif echo "$jj_output" | grep -q "test\|spec"; then
        commit_msg="test: update tests"
    fi
    
    # Commit the changes
    jj commit -m "$commit_msg" --author "opencode <opencode@jgaines.com>"
    
    # Optional: Print confirmation
    echo "Committed changes: $commit_msg"
    echo "Before new prompt: $PROMPT_TEXT"
fi
