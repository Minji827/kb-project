# n8n (선택)

결과 리포트를 Slack/이메일로 자동 전달하는 워크플로우. 시간이 남을 때만.

- `workflow.json` : n8n에서 Export한 워크플로우
- `run_capture.png` : 실행 성공 캡처
- 노드 구성: Trigger(수동/Cron) → Read File(result_report.md) → Slack/Email 발송
