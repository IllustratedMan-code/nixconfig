#!/usr/bin/env bash

remote="$1@$2"

ssh "$remote" "mkdir -p /users/$1/.envs/"
scp ~/.emacs.d/remote/*.sh "$remote:/users/$1/.envs/"
