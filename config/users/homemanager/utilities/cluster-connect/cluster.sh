#!/usr/bin/env bash
export BORDER="rounded"

address="cchmc-cluster"

gum style 'Cluster actions'
action=$(gum choose "connect" "connectp2" "copy to" "copy from", "write ssh config")
if [ "$action" == "connect" ]; then
    ssh -t $address  tmux new -A -s lewt2p
elif [ "$action" == "connectp2" ]; then
    ssh -t cchmc-cluster2  tmux new -A -s lewt2p
elif [ "$action" == "copy from" ]; then
    gum style "enter cluster path"
    cluster_path=$(gum input)
    gum style "enter local path"
    local_path=$(gum input)
    gum confirm && gum spin --spinner points --title "copying..." -- scp "$address:$cluster_path" "$local_path"
elif [ "$action" == "copy to" ]; then
    gum style "enter local path"
    local_path=$(find . | gum filter)
    gum style "enter cluster path"
    cluster_path=$(gum input --value="~/$local_path")
    gum confirm && gum spin --spinner points --title "copying..." -- scp "$local_path" "$address:$cluster_path"
elif [ "$action" == "write ssh config" ]; then
    { echo "Host cchmc-cluster";
      echo "  HostName bmiclusterp1.chmcres.cchmc.org";
      echo "  User lew4xi";
      echo "  ProxyJump lew4xi@ssh.research.cchmc.org"; } >> ~/.ssh/config
fi
