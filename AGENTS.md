# Mundus Production Orchestration - Deployment Hub

**Created:** 2025-11-20
**Purpose:** Coordinate deployment and troubleshooting for 3 Mundus production applications
**Operator:** Chromebook (Claude Code)
**Role:** Orchestration, monitoring, troubleshooting

---

## Repository Information

**GitHub Repository:** TBD (to be created)
**Local Directory:** `/home/jimmyb/m-e-p/mundus-final`
**Type:** Meta-orchestration workspace (not application code)

---

## What This Directory Manages

### The 3 Production Applications

| App | Repository | Deployment | Cost | Ownership |
|-----|------------|------------|------|-----------|
| **Editor** | mundus-production | Render.com | $7/mo | Mansour (backend) + Johan (frontend) |
| **Digest** | digest-production | Render.com | $7/mo | Jimmy + Claude (we own it) |
| **Prompt Lab** | prompt-lab | Render.com | $7/mo | Jimmy + Claude (we own it) |

**Total:** $21/month for complete client-owned infrastructure

---

## Current Status

**Last Updated:** 2025-11-20

### Editor (mundus-production)
- **Status:** ✅ Production-ready
- **Tests:** 50 backend tests passing
- **Security:** Hardened, zero vulnerabilities
- **Documentation:** Professional, client-ready
- **Ready For:** Render.com deployment

### Digest (digest-production)
- **Status:** ✅ Production-ready
- **Tests:** 821 tests passing (backend + digest-service + pdf-service)
- **Security:** Hardened
- **Documentation:** Professional, client-ready
- **Ready For:** Render.com deployment

### Prompt Lab (prompt-lab)
- **Status:** ✅ Production-ready
- **Security:** Hardened (session auth, rate limiting)
- **Documentation:** Professional
- **Ready For:** Render.com deployment

---

## Deployment Phases

### Phase 1: Beast Testing (Current)

**Purpose:** Validate all 3 apps on Beast before client handoff

**URLs (web3studio.dev via Cloudflare Tunnel):**
- https://editor.web3studio.dev/
- https://digest.web3studio.dev/
- https://prompt-lab.web3studio.dev/

**Validation Checklist:**
- [ ] All 3 apps deploy successfully
- [ ] Health checks passing
- [ ] Shared Supabase auth works
- [ ] Cross-navigation works (Editor ↔ Digest)
- [ ] All features functional
- [ ] Performance acceptable
- [ ] No errors in logs

**Status:** ⏳ Ready to deploy, awaiting execution

---

### Phase 2: Render.com Production

**Purpose:** Client-owned production deployment

**URLs (Render.com):**
- https://mundus-editor.onrender.com/
- https://mundus-digest.onrender.com/
- https://mundus-prompt-lab.onrender.com/

**Deployment Steps:**
1. Validate Beast testing complete
2. Connect GitHub repos to Render
3. Configure environment variables
4. Deploy all 3 apps
5. Test production URLs
6. Hand off to client

**Status:** ⏳ Waiting for Beast validation

---

## Operating Constraints

### Editor Repository Constraints

**CRITICAL:** Mansour and Johan's code must be preserved!

**Read First:** `repos/editor/specs/CODE-PRESERVATION-RULES.md`

