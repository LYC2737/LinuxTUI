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
	"2")	# Error Log 출력
		journalctl -p 3 > $TEMP
		
		# 에러로그 화면출력
		whiptail --title="Error Log" --scrolltext --textbox "$TEMP" 30 100	
		;;

	"3")	# Srvice 내용
		# while로 루프 만들기2(마지막에 break넣어서 빠져나가게끔 작업할 것)
                        while true; do
                                # SVC 선언(checklist로 원하는 서비스 선택하게끔, 파일에서 목록 불러오는 식으로 확장할 것)
                                SVC=$(whiptail --title "Service Choose" --checklist "select services" 10 40 4\
                                "sshd" "SSH Daemon" OFF\
                                "httpd" "Apache Daemon" OFF\
                                "chronyd" "NTP Daemon" OFF\
                                "firewalld" "Firewall Daemon" OFF 3>&1 1>&2 2>&3)
                                # 서비스 선택이 정상 완료되지 않았을 때의 처리(경고장 출력 및 초기화면으로 돌아가기)
                                STATUS=$?
                                if [ $STATUS -ne 0 ] || [ -z "$SVC" ]; then
                                        whiptail --title "Warning" --msgbox "취소 하셨거나 서비스 선택하지 않으셨습니다 메뉴로 돌아갑니다" 10 40
                                        break
                                fi
                                # 서비스 활성상태 확인
                                whiptail --title "Service Status" --yesno "서비스활성화 유무 확인하시겠습니까?" 10 40
                                # if로 분기처리
                                if [ $? -ne 0 ]; then
                                        # 경고창 출력 및 초기화면 돌아가기
                                        whiptail --title "Warning" --msgbox "서비스 화면으로 돌아가기" 10 40
                                        continue
                                fi
                                > $TEMP #변수초기화
                                # for문으로 정보 수집
                                for i in $(echo "$SVC"|sed 's/"//g'); do
                                        echo "${i}: $(systemctl is-active $i)"|tr '[a-z]' '[A-Z]' >> $TEMP
                                done
                                # 서비스 활성상태 출력
                                whiptail --title "Service Active" --textbox "$TEMP" 10 40
                                # 추가) 서비스 STATUS 확인 
                                whiptail --title "Service Status" --yesno "서비스 상태정보 확인하시겠습니까?" 10 40
                                # if로 분기(NO일경우 break로 넘겨서 프로그램 종료)
                                if [ $? -ne 0 ]; then
                                        whiptail --title "Warning" --msgbox "프로그램 종료" 10 40
                                        clear
                                        echo "프로그램 종료"
                                        exit 0  # 정상종료
                                fi
                                # 서비스STATUS 확인 및 저장
                                > $TEMP
                                for i in $(echo "$SVC"|sed 's/"//g'); do
                                        echo "=== $i status ===" | tr '[a-z]' '[A-Z]' >> $TEMP
                                        systemctl status $i >> $TEMP 2>&1
                                        printf "\n\n" >> $TEMP
                                done
                                # 서비스 Status 화면출력
                                whiptail --title "Service Status" --scrolltext --textbox "$TEMP" 30 120
                                break
                        done
		;;
	"4")	# EXIT 설정
		exit 0
		;;
esac

done 
