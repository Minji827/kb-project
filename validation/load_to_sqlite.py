"""
load_to_sqlite.py — data/*.csv 를 data/portfolio.db (SQLite) 로 적재
Oracle 환경이 막히거나 로컬에서 SQL을 돌려볼 때 사용.

실행: python validation/load_to_sqlite.py
이후:  python validation/run_sql.py sql/queries_A.sql
"""
import sqlite3
from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data"
db = sqlite3.connect(DATA / "portfolio.db")
for csv in DATA.glob("*.csv"):
    df = pd.read_csv(csv)
    df.columns = df.columns.str.strip().str.lower()
    df.to_sql(csv.stem, db, if_exists="replace", index=False)
    print(f"{csv.name} → 테이블 {csv.stem} ({len(df)} rows)")
db.close()
