# Backpack

A plugin based framework for dotfiles and provisioning.

## Introduction

Backpack is a lightweight plugin based framework for configuring your personal machine.  It  can install software, syncs dotfiles, configure settings, or do anything else you write a plugin for.

Backpack comes with plugins for most common tasks and you can easily write your own.  It's written completely in bash to make setting up a new machine as simple as possible.

You can run backpack multiple times on the same machine safely.  It only changes what it needs to based on the current state of the machine.

## Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/yuloh/backpack/master/tools/install.sh)"
```
