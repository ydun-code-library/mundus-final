# Mundus Production Orchestration

**Purpose:** Meta-repository for managing 3 Mundus production applications during deployment
**Operator:** Chromebook (Claude Code)
**Created:** 2025-11-20
**Version:** 0.1.0

---

## Overview

This directory orchestrates deployment and troubleshooting for the complete Mundus platform ecosystem.

**Managed Applications (3):**
1. **Editor** - Article management and AI writeup generation
2. **Digest** - Daily digest automation with PDF generation
3. **Prompt Lab** - AI prompt testing and optimization

**Deployment Strategy:**
- **Phase 1:** Deploy to Beast (web3studio.dev via Cloudflare Tunnel) for testing
- **Phase 2:** Deploy to Render.com for production client handoff

---

## Directory Purpose

**This is NOT application code** - it's an orchestration workspace.

**What happens here:**
- Coordinate deployments across 3 repos
- Troubleshoot production issues
- Monitor deployment health
- Create deployment specs
- Cross-repo coordination

**What does NOT happen here:**
- No application development
- No feature building
- No direct code changes to production repos

---

## Repository Structure

```
mundus-final/
├── repos/                  # Git submodules (3 production repos)
│   ├── editor/            → mundus-production
│   ├── digest/            → digest-production
│   └── prompt-lab/        → prompt-lab
│
├── deployment/             # Deployment orchestration
│   ├── web3studio/        # Beast deployment specs
│   └── render/            # Render.com deployment specs
│
├── monitoring/             # Health checks and monitoring
│   ├── check-all.sh       # Check all 3 apps
│   └── logs/              # Deployment logs
│
├── docs/                   # Orchestration documentation
│   ├── DEPLOYMENT-WORKFLOW.md
│   ├── TROUBLESHOOTING.md
│   └── ARCHITECTURE-OVERVIEW.md
│
├── CLAUDE.md               # How to operate this directory
├── AGENTS.md               # Workflow and constraints
├── README.md               # This file
└── VERSION                 # 0.1.0
```

---

## The 3 Production Applications

### 1. Editor (mundus-production)
- **Repository:** https://github.com/ydun-code-library/mundus-production
- **Purpose:** Article management with AI writeup generation
- **Stack:** Node.js + React + PostgreSQL
- **Cost:** $7/month (Render)
- **Developers:** Mansour (backend v3), Johan (frontend)
- **Constraints:** ⚠️ Code preservation rules apply

### 2. Digest (digest-production)
- **Repository:** https://github.com/ydun-code-library/digest-production
- **Purpose:** Daily digest automation with PDF/email
- **Stack:** Node.js + React + digest-service + pdf-service (bundled)
- **Cost:** $7/month (Render)
- **Constraints:** ✅ Can modify freely (we own this)

### 3. Prompt Lab (prompt-lab)
- **Repository:** https://github.com/ydun-code-library/prompt-lab
- **Purpose:** AI prompt testing and optimization
- **Stack:** Node.js + Vanilla JS + Express
- **Cost:** $7/month (Render)
- **Constraints:** ✅ Can modify freely (we own this)

**Total Infrastructure Cost:** $21/month

---

## Deployment Workflow

### Phase 1: Beast Testing (web3studio.dev)

**Purpose:** Validate everything works before client handoff

```
Chromebook (this directory)
    ↓ Create deployment specs
Beast
    ↓ Execute specs
web3studio.dev (Cloudflare Tunnel)
    ↓ Test all 3 apps
Chromebook
    ↓ Validate and approve
```

**Domains (Beast via Cloudflare):**
- https://editor.web3studio.dev/
- https://digest.web3studio.dev/
- https://prompt-lab.web3studio.dev/

### Phase 2: Render.com Production

**After Beast validation:**

```
Push to production repos
    ↓
Render.com auto-deploy
    ↓
Production URLs live
    ↓
Client handoff complete
```

**Domains (Render.com):**
- https://mundus-editor.onrender.com/
- https://mundus-digest.onrender.com/
- https://mundus-prompt-lab.onrender.com/

---

## Operating from This Directory

**See CLAUDE.md for detailed instructions.**

**Quick Reference:**

### Troubleshooting Production Issues

```bash
# From this directory
cd /home/jimmyb/m-e-p/mundus-final

# Check all 3 apps
./monitoring/check-all.sh

# Work on specific app
cd repos/editor      # Troubleshoot editor
cd repos/digest      # Troubleshoot digest
cd repos/prompt-lab  # Troubleshoot prompt-lab
```

### Making Changes

**Editor (repos/editor/):**
- ⚠️ **Read CODE-PRESERVATION-RULES.md first!**
- ⚠️ Don't change Mansour's backend v3
- ⚠️ Don't change Johan's frontend
- ✅ Can add tests, fix critical security issues only

**Digest (repos/digest/):**
- ✅ Can change freely (we own it)
- ✅ Can refactor, optimize
- ✅ Just don't break functionality

**Prompt Lab (repos/prompt-lab/):**
- ✅ Can change freely (we own it)
- ✅ Can refactor, optimize
- ✅ Just don't break functionality

---

## Communication with Beast

**Via Tailscale:**
- Chromebook can SSH to Beast: `ssh jamesb@beast`
- Can deploy to Beast for testing
- Can monitor Beast containers
- Coordinate via GitHub (push specs → Beast pulls → executes)

---

## Workflow

**For Deployment Issues:**

1. **Identify issue** in one of the 3 apps
2. **Create fix spec** in this directory (deployment/specs/)
3. **Test locally** if possible
4. **Push spec to production repo**
5. **Beast executes** (or manual fix)
6. **Validate fix** works
7. **Document** in monitoring/logs/

**For Multi-Repo Coordination:**

1. **Create orchestration spec** (affects multiple repos)
2. **Execute from this directory**
3. **Coordinate with Beast** via Tailscale/GitHub
4. **Validate all 3 apps** still work together

---

## Directory Initialization

```bash
cd /home/jimmyb/m-e-p/mundus-final

# Add production repos as submodules
git init
git submodule add git@github.com:ydun-code-library/mundus-production.git repos/editor
git submodule add git@github.com:ydun-code-library/digest-production.git repos/digest
git submodule add git@github.com:ydun-code-library/prompt-lab.git repos/prompt-lab

# Initial commit
git add .
git commit -m "init: Mundus production orchestration directory"
```

---

## Key Principles

1. **Chromebook is Orchestrator** for this directory
2. **Beast is Executor** for heavy deployment work
3. **Respect ownership** - Editor has preservation rules
4. **Test on Beast first** before Render production
5. **Document everything** - deployment logs, issues, decisions

---

**Status:** Initialization in progress
**Next:** Complete setup, add submodules, create deployment specs
**Maintained By:** Chromebook Orchestrator (Claude Code)
