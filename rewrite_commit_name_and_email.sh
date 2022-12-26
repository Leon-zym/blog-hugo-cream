#!/bin/sh

git filter-branch -f --env-filter '

# OLD_EMAIL="leonzym97@gmail.com"
# OLD_EMAIL="leon.zym@qq.com"
# OLD_EMAIL="leon@Leon-laptop.local"
# OLD_EMAIL="zhangyiming@sightp.com"
OLD_EMAIL="leon@LeondeMacBook-Pro.local"
NEW_NAME="Leon Zhang"
NEW_EMAIL="leon.zym@qq.com"


if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$NEW_NAME"
    export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$NEW_NAME"
    export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags