# Git Cheat Sheet

## Quick Commands
**Single line update:**  
`git add -A && git commit -m "message" && git push`

**Clone (works for private repos once `gh auth login` is done):**  
`gh repo clone OWNER/REPO`

**Authenticate (HTTPS) with the GitHub CLI, no tokens in URLs:**  
```bash
gh auth login && gh auth setup-git
```
A 403 on push usually means the cached credential has no write access to that repo (wrong account, or a token without `repo` scope): clear it (below) and log in again.

## Branch Management
- `git branch`: shows current branch  
- `git branch -a`: shows all branches  
- `git switch [branchname]`: switches branch (`git switch -c name` creates one)  
- `git push origin [branchname]`: push changes to branch

## Worktrees (parallel branches / parallel AI agents)
One repo, several checked-out branches in separate folders, each with its own working tree, so agents or tasks do not trample each other:
```bash
git worktree add ../myrepo-feature -b feature     # new branch in a sibling folder
git worktree list
git worktree remove ../myrepo-feature             # when merged
```
Run one agent per worktree. See [ai-agents.md](ai-agents.md).

## Clear Cached Credentials (macOS)
If you get a 403 error even after setting the correct remote URL, your machine might be caching old credentials. Run this to clear them:

```bash
echo "host=github.com
protocol=https
" | git credential-osxkeychain erase
```
Then try your push again. Git will prompt you for the new username and password (token).

# GitHub CLI (gh)

The `gh` command brings GitHub to your terminal.

**Login:**
`gh auth login`

**Check status:**
`gh status`

**Create a repo:**
`gh repo create`

**View PRs:**
`gh pr list`

**Checkout a PR:**
`gh pr checkout [number]`

**Create a release:**
`gh release create [tag] --generate-notes`

## Create a Private Copy of a Forked Public Repo

GitHub doesn't allow making a public fork private. Workaround: create a private mirror.

```bash
# 1. Clone the forked repo as a bare repo
git clone --bare https://github.com/USERNAME/FORKED-REPO.git

# 2. Create a new private repo on GitHub
gh repo create PRIVATE-REPO-NAME --private

# 3. Push the mirror to your new private repo
cd FORKED-REPO.git
git push --mirror https://github.com/USERNAME/PRIVATE-REPO-NAME.git

# 4. Clean up the bare clone
cd ..
rm -rf FORKED-REPO.git

# 5. Clone your new private repo to work with it
git clone https://github.com/USERNAME/PRIVATE-REPO-NAME.git
```

**Optional - add upstream to pull future updates:**
```bash
cd PRIVATE-REPO-NAME
git remote add upstream https://github.com/ORIGINAL-OWNER/ORIGINAL-REPO.git
git fetch upstream
git merge upstream/main
```

**Note:** You lose GitHub's fork connection (no easy PRs back to the original), but you get privacy.