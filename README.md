
# Novicemacs
[![License](https://img.shields.io/github/license/ingtshan/novicemacs)](License)

这是我从零攒起来的 Emacs 配置，尽量结构化，即单个文件专注解决少量问题，同时代码里面尽可能多注释和笔记，故显得有点啰嗦。

结构

```text
> .emacs.d
|-- early-init.el
|-- init.el
|-- etc/
|-- example/
```
所有 Emacs 的配置代码基本都在 etc 文件夹下，并且再分为 lisp, module, site-lisp。example 文件夹存放一些实验代码，或者使用时调用的 “一次性” 代码。

```text
> etc
|-- lisp
|   |-- init-xxx.el
|   |-- all-util.el
|   `-- do-dump.el
|-- module
|   `-- load-xxx.el
`-- site-lisp
> example/
|-- plug-in
    `-- use-xxx.el
```
用这样冗余和功能重叠的结构的目的：
1. etc/lisp 主要是 Emacs/elisp 的层次的问题并且作为各种功能实现的入口
2. etc/module 集中一些复杂的配置 （降低一些 etc/lisp 的复杂度）
3. etc/site-lisp 存放一些第三方库（git submodule 或手动下载）
4. example/plug-in 主要是插件的使用问题，平时并不加入 load-path

init 采用 普通（全正常加载）和 portable dumper （部分写出内存存为 pdmp）两种方式（手动移动 Emacs.pdmp）。通常 主题和字体（UI 美好）等 dump 会出问题。

如果你经常退出重启 Emacs ，那么 portable dumper 可以将复杂配置降低到秒开的程度，缺点就是配置有变动就要测试和重新 do-dump。
