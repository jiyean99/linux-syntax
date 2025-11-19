# =========================================
# 프로세스 / 패키지 / 네트워크 기본 명령어 치트시트
# =========================================

# -----------------------------------------
# 1. 프로세스 관련 명령어
# -----------------------------------------

# ps : 현재 쉘에서 실행 중인 프로세스 목록 간단 조회
ps

# ps -e / ps -ef : 시스템 전체 프로세스 목록을 더 자세히 조회
#  -e  : 모든 프로세스
#  -f  : full format (UID, PID, PPID, CMD 등 더 많은 정보)
ps -e
ps -ef

# ps -ef | grep "문자열" : 특정 프로세스를 이름/패턴으로 검색
#  - ps -ef 출력에서 grep으로 필터링
# 예) nginx 프로세스 찾기
ps -ef | grep "nginx"


# kill -9 [PID] : 프로세스를 강제 종료(SIGKILL)
#  - PID(Process ID)는 ps -ef 등으로 확인
#  - -9는 가장 강력한 종료 시그널이므로, 정말 필요할 때만 사용 권장
# 예) kill -9 12345
# ※ 실서비스/중요 프로세스에 함부로 쓰지 말 것
kill -9 12345


# -----------------------------------------
# 2. 패키지 관리 (yum / apt)
# -----------------------------------------

# yum : 레드햇 계열(RHEL, CentOS 등) 패키지 관리 도구
#  - 예) sudo yum install nginx
# apt : 데비안 계열(Debian, Ubuntu 등) 패키지 관리 도구
#  - 예) sudo apt install nginx

# 아래는 Ubuntu / Debian 계열 기준 예시:

# sudo apt update : 패키지 목록 최신화
#  - 저장소 인덱스를 갱신해서 "설치 가능한 최신 버전 목록" 업데이트
sudo apt update

# sudo apt install [프로그램] : 패키지(프로그램) 설치
# 예) nginx 웹 서버 설치
sudo apt install nginx


# -----------------------------------------
# 3. systemctl (서비스/데몬 프로세스 관리)
# -----------------------------------------

# systemctl : systemd 기반 서비스/프로세스 관리 도구
#  - start / stop / restart / status 등을 제공

# sudo systemctl start [서비스명] : 서비스(프로세스) 시작
# 예) nginx 시작
sudo systemctl start nginx

# sudo systemctl stop [서비스명] : 서비스(프로세스) 종료
sudo systemctl stop nginx

# sudo systemctl restart [서비스명] : 재시작
sudo systemctl restart nginx

# sudo systemctl status [서비스명] : 상태 조회
sudo systemctl status nginx


# -----------------------------------------
# 4. 서비스가 잘 실행됐는지 확인하는 방법
# -----------------------------------------

# 방법 1) 브라우저에서 확인
#  - 로컬 서버에서 웹 서버(예: nginx, apache)가 떠 있다면
#    PC의 브라우저(firefox, chrome 등) 주소창에:
#      http://localhost
#    를 입력해서 페이지가 열리는지 확인.

# 방법 2) 터미널에서 확인 (curl 등)
#  - curl localhost
#  - curl -I localhost   (헤더만 확인)


# 종료하는 또 다른 방법 (kill)
# ---------------------------------
# - systemctl stop 대신, ps -ef | grep "nginx" 로 master 프로세스의 PID를 찾고
#   kill -9 PID 로 강제 종료하는 방법도 있다.
# - 단, 우아한 종료를 위해서는 가급적:
#     sudo systemctl stop nginx
#   를 먼저 시도하는 것이 좋다.


# -----------------------------------------
# 5. 네트워크 / DNS / IP 관련 명령어
# -----------------------------------------

# nslookup [도메인] : 특정 도메인의 IP 주소 정보 조회 (DNS 질의)
#  - DNS 서버에 "이 도메인의 IP가 뭐야?" 라고 묻는 명령
# 예) nslookup naver.com
nslookup naver.com

# ifconfig : 로컬(내 컴퓨터) 네트워크 인터페이스 정보 / IP 주소 확인
#  - 최신 환경에서는 ip addr 명령이 더 자주 쓰이기도 함
ifconfig
# 또는:
# ip addr


# ping [IP 또는 도메인] : 네트워크 연결 상태 확인
#  - 대상 호스트에 ICMP 패킷을 보내서 응답 여부/지연 시간 확인
#  - 하지만 보안상 ping(icmp echo)을 막아두는 서버도 많다.
# 예) 구글 DNS(8.8.8.8)로 테스트
ping 8.8.8.8
# 예) 도메인으로 테스트
ping google.com


# telnet [IP] [포트] : 특정 IP/포트로 텍스트 기반 접속 시도
#  - 보통 보안상 막혀 있거나, 사용 지양(암호화X)되어 현대에는 잘 사용하지 않음.
# 예) telnet 127.0.0.1 80
telnet 127.0.0.1 80

# nc(netcat) -zv [IP 또는 도메인] [포트범위] : 포트 오픈 여부 검사
#  - z : 실제 데이터 전송 없이 포트 스캔
#  - v : verbose(자세한 출력)
# 예) nc -zv 127.0.0.1 80
# 예) nc -zv naver.com 80 443
nc -zv 127.0.0.1 80

# IP와 포트를 이용하면, "특정 서버의 특정 프로그램"이 통신 가능한 상태인지 확인 가능.
#  - 예) 웹 서버 : 보통 80(http), 443(https)
#  - 예) SSH    : 보통 22

# 웰노운 포트(주요 예시)
#  - 22  : SSH (원격 접속)
#  - 80  : HTTP (웹)
#  - 443 : HTTPS (보안 웹)


# -----------------------------------------
# 6. naver IP 예시 관련 메모
# -----------------------------------------

# nslookup naver.com 으로 IP 확인 후:
#  - ping [해당 IP] 로 핑 테스트
#  - nc -zv [해당 IP] 80 443 으로 포트 확인
#
# 예) (실제 IP는 예시)
#   nslookup naver.com
#   ping 223.130.xxx.xxx
#   nc -zv 223.130.xxx.xxx 80 443

# -----------------------------------------
# 7. 원격 접속(SSH) 및 원격 파일 전송(SCP)
# -----------------------------------------

# 원격 접속을 위한 포트:
#  - SSH 기본 포트는 22번.
#  - 방화벽/보안 그룹 설정 시, 원격 접속을 허용하려면
#    22 포트를 먼저 열어야 한다.

# ssh [계정명]@[도메인/IP주소] : SSH 원격 접속
#  - 예) ssh ubuntu@1.2.3.4
#  - 예) ssh ubuntu@my-server.example.com
#  - 기본적으로 22번 포트로 접속.
#  - 만약 포트가 다르면: ssh -p [포트] 계정명@호스트
#    예) ssh -p 2222 ubuntu@1.2.3.4
ssh user@example.com

# scp : SSH 기반 원격 파일 전송 명령
#  - Secure Copy
#
# 로컬 → 원격 업로드:
#   scp [로컬파일] [계정]@[호스트]:[원격경로]
#   예) scp app.jar ubuntu@1.2.3.4:/home/ubuntu/
#
# 원격 → 로컬 다운로드:
#   scp [계정]@[호스트]:[원격파일] [로컬경로]
#   예) scp ubuntu@1.2.3.4:/var/log/syslog ./syslog
#
# 디렉터리 통째로 복사(-r 옵션):
#   scp -r mydir ubuntu@1.2.3.4:/home/ubuntu/
scp local.txt user@example.com:/home/user/
scp user@example.com:/home/user/remote.txt ./
