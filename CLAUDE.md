# Claude Code - Operating Instructions for Mundus Final

**Directory:** /home/jimmyb/m-e-p/mundus-final
**Role:** Orchestration & Troubleshooting Hub
**Operator:** Chromebook (Claude Code)
**Machine:** Chromebook via Claude Code CLI

---

## Purpose of This Directory

**This is a META-ORCHESTRATION workspace** for managing 3 Mundus production applications during deployment and operation.

**What you (Claude Code on Chromebook) do here:**
- ✅ Coordinate deployments across 3 repos
- ✅ Troubleshoot production issues
- ✅ Create deployment specs
- ✅ Monitor health of all 3 apps
- ✅ Work with Beast via Tailscale for heavy tasks
- ✅ Document issues and resolutions

**What you do NOT do here:**
- ❌ Write application features (do that in the production repos)
- ❌ Modify Mansour/Johan's code directly
- ❌ Make breaking changes without specs

---

## The 3 Production Repositories

### 1. Editor (repos/editor/)

**Repository:** mundus-production (git submodule)
**GitHub:** https://github.com/ydun-code-library/mundus-production
**Purpose:** Article management with AI writeup generation
**Deployment:** Render.com ($7/month)

**CRITICAL CONSTRAINTS:**
- ⚠️ **Mansour's backend v3 = READ-ONLY**
- ⚠️ **Johan's frontend = READ-ONLY**
- ⚠️ If security fix needed: Comment old code + detailed notes
- ⚠️ Read repos/editor/specs/CODE-PRESERVATION-RULES.md

**What you CAN do:**
- ✅ Add test files
- ✅ Fix CRITICAL security issues (with documentation)
- ✅ Update documentation
- ✅ Troubleshoot deployment issues

**What you CANNOT do:**
- ❌ Refactor Mansour's code
- ❌ Change Johan's component logic
- ❌ Remove their console.log statements
- ❌ Rename their variables

---

### 2. Digest (repos/digest/)

**Repository:** digest-production (git submodule)
**GitHub:** https://github.com/ydun-code-library/digest-production
**Purpose:** Daily digest automation with PDF/email
**Deployment:** Render.com ($7/month)

**Constraints:** ✅ NONE - We own this code

