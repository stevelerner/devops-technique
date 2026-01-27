# Git Cheat Sheet

## Quick Commands
**Single line update:**  
`git add -A && git commit -m "commit" && git push origin master`

**Clone a private repo:**  
`git clone https://USERNAME@github.com/USERNAME/PRIVREPODIR`

**Fix 403 Error:**  
`git remote set-url origin "https://github-username:personalaccesscode@github.com/github-username/github-repository-name.git"`   
`git remote set-url origin "https://steve.lerner:personalaccesscode@github.com/coralogix/workshops.git"`

**Cache login info (push without logging in):**  
`git config --global credential.helper store`  

**Edit markdown:** use Typora

## Branch Management
- `git branch`: shows current branch  
- `git branch -a`: shows all branches  
- `git checkout [branchname]`: switches branch  
- `git push origin [branchname]`: push changes to branch

# Storing Images and Demos in your Repo

## How to
#### 1. Clone a fresh copy of your repo
In order to prevent any loss of work it is best to clone the repo in a separate location to complete this task.

#### 2. Create a new branch
Create a new branch in your repo by using `git checkout --orphan assets`

This will create and switch you to a new branch called "assets". The `--orphan` flag creates a new branch but without any prior commits. However it does still keep the working tree and index. 

#### 3. Remove files from the working tree
`git rm -rf .`

***THIS WILL DELETE ALL FILES THAT THE WORKING TREE RECOGNIZES*** Any files that were not added to the tree will remain left behind in the folder.

We remove all files from the working tree since we do not want anything but our screenshots and images in this branch.

You can also check what branch you are on anytime by using `git branch`. The branch with the `*` next to it is the current branch.

#### 4. Add your images and screenshots and commit the change
`git add screenshot.png demo.gif logo.png`

`git commit -m "Added Assets"`

#### 5. Finally push your changes
`git push origin assets`


## Use the images in your README
You can now use
`![Demo Animation](../assets/demo.gif?raw=true)`
in your README to have the gif display on your master's readme.

#### Use remote image repo branches

In main repo:

List remote branches  
`git branch -r`

Remove everything in the main repo then:

Switch to assets branch  
`git checkout assets`

Add new files  
`git add NEWFILE`

Commit  
`git commit -m "commit"`

Push assets branch  
`git push origin assets`

## Clear Cached Credentials (macOS)
If you get a 403 error even after setting the correct remote URL, your machine might be caching old credentials. Run this to clear them:

```bash
echo "host=github.com
protocol=https
" | git credential-osxkeychain erase
```
Then try your push again. Git will prompt you for the new username and password (PAT).

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