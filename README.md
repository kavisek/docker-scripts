# Docker Scripts

This repository holds Bash scripts that remove local Docker resources: containers, images, volumes, and networks. It's for developers who want to reset Docker on their workstation to a clean state. After reading this page, you can install the scripts, pick the one that removes what you need, and check what Docker still has.

## Overview

Each script removes one kind of Docker resource, and `deverything.sh` runs four of them in sequence. A `Makefile` copies the scripts to your home directory and prints the current Docker state.

> **Caution:** These scripts delete Docker resources without asking for confirmation. Removed volumes lose their data, and removed images must be pulled or built again. Run `make status` first to see what is going to be removed.

The following table lists the scripts:

| Script | What it removes |
|---|---|
| `dcontainers.sh` | Stops every running container with `docker kill`, then removes every container. |
| `dinactive.sh` | Removes only containers with the status `exited`. |
| `dimages.sh` | Removes every image except those whose `docker images` row contains `docker` or `k8s.gcr.io`, then runs `docker image prune -a -f`. |
| `dvolumes.sh` | Removes every volume. |
| `dnetwork.sh` | Removes every network. |
| `dsystemprune.sh` | Runs `docker system prune --all --force --volumes`, which removes stopped containers, unused networks, unused images, build cache, and unused volumes. |
| `deverything.sh` | Runs `dcontainers.sh`, `dimages.sh`, `dvolumes.sh`, and `dnetwork.sh` from your home directory, in that order. |

> **Note:** The prune step in `dimages.sh` removes every image that no container uses, including the images that the filter skips. After `dcontainers.sh` runs, no containers remain, so `deverything.sh` removes all images.

## Before You Begin

To use the scripts, you need the following:

- Docker Engine or Docker Desktop, with the daemon running.
- Bash. The scripts have no shebang line, so run them with `bash`.
- `make`, to use the `Makefile` targets.
- `watch`, for the `make watch` target. On macOS, install it with `brew install watch`.

## Install the Scripts

`deverything.sh` calls the other scripts from `$HOME`, so the scripts must live in your home directory.

1. Clone the repository and change into it:

   ```sh
   git clone https://github.com/kavisek/docker-scripts.git
   cd docker-scripts
   ```

2. Copy the scripts to your home directory:

   ```sh
   make copy
   ```

   The target runs `cp ./*.sh ${HOME}/` and overwrites any existing copies.

## Remove Docker Resources

To remove one kind of resource, run its script with `bash`:

```sh
bash ~/SCRIPT_NAME
```

Replace the following:

- `SCRIPT_NAME`: the script from the table in the [Overview](#overview), for example `dinactive.sh`.

Each script prints one line for every resource that it removes, and a final line such as `docker volumes destroyed.` when it finishes.

To remove containers, images, volumes, and networks in one step, run the following:

```sh
bash ~/deverything.sh
```

The script prints `everything destroyed.` when it finishes. Docker's built-in networks `bridge`, `host`, and `none` can't be removed, so `dnetwork.sh` prints an error for each of them. You can ignore those errors.

## Verify

To list the Compose projects, containers, volumes, and networks that remain, run the following:

```sh
make status
```

> **Note:** The target's last command, `docker images ls`, filters for images named `ls` instead of listing all images. To list every image, run `docker image ls`.

To refresh that list every 5 seconds, run `make watch`. To stop it, press `Control+C`.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
