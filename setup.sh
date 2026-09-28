#!/usr/bin/env bash
# 통합 담당(저장소 owner)이 시작 직후 1회 실행. GitHub에 빈 저장소를 먼저 만들고 URL을 인자로 준다.
#   bash setup.sh https://github.com/<owner>/kb-project.git
set -e
REMOTE="$1"
[ -z "$REMOTE" ] && { echo "usage: bash setup.sh <github-remote-url>"; exit 1; }

git init -b main
git add .
git commit -m "[통합] chore: 프로젝트 뼈대 및 템플릿 초기화"
git remote add origin "$REMOTE"
git push -u origin main

echo
echo "완료. 다음 단계:"
echo "  1. bash .github/scripts/setup_github.sh <owner/repo> <팀원 github id ...>  (협업자 초대·main 보호·Issue 7개)"
echo "  2. 각 Issue에 담당자 지정"
echo "  3. 각 팀원: git clone → git checkout -b <본인 github id> → git push -u origin <본인 github id>"
