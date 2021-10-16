;;; bqn-comint.el -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'comint)
(require 'bqn-input)
(require 'bqn-backslash)
(require 'bqn-syntax)
(require 'bqn-symbols)

(defgroup bqn-comint nil
  "Run a BQN interpreter inside a buffer."
  :group 'languages)

(defcustom bqn-comint-program-command ""
  "BQN interpreter."
  :type 'string
  :group 'bqn-comint)

(defcustom bqn-comint-program-arguments nil
  "List of command line arguments to pass to the BQN interpreter."
  :type 'string
  :group 'bqn-comint)

(defcustom bqn-comint-mode-hook nil
  "Hook for customizing `bqn-comint-mode'."
  :type 'hook
  :group 'bqn-comint)

(defvar bqn-comint-buffer nil
  "Name of the inferior BQN buffer.")

(defun bqn--set-bqn-command (cmd)
  "Set `bqn-comint-program-command' to CMD."
  (setq bqn-comint-program-command cmd))

(defun bqn--set-bqn-arguments (args)
  "Set `bqn-comint-program-arguments' to ARGS."
  (setq bqn-comint-program-arguments args))

;;;###autoload
(define-derived-mode bqn-comint-mode comint-mode "Inferior BQN"
  "Major mode for interacting with an inferior BQN process. A BQN process can be
fired up with `run-bqn'.

Customization: Entry to this mode runs the hooks on comint-mode-hook and
bqn-comint-mode-hook (in that order)."
  :group 'bqn-comint)

;;;###autoload
(defun run-bqn ()
  "Run an inferior BQN process."
  (interactive)
  (let (--buffer (generate-new-buffer "*BQN*"))
    (apply #'make-comint-in-buffer
           "BQN" --buffer bqn-comint-program-command nil bqn-comint-program-arguments)
    (pop-to-buffer --buffer)))

(provide 'bqn-comint)

;;; bqn-comint.el ends here
