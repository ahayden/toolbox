# Development tools in containers

Multiarch development environments

## Setup

1. Enable beta GHCR on your GH acct
2. Fork this repo under your GH user
3. Clone the repo locally
4. Edit `docker-compose.yaml` to include registry paths from your GH user
5. Run an environment 
    - For the dev shell `docker compose run dev /bin/bash -l`
    - For JupyterLab:
      1. Generate an ssh keypair: `ssh-keygen -t rsa -b 4096 -f ~/.ssh/sci`
      2. Copy the public component to the container persistent storage:
          1. `docker compose run dev /bin/bash -l` 
          2. paste sci.pub into ~/.ssh/authorized_keys
          3. `chmod 0600  ~/.ssh/authorized_keys`
      3. On your local machine create an .ssh/config entry:
          Host sci
            HostName localhost
            Port 2222
            LocalForward 8888 sci:8888
            User <your GH user>
            IdentityFile ~/.ssh/sci
      4. `docker compose up`
      5. `ssh sci`
      6. Open http://localhost:8888 in a browser

