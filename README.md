# Mundus Platform - Orchestration Hub

**Purpose:** Coordinate deployment and maintenance for Mundus platform
**Created:** 2025-11-20
**Version:** 1.0.0
**Type:** Meta-orchestration workspace

---

## Overview

This directory coordinates the complete Mundus platform consisting of 4 repositories:

1. **Editor** - Article management and AI writeup generation
2. **Digest** - Daily digest automation with PDF/email
3. **Prompt Lab** - AI prompt testing and optimization
4. **Supabase** - Edge Functions and database infrastructure

**Purpose:**
- Coordinate deployments across all repositories
- Monitor application health
- Troubleshoot cross-repository issues
- Document deployment history
- Manage staging and production environments

---

## Platform Architecture

```
┌────────────────────────────────────┐
│  Editor Application ($7/month)     │
│  - Article management              │
│  - AI writeup generation           │
│  - Admin dashboard                 │
└───────────┬────────────────────────┘
            ↓
┌────────────────────────────────────┐
│  Digest Application ($7/month)     │
│  - Daily digest automation         │
│  - PDF generation (bundled)        │
│  - Email automation                │
└───────────┬────────────────────────┘
            ↓
┌────────────────────────────────────┐
│  Prompt Lab ($7/month)             │
│  - AI prompt testing               │
│  - Model configuration             │
│  - Results comparison              │
└───────────┬────────────────────────┘
            ↓
┌────────────────────────────────────┐
│  Supabase Backend (managed)        │
│  - PostgreSQL databases (2)        │
│  - Edge Functions (5 deployed)     │
│  - Automated content pipeline      │
└────────────────────────────────────┘
```

**Total Cost:** $21/month (+ Supabase usage)

---

## Repository Structure

```
mundus-final/
├── repos/                      # Git submodules
│   ├── editor/                → mundus-production (GitHub)
│   ├── digest/                → digest-production (GitHub)
│   ├── prompt-lab/            → prompt-lab (GitHub)
│   └── supabase/              → mundus-supabase (GitHub)
│
├── deployment/                 # Deployment coordination
│   ├── web3studio/            # Staging deployment specs
│   ├── render/                # Production deployment specs
│   └── STATUS.md              # Current deployment status
│
├── monitoring/                 # Platform monitoring
│   ├── check-all.sh           # Health check all apps
│   ├── logs/                  # Deployment history
│   │   ├── deployment-history.log
│   │   ├── fixes.log
│   │   └── issues.log
│   └── README.md
│
├── docs/                       # Orchestration guides
│   ├── DEPLOYMENT-WORKFLOW.md
│   ├── TROUBLESHOOTING.md
│   └── ARCHITECTURE-OVERVIEW.md
│
├── CLAUDE.md                   # AI assistant context
├── AGENTS.md                   # Current status & guidelines
├── WORKFLOW.md                 # Red/Green Checkpoint methodology
├── README.md                   # This file
└── VERSION                     # 1.0.0
```

---

## Quick Start

### Check Platform Health

```bash
cd /path/to/mundus-final

# Check all applications
./monitoring/check-all.sh
```

### Update All Repositories

```bash
# Pull latest from all repos
cd repos/editor && git pull origin main
cd ../digest && git pull origin main
cd ../prompt-lab && git pull origin master
cd ../supabase && git pull origin master
```

### Work on Specific Application

```bash
cd repos/editor      # Work on Editor
cd repos/digest      # Work on Digest
cd repos/prompt-lab  # Work on Prompt Lab
cd repos/supabase    # Manage Supabase
```

---

## Deployment Strategy

### Phase 1: Staging (web3studio.dev)

**Purpose:** Validate before production

```bash
# Deploy to staging environment
# See deployment/web3studio/ for specs

# Test all applications
./monitoring/check-all.sh

# Validate:
# - All apps healthy
# - Shared auth works
# - Cross-navigation works
# - Performance acceptable
```

---

### Phase 2: Production (Render.com)

**Purpose:** Client-owned production deployment

```bash
# After staging validation complete
# See deployment/render/ for checklist

# Connect repos to Render
# Configure environment variables
# Enable auto-deploy

# Monitor deployment
# Validate production URLs
```

---

## Development Workflow

**All changes follow Red/Green Checkpoint methodology.**

See `WORKFLOW.md` for complete guide.

**Quick Summary:**
1. 🔴 Implement change
2. 🟢 Validate (run tests, checks)
3. 🔵 Checkpoint (commit, document)

---

## Critical Documentation

**Must Read:**
- **`WORKFLOW.md`** - Development methodology for all changes
- **`repos/editor/specs/CODE-PRESERVATION-RULES.md`** - Editor modification constraints
- **`repos/supabase/docs/APP-INTEGRATION-MAP.md`** - App/Supabase dependencies

**Deployment:**
- `deployment/STATUS.md` - Current deployment state
- `deployment/web3studio/` - Staging deployment
- `deployment/render/` - Production deployment

**Monitoring:**
- `monitoring/check-all.sh` - Health check script
- `monitoring/logs/` - Deployment and change history

---

## Troubleshooting

### Application Won't Start

1. Check environment variables
2. Check database connection (Supabase)
3. Review recent commits
4. Check Render/staging logs
5. Test locally

### Cross-Application Issues

**Shared Auth Not Working:**
- Verify same Supabase project/keys
- Check CORS settings
- Test each app independently

**Edge Function Failures:**
- Check `repos/supabase/docs/APP-INTEGRATION-MAP.md`
- Verify Edge Function deployed
- Check Supabase logs
- Test Edge Function directly

---

## Support

**Repositories:**
- Editor: https://github.com/ydun-code-library/mundus-production
- Digest: https://github.com/ydun-code-library/digest-production
- Prompt Lab: https://github.com/ydun-code-library/prompt-lab
- Supabase: https://github.com/ydun-code-library/mundus-supabase

**Issues:** Use GitHub Issues in respective repositories
**Orchestration:** Use mundus-final repo Issues for cross-repo coordination

---

**Last Updated:** 2025-11-20
**Version:** 1.0.0
**Maintained By:** Platform Team
