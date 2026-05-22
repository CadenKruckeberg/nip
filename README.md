# nip

## Overview

`nip` is a small wrapper/interface for the Nix Package Manager's `nix profile` written in Bash. When we ([Cody](https://github.com/crmckenna2) and [I](https://github.com/CadenKruckeberg)) were exploring the idea for this project, our early versions went by the name `np`; in an effort to differentiate our new work from our old, have a real word as the name for our tool, and follow the snowy, cold theme of Nix, we named it `nip`. This tool aims to recover the ease-of-use of traditional package managers like `apt`, `dnf`, etc. while reaping the benefits that come with (in our opinion, the best) package repository: `nixpkgs`. While reaching this goal, we made an effort to not obstruct a Nix user's workflow/environment if they wanted to also use `nip`.

## Usage

| Command | Function |
|--|--|
| `nip add`, `nip install` | Add package(s) |
| `nip clean` | Wipe history and collect garbage |
| `nip import` | Add package(s) from package list through stdin |
| `nip list` | List added package(s) (**Note:** Only lists packages installed from the official `nixpkgs` repository) |
| `nip search` | Search for packages whose name contains what you provide |
| `nip remove` | Remove package(s) |
| `nip update` | Update all or specified package(s) |

## Examples

#### Adding/Installing:
`nip add cowsay`, `nip install cowsay curl`

#### Importing:
```console
$ cat packages.txt
cowsay
curl
$ nip import < packages.txt
```

#### Listing:
```console
$ nip list
cowsay
curl
```

#### Removing:
`nip remove cowsay`, `nip remove cowsay curl`

#### Updating:
`nip update cowsay`, `nip update cowsay curl`, `nip update` (updates all packages)

## Setup

> [!IMPORTANT]
> `nip` requires a working installation of the Nix Package Manager to work; specifically, at least version `2.30.0`. Follow instructions [here](https://nixos.org/download/) to download and install Nix.

> [!IMPORTANT]
> At the time of writing, using `nix profile` (and by extension, `nip`) requires two features that Nix still considers "experimental". Include `experimental-features = flakes nix-command` in your Nix Package Manager configuration file (likely `~/.config/nix/nix.conf`).

> [!IMPORTANT]
> `nip list` and `nip search` depend on `jq`. After installing `nip`, simply run `nip add jq` (or obtain `jq` however else you'd like) to enable `nip list`.

> [!IMPORTANT]
> If you are using `zsh` and want completions to work, add the following to your `.zshrc`:
> ```console
> fpath=("\((HOME)/.local/share/zsh/site-functions" \)fpath)
> autoload -Uz compinit && compinit
> ```

### Nix Flake (Recommended)

This project has a Nix Flake, providing lots of functionality, but most importantly:
```bash
nix profile add github:CadenKruckeberg/nip
```
will install `nip` with no fuss. To uninstall, simply run `nix profile remove nip`, or even `nip remove nip` for fun.

### Makefile

You can clone this repository `git clone https://github.com/CadenKruckeberg/nip`, change directory into the project `cd nip`, and install it with its Makefile `make install` (this, of course, requires `make`). To uninstall, simply run `make uninstall` instead.

> [!TIP]
> The only real reason to install `nip` instead of just using the bash script is for completions. If you don't care for the completions, you can simply clone the repo (and ensure execute permissions) and use the bash script (probably symlink it to somewhere in your `PATH` or otherwise add it to your `PATH`).

## Configuration

You can configure some functionality of `nip` through a simple Bash configuration file. `nip` looks for `XDG_CONFIG_HOME/nip/config`, which likely is (and defaults to if no `XDG_CONFIG_HOME`) `~/.config/nip/config`.


| Configuration | Options | Default |
|--|--|--|
| `BRANCH` | `"nixpkgs"`, `"nixpkgs/nixos-25.11"`, etc. | `"nixpkgs"` |
| `GC_ON_UPDATE_ALL` | `0` if you don't want `nip` to run `nix store gc` after updating all packages, `1` if you do. | `0` |
| `WIPE_HISTORY` | `0` if you don't want `nip` to run `nix profile wipe-history` after adding, importing, removing, or updating, `1` if you do. | `0` |

### Example Config File:
`~/.config/nip/config`:
```bash
BRANCH="nixpkgs/nixos-25.11"
GC_ON_UPDATE_ALL=1
WIPE_HISTORY=1
```

## Troubleshooting
- If you receive `error: 'add' is not a recognised command`, ensure your Nix Package Manager is at least version `2.30.0`.
- If you receive errors such as `error: experimental Nix feature 'nix-command' is disabled; add '--extra-experimental-features nix-command' to enable it` or `error: experimental Nix feature 'flakes' is disabled; add '--extra-experimental-features flakes' to enable it`, include `experimental-features = flakes nix-command` in your Nix Package Manager configuration file (likely `~/.config/nix/nix.conf`).
- If you receive `nip: 'jq' is required for 'list'. Install it with: nip add jq` or `nip: 'jq' is required for 'search'. Install it with: nip add jq`, run `nip add jq`.
- If you are using `zsh` and completions aren't working, ensure the following is in your `.zshrc`:
```console
fpath=("\((HOME)/.local/share/zsh/site-functions" \)fpath)
autoload -Uz compinit && compinit
```
 
