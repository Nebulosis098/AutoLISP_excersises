(defun c:hello ( / msg)
  (setq msg (getstring T "\nEnter a message: "))
  (alert msg)
) 