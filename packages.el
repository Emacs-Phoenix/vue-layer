;;; packages.el --- vue layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: 放為 <chchen@FWei.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `vue-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `vue/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `vue/pre-init-PACKAGE' and/or
;;   `vue/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst vue-packages
  '(
    company
    company-tern
    emmet-mode
    flycheck
    smartparens
    tern
    web-mode
    )
  "The list of Lisp packages required by the vue layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun vue/post-init-company ()
  (spacemacs|add-company-hook vue-mode))

(defun vue/post-init-company-tern ()
  (push 'company-tern 'company-web company-backends-vue-mode))

(defun vue/post-init-emmet-mode ()
  (add-hook 'vue-mode-hook 'emmet-mode))

(defun vue/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (dolist (checker '(javascript-eslint javascript-standard))
      (flycheck-add-mode checker 'vue-mode)))
  (add-hook 'vue-mode-hook #'spacemacs//vue-use-eslint-from-node-modules)
  (spacemacs/add-flycheck-hook 'vue-mode))

(defun vue/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'vue-mode-hook #'smartparens-strict-mode)
    (add-hook 'vue-mode-hook #'smartparens-mode)))

(defun vue/post-init-tern ()
  (add-hook 'vue-mode-hook 'tern-mode)
  (spacemacs//set-tern-key-bindings 'vue-mode))

(defun vue/post-init-web-mode ()
  (define-derived-mode vue-mode web-mode "vue")
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  (add-hook 'vue-mode-hook 'spacemacs//setup-vue-mode))

;;; packages.el ends here
