# Copy the last commit in a branch. 
# Passing a branch name will checkout that branch, copy the last commit, and return to previous branch.
function clc {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    RESET="\033[0m"

    function copy_last_commit {
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
        LAST_COMMIT_SHA=$(git rev-parse HEAD)
        echo "$LAST_COMMIT_SHA" | tr -d '\n' | pbcopy
        echo "Copied ${GREEN}${LAST_COMMIT_SHA} ${RESET}from the ${BRANCH} branch."
    }

    if [ ! -z "$1" ]; then
        if git checkout $1 >/dev/null; then
            copy_last_commit
            git checkout - >/dev/null
        else
            echo "${RED}Checkout failed. Did not copy anything."
        fi
    else
        copy_last_commit
    fi
}
