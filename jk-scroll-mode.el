(defun jk-scroll-half (direction)
  "copied from https://www.emacswiki.org/emacs/HalfScrolling"
  (let ((opos (cdr (nth 6 (posn-at-point)))))
    ;; opos = original position line relative to window
    (move-to-window-line nil)  ;; Move cursor to middle line
      (if direction
          (recenter-top-bottom -1)  ;; Current line becomes last
        (recenter-top-bottom 0))  ;; Current line becomes first
      (move-to-window-line opos)) ;; Restore cursor/point position
  )  

(defun jk-scroll-half-page-down ()
  (interactive)
  (jk-scroll-half nil))

(defun jk-scroll-half-page-up ()
  (interactive)
  (jk-scroll-half t))

(defun jk-change-cursor-color (jk-color)
  (if jk-scroll-mode
      (progn
        (setq jk-old-cursor-color (cdr (assoc 'cursor-color (frame-parameters))))
        (set-cursor-color jk-color))
   (set-cursor-color old-cursor-color)))

(defun jk-scroll-change-cursor-color ()
  (interactive)
  jk-change-cursor-color "brightblue")


(define-minor-mode jk-scroll-mode
  "Toggles global jk-scroll-mode" ;; i want buffer local though
  :init-value nil ;; initial value, nil for disabled by default,
  ;;t for enabled
  :global t ;; maybe changing this is what i want for buffer loc
  ;; :group 'jk-scroll ;; i have no idea what this is
  :lighter " jk-scroll" ;; thing displayed at bottom for mode
  :keymap (define-keymap
  "j" #'next-line
  "k" #'previous-line
  "l" #'left-char
  ";" #'right-char
  "i" #'jk-scroll-mode ;; used to go back to typing
  "C-l" #'left-word
  "C-;" #'right-word ;; why doesnt this one work?
  "C-j" #'jk-scroll-half-page-down
  "C-k" #'jk-scroll-half-page-up
  ;; "SPC" #'right-char ;; this doesnt work
  ;; make the rest of the keys nil so i dont try to type while
  ;; in this mode
  "q" #'ignore ;; is this possible to do using regex instead?
  "w" #'ignore
  "e" #'ignore
  "r" #'ignore
  "t" #'ignore
  "y" #'ignore
  "u" #'ignore
  "o" #'ignore
  "p" #'ignore
  "[" #'ignore
  "]" #'ignore
  "\\" #'ignore ;; this one may be weird
  "a" #'ignore
  "s" #'ignore
  "d" #'ignore
  "f" #'ignore
  "g" #'ignore
  "h" #'ignore
  "'" #'ignore
  "z" #'ignore
  "x" #'ignore
  "c" #'ignore
  "v" #'ignore
  "b" #'ignore
  "n" #'ignore
  "m" #'ignore
  "," #'ignore
  "." #'ignore
  "/" #'ignore
  "`" #'ignore
  "1" #'ignore
  "2" #'ignore
  "3" #'ignore
  "4" #'ignore
  "5" #'ignore
  "6" #'ignore
  "7" #'ignore
  "8" #'ignore
  "9" #'ignore
  "0" #'ignore
  "-" #'ignore
  "=" #'ignore
  )
  )

(add-hook 'jk-scroll-mode-on-hook (lambda() (interactive)
									(message "jk-scroll on!")))
(add-hook 'jk-scroll-mode-off-hook (lambda () (interactive)
									 (message "jk-scroll off!")))

(global-set-key (kbd "C-c n") #'jk-scroll-mode)

(provide 'jk-scroll-mode)
