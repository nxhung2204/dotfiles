---
name: implement-issue
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Skill, mcp__github__*, mcp__slack__*
description: Orchestrator cho toàn bộ implement issue. Không code trực tiếp.
---

Mục đích: Điều phối toàn bộ flow implement một issue từ spec.

**QUAN TRỌNG: Chạy hoàn toàn tự động, KHÔNG DỪNG GIỮA CÁC BƯỚC:**

THỰC HIỆN TẤT CẢ CÁC BƯỚC SAU TRONG MỘT LẦN EXECUTION - KHÔNG DỪNG ĐỂ REPORT:

## STEP 1: Prepare (pull, branch, check approved)

1. git checkout develop → fallback to main
2. git pull origin develop → fallback to main
3. Parse issue info from ARGUMENTS (spec filename like `@specs/issues/018-*.md`):
   - Extract GitHub Issue number from spec file (NOT from filename!)
   - Extract title from metadata
   - Check "Review: Approved" - if not, STOP and error
4. Create branch: `feature/hung-#[ISSUE_NUMBER]-[slug-title]`
5. Notify Slack (mcp__slack__slack_post_message) if configured, save thread_ts

## STEP 2: Code (thực hiện checklist)

1. Read spec file → get Implementation Checklist
2. For EACH checklist item:
   - **ALWAYS** gọi rule-lookup subagent trước khi code (bắt buộc, không skip)
   - Implement item
   - Nếu UI/color → gọi design-checker subagent
   - Sau mỗi item lớn → gọi code-reviewer subagent
3. KHÔNG over-engineer

## STEP 3: Quality (test & fix)

1. Detect project type and run appropriate checks:
   - Neovim plugin: chạy tests nếu có
   - Flutter: flutter analyze + flutter test
   - Rails: rubocop + rails test
   - Node: npm test / npm run lint
   - Python: pytest / black --check
   - Rust: cargo clippy + cargo test
2. Nếu có lỗi → fix hoặc gọi error-fixer subagent
3. Verify 0 errors/warnings

## STEP 4: Finalize (commit, PR, notify)

1. Git commit changed files (dùng commit skill hoặc git commit trực tiếp)
2. Update spec status: "PR: Todo" → "PR: Draft"
3. Commit status change
4. Push branch: git push -u origin <branch>
5. Create Draft PR (mcp__github__create_pull_request)
6. Notify Slack complete (reply thread) if configured

## STEP 5: FINAL SUMMARY

CHỈ REPORT SUMMARY 1 LẦN Ở CUỐI:
- PR link
- Files changed
- Checklist items completed
- Test results

---

**CRITICAL RULES:**
- KHÔNG dùng AskUserQuestion - luôn proceed với default
- KHÔNG dừng giữa các steps
- Tests failed → fix → continue, KHÔNG dừng
- KHÔNG tự code → dùng subagent khi cần (rule-lookup, code-reviewer, error-fixer, design-checker)
