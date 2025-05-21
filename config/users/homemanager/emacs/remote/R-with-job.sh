#!/bin/bash
source /etc/bashrc

source /data/weirauchlab/common/lab_bashrc


module load R
exec bsub -Is -W4:00 -M8000 -n1 "module load R && R $@"
