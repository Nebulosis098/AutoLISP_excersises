(defun c:drawsheet ()
  ;; Función para pedir el tamaño de la lámina
  (defun get-sheet-size ()
    (setq width (getreal "\nIngrese el ancho de la lámina: "))
    (setq height (getreal "\nIngrese la altura de la lámina: "))
    (list width height)
  )

  ;; Función para dibujar la lámina
  (defun draw-sheet (width height)
    (setq p1 (list 0 0))
    (setq p2 (list width 0))
    (setq p3 (list width height))
    (setq p4 (list 0 height))
    (command "LINE" p1 p2 p3 p4 "C")
    (command "RECTANG" p1 p3) 
  )

  ;; Función para insertar el bloque de rótulo
  (defun insert-titleblock (blockname)
    (setq insert_point (getpoint "\nSeleccione el punto de inserción del rótulo: "))
    (command "INSERT" blockname insert_point 1 1 0)
  )

  ;; Pedir el tamaño de la lámina al usuario
  (setq sheet-size (get-sheet-size))
  (setq width (car sheet-size))
  (setq height (cadr sheet-size))

  ;; Dibujar la lámina
  (draw-sheet width height)

  ;; Solicitar el nombre del bloque de rótulo
  (setq blockname (getstring "\nIngrese el nombre del bloque de rótulo: "))

  ;; Insertar el bloque de rótulo
  (insert-titleblock blockname)

  (princ)
)
