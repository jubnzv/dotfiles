;; -*- lexical-binding: t -*-
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

;; We don't use package.el. This needs to happen here because
;; package.el gets initialized before loading the regular init-file.
(setq package-enable-at-startup nil)
