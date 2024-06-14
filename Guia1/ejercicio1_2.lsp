(defun c:drawrectangle ()
  (defun get-point-with-prompt (prompt)
    (getpoint prompt)
  )

  ;; Solicitar el punto inferior izquierdo
  (setq p1 (get-point-with-prompt "\nIngrese el punto inferior izquierdo o seleccione con el mouse: "))

  ;; Solicitar el punto superior derecho
  (setq p2 (get-point-with-prompt "\nIngrese el punto superior derecho o seleccione con el mouse: "))

  ;; Calcular los otros dos puntos del rectángulo
  (setq p3 (list (car p2) (cadr p1)))
  (setq p4 (list (car p1) (cadr p2)))

  ;; Dibujar el rectángulo usando líneas
  (command "LINE" p1 p3 p2 p4 "C")
  (princ)
  ;princ es una función de AutoLISP que imprime un valor en la línea de 
  ;comandos sin una nueva línea al final.
  ;Llamar a princ sin argumentos se utiliza comúnmente para suprimir la 
  ;salida de nil (valor de retorno por defecto) en la línea de comandos, 
  ;lo que hace que el programa termine de manera "silenciosa".
)

(defun get-point-with-prompt (prompt)
  (getpoint prompt)
)
