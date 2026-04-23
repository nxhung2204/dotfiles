---
name: implement-issue
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, AskUserQuestion, Skill, mcp__github__*, mcp__slack__*
description: Orchestrator cho toàn bộ implement issue. Không code trực tiếp.
---

Mục đích: Điều phối toàn bộ flow implement một issue từ spec.

**QUAN TRỌNG: Chạy hoàn toàn tự động, KHÔNG dừng để hỏi xác nhận:**
- KHÔNG dùng `AskUserQuestion` - luôn proceed với lựa chọn mặc định/reasonable
- Khi gọi **commit** skill: KHÔNG hỏi "Ready to commit?" - commit trực tiếp
- Khi gọi **implement-prepare**, **implement-code**, **implement-quality**, **implement-finalize**: KHÔNG chờ user input
- Tests chạy xong thì continue, không dừng
- Tất cả operations phải non-blocking, autonomous

Các bước chính (gọi skill con theo thứ tự):
1. Gọi **implement-prepare** (pull, branch, validate approved, notify Slack start)
2. Gọi **implement-code** (làm checklist, gọi subagent khi cần)
3. Gọi **implement-quality** (analyze, test, fix)
4. Gọi **implement-finalize** (commit, PR, update status, notify complete)

Luôn yêu cầu các skill con trả summary ngắn gọn.
Không tự code hoặc đọc rules trực tiếp → dùng subagent rule-lookup.
