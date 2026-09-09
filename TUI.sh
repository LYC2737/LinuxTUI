#!/bin/bash

# 임시파일 생성 및 삭제 트리거 작성
TEMP=$(mktemp)
trap 'rm -f $TEMP' EXIT

# TUI 메뉴창 만들기

while true; do

        MENU=$(whiptail --title "Menu" --menu "select your choice" 12 30 4 \
        "1" "System Info"\
        "2" "Error Log" \
        "3" "Service Info" \
        "4" "Exit" 3>&1 1>&2 2>&3)


if [ $? -ne 0 ]; then
	exit 1
fi

done 