**What you CAN do:**
- ✅ Refactor freely
- ✅ Optimize performance
- ✅ Fix bugs
- ✅ Add features
- ✅ Change anything (just don't break functionality)

---

### 3. Prompt Lab (repos/prompt-lab/)

**Repository:** prompt-lab (git submodule)
**GitHub:** https://github.com/ydun-code-library/prompt-lab
**Purpose:** AI prompt testing and optimization
**Deployment:** Render.com ($7/month)

**Constraints:** ✅ NONE - We own this code

**What you CAN do:**
- ✅ Refactor freely
- ✅ Optimize performance
- ✅ Fix bugs
- ✅ Add features
- ✅ Change anything (just don't break functionality)

---

## How to Operate

### Starting a Session

```bash
# Navigate to orchestration directory
cd /home/jimmyb/m-e-p/mundus-final

# Claude Code will auto-load this CLAUDE.md
# Read AGENTS.md for current status and tasks
```

**Always check:**
1. Read AGENTS.md for current deployment status
2. Check deployment/STATUS.md for latest issues
3. Review monitoring/logs/ for recent problems

---

### Troubleshooting a Production Issue

**Scenario:** Editor app has a bug in production

```bash
# 1. Navigate to editor submodule
cd repos/editor

# 2. Pull latest
git pull origin main

# 3. Reproduce issue locally
cd backend && npm run dev
# OR
cd frontend && npm run dev

# 4. Identify root cause
# Use Claude Code tools: Read, Grep, Bash, etc.

# 5. Create fix
# If affects Mansour/Johan's code: Read CODE-PRESERVATION-RULES.md
# If just config/docs: Fix directly

# 6. Test fix
npm test

# 7. Commit and push
git add .
git commit -m "fix: [description]"
git push origin main

# 8. Document in orchestration directory
cd /home/jimmyb/m-e-p/mundus-final
echo "[Date] - Editor - [Issue] - [Fix]" >> monitoring/logs/fixes.log
```

---

### Deploying to Beast for Testing

**Use Beast via Tailscale:**

```bash
# SSH to Beast from Chromebook
ssh jamesb@beast

# On Beast, pull latest
cd ~/mundus-production && git pull origin main
cd ~/digest-production && git pull origin main
cd ~/prompt-lab && git pull origin main

# Deploy with Docker Compose
docker-compose up -d

# Access via Cloudflare Tunnel
# https://editor.web3studio.dev/
# https://digest.web3studio.dev/
# https://prompt-lab.web3studio.dev/
```

**Create deployment spec from orchestration directory:**

```bash
cd /home/jimmyb/m-e-p/mundus-final

# Create spec in deployment/web3studio/
cat > deployment/web3studio/DEPLOY-ALL-TO-BEAST.md <<EOF
# Deploy All 3 Apps to Beast

[Step-by-step instructions for Beast]
EOF

# Push spec
git add deployment/
git commit -m "deploy: Add Beast deployment spec"
git push origin main

# Beast pulls and executes
```

---

### Working with Beast

**Via Tailscale:**
- Chromebook can SSH: `ssh jamesb@beast`
- Chromebook can access Beast Docker: `ssh jamesb@beast "docker ps"`

**Via GitHub (Preferred):**
- Chromebook creates spec → pushes to GitHub
- Beast pulls spec → executes
- Beast pushes results → Chromebook reviews

**Communication Pattern:**
```
Chromebook (Strategic):
- Analyze issue
- Create detailed spec
- Push to GitHub

Beast (Execution):
- Pull spec
- Execute with Haiku 4.5
- Push results

Chromebook (Review):
- Pull results
- Validate quality
- Approve or request iteration
```

---

## Critical Operating Rules

### Rule 1: Never Modify Production Repos Directly from Here

**WRONG:**
```bash
cd repos/editor
# Make changes directly
git commit && git push
```

**RIGHT:**
```bash
cd repos/editor
# Read code, investigate issue
# Return to orchestration directory
cd /home/jimmyb/m-e-p/mundus-final
# Create spec for fix
# Push spec, let Beast execute or execute manually with care
```

---

### Rule 2: Respect Editor Code Preservation

**ALWAYS check before modifying editor:**

```bash
cd repos/editor
cat specs/CODE-PRESERVATION-RULES.md

# If touching backend v3 or frontend:
# - Comment old code
# - Add detailed notes
# - Minimal changes only
# - Security fixes only
```

---

### Rule 3: Test on Beast Before Render

**Deployment Flow:**
1. ✅ Test locally on Chromebook (if light)
2. ✅ Deploy to Beast (web3studio.dev)
3. ✅ Validate all 3 apps work
4. ✅ Check cross-navigation
5. ✅ Check shared auth
6. ✅ THEN deploy to Render.com

**Never:**
- ❌ Deploy directly to Render without Beast validation
- ❌ Skip testing phase
- ❌ Deploy unverified changes

---

### Rule 4: Document Everything

**After any deployment or fix:**

```bash
cd /home/jimmyb/m-e-p/mundus-final

# Log the action
echo "[2025-11-20] Editor - Fixed XSS vulnerability - Deployed to Beast - Validated OK" >> monitoring/logs/deployment-history.log

# Update status
# Edit deployment/STATUS.md with current state
```

---

## Tools Available

**From Chromebook:**
- ✅ Claude Code (you!) - Analysis, planning, specs
- ✅ SSH to Beast - Heavy tasks, Docker deployments
- ✅ GitHub - Coordination, version control
- ✅ Tailscale - Secure access to Beast

**From Beast (via Tailscale/SSH):**
- ✅ Docker - Container builds and deployments
- ✅ Haiku 4.5 - Execution of specs
- ✅ Heavy processing - Builds, tests
- ✅ Cloudflare Tunnel - web3studio.dev testing

---

## Typical Session Workflow

### Session Start

```bash
cd /home/jimmyb/m-e-p/mundus-final

# Claude Code loads this CLAUDE.md automatically
# Read current status
cat AGENTS.md
cat deployment/STATUS.md

# Check health
./monitoring/check-all.sh
```

### During Session

- Troubleshoot issues as they arise
- Create specs for fixes
- Coordinate with Beast
- Monitor deployments
- Document changes

### Session End

```bash
# Update status
# Edit deployment/STATUS.md

# Commit orchestration changes
git add .
git commit -m "session: [What was accomplished]"
git push origin main
```

---

## Emergency Procedures

### App Down on Render

1. Check Render dashboard logs
2. SSH to Beast and test there
3. If Beast works, issue is Render-specific
4. If Beast also fails, issue is in code
5. Create hotfix spec
6. Test on Beast
7. Deploy to Render

### Database Issue

1. Check Supabase dashboard
2. Check connection strings
3. Test queries manually
4. If all 3 apps affected: Database issue
5. If 1 app affected: App configuration issue

### Cross-App Issues

1. Test shared auth (can user login to all 3?)
2. Test shared database (do all 3 see same data?)
3. Test cross-navigation (links work?)
4. Document in monitoring/logs/cross-app-issues.log

---

## Quick Reference

**Health Checks:**
```bash
curl https://editor.web3studio.dev/health
curl https://digest.web3studio.dev/health
curl https://prompt-lab.web3studio.dev/health
```

**Beast Access:**
```bash
ssh jamesb@beast
ssh jamesb@beast "docker ps"
ssh jamesb@beast "cd ~/mundus-production && git status"
```

**Repository Updates:**
```bash
cd repos/editor && git pull origin main
cd ../digest && git pull origin main
cd ../prompt-lab && git pull origin master
```

---

**Remember:** You are the Orchestrator. Analyze, plan, coordinate. Let Beast execute heavy tasks.

**Last Updated:** 2025-11-20
**Operator:** Chromebook (Claude Code)
