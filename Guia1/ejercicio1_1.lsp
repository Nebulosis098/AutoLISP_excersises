; Función para Zoom All (ZA)
(defun c:ZA ()
  (command "ZOOM" "ALL")
)

; Función para Zoom Extents (ZE) con un 80% del tamaño real
(defun c:ZE ()
  (command "ZOOM" "EXTENTS")
  ; Aplicar un factor de escala del 80%
  (setq center (trans '(0 0 0) 0 1))
  (command "ZOOM" "SCALE" "0.8X" center)
)

; Función para Zoom Window (ZW)
(defun c:ZW ()
  (setq p1 (getpoint "\nSeleccione el primer punto de la ventana: "))
  (setq p2 (getcorner p1 "\nSeleccione el punto opuesto de la ventana: "))
  (command "ZOOM" "WINDOW" p1 p2)
)

; Función para Zoom Previous (ZP)
(defun c:ZP ()
  (command "ZOOM" "PREVIOUS")
)

; Función Principal para Seleccionar y Ejecutar los Comandos
(defun c:izoom ()
  (prompt "\nSeleccione una opción de Zoom: ")
  (prompt "\n1. Zoom All (ZA)")
  (prompt "\n2. Zoom Extents (ZE) con un 80% del tamaño real")
  (prompt "\n3. Zoom Window (ZW)")
  (prompt "\n4. Zoom Previous (ZP)")
  (setq option (getint "\nIngrese el número de opción: "))
  (cond
    ((= option 1) (c:ZA))
    ((= option 2) (c:ZE))
    ((= option 3) (c:ZW))
    ((= option 4) (c:ZP))
    (T (prompt "\nOpción no válida."))
  )
)
