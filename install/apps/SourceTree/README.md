# SourceTree Custom Actions

A list of useful SourceTree custom actions built atop existing **`git`** commands, to extend SourceTree functionalities. For example, you can **delete merged branches** to quickly keep the remote clean or you can **undo the last commit** if you made a mistake

## Usage

In SourceTree, open **Preferences** by <kbd>⌘</kbd> + <kbd>,</kbd> and then click on the "**Custom Actions**" tab:

![Custom Actions](images/custom_actions.png)

From there you can "**Add**", "**Edit**" or "**Remove**" custom actions for SourceTree.

![Custom Actions Add](images/custom_actions_add.png)

Type in whatever you want in the Menu Caption. It is recommended to select both the check boxes of "**Open in Separate Window**" and "**Show Full Output**" so that it is easier to capture errors if there is any.

And here are the available actions in this repo:

### Remove Merged Branches

Delete all branches that are merged to **`current`** branch, **`master`** branch, **`dev`** branch or **`develop`** branch. By default, this script only deletes merged branches locally. If we want to also remove the merged branch in a remote, we can pass in the remote name as a parameter.

|
+ **Script:** `remove_merged_branches.sh`
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>-</kbd>
+ **Parameter:** remote name _( OPTIONAL )_

This is very useful for keeping the repo clean. During development, we can easily end up with a lot of PR branches that are merged. They can be clean up with this easily.

### Make Zombie Branch

Rename the current branch to **`zombie/YYYY-MMM-DD/HH-MM-SS/{Current Branch Name}`**. The idea is to archive a branch instead of deleting it immediately. It is nicer to put the branches in folder start with letter "**z**" _( zombie )_ instead of "**a**" _( archive )_ because SourceTree will order the branches by lexical order.

+ **Script:** `make_zombie.sh`
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>A</kbd>

<p align="center">
    <img src="images/branches.png" alt="Branches"/>
</p>

### Clean Up Zombie Branches

Zombie branches that are older than 1 month will be deleted.

+ **Script:** `kill_zombies.sh`
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>K</kbd>

### Safe Force Push Current Branch To Remote

You can enable force push from SourceTree directly.

<p align="center">
    <img src="images/force_push.png" alt="Force Push"/>
</p>


However, force push is a dangerous operation since it will overwrite the history in the remote. When you make a mistake, then you'll lose your changes and there is no going back. This script will check if the remote branch has diverged from the local branch; if it is, then a zombie branch will be created in the remote so that you won't lost any of the changes.

Force push is a handy to keep the commit history clean. This feature is especially useful when being used along with **`git amend`** in SourceTree when you have some small changes that you just want to amende to the last commit.

<p align="center">
    <img src="images/amend.png" alt="Amend"/>
</p>

By default, this script will push to **`origin`** remote. But you can specify your remote name in the parameter.

+ **Script:** `safe_push_current_branch.sh`
+ **Parameter:** remote name _( OPTIONAL )_
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>P</kbd>

### Undo Last Commit

Sometimes we need to ad-hoc switch to a different branch. However, we cannot do that with uncommitted changes. Using this script, we can make a dummy commit to save the work-in-progress changes. And later on, after we finish the business with the other branch, we can switch back to this branch, and simply undo the last commit.

Just in case we call this script by mistake, the script will make a zombie branch before undoing the last commit.

You can call this script multiple time to undo multiple commits.

+ **Script:** `undo_last_commit.sh`
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>Z</kbd>

This is a similar idea with **`git stash`**, however, I prefer seeing everything in my tree :)

> Use **`git stash`** when you want to record the current state of the working directory and the
> index, but want to go back to a clean working directory. The command saves your local modifications
> away and reverts the working directory to match the HEAD commit. [reference ⟶](https://git-scm.com/docs/git-stash)

### Update Branches

This allows you to update **`master`** branch from a different branch without having the checkout the **`master`** branch first.
Normally, before submitting a pull request, we will update **`master`** _( handy with this script )_ and rebase change on top of it **`git rebase master`**.

This script will update stable branch as well if it exists.

<p align="center">
    <img src="images/rebase_master.png" alt="Rebase Master"/>
</p>

+ **Script:** `update_branches.sh`
+ **Recommended Shortcut:** <kbd>fn</kbd> + <kbd>U</kbd>
+ **Example Output**

  ```git
  ✅ Update branch 'master'.
  ❌ Skip branch 'stable' since it doesn't exist.
  ```

## Power Users 💪

Sourcetree saves all the custom actions under:

  ```sh
  /Library/Application Support/SourceTree/actions.plist
  ```

The **`install.sh`** script will create symbolic links for each of the custom actions here in folder **`usr/local/bin`** and update **`actions.plist`**.

> &nbsp;
> ❗ **IMPORTANT** ❗
> **This will overwrite your existing action settings.**
> &nbsp;

After running **`sh install.sh`**, restart Sourcetree, and expect to see the following:

<p align="center">
    <img src="images/installed.png" alt="Installed"/>
</p>
