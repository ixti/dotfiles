# /home/ixti

## Install

``` bash
yadm clone --branch yadm --single-branch "git@gitlab.com:${USER}/dotfiles.git"
yadm submodule update --init --recursive
```

## Update

``` bash
yadm pull && yadm submodule update --init --recursive
```
