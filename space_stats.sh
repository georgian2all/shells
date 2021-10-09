#!/bin/bash

check_disk_space() {

  # Human friendly available disk space
  HF_AV_DISK_SPACE=$(df -h $1 | awk 'NR==2 {print $4}' )

  # Human friendly available disk space
  HF_USED_DISK_SPACE=$(df -h $1 | awk 'NR==2 {print $3}' )

  # Human friendly total disk space
  HF_TOTAL_DISK_SPACE=$(df -h $1 | awk 'NR==2 {print $2}' )

  TARGET_PART=$(df -h $1 | awk 'NR==2 {print $1}')

  echo "Analyzed filesystem: ${TARGET_PART}"
  echo "Available disk space: ${HF_AV_DISK_SPACE}"
  echo "Used disk space: ${HF_USED_DISK_SPACE}"
  echo "Total disk capacity: ${HF_TOTAL_DISK_SPACE}"
}


while getopts s: flag
do
    case "${flag}" in
        s) analized_path=${OPTARG};;
    esac
done

check_disk_space $analized_path
