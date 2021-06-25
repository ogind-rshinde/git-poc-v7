#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo $BRANCH



# PARENT_COMMIT_ID=$(git reflog --pretty=format:"%h" $BRANCH | tail -n 1)
# echo $PARENT_COMMIT_ID
# echo "**********************************"
# for j in $(git reflog origin/main --pretty=format:'%h')
# do
#   echo "$j"
# done