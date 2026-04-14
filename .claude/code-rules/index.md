# Rules Index (Pre-computed for Fast Lookup)

## Usage
Import this file first to get keyword→rule mappings, then read only relevant sections.

**Token savings: ~80-85%** vs reading full files.

---

## Keyword Map (Global Rules)

| Keyword | File | Section | Lines |
|---------|------|---------|-------|
| **parser, grammar, language** | coding-rules.md | Follow Existing Codebase | 25-40 |
| **function, method, size** | clean-code.md | Function Size | 200-228 |
| **naming, name, variable** | clean-code.md | Meaningful Names | 110-145 |
| **single, responsibility, split** | clean-code.md | Single Responsibility | 160-185 |
| **dry, repeat, duplicate** | clean-code.md | DRY | 190-210 |
| **guard, early, return** | clean-code.md | Return Early | 90-120 |
| **magic, number, constant** | clean-code.md | Magic Numbers | 32-60 |
| **string, hardcoded, text** | clean-code.md | Hardcoded Strings | 62-88 |
| **indent, space, format** | code-style.md | Indentation | 32-60 |
| **line, length, wrap** | code-style.md | Line Length | 62-75 |
| **blank, line, separate** | code-style.md | Blank Lines | 98-125 |
| **condition, if, format** | code-style.md | Condition Formatting | 170-195 |
| **flutter, widget, state** | core.md | Language-specific | 12-16 |
| **const, constructor** | core.md | Universal | 8 |
| **layer, architecture** | core.md | Universal | 4 |
| **small, function, generate** | coding-rules.md | Generate Small Functions | 68-100 |
| **pattern, predictable** | coding-rules.md | Prefer Predictable Patterns | 40-65 |
| **clarity, cleverness** | coding-rules.md | Core Principles | 12-22 |
| **refactor, extract, method** | refactoring.md | When to Refactor | 1-30 |

---

## Quick Reference by Category

### Structure & Architecture
- Clean Architecture layers → `core.md:4`
- Single Responsibility → `clean-code.md:160-185`
- DRY → `clean-code.md:190-210`

### Functions & Methods
- Size limits (20-30 lines) → `coding-rules.md:68-100`, `clean-code.md:200-228`
- Guard clauses → `clean-code.md:90-120`
- Early return → `code-style.md:130-152`

### Naming & Constants
- Magic numbers → `clean-code.md:32-60`
- Meaningful names → `clean-code.md:110-145`
- Hardcoded strings → `clean-code.md:62-88`

### Formatting
- Indentation → `code-style.md:32-60`
- Line length → `code-style.md:62-75`
- Blank lines → `code-style.md:98-125`
- Guard clause spacing → `code-style.md:127-152`

### Flutter Specific
- Const constructors → `core.md:8`
- Widget rules → `core.md:12-16`

### AI Code Generation
- Follow existing patterns → `coding-rules.md:25-40`
- Prefer predictable patterns → `coding-rules.md:40-65`
- Clarity over cleverness → `coding-rules.md:12-22`

### Refactoring
- When to refactor → `refactoring.md:1-30`
- Extract method → `refactoring.md:30-60`

---

## File Statistics
- `core.md`: 17 lines (always loaded)
- `clean-code.md`: ~350 lines
- `code-style.md`: ~280 lines
- `coding-rules.md`: ~180 lines
- `refactoring.md`: ~90 lines
- **Total**: ~917 lines

## Token Optimization
- Reading full files: ~15k tokens
- Reading targeted sections: ~2-3k tokens
- Using this index: ~500 tokens + targeted reads

**Savings: ~80-85% reduction**

---

## Project-Specific Rules (specs/rules/)

Flutter/Dart project rules được load từ `specs/rules/` trong project root:
- **flutter.md** → Flutter best practices, widget rules
- **clean-architecture.md** → Kiến trúc lớp, dependency rule
- **folder-structure.md** → Cấu trúc thư mục dự án
- **widgets.md** → Widget extraction, composition
- **design.md** → Colors, design tokens sync

> **Note:** `flutter/` và `rails/` folders trong ~/.claude/code-rules/ để trống - dự kiến dùng cho shared rules cross-project nếu cần.
