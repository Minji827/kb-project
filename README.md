# 포트폴리오 데이터랩 × 시장 지표 브리핑 (KB Bridge AI 원데이 프로젝트)

> 가상 보유종목의 평가금액·손익(F)을 SQL과 Pandas로 각각 계산해 교차검증하고, 같은 기간 시장지수(C)와 비교해 초과수익·상대 변동이 컸던 구간을 브리핑한다.

## 1. 문제 정의

- 데이터: `data/portfolio.csv` (보유종목·수량·매입가), `data/stock_prices.csv` (일자별 종가), `data/market_index.csv` (일자별 지수 — 금융위 API 또는 `data/fetch_index.py` 대체 생성)
- 분석 질문
  1. 종목별 현재 평가금액과 손익률은 얼마이며, 상위/하위 3개 종목은 무엇인가? (F)
  2. 포트폴리오 총액과 시장지수의 일간 변화율을 비교했을 때, 초과수익이 가장 컸던 구간과 부진했던 구간은? (F+C)
  3. 지수 변동이 컸던 날(상위 5)에 포트폴리오는 같은 방향으로 움직였나, 어느 종목이 그 차이를 만들었나? (F+C)
- 핵심 원칙: **같은 질문을 SQL과 Pandas로 각각 풀고, 결과를 파일로 내보내 검증 스크립트로 비교한다.**

## 2. 팀원별 역할 (독립 산출물 기준)

| # | 이름 | 역할 | 개인 산출물 | 브랜치 (개인 이름) |
|---|---|---|---|---|
| 1 | | SQL – 보유/평가 (F) | `sql/queries_A.sql` → `outputs/sql_A_*.csv` | `<본인 브랜치>` |
| 2 | | SQL – 시계열·지수 비교 (F+C) | `sql/queries_B.sql` → `outputs/sql_B_*.csv` | `<본인 브랜치>` |
| 3 | | Pandas – 평가/손익 (F) | `notebooks/analysis_C.ipynb` → `outputs/pandas_C_*.csv` | `<본인 브랜치>` |
| 4 | | Pandas – 시계열·지수 비교 (F+C) | `notebooks/analysis_D.ipynb` → `outputs/pandas_D_*.csv` | `<본인 브랜치>` |
| 5 | | 지수 확보·분석 (C) | `data/fetch_index.py`, `notebooks/analysis_E.ipynb` → `data/market_index.csv`, `outputs/pandas_E_*.csv` | `<본인 브랜치>` |
| 6 | | 검증 | `validation/validation_F.py` | `<본인 브랜치>` |
| 7 | | 통합 + AI 로그 + 리포트 + n8n(선택) | `README.md`, `CONTRIBUTION.md`, `ai_log.md`, `result_report.md`, `n8n/` | `<본인 브랜치>` |

리뷰 짝: 1↔3, 2↔4, 5↔6, 7은 전체 PR 리뷰. AI 사용 사례는 각자 `ai_log.md` 본인 섹션에 직접 커밋한다.

## 3. 실행 방법

```bash
pip install -r requirements.txt

# 시장지수 확보 (API 키 있으면 export DATA_GO_KR_KEY=..., 없으면 자동으로 가상 지수 생성)
python data/fetch_index.py

# SQL 결과 내보내기 (sqlite3 CLI 불필요. Oracle 사용 시 SQL Developer에서 CSV export)
python validation/load_to_sqlite.py          # data/*.csv → data/portfolio.db
python validation/run_sql.py sql/queries_A.sql   # -- @export: 주석 붙은 쿼리를 outputs/ 로 내보냄
python validation/run_sql.py sql/queries_B.sql

# Pandas 분석
jupyter notebook notebooks/analysis_C.ipynb   # C, D, E 각각

# 교차검증
python validation/validation_F.py
```

## 4. 핵심 결과

> `result_report.md` 참고. 아래는 요약 3줄.

- (결과 1)
- (결과 2)
- (결과 3)

## 5. 저장소 구조

```
data/          원본 CSV (수정 금지) + fetch_index.py
sql/           개인별 SQL 파일
notebooks/     개인별 노트북 (1인 1파일)
validation/    검증 스크립트
outputs/       각자 내보낸 결과 CSV (검증 입력)
n8n/           선택: workflow.json, 실행 캡처
```

## 6. Git 규칙 요약 (상세: `COMMIT_RULES.md`)

- 각자 **개인 이름 브랜치**(예: `joonhwanko`)에서 작업, 작업 전 `git pull origin main`
- `main` 직접 push 금지 → 개인 브랜치에서 `main`으로 PR, 리뷰 1명 승인 후 머지
- 커밋 메시지: `[이름] type: 작업 내용` — type은 `feat / fix / data / test / refactor / docs / chore`
- `.ipynb`는 1인 1파일, 커밋 전 output clear
- `git push --force` 금지, 실수는 revert
