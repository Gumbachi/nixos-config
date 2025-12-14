# How to: Git with SSH [LINK](https://docs.codeberg.org/security/ssh-key/)

1. `ssh-keygen -t ed25519 -a 100 -C "github"`
   1. `-t` = key type
   2. `-a` = key complexity (derivations)
   3. `-C` = comment (optional)
2. Follow prompts for file path (I leave default path) and passphrase
3. Copy token to clipboard (located in `~/.ssh/id_ed25519.pub`)
4. Go to Settings > SSH and GPG Keys on GitHub and add SSH key

## Switch Repo to SSH from HTTPS

`git remote set-url origin <ssh link>`

# Git remove tracked file

I used this to removed a file that was already tracked by git
but recently added to a git ignore

`git rm --cached <file>`
