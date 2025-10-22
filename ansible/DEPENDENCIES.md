# Ansible Role 의존성 문서

이 문서는 Ansible Role 간의 의존성과 실행 순서를 명시합니다.

## 📊 Role 의존성 트리

```
Alpineupgrade (기본 Role - 패키지 업데이트)
├── Technitium (DNS 서버)
├── Postgresql (데이터베이스)
│   └── Patroni (HA 관리자)
│       └── Haproxy (로드밸런서)
├── Docker (컨테이너 엔진)
│   ├── Portainer (Docker UI)
│   └── Glance (대시보드)
├── Nginx (리버스 프록시)
└── Gitea (Git 서버)

독립 설정 Role (설치 전 실행)
├── EtcdConfig → Etcd
└── PatroniConfig → Patroni
```

## 🔄 실행 순서 (playbooks.yml)

### 1단계: DNS 서버
```yaml
Alpineupgrade → Technitium
```

### 2단계: etcd 클러스터
```yaml
EtcdConfig (설정) → Etcd (설치)
```
**⚠️ 중요:** EtcdConfig는 Etcd 설치 **전에** 실행되어야 합니다!

### 3단계: PostgreSQL HA 클러스터
```yaml
Etcd (실행 중) → PatroniConfig (설정) → Postgresql + Patroni (설치) → Haproxy
```
**⚠️ 중요:**
- PatroniConfig는 Etcd가 실행 중일 때 실행
- PatroniConfig는 PostgreSQL/Patroni 설치 **전에** 실행
- Haproxy는 Patroni가 실행 중일 때 설치

### 4단계: Docker 컨테이너
```yaml
Docker (설치) → Portainer / Glance (배포)
```
**⚠️ 중요:** Glance는 Technitium DNS가 실행 중이어야 함 (API 접근 필요)

### 5단계: 리버스 프록시
```yaml
Nginx (설치)
```
**⚠️ 중요:** 백엔드 서비스들이 실행 중이어야 함

### 6단계: Git 서버 (준비 중)
```yaml
Gitea (설치)
```

## 📝 Role별 dependencies 정의

### Alpineupgrade
- **dependencies:** 없음
- **설명:** 가장 먼저 실행되어야 하는 기본 Role

### Technitium
- **dependencies:** `Alpineupgrade`
- **설명:** DNS 서버 설치

### EtcdConfig
- **dependencies:** 없음
- **설명:** etcd 설정 파일 생성 (설치 전)

### Etcd
- **dependencies:** `Alpineupgrade`
- **playbook 의존성:** `EtcdConfig` (수동 실행)
- **설명:** etcd 분산 키-값 저장소 설치

### Postgresql
- **dependencies:** `Alpineupgrade`
- **설명:** PostgreSQL 17 설치

### PatroniConfig
- **dependencies:** 없음
- **실행 조건:** Etcd가 실행 중이어야 함
- **설명:** Patroni 설정 파일 생성 (설치 전)

### Patroni
- **dependencies:** `Postgresql`
- **playbook 의존성:** `PatroniConfig` (수동 실행)
- **실행 조건:** Etcd가 실행 중이어야 함
- **설명:** Patroni HA 관리자 설치

### Haproxy
- **dependencies:** `Alpineupgrade`
- **실행 조건:** Patroni가 실행 중이어야 함
- **설명:** PostgreSQL HA 로드밸런서

### Docker
- **dependencies:** `Alpineupgrade`
- **설명:** Docker 엔진 + macvlan 네트워크 설정

### Portainer
- **dependencies:** `Docker`
- **설명:** Portainer 컨테이너 배포

### Glance
- **dependencies:** `Docker`
- **실행 조건:** Technitium DNS가 실행 중이어야 함
- **설명:** Glance 대시보드 배포

### Nginx
- **dependencies:** `Alpineupgrade`
- **실행 조건:** 백엔드 서비스들이 실행 중이어야 함
- **설명:** Nginx 리버스 프록시 + SSL

### Gitea
- **dependencies:** `Alpineupgrade`
- **실행 조건:** PostgreSQL이 실행 중이어야 함
- **설명:** Gitea Git 서버 (준비 중)

## ⚠️ 주의사항

### Config Role 실행 순서
**설정 Role은 반드시 설치 Role **전에** 실행되어야 합니다:**

1. **EtcdConfig → Etcd**
   - `/etc/conf.d/etcd` 파일을 먼저 생성해야 함

2. **PatroniConfig → Patroni**
   - `/etc/patroni/patroni.yml` 파일을 먼저 생성해야 함

### 런타임 의존성
**일부 Role은 다른 서비스가 실행 중이어야 합니다:**

- **PatroniConfig:** Etcd 클러스터가 실행 중 (2379 포트 접근)
- **Patroni:** Etcd 클러스터가 실행 중
- **Haproxy:** Patroni API가 실행 중 (8008 포트)
- **Glance:** Technitium DNS API가 실행 중 (5380 포트)
- **Nginx:** 백엔드 서비스들이 실행 중

### 네트워크 포트 의존성

| 서비스 | 필요한 포트 | 설명 |
|--------|------------|------|
| Etcd | 2379 (client), 2380 (peer) | 클러스터 통신 |
| Patroni | 8008 (REST API), 2379 (etcd) | HA 관리 |
| HAProxy | 8008 (Patroni API) | 헬스체크 |
| Glance | 5380 (Technitium API) | DNS 통계 |
| Nginx | 백엔드 포트들 | 리버스 프록시 |

## 🔗 참조

각 Role의 자세한 변수 의존성은 다음을 참조하세요:
- [VARIABLES.md](./VARIABLES.md) - 변수 레퍼런스 가이드
- `ansible/roles/*/meta/main.yml` - 각 Role의 메타데이터