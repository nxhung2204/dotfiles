---
name: plan-to-story
description: Convert a multi-phase implementation plan (specs/plan.md or specs/portfolio.md) into PR-sized tasks. Each task is scoped for a single Pull Request with checklist items. Output saved to specs/story.md. Use when you need to break down a plan into concrete, manageable tasks.
---

# Plan to Story

Transform a detailed implementation plan into a structured story with PR-sized tasks.

## What this skill does

Takes an existing implementation plan (e.g., `specs/portfolio.md`) and generates `specs/story.md` with:

- **Grouped tasks**: Each Phase divided into logical, PR-sized chunks
- **Checklist items**: Each task has acceptance criteria as checkboxes
- **Vertical slices**: Each task spans end-to-end (not layer-by-layer)
- **Progress tracking**: Easy to mark items complete as you implement

## Input

The skill reads from:
- `specs/plan.md` (if exists), OR
- `specs/portfolio.md` (fallback)

The plan should have phases with "What to build" sections and acceptance criteria (checkboxes).

## Output

Creates `specs/story.md` with structure:

```
## Phase N: <Title>

### Task N.1: <Task title>
- [ ] Item 1
- [ ] Item 2
- [ ] Item 3

### Task N.2: <Task title>
- [ ] Item 1
- [ ] Item 2
```

## Process

### 1. Analyze the plan file

Read the plan and identify:
- Number of phases
- Acceptance criteria for each phase
- Logical groupings (which criteria belong in same PR)

### 2. Group acceptance criteria into PR-sized tasks

For each phase:
- Group related acceptance criteria into tasks
- Each task should be implementable in a single PR (ideally 40–100 lines of code)
- Task should deliver end-to-end functionality (not just one layer)
- Name task descriptively (e.g., "Task 1.1: Vue setup & routing" not "Task 1.1: Install packages")

### 3. Write the story.md file

For each phase:

```markdown
## Phase N: <Phase Title>

### Task N.1: <Short descriptive title>
- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2
- [ ] Acceptance criterion 3

### Task N.2: <Short descriptive title>
- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2
```

### 4. Add metadata section

At the end of story.md, include:
- Total task count
- Summary of phases
- Instructions for using the story (check off items as you complete them)
- Progress tracking checklist (one item per phase)

## Example

**Input (plan excerpt):**
```
## Phase 1: Project Setup

### Acceptance criteria
- [ ] Vue 3 + Vite initialized
- [ ] Tailwind CSS configured
- [ ] Router setup with 7 routes
- [ ] Supabase project created
- [ ] Database schema created (3 tables)
- [ ] RLS policies configured
```

**Output (story.md excerpt):**
```
## Phase 1: Project Setup

### Task 1.1: Vue 3 + Vite + Tailwind setup
- [ ] Vue 3 + Vite initialized
- [ ] Tailwind CSS configured
- [ ] Router setup with 7 routes

### Task 1.2: Supabase project & database
- [ ] Supabase project created
- [ ] Database schema created (3 tables)
- [ ] RLS policies configured
```

## Tips

- **Grouping heuristic**: Tasks should be related functionally (e.g., "form validation + submission" go together; "fetching + rendering" go together)
- **Naming**: Task titles should describe the outcome, not the implementation ("About page - bio & timeline" not "Create component and style it")
- **Sizing**: Aim for 3–8 acceptance criteria per task (not 1–2, not 15+)
- **Vertical slices**: Each task should touch multiple layers if applicable (e.g., "Setup form + validation + backend submission" not just "Create form component")

## Notes

- Each phase becomes multiple tasks
- Tasks are numbered sequentially within a phase (1.1, 1.2, 1.3, etc.)
- Story.md is the authoritative source for implementation order — follow it from top to bottom
- Mark items [ ] as done → [x] as you complete them (git-friendly checklist)
