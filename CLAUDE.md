# Claude Code - Mundus Orchestration Hub

**Directory:** mundus-final
**Purpose:** Coordinate deployment and troubleshooting for Mundus platform
**Type:** Meta-orchestration workspace

---

## Purpose

This directory coordinates 4 Mundus repositories:
- **Editor** - Article management application
- **Digest** - Daily digest automation
- **Prompt Lab** - AI prompt testing tool
- **Supabase** - Edge Functions and database management

**What happens here:**
- Coordinate deployments across repositories
- Troubleshoot production issues
- Monitor application health
- Create deployment specifications
- Document changes and decisions

---

## Repository Structure

```
mundus-final/
├── repos/                  # Git submodules (4 repositories)
│   ├── editor/            → mundus-production
│   ├── digest/            → digest-production
│   ├── prompt-lab/        → prompt-lab
│   └── supabase/          → mundus-supabase
│
├── deployment/             # Deployment coordination
│   ├── web3studio/        # Staging deployment
│   ├── render/            # Production deployment
│   └── STATUS.md          # Current deployment status
│
├── monitoring/             # Health checks
│   ├── check-all.sh       # Check all applications
│   └── logs/              # Deployment history
│
├── docs/                   # Orchestration guides
│
├── CLAUDE.md               # This file (AI assistant context)
├── AGENTS.md               # Workflow and guidelines
├── WORKFLOW.md             # Red/Green Checkpoint methodology
└── README.md               # Overview
```

---

## The 4 Repositories

### 1. Editor (repos/editor/)
**Repository:** mundus-production
**Purpose:** Article management with AI writeup generation
**Deployment:** Render.com ($7/month)
**Developers:** Mansour (backend), Johan (frontend)

**Important:** Backend v3 and frontend code should be modified carefully
- Read `repos/editor/specs/CODE-PRESERVATION-RULES.md` before changes
- Comment old code if security fixes needed
- Add detailed notes for any modifications

### 2. Digest (repos/digest/)
**Repository:** digest-production
**Purpose:** Daily digest automation with PDF/email
**Deployment:** Render.com ($7/month)
**Services:** digest-service + pdf-service bundled

**Constraints:** Can modify freely (self-contained codebase)

### 3. Prompt Lab (repos/prompt-lab/)
**Repository:** prompt-lab
**Purpose:** AI prompt testing and optimization
**Deployment:** Render.com ($7/month)

**Constraints:** Can modify freely

### 4. Supabase (repos/supabase/)
**Repository:** mundus-supabase
**Purpose:** Edge Functions, database management
**Deployment:** Supabase (managed service)

**Critical:** Check `repos/supabase/docs/APP-INTEGRATION-MAP.md` before changes
- Shows which apps use which Edge Functions
- Prevents breaking apps with backend changes

---

## Working from This Directory

### Starting a Session

```bash
cd /path/to/mundus-final

# Check current status
cat AGENTS.md
cat deployment/STATUS.md

# Check all apps health
./monitoring/check-all.sh
```

### Troubleshooting an Issue

**Example: Editor has a bug**

```bash
# Navigate to editor
cd repos/editor

# Pull latest
git pull origin main

# Investigate using Claude Code tools
# (Read, Grep, Bash, etc.)

# Create fix following WORKFLOW.md (RED→GREEN→CHECKPOINT)

# Test
cd backend && npm test

# Commit and push
git add .
git commit -m "fix: [description]"
git push origin main

# Document
cd /path/to/mundus-final
echo "[Date] Editor - [Issue] - [Fix]" >> monitoring/logs/fixes.log
```

### Updating Edge Functions

```bash
# Navigate to Supabase repo
cd repos/supabase

# Check integration map FIRST
cat docs/APP-INTEGRATION-MAP.md
# See which apps use this function

# Make changes to Edge Function

# Deploy
export SUPABASE_ACCESS_TOKEN=<token>
npx supabase functions deploy <function-name> --no-verify-jwt

# Test affected apps
cd ../editor && npm test
cd ../prompt-lab && npm test

# Commit
git add .
git commit -m "fix: [description]"
git push origin master
```

---

## Deployment Workflow

### Phase 1: Staging (web3studio.dev)

**Purpose:** Test all applications before production

**Staging URLs:**
- https://editor.web3studio.dev/
- https://digest.web3studio.dev/
- https://prompt-lab.web3studio.dev/

**Validation:**
- All apps deploy successfully
- Health checks passing
- Shared authentication works
- Cross-navigation works
- All features functional

### Phase 2: Production (Render.com)

**Purpose:** Client-owned production deployment

**Production URLs:**
- https://mundus-editor.onrender.com/
- https://mundus-digest.onrender.com/
- https://mundus-prompt-lab.onrender.com/

**Deployment:**
1. Validate staging complete
2. Connect GitHub repos to Render
3. Configure environment variables
4. Auto-deploy from main/master branches

---

## Critical Guidelines

### Before Changing Code

**Editor Repository:**
1. Read `repos/editor/specs/CODE-PRESERVATION-RULES.md`
2. Backend v3 and frontend require careful handling
3. Comment old code if changes needed
4. Add detailed notes explaining why

**Supabase Repository:**
1. Read `repos/supabase/docs/APP-INTEGRATION-MAP.md`
2. Check which apps use the Edge Function
3. Update ALL affected apps
4. Test each app after deployment

**Digest & Prompt Lab:**
1. Can modify freely
2. Follow WORKFLOW.md (RED→GREEN→CHECKPOINT)
3. Don't break existing functionality

---

## Development Methodology

**Follow WORKFLOW.md for all changes:**

1. 🔴 **RED:** Implement the change
2. 🟢 **GREEN:** Validate with tests and checks
3. 🔵 **CHECKPOINT:** Commit and document

**Never skip the GREEN phase.**

---

## Health Monitoring

**Check all applications:**
```bash
./monitoring/check-all.sh
```

**Manual checks:**
```bash
curl https://editor.web3studio.dev/health
curl https://digest.web3studio.dev/health
curl https://prompt-lab.web3studio.dev/health
```

---

## Common Tasks

### Deploy All Apps to Staging

See `deployment/web3studio/DEPLOY-ALL.md` for complete guide.

### Deploy to Render.com Production

See `deployment/render/DEPLOY-CHECKLIST.md` for complete guide.

### Update Documentation

After any change:
```bash
cd /path/to/mundus-final

# Log the change
echo "[Date] [Repo] - [Change]" >> monitoring/logs/changes.log

# Update deployment status if needed
# Edit deployment/STATUS.md
```

---

## Emergency Procedures

### Application Down

1. Check health endpoint: `curl https://app-url/health`
2. Check Render logs (Render dashboard)
3. Check recent commits: `git log -5`
4. Check if recent deploy: Review deployment/STATUS.md
5. Rollback if needed: `git revert <commit>`

### Supabase Issue

1. Check Supabase dashboard status
2. Check Edge Function logs
3. Verify environment variables set
4. Test Edge Function directly
5. Review integration map for affected apps

---

## Documentation Structure

**Always update after changes:**
- `deployment/STATUS.md` - Current deployment state
- `monitoring/logs/` - Change history
- Each repo's documentation (if structure/API changes)

---

**This Directory:** Orchestration hub for client
**Workflow:** Red/Green Checkpoint methodology
**Support:** GitHub Issues in respective repositories
