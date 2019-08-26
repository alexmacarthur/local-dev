# Copy the last commit in a branch.
# If a branch name is passed as an argument, get last commit from that branch.
function clc {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    RESET="\033[0m"

    function copyLastCommit {
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
        LAST_COMMIT_SHA=$(git rev-parse HEAD)
        echo "$LAST_COMMIT_SHA" | pbcopy
        echo "Copied ${GREEN}${LAST_COMMIT_SHA} ${RESET}from the ${BRANCH} branch."
    }

    if [ ! -z "$1" ]; then
        if git checkout $1 >/dev/null; then
            copyLastCommit
            git checkout - >/dev/null
        else
            echo "${RED}Checkout failed. Did not copy anything."
        fi
    else
        copyLastCommit
    fi
}
