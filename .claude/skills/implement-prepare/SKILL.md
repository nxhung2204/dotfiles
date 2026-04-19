---
name: implement-prepare
allowed-tools: Read, Bash(git checkout:*), Bash(git pull:*), Bash(git branch:*), Bash(mkdir *), mcp__slack__*
description: Chuẩn bị trước khi code: pull, branch, check approved, notify Slack.
---

Các bước:

1. Checkout
- git checkout develop
    - fallback to main
- git pull origin develop
    - fallback to main

2. Parse issue info from spec
- ARGUMENTS format: [spec-filename]
- Read spec file from specs/issues/[spec-filename].md
- Extract: issue number from "GitHub Issue: #XX" line (NOT from filename prefix!)
- Extract: title from "Title:" field
- Check: "Review: Approved" - if not approved, stop and notify

3. Tạo branch
- feature/hung-#[ACTUAL-GITHUB-ISSUE-NUMBER]-[slug-title-from-metadata]
- slug phải là tiếng anh
- IMPORTANT: Use GitHub Issue number (e.g., #26 → 26), NOT spec filename prefix (000)


- Notify Slack bắt đầu (mcp__slack__slack_post_message), lưu thread_ts
```
Use mcp__slack__slack_post_message:

channel: [slack-channel-id from CLAUDE.md]
text: "🚀 Bắt đầu implement Issue #[N]: [title]\nBranch: feature/hung-#[N]-[slug]"
Save the returned ts value for threading later If MCP fails → fallback to slack CLI
```

- Trả summary: branch name + spec title + status
