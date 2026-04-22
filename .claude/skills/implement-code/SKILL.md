---
name: implement-code
allowed-tools: Agent, Read, Write, Edit, Grep, Glob, Bash
description: Thực hiện Implementation Checklist.
---

- Đọc spec → tuần tự làm từng item trong Checklist
- **ALWAYS** trước khi code bất kỳ item nào: gọi **rule-lookup** subagent với từ khóa item (bắt buộc, không skip)
- Nếu UI/color: gọi **design-checker** subagent
- Sau mỗi item lớn: gọi **code-reviewer** subagent để verify
- Không over-engineer, không code ngoài spec

**IMPORTANT:** KHÔNG report summary cho user - chỉ return kết quả để orchestrator tiếp tục step tiếp theo.
Return: { files_changed, checklist_items_completed }
