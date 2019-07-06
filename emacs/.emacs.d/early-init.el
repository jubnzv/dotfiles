;; -*- lexical-binding: t -*-
;; * Improve Startup Speed
;; ** Kill package.el
;; Must use early init file as of Emacs 27

;; ** Disable Tool Bar, Menu Bar, and Scroll Bar
;; doing this here reduces init time by ~0.2 seconds
;; disabling `tool-bar-mode' in normal init file takes ~0.1s
;; https://github.com/raxod502/radian/issues/180
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; ** Set Font
(push '(font . "Iosevka-12") default-frame-alist)
