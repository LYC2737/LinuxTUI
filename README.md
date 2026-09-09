# Linux TUI 프로그램 제작하기

## 프로젝트 소개
* **목표**: whiptail을 이용해 쉘스크립트 TUI 제작해보기  
* **개발 기간**: 2026.09.09 ~ 2026.09.09  
* **제작자**: 이연창  

## 주요 기능
1. **System 정보확인**: OS 버전, Hostname, IP정보, Routing 정보, df정보
2. **Erro Log확인**: journalctl -p 3옵션으로 확인(OS버전 확인할 것)
3. **Service 조회**: 4가지 서비스 선택하여 액티브 상태와 status정보 조회

## 사용방법
```bash
# 1. git clone
# git clone git@github.com:LYC2737/LinuxTUI.git
git clone https://github.com/LYC2737/LinuxTUI.git

# 2. 디렉토리 이동
cd LinuxTUI

# 3. 실행권한 부여
sudo chmod +x TUI.sh

# 4. 실행 
bash TUI.sh
```
