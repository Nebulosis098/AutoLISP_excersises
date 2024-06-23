(defun c:drawflashlight ()
  ;; Solicitar el punto central de inserción y la altura de la linterna
  (setq center-point (getpoint "\nIngrese el punto central de inserción: "))
  (setq height (getreal "\nIngrese la altura de la linterna: "))

  ;; Definir las dimensiones de la linterna basadas en la altura
  (setq base-radius (* 0.2 height))   ; Radio de la base (20% de la altura)
  (setq body-radius (* 0.1 height))   ; Radio del cuerpo (10% de la altura)
  (setq tip-radius (* 0.4 height))    ; Radio de la punta de iluminación (40% de la altura)
  (setq body-height (* 0.8 height))   ; Altura del cuerpo (80% de la altura)
  (setq base-height (* 0.1 height))   ; Altura de la base (10% de la altura)
  (setq tip-height (* 0.1 height))    ; Altura de la punta de iluminación (10% de la altura)

  ;; Calcular los puntos de inicio para cada parte
  (setq body-start (polar center-point 0 (- (/ body-height 2))))
  (setq base-start (polar body-start (- (/ pi 2)) base-height))
  (setq tip-start (polar body-start (/ pi 2) body-height))

  ;; Dibujar la base de la linterna (cilindro)
  (command "CYLINDER" base-start "R" base-radius "H" base-height)

  ;; Dibujar el cuerpo de la linterna (cilindro)
  (command "CYLINDER" body-start "R" body-radius "H" body-height)

  ;; Dibujar la punta de iluminación de la linterna (cilindro)
  (command "CYLINDER" tip-start "R" tip-radius "H" tip-height)

  ;; Terminar el programa
  (princ)
)

(defun polar (pt ang dist)
  (list (+ (car pt) (* dist (cos ang)))
        (+ (cadr pt) (* dist (sin ang)))))
