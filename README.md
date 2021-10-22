
# A

这是我从零攒起来的 Emacs 配置，尽量结构化，即单个文件专注解决少量问题，同时代码里面尽可能多注释和笔记，故显得有点啰嗦。

结构

```text
> .emacs.d
|-- early-init.el
|-- init.el
|-- etc/
|-- example/
```
所有 Emacs 的配置代码基本都在 etc 文件夹下，并且再分为 lisp, module, plug-in, site-lisp

```text
> etc
|-- lisp
|   `-- init-xxx.el
|-- module
|   `-- xx/all.kinds.el
|-- plug-in
|   `-- use-xxx.el
`-- site-lisp
```
用这样冗余和功能重叠的结构的目的，lisp 主要是 Emacs/elisp 的层次的问题并且作为各种功能实现的入口，plug-in 主要是插件的使用问题，module 集中一些复杂的配置。