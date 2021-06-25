#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Your current branch is $BRANCH"

branchType=${BRANCH:0:4}
if [ "$branchType" == "feat" ] || [ "$branchType" == "dvbg" ] || [ "$branchType" == "hfbg" ]
then
    echo "$(tput setaf 1) ***** git cherry-pick is not applicable for this branch. **** "
    exit;
fi

if [[ "$branchType" == "qabg" ]]
then
    parentBranch='release/next'
fi


if [[ "$BRANCH" != "$parentBranch" ]]
then
    git pull origin $BRANCH
    git checkout main
    git pull origin main
    git checkout $parentBranch
    git pull origin $parentBranch    
fi

cherryPickCommitIdList=$(git log $BRANCH --not main release/next --oneline --no-merges --pretty=format:"%h|" --reverse)
cherryPickArr=($(echo "$cherryPickCommitIdList" | tr '|' '\n'))

for element in "${cherryPickArr[@]}"
do
    if [[ "$element" != "" ]]
    then
        echo "$(tput setaf 2) Invoke the cherry-pick for $element......"
        git cherry-pick $element
        git push origin $parentBranch
        echo "$(tput setaf 2) **************** Cherry-pick is initiated for $element *************************"
    else
        echo "$(tput setaf 1) ************************************************
            ********** Commit Id is not valid, Please contact with administrator!!   ****************************"
    fi
done
