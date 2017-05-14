# Backpack

A plugin based framework for dotfiles and provisioning.

## Introduction

Backpack is a lightweight plugin based framework for configuring your personal machine.  It  can install software, syncs dotfiles, configure settings, or do anything else you write a plugin for.

Backpack comes with plugins for most common tasks and you can easily write your own.  It's written completely in bash to make setting up a new machine as simple as possible.

You can run backpack multiple times on the same machine safely.  It only changes what it needs to based on the current state of the machine.

## Requirements

- OSX or linux
- bash
- At least curl and tar to get started

## Installation

The following command will install backpack.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/yuloh/backpack/master/tools/install.sh)"
```

What it does:
    - copies this repo to `~/.backpack`
    - writes a script to `/usr/local/bin/backpack`
    - writes a config file to `~/.config/backpack/backpackrc`

If you have git it will clone the repo and you can use `backpack update` to keep it updated.  If you don't have git it will use tar to extract an archive.  If you had to use an archive you can run `backpack settle` once you have git and it will replace itself with a git repo.

## Usage

### Plugins

Backpack is powered by plugins.  When you run `backpack provision` it runs through all of the plugins and let's them do their thing.  Same thing with `backpack backup`.  You can look in the [plugins directory](./plugins) to see what's available.  Each plugin should have a README.

#### Usage

To Enable a plugin, add it to your `backpackrc` file.  By default the backpackrc lives in `~/.config/backpack/backpackrc`.  Once you open it in your editor you should see something like this:

```bash
plugins=(
    dotfiles
    xcode
    brew
)
```

Just add any plugins you want to use to the list and you are good to go.

#### Custom Plugins

You can add your own plugins to `~/.config/backpack/plugins`.  Just add a directory named after the plugin and put a bash script in it named like `my-plugin.plugin.sh`.

### Provisioning

Most plugins just make sure something is installed or setup and fix it if it isn't.  `backpack provision` will run each plugin in the order you listed them.  You usually want to run this on a new machine or after updating your backpackrc.

### Backup

Each plugin can specify a `plugin-name.backup.sh` file, which is ran by `backpack backup`.  This command is used to dump installed packages, backup settings, etc.  Most plugins will backup files to the `~/.config/backpack` directory so you can add them to version control or sync them between machines.

## Available Plugins

### Apt

#### backup

Backs up installed packages into an `Aptfile` in your backpack directory.

#### provision

Runs `apt-get update` and installs any packages listed in the `Aptfile`.

### Brew

#### backup

Backs up installed packages into a `Brewfile` in your backpack directory.

#### provision

Ensures homebrew is installed, updates it, installs any packages listed in the `Brewfile` and runs `brew cleanup`

### composer

#### provision

Ensures composer is installed and installs any packages listed in the global composer.json

### dotfiles

The dotfiles plugin syncs dotfiles and application settings.  If you enabled `httpie` and ran `backpack backup` it would move the `~/.httpie` config folder to your dotfiles folder and symlink it.

```bash
mv ~/.httpie ~/Dropbox/dotfiles/.httpie
ln -s ~/Dropbox/dotfiles/.httpie ~/.httpie
```

Now when you run `backpack provision` on another machine it will symlink it.  If the file already exists it will let you know and you can decide what to do.

```bash
ln -s ~/Dropbox/dotfiles/.httpie ~/.httpie
```

Each app has a config file that lists what files it syncs.  You can easily add your own apps to sync anything else.

If you are syncing an OSX settings file (anything in `~/Library`) it won't be synced to a linux machine.

#### Configuration

To use this plugin you should specify a path to backup dotfiles too.  Defaults to `~/.config/backpack/dotfiles`.

You also need to specify what apps you want to backup settings for.  Available apps are in [plugins/dotfiles/apps](./plugins/dotfiles/apps).

Custom apps can be added to `~/.config/backpack/plugins/dotfiles/apps.`  You can also override an apps config.

**warning:** Some apps will sync sensitive information like ssh keys or API credentials.  You shouldn't sync your dotfiles to a public location unless you know what you are doing.

Some settings files will also change _a lot_, so it's a good idea to use something like Dropbox if you are syncing app settings.

```bash
dotfiles_path=~/Dropbox/dotfiles

dotfiles=(
    aws
    bash
    curl
    vlc
)
```

#### backup

Moves any matching files to the configured dotfiles folder and replaces them with symlinks.

#### provision

Creates any missing symlinks for backed up dotfiles.

### npm

Installs global NPM packages.  This plugin does not install npm itself.  You should use the brew or apt plugin to do that.

#### Configuration

To configure this plugin define the list of packages you want to install in your backpackrc.

```bash
npm_packages=(ember-cli phantomjs)
```

#### provision

Globally installs the configured packages.

### oh-my-zsh

#### provision

Downloads and runs the oh-my-zsh installer if it isn't already installed.

### pip

#### backup

Creates a `requirements.txt` file in your backpack directory for any globally installed packages.

#### provision

Installs the packages from `requirements.txt`.

### ssh-keys

@todo

### vundle

@todo

### xcode

@todo
