---
title: Clipboard in Neovim
date: 2024-12-29 13:00 +0800
categories: neovim
tag: clipboard wsl ssh osc52
---

## Introduction

Neovim/Vim provides us with a brilliant yank/put (or copy/paste) system:
`y` to yank contents to a register and `p` to put contents from a register,
with multiple registers to select from.

However, there are some inconvenient:

1. Sync with the *system clipboard*
2. Sync when using *SSH*
3. Sync between *WSL* and host

This essay aims to deal with these problems.

## Origin CLip

First of all, press `y` in normal mode in vim/nvim can yank the contents to a register,
and `p` can put contents from a register to editor.

This is the simplest usage of origin clip. However what is the register?

**Registers is a storage location where you can save text for
later use**

In nvim, there are 5 groups of registers:

1. **Unnamed Register(")**: This is the default register.
2. **Number Registers(0-9)**: These registers store the last ten yanked
or deleted texts.
3. **Named Registers(a-z)**: These registers could be specified by press letter
after `"`.
4. **System Clipboard Registers (+ and \*)**: These registers interact
with the system clipboard.
5. **Black Hole Register (_)**: This register drop all contents.

These register could be specified by press corresponding symbol after `"`.
And if you do not specify, nvim would use unnamed register.

Thus, press `"add` would yank current line to the `a` register without override the
default register, which means you can store many distinct contents at same time.

But the `_` register is an exception: all contents yanked to it cannot be reused.
It is just like a black hole; everything can go in, but nothing can get out
(if you do not consider Hawking's theory).

## System CLipboard

As metioned above, there are two system clipboard registers used to sync with
system clipboard. But it is a bit of hassle. Usually, I use this command to
make it conveniently.

```lua
vim.opt.clipboard:append 'unnamedplus'
```

## OSC52

If we would like to sync with remote machine when we use ssh to connect. There
are more work to do.

Nvim provides a OSC52 clipboard for users (`:help clipboard-osc52` could find the
document), OSC52 is ANSI escape sequence that allows user to copy text to the system
clipboard even from a remote SSH session. Add this snip to your configuration.

```lua
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy '+',
        ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste '+',
        ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
}
```

This code custom clipboard to replace + and \* registers.

## WSL
