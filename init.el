(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; 初期化
(package-initialize)

;;行数表示
(global-linum-mode t)
(setq linum-format "%4d")
(line-number-mode t) ; 下のバーに行数を表示
;; frameの大きさを文字数で指定
(setq default-frame-alist
  '(
    (width . 130)
    (height . 120)
   ))

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-mode t)
 '(minimap-window-location (quote right))
 '(package-selected-packages
   (quote
    (pyenv-mode-auto pyenv-mode markdown-mode minimap counsel highlight-indent-guides jedi elpy company-jedi company highlight-numbers monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "#003333")))))

;; monokai
(load-theme 'monokai t)
(set-face-foreground 'font-lock-variable-name-face "white")
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;;----
;; タイトルバーにフルパス表示
;;----
(setq frame-title-format "%f")

;;カッコの対応補完
(electric-pair-mode 1)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(require 'company)
(global-company-mode) ; 全バッファで有効にする 
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;; jedi-core
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; elpy
(package-initialize)
(elpy-enable)
;;; 使用する Anaconda の仮想環境を設定
;;(defvar venv-default "~/.pyenv/versions/miniconda3-latest/envs/tf")
;;; virtualenv を使っているなら次のようなパス
;; (defvar venv-default "~/.virtualenvs/hoge")
;;; デフォルト環境を有効化
;;(pyvenv-activate venv-default)
;;; REPL 環境に IPython を使う
;;(elpy-use-ipython)
;;; 自動補完のバックエンドとして Rope か Jedi を選択
(setq elpy-rpc-backend "jedi-core")

;; 対応するカッコをハイライト
(show-paren-mode t)

;;インデントカラー追加
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'column)


;; 背景の不透明度（アクティブウィンドウが90%,非アクティブが80%）
(add-to-list 'default-frame-alist '(alpha . (95 95)))

;; ivy/swiper
(ivy-mode 1) ;; デフォルトの入力補完がivyになる
(counsel-mode 1)
;; M-x, C-x C-fなどのEmacsの基本的な組み込みコマンドをivy版にリマップする
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)

;; minimap
(require 'minimap)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; markdown-mode
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; pyenv
(require 'pyenv-mode)
(require 'pyenv-mode-auto)
