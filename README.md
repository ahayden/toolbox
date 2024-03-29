# Development tools in containers

Multiarch development environments

## Setup

1. Enable the beta GitHub Container Registry service on your GitHub acct
2. Fork this repo under your GitHub user
3. Clone the repo locally
4. Edit `docker-compose.yaml` to include registry paths from your GitHub user
5. Run an environment 
    - For the dev shell `docker compose run dev /bin/bash -l`
    - For JupyterLab:
      1. Generate ssh keypair: `ssh-keygen -t ed5519 -f ~/.ssh/scidev`
      2. Copy the public component to the container persistent storage:
          1. `docker compose run dev /bin/bash -l` 
          2. paste scidev.pub into ~/.ssh/authorized_keys
          3. `chmod 0600  ~/.ssh/authorized_keys`
      3. On your local machine create an .ssh/config entry:
          ```
          Host scidev
            HostName localhost
            Port 2222
            LocalForward 8888 sci:8888
            User 'your GitHub user'
            IdentityFile ~/.ssh/scidev
          ```
      4. `docker compose up`
      5. `ssh scidev`
      6. Open http://localhost:8888 in a browser
7. Install an R kernel: `install.packages('IRkernel'); IRkernel::installspec()`
7. This allows for multiple GPG keys per container volume. The git config,
   `~/.config/git/config` is common between the host and container, but
   `~/.config/git.signingkey` can reference different subkeys.
    - Add the following include statement in the global git config:
```
[include]
path = ~/.config/git.signingkey
```
