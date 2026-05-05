---
name: drill-issue
description: Deep dive into issue content through systematic questioning. Clarifies requirements, constraints, and edge cases until you have clear understanding. Generates implementation checklist as output.
---

# Drill Issue

Systematically clarify issue requirements through targeted questioning until you reach crystal-clear understanding. Outputs actionable implementation checklist.

## What this skill does

Takes a synced issue file and:
- **Questions deeply** about problem, acceptance criteria, constraints, edge cases
- **Clarifies assumptions** about scope, dependencies, technical decisions
- **Identifies gaps** in requirements before implementation starts
- **Generates checklist** with concrete implementation tasks
- **Continues iteratively** until requirements are unambiguous

## Input

Issue file from `specs/issues/[issue-number].md` (previously synced via `github-issues-to-md`).

## Process

### 1. Read issue file

Parse:
- Title
- Labels
- Body/Description
- Current acceptance criteria (if any)

### 2. Ask clarifying questions

Work through these systematically:

#### Problem Understanding
- What's the core problem being solved?
- Who are the users affected?
- Why is this important right now?
- What's the success metric?

#### Acceptance Criteria
- Are the success criteria measurable?
- Are there hidden edge cases?
- What counts as "done"?
- What's explicitly out of scope?

#### Technical Constraints
- Any architectural constraints?
- Required tech stack / frameworks?
- Integration points with existing systems?
- Performance / scale requirements?

#### Edge Cases & Error Handling
- What happens if input is empty/invalid?
- How should errors be handled?
- What about concurrent requests?
- Offline scenarios? Rate limiting?

#### Dependencies
- Does this depend on other work?
- Does anything depend on this?
- Timeline constraints?
- Blocker issues?

#### Implementation Approach (optional)
- Do you have preferences on implementation?
- Existing patterns in codebase?
- Testing strategy?

### 3. Iterate until clear

- If answer is vague → ask follow-up
- If contradictions emerge → resolve them
- If gaps appear → fill them
- Continue until you can confidently explain the feature to someone else

### 4. Generate implementation checklist

Create checklist with:
- **Setup phase** (dependencies, scaffolding)
- **Core implementation** (main feature logic)
- **Integration** (connect to other systems)
- **Testing** (unit, integration, edge cases)
- **Documentation** (if needed)

Format as:
```markdown
## Implementation Checklist

### Setup
- [ ] Task 1
- [ ] Task 2

### Core Implementation
- [ ] Task 1
- [ ] Task 2

### Integration & Testing
- [ ] Task 1
- [ ] Task 2
```

### 5. Output summary

Report:
- **Clarification summary** (what was unclear, what got clarified)
- **Final understanding** (2-3 sentence summary of what will be built)
- **Implementation checklist** (ready to copy into issue)
- **Next steps** (ready to implement)

## Example

**Input:**
```
# Add dark mode toggle

Toggle dark mode in user settings
```

**Questions asked:**
- What's the success metric? (50% users enable it? No errors on toggle?)
- Where does preference save? (Local storage? User DB?)
- What colors for dark mode? (Auto-detect system? Manual toggle?)
- Does dark mode affect all pages? (Just frontend? API responses?)
- Testing? (Visual regression? A11y checks?)

**Output:**
```
## Clarification Summary
- Dark mode saves to user account (not local storage)
- Uses system-detect default, user can override
- Affects all UI, not API
- Need visual regression tests

## Final Understanding
Add dark mode toggle in settings that persists to user account. Defaults to system preference, survives page reload. All UI components theme-aware.

## Implementation Checklist

### Setup
- [ ] Add dark_mode column to users table
- [ ] Create theme service/hook

### Core Implementation
- [ ] Add toggle in settings page
- [ ] Implement theme switching logic
- [ ] Update all UI components with theme styles
- [ ] Save preference to database

### Integration & Testing
- [ ] Test persistence across sessions
- [ ] Visual regression tests (light/dark)
- [ ] Test system preference detection
- [ ] Mobile responsiveness
```

## Rules

- **Don't read between the lines** - Ask if unclear
- **Don't assume tech stack** - Confirm with user
- **Don't skip edge cases** - Systematic questioning catches them
- **Don't write code yet** - Just clarify & document
- **Be conversational** - Ask like a colleague, not a checklist

## Tips

- Start broad (problem understanding), then narrow (edge cases)
- Listen for "I think..." or "probably..." → those need clarification
- Watch for contradictions between criteria
- Checklist should be implementation-ready (not too high-level, not too low-level)
- If user is a domain expert, trust their judgment; if unsure, ask more questions
