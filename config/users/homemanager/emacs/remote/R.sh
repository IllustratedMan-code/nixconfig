#!/bin/bash
source /etc/bashrc

source /data/weirauchlab/common/lab_bashrc


module load R
exec R "$@"

