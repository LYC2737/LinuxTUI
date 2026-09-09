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

# CASE 구문 사용하여 메뉴 선택시 분기 실행
case $MENU in
	"1")	# 메뉴 1번, System Info 
		echo "=== Host Name ===" > $TEMP
		echo "HostName: $(hostname)" >> $TEMP
		printf "\n\n" >> $TEMP

		echo "=== IP info ===" >> $TEMP
		ip  -4 -o a sh |awk '{print "Interface: " $2 " --> IP: " $4}' |column -t >> $TEMP
		printf "\n\n" >> $TEMP

		echo "=== Routing Table ===" >> $TEMP
		ip route |column -t >> $TEMP
		printf "\n\n" >> $TEMP

		echo "=== df info ===" >> $TEMP
		df -TPh >> $TEMP

		# $TEMP로 받은 내용 화면에 출력하기
		whiptail --title="System Info" --scrolltext --textbox "$TEMP" 30 100	
		;;
	"2")
		;;

	"3")
		;;
	"4")
		;;
esac

done 