**Rules:**
- ❌ DO NOT modify backend v3 controllers, repositories, routes
- ❌ DO NOT modify frontend components (Johan's work)
- ❌ DO NOT refactor their code
- ✅ CAN add test files (new files only)
- ✅ CAN fix CRITICAL security issues (with detailed comments)
- ✅ CAN update documentation

**If Security Fix Required:**
```jsx
{/*
  ORIGINAL CODE (Johan/Mansour):
  [Old code here]

  SECURITY FIX (Date - Audit Finding):
  Issue: [Description]
  Fix: [What changed]
  Why: [Justification]
*/}
[New code]
```

---

### Digest & Prompt Lab: No Constraints

**We own these repos** - can modify freely

**Guidelines:**
- ✅ Refactor for clarity
- ✅ Optimize performance
- ✅ Fix bugs immediately
- ✅ Add features as needed
- ⚠️ Don't break existing functionality (test first!)

---

## Workflow for Changes

### Making Changes to Editor

**Process:**
1. Navigate: `cd repos/editor`
2. Read: `cat specs/CODE-PRESERVATION-RULES.md`
3. Investigate issue using Claude Code tools
4. Create minimal fix (if security-critical only)
5. Comment old code + add detailed notes
6. Test thoroughly
7. Commit with detailed message
8. Push to GitHub
9. Document in `monitoring/logs/fixes.log`

---

### Making Changes to Digest or Prompt Lab

**Process:**
1. Navigate: `cd repos/digest` or `cd repos/prompt-lab`
2. Investigate issue
3. Create fix (can refactor freely)
4. Test thoroughly
5. Commit and push
6. Document in monitoring logs

---

## Deployment Coordination

### Deploying to Beast (web3studio.dev)

**Chromebook's Role:**
1. Create deployment spec (deployment/web3studio/)
2. SSH to Beast via Tailscale
3. Execute deployment OR create spec for Beast
4. Monitor deployment
5. Validate all 3 apps
6. Document results

**Beast's Role:**
1. Pull latest from all 3 repos
2. Build Docker containers
3. Deploy to Beast
4. Configure Cloudflare Tunnels
5. Run health checks
6. Report status

---

### Deploying to Render.com

**Chromebook's Role:**
1. Ensure Beast validation complete
2. Create deployment checklist
3. Connect repos to Render (if not already)
4. Verify environment variables
5. Monitor auto-deployment
6. Validate production URLs
7. Document for client handoff

---

## Communication with Beast

**Methods:**

1. **Via Tailscale/SSH (Direct):**
   ```bash
   ssh jamesb@beast
   # Direct commands on Beast
   ```

2. **Via GitHub (Async):**
   ```bash
   # Chromebook creates spec → pushes
   git push origin main

   # Beast pulls → executes
   # Beast pushes results → Chromebook reviews
   ```

**Prefer GitHub for:**
- Complex multi-step deployments
- When spec documentation is valuable
- Async execution (Beast works while Chromebook does other things)

**Prefer SSH for:**
- Quick checks
- Emergency fixes
- Real-time monitoring

---

## Troubleshooting Guide

### App Won't Start

1. Check environment variables
2. Check database connection
3. Check Supabase status
4. Review container logs
5. Test locally
6. Deploy to Beast for isolation testing

### Cross-App Issues

**Shared Auth Not Working:**
1. Verify both apps use same SUPABASE_URL
2. Verify SUPABASE_ANON_KEY matches
3. Test login on each app separately
4. Check CORS settings

**Cross-Navigation Broken:**
1. Verify environment variables (VITE_EDITOR_URL, VITE_DIGEST_URL)
2. Check links in frontend code
3. Test manually

---

## Monitoring

### Health Check Script

**File:** `monitoring/check-all.sh`

```bash
#!/bin/bash
echo "=== Checking All 3 Production Apps ==="

echo -n "Editor: "
curl -f https://editor.web3studio.dev/health && echo "✅" || echo "❌"

echo -n "Digest: "
curl -f https://digest.web3studio.dev/health && echo "✅" || echo "❌"

echo -n "Prompt Lab: "
curl -f https://prompt-lab.web3studio.dev/health && echo "✅" || echo "❌"
```

**Run:** `./monitoring/check-all.sh`

---

## Directory Structure

```
mundus-final/
├── repos/                      # Git submodules
│   ├── editor/                → mundus-production
│   ├── digest/                → digest-production
│   └── prompt-lab/            → prompt-lab
│
├── deployment/                 # Deployment orchestration
│   ├── web3studio/            # Beast deployment specs
│   │   ├── DEPLOY-EDITOR.md
│   │   ├── DEPLOY-DIGEST.md
│   │   ├── DEPLOY-PROMPT-LAB.md
│   │   └── DEPLOY-ALL.md
│   ├── render/                # Render.com deployment
│   │   ├── DEPLOY-CHECKLIST.md
│   │   └── ENV-VARS.md
│   └── STATUS.md              # Current deployment status
│
├── monitoring/                 # Health & monitoring
│   ├── check-all.sh           # Health check script
│   ├── logs/
│   │   ├── deployment-history.log
│   │   ├── fixes.log
│   │   └── issues.log
│   └── README.md
│
├── docs/                       # Orchestration docs
│   ├── DEPLOYMENT-WORKFLOW.md
│   ├── TROUBLESHOOTING.md
│   └── ARCHITECTURE-OVERVIEW.md
│
├── CLAUDE.md                   # Operating instructions (this context)
├── AGENTS.md                   # Current status & workflow
├── README.md                   # Directory overview
└── VERSION                     # 0.1.0
```

---

## Important Notes

### This is an Orchestration Directory

**Not application code!** This directory coordinates the 3 production repos.

**Think of it as:**
- Mission control for deployments
- Troubleshooting workspace
- Coordination hub
- Documentation central

### Chromebook is Primary Operator

**From this directory, Chromebook can:**
- Investigate issues across all 3 repos
- Create deployment plans
- Coordinate with Beast
- Monitor production health
- Document deployment history

**Chromebook does NOT:**
- Build Docker containers (Beast does this)
- Run heavy tests (Beast does this)
- Host applications (Beast or Render does this)

---

## Next Steps

**Immediate (Setup):**
- [x] Create directory structure
- [x] Write CLAUDE.md
- [x] Write AGENTS.md
- [ ] Add git submodules for 3 repos
- [ ] Create deployment directory structure
- [ ] Create monitoring scripts
- [ ] Initialize git repository
- [ ] Push to GitHub

**Phase 1 (Beast Testing):**
- [ ] Create Beast deployment specs
- [ ] Deploy all 3 apps to Beast
- [ ] Configure Cloudflare Tunnels
- [ ] Validate functionality
- [ ] Document results

**Phase 2 (Client Handoff):**
- [ ] Deploy to Render.com
- [ ] Final validation
- [ ] Create client handoff documentation
- [ ] Transfer to client

---

**Directory Status:** In setup
**Phase:** Initialization
**Ready For:** Adding submodules and creating deployment specs

---

*Last Updated: 2025-11-20*
*Maintained By: Chromebook Orchestrator (Claude Code)*
