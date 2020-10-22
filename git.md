Single line update:  
`git add -A && git commit -m "commit" && git push origin master`

Clone a private repo:  
`git clone https://USERNAME@github.com/USERNAME/PRIVREPODIR`

Fix 403:  
`git remote set-url origin "https://github-username@github.com/github-username/github-repository-name.git"`

Edit markdown: use Typora

# Storing Images and Demos in your Repo
In this quick walkthough you'll learn how to create a separate branch in your repo to house your screenshots and demo gifs for use in your master's readme.

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
