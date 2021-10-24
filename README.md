# Novicemacs                                                   
[![image](https://img.shields.io/github/license/ingtshan/novicemacs)](https://github.com/ingtshan/novicemacs/blob/main/LICENSE)

写在前面：

这是我从零一点点攒起来的 Emacs 配置。

作为初学者的目标是尽量在单个文件内解决少量的问题，并保持清晰配置文件的结构，同时碍于我蹩脚的英语表达能力，注释和笔记中基本使用中文（但文件函数变量名等还是代入英文逻辑）。

介绍:

所有 Emacs 的 initial 配置代码都在 etc 文件夹下，并且再分为 `lisp`, `module`, `site-lisp`。

配置文件结构和目的：

1. ~etc/lisp~      ;主要解决 Emacs/elisp 的层次的问题并且作为各种功能实现的入口
2. ~etc/module~    ;集中一些复杂的配置 （降低一些 etc/lisp 的复杂度）
3. ~etc/site-lisp~ ;存放一些包管理不好加载的第三方库（git submodule 或手动下载）

```
.emacs.d
├── early-init.el
├── init.el
├── etc
│   ├── lisp
│   │   ├── sys-info.el
│   │   ├── all-util.el
│   │   ├── do-dump.el
│   │   └── init-xxx.el
│   ├── module
│   │   └── load-xxx.el
│   ├── site-lisp
│   │   │   └── notdeft
│   └── ... (other package's config files, not .el)
├── example
│   ├── plug-in
│   │   └── use-xxx.el
│   └── ... (other usage.el)
├── var
│   ├── dumper
│   │   └── Emacs.pdmp
│   └── ... (other data files)
└── ...
```

其中, `inint.el` 提供了一个使用 `portable dumper` 部分预加载的方式启动 Emacs 的
配置手脚架。

如果你经常退出重启 Emacs ，那么 portable dumper 可以将复杂配置降低到秒开的程度，缺点就是配置有变动就要测试和重新生成预加载文件（Emacs.pdmp）。

启动方式（兼容正常启动）:

终端 `--dump-file=path-to-your.pdmp`

```shell
emacs --dump-file=~.emacs.d/var/dumper/Emacs.pdmp
```

GUI 我目前是手动替换软件包下的 `Emacs.pdmp`

# 最后：一点感想

本项目中我写（或抄）配置 Emacs 的代码的目的，仅是打造一份趁手的工具。

故而，这些代码和所耗费的精力，脱离我个人而言是没有 “产出价值” 的。并且，投入时间和精力丰富自己的编程技能，和学习更多 “实战意义” 的编程知识（如 算
法，计算机408基础知识），甚至学习数学（抽象问题解决能力）都远比花费大量时间
“蹲在地上玩 Emacs 玩具” 来得有用。

但其实是，配置和使用 Emacs 过程中，提供了对
于熟悉的编程语言或大规模商用的技术下，对于同一个抽象问题的不同 理解角度/解决思路。
同时，尽量成为活跃的 Emacser， 积极参与社区互动，甚至编写通用插件，反而因为参与到解决大家（包括我自己）的问题而获得 “贡献价值”。
