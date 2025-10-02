#!/bin/bash


set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib. Syntax is...
# check <LABEL> <cmd> [args...]

check "validate zsh history HISTFILE" cat /root/.zshrc | grep 'HISTFILE=/root/.history/zsh_history'
check "validate zsh history HISTSIZE" cat /root/.zshrc | grep 'HISTSIZE=1000000000'
check "validate zsh history HISTFILESIZE" cat /root/.zshrc | grep 'HISTFILESIZE=1000000000'
check "validate zsh history HIST_IGNORE_ALL_DUPS" cat /root/.zshrc | grep 'setopt HIST_IGNORE_ALL_DUPS'
check "validate zsh history INC_APPEND_HISTORY" cat /root/.zshrc | grep 'setopt INC_APPEND_HISTORY'
check "validate zsh history HISTTIMEFORMAT" cat /root/.zshrc | grep 'HISTTIMEFORMAT="%F, %T "'

# check "validate zsh history env var HISTFILE" zsh -c 'echo $HISTFILE'
# # | grep '/root/.history/zsh_history'
# check "validate zsh history HISTSIZE" zsh -c 'echo $HISTSIZE'
# | grep '1000000000'
# check "validate zsh history HISTFILESIZE" cat /root/.zshrc | grep 'HISTFILESIZE=1000000000'
# check "validate zsh history HIST_IGNORE_ALL_DUPS" cat /root/.zshrc | grep 'setopt HIST_IGNORE_ALL_DUPS'
# check "validate zsh history INC_APPEND_HISTORY" cat /root/.zshrc | grep 'setopt INC_APPEND_HISTORY'
# check "validate zsh history HISTTIMEFORMAT" cat /root/.zshrc | grep 'HISTTIMEFORMAT=%F, %T '

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
