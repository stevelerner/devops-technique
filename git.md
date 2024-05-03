Single line update:  
`git add -A && git commit -m "commit" && git push origin master`

Clone a private repo:  
`git clone https://USERNAME@github.com/USERNAME/PRIVREPODIR`

Fix 403:  
`git remote set-url origin "https://github-username@github.com/github-username/github-repository-name.git"`

Cache login info so you can push without logging in:  
`git config --global credential.helper store`  

Edit markdown: use Typora

Branches:  
`git branch` shows current branch  
`git branch -a` shows all branches  
`git checkout [branchname]` switches branch  
`git push origin [branchname]` push changes to branch

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

#### 4. Finally push your changes
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
