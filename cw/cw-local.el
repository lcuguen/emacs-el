;; Init

(let ((generated-autoload-file (concat cw:tmp-dir "autoloads")))
  (unless noninteractive
    (update-directory-autoloads
     cw:home-dir cw:packages-config-dir
     cw:private-home-dir cw:private-packages-config-dir))
  (when cw:byte-compile-config
    (loop for d in (list cw:home-dir cw:private-home-dir)
	  do (byte-recompile-directory d 0)))
  (when (file-exists-p generated-autoload-file)
    (load generated-autoload-file)))

(defun cw:init()
  "Initialize all settings"
  (color-theme-tango)
  (windmove-default-keybindings)

  ;;
  ;; Key bindings
  ;;

  ;; cw-functions
  (global-set-key (kbd "C-%") 'goto-match-paren)

  ;; descbinds-anything
  (global-set-key (kbd "C-h b") 'descbinds-anything)
  ;; dired
  (define-key global-map (kbd "C-x C-d") 'dired)
  ;; frame
  (global-set-key (kbd "C-x K") 'delete-frame)
  ;; hippie-exp
  (define-key global-map (kbd "M-/") 'hippie-expand)
  ;; ido
  (define-key global-map (kbd "C-x C-b") 'ido-switch-buffer)
  (define-key global-map (kbd "C-x b") 'ido-switch-buffer)
  ;; magit
  (global-set-key (kbd "C-x C-z") 'magit-status)
  ;; smex
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "ESC M-x") 'execute-extended-command)


  (when (running-macosxp)
    (global-set-key (kbd "<C-M-return>") 'ns-toggle-fullscreen)
    (global-set-key (kbd "M-v") 'yank))

  (desktop-save-mode 1)
  (savehist-mode 1)
  (ido-mode t)
  (show-paren-mode t)
  (global-hl-line-mode)

  (setq display-buffer-function 'popwin:display-buffer)
  (qbs-init)



)

(unless noninteractive (cw:init))

(provide 'cw-local)
