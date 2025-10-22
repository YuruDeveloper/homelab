# Ansible 변수 레퍼런스 가이드

이 문서는 모든 Ansible Role에서 사용하는 변수의 의존성과 정의 위치를 명시합니다.

## 📚 목차

- [전역 변수](#전역-변수)
- [etcd 클러스터 변수](#etcd-클러스터-변수)
- [PostgreSQL HA 변수](#postgresql-ha-변수)
- [Docker 네트워크 변수](#docker-네트워크-변수)
- [Nginx 프록시 변수](#nginx-프록시-변수)
- [변수 정의 위치](#변수-정의-위치)

---

## 전역 변수

### ansible_python_interpreter
- **타입:** string
- **기본값:** `/usr/bin/python3`
- **정의 위치:** `group_vars/all.yml`
- **사용 Role:** 모든 Role
- **설명:** Alpine Linux의 Python 인터프리터 경로

### ansible_user
- **타입:** string
- **기본값:** `root`
- **정의 위치:** `group_vars/all.yml`
- **사용 Role:** 모든 Role
- **설명:** SSH 접속 사용자

### ansible_host_key_checking
- **타입:** boolean
- **기본값:** `false`
- **정의 위치:** `group_vars/all.yml`
- **사용 Role:** 모든 Role
- **설명:** SSH 호스트 키 검증 비활성화

---

## etcd 클러스터 변수

### etcd_member_ips
- **타입:** list[string]
- **필수:** ✅
- **정의 위치:** `group_vars/HApostgresql/var.yml`
- **사용 Role:** EtcdConfig, Etcd, PatroniConfig, Haproxy
- **예시:**
  ```yaml
  etcd_member_ips:
    - 192.168.2.102  # haproxy
    - 192.168.2.103  # db0
    - 192.168.2.104  # db1
  ```
- **설명:** etcd 클러스터 멤버들의 IP 주소 목록
- **⚠️ 중요:**
  - inventory.yml의 `ansible_host`와 일치해야 함
  - `etcd_member_names`와 길이가 같아야 함
  - 순서가 `etcd_member_index`와 매핑됨

### etcd_member_names
- **타입:** list[string]
- **필수:** ✅
- **정의 위치:** `group_vars/HApostgresql/var.yml`
- **사용 Role:** EtcdConfig, Etcd, PatroniConfig, Haproxy
- **예시:**
  ```yaml
  etcd_member_names:
    - postgresql     # haproxy 호스트 (index 0)
    - postgreslave0  # db0 호스트 (index 1)
    - postgreslave1  # db1 호스트 (index 2)
  ```
- **설명:** etcd 클러스터 멤버들의 이름 목록
- **⚠️ 중요:**
  - inventory.yml의 호스트와 논리적으로 매핑되어야 함
  - `etcd_member_ips`와 길이가 같아야 함

### etcd_member_index
- **타입:** integer
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (각 play마다 다름)
- **사용 Role:** EtcdConfig, Etcd, PatroniConfig, Haproxy
- **값:**
  - `0`: haproxy 노드
  - `1`: db0 노드
  - `2`: db1 노드
- **예시:**
  ```yaml
  - name: Etcd Config
    hosts: haproxy
    vars:
      etcd_member_index: 0
  ```
- **설명:** 현재 호스트가 `etcd_member_ips`/`etcd_member_names` 배열에서 차지하는 인덱스
- **⚠️ 중요:**
  - 0부터 시작
  - 배열 범위를 벗어나면 안 됨
  - 각 호스트마다 고유한 값

### etcd_version
- **타입:** string
- **필수:** ❌ (선택)
- **기본값:** `"3.6.5"`
- **정의 위치:** `roles/Etcd/defaults/main.yml`
- **사용 Role:** Etcd
- **설명:** etcd 바이너리 버전

### etcd_download_url
- **타입:** string
- **필수:** ❌ (자동 생성)
- **정의 위치:** `roles/Etcd/vars/main.yml`
- **사용 Role:** Etcd
- **템플릿:** `https://github.com/etcd-io/etcd/releases/download/v{{ etcd_version }}/etcd-v{{ etcd_version }}-linux-amd64.tar.gz`
- **설명:** etcd 다운로드 URL

---

## PostgreSQL HA 변수

### postgresql_version
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (PatroniConfig play)
- **사용 Role:** PatroniConfig
- **값:** `"17"`
- **예시:**
  ```yaml
  - name: Patroni Config
    hosts: db0
    vars:
      postgresql_version: 17
  ```
- **설명:** PostgreSQL 메이저 버전

### subnet
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (PatroniConfig play)
- **사용 Role:** PatroniConfig
- **예시:** `"192.168.2.0/24"`
- **설명:** PostgreSQL 접근을 허용할 네트워크 대역 (pg_hba.conf)

### password
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml`에서 vault 참조
- **실제 값:** `group_vars/HApostgresql/vault.yml`의 `postgresql_password`
- **사용 Role:** PatroniConfig
- **예시:**
  ```yaml
  vars:
    password: "{{ postgresql_password }}"
  ```
- **설명:** PostgreSQL 슈퍼유저 및 복제 사용자 비밀번호
- **⚠️ 중요:** 민감한 정보이므로 vault에 암호화하여 저장

---

## Docker 네트워크 변수

### subnet
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Docker play)
- **사용 Role:** Docker
- **예시:** `"192.168.4.0/24"`
- **설명:** Docker macvlan 네트워크 대역

### gateway
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Docker play)
- **사용 Role:** Docker
- **예시:** `"192.168.4.1"`
- **설명:** Docker macvlan 게이트웨이

### portainer_ip
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Portainer play)
- **사용 Role:** Portainer
- **예시:** `"192.168.4.100"`
- **설명:** Portainer 컨테이너 IP 주소
- **⚠️ 중요:** `subnet` 대역 내여야 함

### glance_ip
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Glance play)
- **사용 Role:** Glance
- **예시:** `"192.168.4.101"`
- **설명:** Glance 컨테이너 IP 주소
- **⚠️ 중요:** `subnet` 대역 내여야 함

### technitium0_apikey
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Glance play)
- **사용 Role:** Glance
- **예시:** `"your-api-key-here"`
- **설명:** Technitium DNS #1 API 키
- **⚠️ 중요:** DNS 서버 웹 UI에서 수동 생성 필요

### technitium1_apikey
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Glance play)
- **사용 Role:** Glance
- **예시:** `"your-api-key-here"`
- **설명:** Technitium DNS #2 API 키
- **⚠️ 중요:** DNS 서버 웹 UI에서 수동 생성 필요

---

## Nginx 프록시 변수

### postgres_ip
- **타입:** string
- **필수:** ✅
- **정의 위치:** `playbooks.yml` (Nginx play)
- **사용 Role:** Nginx
- **예시:** `"192.168.2.102"`
- **설명:** PostgreSQL HAProxy IP 주소

### services
- **타입:** list[object]
- **필수:** ✅
- **정의 위치:** `group_vars/nginx/var.yml`
- **사용 Role:** Nginx
- **구조:**
  ```yaml
  services:
    - domain: (string) 도메인 이름
      ip: (string) 백엔드 IP
      port: (int) 백엔드 포트
  ```
- **예시:**
  ```yaml
  services:
    - domain: opnsense.bytedev.duckdns.org
      ip: 192.168.0.1
      port: 80
    - domain: portainer.bytedev.duckdns.org
      ip: 192.168.4.100
      port: 9000
  ```
- **설명:** Nginx가 프록시할 서비스 목록

### duckdns_token
- **타입:** string
- **필수:** ✅
- **정의 위치:** `group_vars/nginx/vault.yml`
- **사용 Role:** Nginx
- **설명:** DuckDNS API 토큰 (SSL 인증서 발급용)
- **⚠️ 중요:** 민감한 정보이므로 vault에 암호화하여 저장

---

## 변수 정의 위치

### group_vars/all.yml
```yaml
ansible_python_interpreter: /usr/bin/python3
ansible_user: root
ansible_host_key_checking: false
```

### group_vars/HApostgresql/var.yml
```yaml
etcd_member_names:
  - postgresql
  - postgreslave0
  - postgreslave1

etcd_member_ips:
  - 192.168.2.102
  - 192.168.2.103
  - 192.168.2.104
```

### group_vars/HApostgresql/vault.yml
```yaml
# ansible-vault로 암호화
postgresql_password: "your-secure-password"
```

### group_vars/nginx/var.yml
```yaml
services:
  - domain: opnsense.bytedev.duckdns.org
    ip: 192.168.0.1
    port: 80
  # ... (생략)
```

### group_vars/nginx/vault.yml
```yaml
# ansible-vault로 암호화
duckdns_token: "your-duckdns-token"
```

### playbooks.yml
```yaml
# etcd_member_index, postgresql_version, subnet, password 등
# 각 play마다 정의
- name: Etcd Config
  hosts: haproxy
  vars:
    etcd_member_index: 0
  roles:
    - EtcdConfig

- name: Patroni Config
  hosts: db0
  vars:
    etcd_member_index: 1
    postgresql_version: 17
    subnet: "192.168.2.0/24"
    password: "{{ postgresql_password }}"
  roles:
    - PatroniConfig
```

### roles/*/defaults/main.yml
```yaml
# 각 Role의 기본값
# 예: roles/Etcd/defaults/main.yml
etcd_version: "3.6.5"
```

---

## 🔗 변수 간 의존성 매트릭스

| 변수 | 의존하는 변수 | 검증 규칙 |
|------|--------------|----------|
| `etcd_member_index` | `etcd_member_ips`, `etcd_member_names` | `0 <= index < len(etcd_member_ips)` |
| `etcd_member_ips` | `etcd_member_names` | `len(etcd_member_ips) == len(etcd_member_names)` |
| `portainer_ip` | `subnet` | IP가 subnet 범위 내 |
| `glance_ip` | `subnet` | IP가 subnet 범위 내 |
| `password` | `postgresql_password` (vault) | vault에서 정의되어야 함 |
| `duckdns_token` | - | vault에서 정의되어야 함 |

---

## ⚠️ 변수 설정 시 주의사항

### 1. etcd 클러스터 변수
```yaml
# ❌ 잘못된 예
etcd_member_ips: [192.168.2.102, 192.168.2.103]
etcd_member_names: [postgresql, postgreslave0, postgreslave1]  # 길이 불일치!

# ✅ 올바른 예
etcd_member_ips: [192.168.2.102, 192.168.2.103, 192.168.2.104]
etcd_member_names: [postgresql, postgreslave0, postgreslave1]
```

### 2. IP 주소 일관성
```yaml
# inventory.yml
haproxy:
  ansible_host: 192.168.2.102

# group_vars/HApostgresql/var.yml
etcd_member_ips:
  - 192.168.2.102  # ✅ inventory와 일치
```

### 3. 배열 인덱스
```yaml
# playbooks.yml
- hosts: haproxy  # inventory 첫 번째 호스트
  vars:
    etcd_member_index: 0  # ✅ 배열 첫 번째

- hosts: db0      # inventory 두 번째 호스트
  vars:
    etcd_member_index: 1  # ✅ 배열 두 번째
```

### 4. 네트워크 대역
```yaml
# Docker macvlan 설정
subnet: 192.168.4.0/24
gateway: 192.168.4.1

# 컨테이너 IP는 범위 내여야 함
portainer_ip: 192.168.4.100  # ✅
glance_ip: 192.168.5.100     # ❌ 다른 대역!
```

---

## 🔗 참조

- [DEPENDENCIES.md](./DEPENDENCIES.md) - Role 의존성 가이드
- `ansible/roles/*/meta/main.yml` - 각 Role의 메타데이터