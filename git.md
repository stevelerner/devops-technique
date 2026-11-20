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

## Different GitHub account per repo (automatic when you `cd`)
Use this when two GitHub accounts share one Mac (here `stevelerner` and `tinyolly`) and each repo must push as its own account. Two pieces, both per repo:

**1. Log in to both accounts once** (tokens live in the macOS keychain; `gh` can hold several):
```bash
gh auth login          # run again for the second account
gh auth status         # lists both; one is "Active"
```

**2. `git push` / `git pull` (HTTPS): a credential helper in that repo's own `.git/config`.** Run inside the repo, with `ACCOUNT` = the GitHub login that owns the push rights:
```bash
ACCOUNT=tinyolly
git config --local credential.helper ''      # clear the inherited helpers first (empty value resets the list)
git config --local --add credential.helper \
  '!f() { test "$1" = get && echo username='$ACCOUNT' && echo password=$(gh auth token --user '$ACCOUNT'); }; f'
```
Git now asks `gh` for that account's token on every push, whichever account is active globally. Repos without this block fall back to `~/.gitconfig`, which uses the globally active `gh` account (`gh auth switch` changes it).

**3. The `gh` CLI (PRs, releases, `gh api`): direnv sets `GH_TOKEN` when you enter the folder.** One-time setup: `brew install direnv`, add the hook to your shell's startup file (bash: `echo 'eval "$(direnv hook bash)"' >> ~/.bash_profile`; zsh: `echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc`), open a new terminal. Then in the repo root:
```bash
echo 'export GH_TOKEN=$(gh auth token --user tinyolly)' > .envrc
direnv allow
```
Leaving the folder unsets it. Add `.envrc` to your global ignore (`~/.config/git/ignore`) so it is never committed.

**Check it:** `cd` into the repo, then `gh api user --jq .login` (should print that repo's account) and `git config --show-origin --get-all credential.helper` (shows the per-repo helper last). Wrong account on push gives a 403; fix the `ACCOUNT` in step 2.

### Generic recipe: any account, any repo
Replace `ACCOUNT` with the GitHub login and run from the repo root. Needs `gh`, `direnv` (hooked in `~/.bash_profile` or `~/.zshrc`) and a one-time `gh auth login` for that account.
```bash
ACCOUNT=some-login                                   # 1. the GitHub login to use in this repo

gh auth login                                        # 2. once per account (skip if `gh auth status` already lists it)

git config --local credential.helper ''              # 3. git push/pull as ACCOUNT
git config --local --add credential.helper \
  '!f() { test "$1" = get && echo username='$ACCOUNT' && echo password=$(gh auth token --user '$ACCOUNT'); }; f'

echo 'export GH_TOKEN=$(gh auth token --user '$ACCOUNT')' > .envrc   # 4. gh CLI as ACCOUNT in this folder
direnv allow
grep -qx .envrc ~/.config/git/ignore || echo .envrc >> ~/.config/git/ignore   # 5. never commit .envrc

git config --show-origin --get-all credential.helper    # 6. check: the per-repo helper is listed last
gh api user --jq .login                                  #    prints ACCOUNT (in an interactive shell, after direnv loads)
```
Undo: `git config --local --unset-all credential.helper` and delete `.envrc`. Also make sure the remote is HTTPS (`git remote -v`); SSH remotes ignore credential helpers.

Current setup: `tinyolly` repo uses `tinyolly`; `inferencerouter` uses `stevelerner`; `istio-ambient-demo` uses the global default (`stevelerner`).

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