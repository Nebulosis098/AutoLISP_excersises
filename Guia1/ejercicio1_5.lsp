(defun c:noloveo ()
  ;Funcion generica para solicitar punto con un mensaje "prompt"
  (defun get-point-with-prompt (prompt)
    (getpoint prompt) ;prompt es el texto que le debemos pasar
  )

  ;request point p1
  (setq p1 (get-point-with-prompt "/nIngrese el punto inferior izquierdo"))
  
  ;request point p2
  (setq p2 (get-point-with-prompt "/nIngrese el punto superior derecho"))
  
  ;making the rectangle
  (command "RECTANG" p1 p2)
  
  ;Funcion que calcula el área  
  

)