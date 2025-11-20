# Mundus Platform - Orchestration Hub

**Purpose:** Coordinate deployment and maintenance for Mundus platform
**Created:** 2025-11-20
**Type:** Meta-orchestration workspace
**Version:** 1.0.0

---

## Overview

This repository coordinates 4 Mundus platform repositories during deployment, troubleshooting, and maintenance.

**Managed Repositories:**
1. **Editor** - Article management and AI writeup generation
2. **Digest** - Daily digest automation with PDF/email
3. **Prompt Lab** - AI prompt testing and optimization
4. **Supabase** - Edge Functions and database infrastructure

**Total Infrastructure:** $21/month (Render.com + Supabase)

---

## Repository Information

**GitHub:** https://github.com/ydun-code-library/mundus-final
**Type:** Orchestration workspace (not deployed application)
**Contains:** Git submodules for 4 production repositories

---

## Current Status

**Last Updated:** 2025-11-20

### Applications

| App | Repository | Status | Tests | Security |
|-----|------------|--------|-------|----------|
| **Editor** | mundus-production | ✅ Ready | 50 passing | Hardened |
| **Digest** | digest-production | ✅ Ready | 821 passing | Hardened |
| **Prompt Lab** | prompt-lab | ✅ Ready | - | Hardened |
| **Supabase** | mundus-supabase | ✅ Ready | - | Documented |

### Deployment Status

**Staging (web3studio.dev):** ⏳ Pending deployment
**Production (Render.com):** ⏳ Pending deployment

See `deployment/STATUS.md` for detailed status.

---

## Development Workflow

**All changes follow Red/Green Checkpoint methodology:**

See `WORKFLOW.md` for complete methodology.

**Summary:**
1. 🔴 **RED:** Implement the change
2. 🟢 **GREEN:** Validate with tests
3. 🔵 **CHECKPOINT:** Commit and document

**Never skip validation (GREEN phase).**

---

## Repository Constraints

### Editor (repos/editor/)

**Special Constraints:**
- Backend v3: Requires careful modification (see CODE-PRESERVATION-RULES.md)
- Frontend: Requires careful modification
- Original developers: Mansour (backend), Johan (frontend)
- Security fixes: Comment old code + detailed notes

**Can Do:**
- Add test files
- Fix critical security issues (with documentation)
- Update documentation
- Troubleshoot deployment

**Avoid:**
- Refactoring their code unnecessarily
- Removing their debugging statements
- Breaking changes without discussion

---

### Digest, Prompt Lab, Supabase

**Constraints:** Standard best practices only

**Can Do:**
- Modify code freely
- Refactor for improvements
- Optimize performance
- Add features

**Must Do:**
- Follow WORKFLOW.md (RED→GREEN→CHECKPOINT)
- Don't break existing functionality
- Test thoroughly before deploying

---

### Supabase (repos/supabase/)

**Critical Constraint:**

**Before changing ANY Edge Function:**
1. Read `repos/supabase/docs/APP-INTEGRATION-MAP.md`
2. Check which apps use that function
3. Update ALL affected applications
4. Test each affected app
5. Deploy Edge Function first, then apps

**Why:** Apps depend on Edge Functions - coordinate changes!

---

## Deployment Phases

### Phase 1: Staging Validation

**Deploy to:** web3studio.dev (staging environment)

**Purpose:**
- Test all 4 components together
- Validate shared authentication
- Test cross-navigation (Editor ↔ Digest)
- Performance testing
- Final validation before client handoff

**Checklist:** See `deployment/web3studio/`

---

### Phase 2: Production Deployment

**Deploy to:** Render.com (client-owned)

**URLs:**
- https://mundus-editor.onrender.com/
- https://mundus-digest.onrender.com/
- https://mundus-prompt-lab.onrender.com/

**Steps:**
1. Staging validation complete
2. Connect repos to Render
3. Configure environment variables
4. Auto-deploy enabled
5. Monitor production health

**Checklist:** See `deployment/render/`

---

## Monitoring & Health Checks

**Check all applications:**
```bash
./monitoring/check-all.sh
```

**Manual health checks:**
```bash
curl https://editor.web3studio.dev/health
curl https://digest.web3studio.dev/health
curl https://prompt-lab.web3studio.dev/health
```

**Logs:**
- Deployment history: `monitoring/logs/deployment-history.log`
- Issue tracking: `monitoring/logs/issues.log`
- Fix history: `monitoring/logs/fixes.log`

---

## Directory Purpose

**This is NOT application code** - it's a coordination workspace.

**Use this directory to:**
- ✅ Coordinate multi-repo deployments
- ✅ Troubleshoot cross-application issues
- ✅ Monitor platform health
- ✅ Document deployment decisions
- ✅ Maintain change history

**Do NOT use this directory for:**
- ❌ Feature development (do in respective repos)
- ❌ Application code (belongs in repos/)
- ❌ Database changes (do in repos/supabase/)

---

## Common Operations

### Update All Repositories

```bash
cd repos/editor && git pull origin main
cd ../digest && git pull origin main
cd ../prompt-lab && git pull origin master
cd ../supabase && git pull origin master
```

### Deploy to Staging

See `deployment/web3studio/DEPLOY-ALL.md`

### Deploy to Production

See `deployment/render/DEPLOY-CHECKLIST.md`

### Check Platform Health

```bash
./monitoring/check-all.sh
```

---

## Documentation

- **WORKFLOW.md** - Red/Green Checkpoint development methodology
- **README.md** - Overview of this orchestration directory
- **AGENTS.md** - Current status and guidelines
- **deployment/STATUS.md** - Deployment tracking
- **repos/supabase/docs/APP-INTEGRATION-MAP.md** - Critical integration reference

---

## For AI Coding Assistants

When working in this directory:

1. **Read WORKFLOW.md** - Follow RED→GREEN→CHECKPOINT for all changes
2. **Check integration map** - Before Supabase changes
3. **Respect constraints** - Editor has code preservation rules
4. **Test thoroughly** - Validate before deploying
5. **Document everything** - Update logs and status files

---

**Last Updated:** 2025-11-20
**Version:** 1.0.0
**For:** Platform orchestration and deployment coordination
