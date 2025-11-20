# Development Workflow - Red/Green Checkpoint Methodology

**Version:** 1.0
**Last Updated:** 2025-11-20
**Purpose:** Systematic development methodology for all Mundus projects

---

## Overview

This workflow ensures quality, prevents regressions, and maintains clear progress tracking through explicit validation gates.

**Core Pattern:**
```
🔴 RED (IMPLEMENT) → 🟢 GREEN (VALIDATE) → 🔵 CHECKPOINT (GATE)
```

---

## The Three Phases

### 🔴 RED PHASE: Implement

**Purpose:** Write code, build features, create implementation

**Activities:**
- Write new code
- Modify existing code
- Create new files
- Install dependencies
- Configure systems

**Output:** Implementation complete but unverified

**Duration:** Varies by task complexity

---

### 🟢 GREEN PHASE: Validate

**Purpose:** Prove the implementation works through explicit verification

**Activities:**
- Run tests (`npm test`)
- Execute validation commands
- Check builds (`npm run build`, `docker build`)
- Verify functionality manually
- Run security scans (`npm audit`)
- Check for regressions

**Success Criteria:**
- All tests pass
- Build succeeds
- Functionality works as expected
- No new vulnerabilities introduced

**Output:** Verified working implementation

**Critical Rule:** Never skip validation. Always run explicit commands.

---

### 🔵 CHECKPOINT: Gate

**Purpose:** Mark complete, document rollback, commit to version control

**Activities:**
- Mark task as complete
- Document what was done
- Document rollback procedure
- Commit changes with clear message
- Update status/tracking documents

**Output:** Checkpointed progress with rollback capability

**Rollback Example:**
```bash
# If this checkpoint fails, rollback with:
git revert <commit-hash>
# OR
git checkout <file> # Restore specific file
```

---

## Example Workflow

### Task: Add Rate Limiting to API

**🔴 RED: Implement**
```bash
# Install dependency
npm install express-rate-limit

# Add to server.js
import rateLimit from 'express-rate-limit';
const limiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 100 });
app.use('/api/', limiter);
```

**🟢 GREEN: Validate**
```bash
# Test server starts
npm run dev

# Test rate limiting works
for i in {1..110}; do curl http://localhost:3000/api/test; done
# Should see 429 error after 100 requests

# Run test suite
npm test

# All tests pass ✅
```

**🔵 CHECKPOINT: Gate**
```bash
# Commit
git add package.json src/server.js
git commit -m "feat: Add rate limiting to API endpoints

Added:
- express-rate-limit dependency
- 100 requests per 15 minutes per IP
- Applied to all /api/ routes

Validation:
- Tested manually (429 after 100 requests)
- All tests pass (npm test)
- Server starts without errors

Rollback:
git revert HEAD
npm uninstall express-rate-limit
"

# Push
git push origin main

# Mark complete
echo "[2025-11-20] Rate limiting - COMPLETE" >> STATUS.md
```

---

## Benefits

### 1. Quality Assurance
- Explicit validation prevents broken code reaching production
- Every change is tested before commit

### 2. Clear Progress
- Checkpoint gates show exactly what's complete
- Easy to see project status

### 3. Rollback Capability
- Every checkpoint documented with rollback procedure
- Can safely undo changes if needed

### 4. No Assumptions
- Don't assume it works - prove it works
- Validation commands are explicit and repeatable

---

## When to Use

**Use for:**
- ✅ New features
- ✅ Bug fixes
- ✅ Refactoring
- ✅ Security updates
- ✅ Dependency updates
- ✅ Any code change

**Even for small changes** - the pattern prevents issues

---

## Anti-Patterns (Don't Do This)

❌ **Skip Validation:**
```
🔴 RED: Write code
🔵 CHECKPOINT: Commit (NO GREEN!)
```
*Risk: Broken code committed*

❌ **No Rollback Documentation:**
```
🔵 CHECKPOINT: Mark complete
(No rollback procedure documented)
```
*Risk: Can't undo if issues found*

❌ **Batch Multiple Tasks:**
```
🔴 RED: Feature A + Feature B + Feature C
🟢 GREEN: Test all at once
🔵 CHECKPOINT: Mark all complete
```
*Risk: Can't isolate failures, unclear what broke*

---

## Best Practices

### 1. One Task per Cycle
- Complete RED → GREEN → CHECKPOINT for one task
- Then start next task
- Keeps changes isolated

### 2. Explicit Validation Commands
- Document exact commands run
- Make validation repeatable
- "It worked on my machine" → "Here's the command that proves it"

### 3. Detailed Checkpoints
- What was done
- How it was validated
- How to rollback
- Clear commit messages

### 4. No Assumptions
- Don't assume tests pass - run them
- Don't assume it builds - build it
- Don't assume it works - test it

---

## Validation Command Examples

**Backend Changes:**
```bash
npm test                    # Run test suite
npm run build              # Verify builds
npm audit                  # Check security
docker build -t test .     # Verify container
```

**Frontend Changes:**
```bash
npm test                   # Run tests
npm run build              # Build production
npm run lint               # Check code style
```

**Database Changes:**
```bash
# Test migration
psql < migration.sql

# Verify schema
\d table_name

# Rollback
psql < rollback.sql
```

**Edge Function Changes:**
```bash
# Deploy to Supabase
npx supabase functions deploy <name>

# Test with curl
curl -X POST https://.../<name> -d '{"test": true}'

# Check logs
npx supabase functions logs <name>
```

---

## Checkpointing in Team Environment

**Solo Developer:**
- Checkpoint locally
- Push when ready

**Team (multiple developers):**
- Checkpoint locally first (🔴→🟢→🔵)
- Create PR for review
- Team validates (additional GREEN)
- Merge = final checkpoint
- Document in PR description:
  - What was implemented
  - How it was validated
  - Rollback procedure

---

## Summary

**Simple but Effective:**
1. 🔴 **Do the work** (RED)
2. 🟢 **Prove it works** (GREEN)
3. 🔵 **Save progress** (CHECKPOINT)

**Never skip GREEN.**

**This methodology prevents 90% of production issues by ensuring everything is validated before commit.**

---

**Methodology:** Red/Green Checkpoint System
**Version:** 1.0
**Suitable For:** Any software development project
**Last Updated:** 2025-11-20
