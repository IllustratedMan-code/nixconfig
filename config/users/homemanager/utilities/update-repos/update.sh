#!/usr/bin/env bash


update(){
    cd "$1"
    git add .
    git commit -m "Robo Update"
    git push
}

