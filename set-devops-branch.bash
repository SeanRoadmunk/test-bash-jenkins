#!/bin/bash

eval $(ssh-agent) > /dev/null
echo "$GIT_SSH_PASSPHRASE" | ssh-add "$GIT_SSH_KEY_PATH"

if [ -z "$devopsBranch" ]; then
  if [ "git ls-remote --heads git@github.com:Roadmunk/devops.git $branch" ]; then
      echo "Branch named $branch does exist"
      devopsBranch_name=$branch
  else
      echo "Branch named $branch does not exist"
      devopsBranch_name="dev"
  fi


  if [ "$server" = "rc" ]; then
    devopsBranch_name="rc"
  fi
  if [ "$server" = "demo" ]; then
    devopsBranch_name="master"
  fi
else
	devopsBranch_name=$devopsBranch
fi

echo "DEVOPS_BRANCH=$devopsBranch_name"
echo "DEVOPS_BRANCH=$devopsBranch_name" > env.properties
