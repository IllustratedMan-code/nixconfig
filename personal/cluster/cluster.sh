#!/usr/bin/env bash
export BORDER="rounded"

address="osc"

gum style 'Cluster actions'
action=$(gum choose "connect" "copy to" "copy from")
if [ "$action" == "connect" ]; then
    ssh -Y -t $address  tmux new -A -s lewt2p
elif [ "$action" == "copy from" ]; then
    gum style "enter cluster path"
    cluster_path=$(gum input)
    gum style "enter local path"
    local_path=$(gum input)
    gum confirm && gum spin --spinner points --title "copying..." -- scp "$address:$cluster_path" $local_path
elif [ "$action" == "copy to" ]; then
    gum style "enter local path"
    local_path=$(ls . | gum filter)
    gum style "enter cluster path"
    cluster_path=$(gum input --value="~/$local_path")
    gum confirm && gum spin --spinner points --title "copying..." -- scp $local_path "$address:$cluster_path"
fi


