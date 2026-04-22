---
name: implement-finalize
allowed-tools: Skill, Read, Write, Edit, Bash(git *), Bash(mkdir *), Bash(slack *), mcp__github__*, mcp__slack__*, Bash(cat:*), Bash(gh pr:*)
description: Commit, tạo PR, update status, notify Slack.
---

1. Commit (chỉ add files đã thay đổi)
    - Dùng commit skill

2. Update status trong spec file thành "PR: Draft"
Sửa dòng status:
```
## **Status:**
- PR: Todo
```
Thành:
```
## **Status:**
- PR: Draft
```

3. Push branch
    - git push -u origin <branch-name>

4. Tạo Draft PR với github mcp
    - Title: [title]
    - Body:
```
[Tóm tắt ngắn gọn những gì đã implement dễ hiểu nhất bằng tiếng Anh]

## Issue
closes #XX
```

5. Notify Slack hoàn thành (tuỳ chọn — chỉ thực hiện nếu thread_ts có từ prepare step)
- Nếu thread_ts = null → bỏ qua
- Nếu có → dùng mcp__slack__slack_reply_to_thread reply vào thread đó

**IMPORTANT:** KHÔNG report summary cho user - chỉ return kết quả để orchestrator report FINAL SUMMARY.
Return: { pr_url, files_committed }
