# Linux TUI 프로그램 (sysmenu)

## 프로젝트 소개
* **목표**: whiptail을 활용한 TUI 기반 시스템 관리 셸 스크립트 제작 및 RPM 패키징
* **개발 기간**: 2026.09.09 ~ 2026.09.10
* **제작자**: 이연창

## 주요 기능
1. **System 정보 확인**: Hostname, IP 정보, Routing Table, 디스크(df) 정보
2. **Error Log 확인**: `journalctl -p 3` 옵션을 이용한 심각한 오류 로그 조회
3. **Service 조회**: SSH, Apache, NTP, Firewall 등 주요 서비스의 Active 상태 및 상세 Status 확인

---

## 사용 방법

상황에 맞게 **[방법 1] RPM 패키지 설치** 또는 **[방법 2] 소스 코드 직접 실행** 중 선택하여 진행합니다.

### 방법 1. RPM 패키지 설치 (권장)
GitHub Release에 배포된 `.rpm` 파일로 의존성 패키지와 함께 한 번에 설치하여 사용합니다.

```bash
# 1. RPM 패키지 다운로드 및 설치
sudo dnf install -y [https://github.com/LYC2737/LinuxTUI/releases/download/v1.0.0/sysmenu-1.0-1.el9.noarch.rpm](https://github.com/LYC2737/LinuxTUI/releases/download/v1.0.0/sysmenu-1.0-1.el9.noarch.rpm)

# 2. 어디서나 명령어 입력으로 실행
sysmenu
```

### 방법 2. 소스 코드 직접 실행
```bash
# 1. 저장소 클론 및 디렉토리 이동
git clone [https://github.com/LYC2737/LinuxTUI.git](https://github.com/LYC2737/LinuxTUI.git)
cd LinuxTUI

# 2. 실행 권한 부여
chmod +x sysmenu.sh

# 3. 스크립트 실행
./sysmenu.sh
```

