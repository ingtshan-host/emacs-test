(;;use regex to math org file in root of dotfiles
 string-match-p
 (expand-file-name
  (concat user-emacs-directory "etc/.*/*.el$" ))
 (buffer-file-name))
